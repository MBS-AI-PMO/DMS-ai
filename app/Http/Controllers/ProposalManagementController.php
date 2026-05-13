<?php

namespace App\Http\Controllers;

use App\Models\ProposalFile;
use App\Models\ProposalFileRequest;
use App\Models\ProposalFolder;
use App\Models\FileRequests;
use App\Models\FileRequestStatusEnum;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Storage;
use Ramsey\Uuid\Uuid;

class ProposalManagementController extends Controller
{
    public function index()
    {
        $userId = $this->getUserId();
        $rootFolder = $this->ensureRootFolder($userId);

        $folders = ProposalFolder::where('createdBy', $userId)
            ->orderBy('name')
            ->get();

        $folderMap = $folders->keyBy('id');
        $rootId = $rootFolder->id;

        $files = ProposalFile::with('folder')
            ->where('createdBy', $userId)
            ->orderByDesc('createdDate')
            ->get()
            ->map(function (ProposalFile $file) use ($folderMap, $rootId) {
                $folderPath = $this->buildFolderPathWithoutRoot($file->folderId, $folderMap, $rootId);
                $fileName = $file->title ?: $file->originalName;

                return [
                    'id' => $file->id,
                    'folderId' => $file->folderId,
                    'title' => $fileName,
                    'displayTitle' => $folderPath ? "{$folderPath} / {$fileName}" : $fileName,
                    'originalName' => $file->originalName,
                    'url' => $file->url,
                    'createdDate' => $file->createdDate,
                ];
            })
            ->values();

        $fileRequests = ProposalFileRequest::where('createdBy', $userId)
            ->with('linkedFileRequest')
            ->orderByDesc('createdDate')
            ->get()
            ->map(function (ProposalFileRequest $request) {
                $status = $request->status;
                if ($request->linkedFileRequest) {
                    $status = $request->linkedFileRequest->fileRequestStatus === FileRequestStatusEnum::UPLOADED->value
                        ? 'Uploaded'
                        : 'Pending';
                }

                return [
                    'id' => $request->id,
                    'folderId' => $request->folderId,
                    'fileRequestId' => $request->fileRequestId,
                    'title' => $request->title,
                    'description' => $request->description,
                    'status' => $status,
                    'createdDate' => $request->createdDate,
                ];
            })
            ->values();

        return response()->json([
            'rootFolderId' => $rootFolder->id,
            'folders' => $folders->map(function (ProposalFolder $folder) {
                return [
                    'id' => $folder->id,
                    'name' => $folder->name,
                    'parentFolderId' => $folder->parentFolderId,
                ];
            })->values(),
            'files' => $files,
            'fileRequests' => $fileRequests,
        ]);
    }

    public function createFolder(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:100',
            'parentFolderId' => 'nullable|exists:proposalFolders,id',
        ]);

        $userId = $this->getUserId();
        $rootFolder = $this->ensureRootFolder($userId);
        $now = Carbon::now();

        $folder = ProposalFolder::create([
            'id' => Uuid::uuid4()->toString(),
            'name' => trim($request->name),
            'parentFolderId' => $request->parentFolderId ?: $rootFolder->id,
            'createdBy' => $userId,
            'createdDate' => $now,
            'modifiedDate' => $now,
        ]);

        return response()->json($folder, 201);
    }

    public function uploadFile(Request $request)
    {
        $request->validate([
            'file' => 'required|file',
            'folderId' => 'nullable|exists:proposalFolders,id',
            'title' => 'nullable|string|max:255',
        ]);

        $userId = $this->getUserId();
        $rootFolder = $this->ensureRootFolder($userId);
        $folderId = $request->folderId ?: $rootFolder->id;
        $uploadedFile = $request->file('file');
        $storedPath = $uploadedFile->storeAs(
            'proposals',
            Uuid::uuid4() . '.' . $uploadedFile->getClientOriginalExtension(),
            'local'
        );

        $file = ProposalFile::create([
            'id' => Uuid::uuid4()->toString(),
            'folderId' => $folderId,
            'title' => $request->title ?: pathinfo($uploadedFile->getClientOriginalName(), PATHINFO_FILENAME),
            'originalName' => $uploadedFile->getClientOriginalName(),
            'url' => $storedPath,
            'createdBy' => $userId,
            'createdDate' => Carbon::now(),
        ]);

        return response()->json($file, 201);
    }

    public function createFileRequest(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'email' => 'nullable|email|max:255',
            'description' => 'nullable|string',
            'maxDocument' => 'required|integer|min:1',
            'sizeInMb' => 'required|integer|min:1',
            'fileExtension' => 'nullable|array',
            'fileExtension.*' => 'integer|min:0',
            'hasPassword' => 'nullable|boolean',
            'password' => 'nullable|string|max:255|required_if:hasPassword,true',
            'linkExpiryTime' => 'nullable|date',
            'folderId' => 'nullable|exists:proposalFolders,id',
            'baseUrl' => 'nullable|string|max:500',
        ]);

        $userId = $this->getUserId();
        $rootFolder = $this->ensureRootFolder($userId);
        $requestColumns = Schema::getColumnListing('proposalFileRequests');
        $linkedFileRequestId = null;

        if (!empty($validated['email'])) {
            $linkedFileRequestId = $this->createAndSendPlatformFileRequest($validated);
        }

        $fileRequestPayload = [
            'id' => Uuid::uuid4()->toString(),
            'folderId' => $request->folderId ?: $rootFolder->id,
            'fileRequestId' => $linkedFileRequestId,
            'title' => $request->title,
            'description' => $request->description,
            'status' => 'pending',
            'createdBy' => $userId,
            'createdDate' => Carbon::now(),
        ];

        if (in_array('email', $requestColumns, true)) {
            $fileRequestPayload['email'] = $request->email;
        }
        if (in_array('maxDocument', $requestColumns, true)) {
            $fileRequestPayload['maxDocument'] = $request->maxDocument;
        }
        if (in_array('sizeInMb', $requestColumns, true)) {
            $fileRequestPayload['sizeInMb'] = $request->sizeInMb;
        }
        if (in_array('allowExtension', $requestColumns, true)) {
            $fileRequestPayload['allowExtension'] = is_array($request->fileExtension) ? implode(',', $request->fileExtension) : null;
        }
        if (in_array('hasPassword', $requestColumns, true)) {
            $fileRequestPayload['hasPassword'] = (bool) $request->hasPassword;
        }
        if (in_array('password', $requestColumns, true)) {
            $fileRequestPayload['password'] = $request->hasPassword ? $request->password : null;
        }
        if (in_array('linkExpiryTime', $requestColumns, true)) {
            $fileRequestPayload['linkExpiryTime'] = $request->linkExpiryTime ? Carbon::parse($request->linkExpiryTime) : null;
        }

        $fileRequest = ProposalFileRequest::create($fileRequestPayload);

        return response()->json($fileRequest, 201);
    }

    private function createAndSendPlatformFileRequest(array $validated): string
    {
        $allowExtension = '';
        foreach (($validated['fileExtension'] ?? []) as $item) {
            $allowExtension .= \App\Models\AllowFileTypeEnum::getName((int) $item) . ',';
        }
        $allowExtension = rtrim($allowExtension, ',');

        $password = null;
        if (!empty($validated['hasPassword']) && !empty($validated['password'])) {
            $password = base64_encode($validated['password']);
        }

        $platformRequest = FileRequests::create([
            'subject' => $validated['title'],
            'email' => $validated['email'],
            'password' => $password,
            'maxDocument' => $validated['maxDocument'],
            'sizeInMb' => $validated['sizeInMb'],
            'allowExtension' => $allowExtension,
            'fileRequestStatus' => FileRequestStatusEnum::CREATED->value,
            'linkExpiryTime' => !empty($validated['linkExpiryTime']) ? Carbon::parse($validated['linkExpiryTime']) : null,
            'isLinkExpired' => false,
            'isDeleted' => false,
            'deletedBy' => '',
        ]);

        $this->sendFileRequestEmail($validated, (string) $platformRequest->id);

        return (string) $platformRequest->id;
    }

    private function sendFileRequestEmail(array $request, string $id): void
    {
        try {
            $body = Storage::disk('public')->get('file-request-template.html');
            $userId = $this->getUserId();
            $user = \App\Models\Users::find($userId);
            $fromName = $user ? ($user->firstName . ' ' . $user->lastName) : 'System';

            $baseUrl = !empty($request['baseUrl']) ? $request['baseUrl'] : (config('app.url') . '/file-requests/preview/');
            $url = $baseUrl . $id;
            $body = str_replace('##FROM_NAME##', $fromName, $body);
            $body = str_replace('##UPLOAD_LINK##', $url, $body);

            app(\App\Repositories\Contracts\EmailRepositoryInterface::class)->sendEmail([
                'to_address' => $request['email'],
                'subject' => $fromName . ' has requested you to upload a file.',
                'message' => $body,
                'path' => null,
            ]);
        } catch (\Throwable $th) {
        }
    }

    public function openFile(string $id)
    {
        $userId = $this->getUserId();
        $file = ProposalFile::where('id', $id)
            ->where('createdBy', $userId)
            ->firstOrFail();

        if (!Storage::disk('local')->exists($file->url)) {
            abort(404, 'File not found.');
        }

        $path = Storage::disk('local')->path($file->url);
        $mimeType = Storage::disk('local')->mimeType($file->url) ?: 'application/octet-stream';
        $fileName = $file->originalName ?: ($file->title . '.bin');

        return response()->file($path, [
            'Content-Type' => $mimeType,
            'Content-Disposition' => 'inline; filename="' . $fileName . '"',
        ]);
    }

    private function ensureRootFolder(string $userId): ProposalFolder
    {
        $rootFolder = ProposalFolder::where('createdBy', $userId)
            ->where('name', 'proposals')
            ->whereNull('parentFolderId')
            ->first();

        if ($rootFolder) {
            return $rootFolder;
        }

        $now = Carbon::now();

        return ProposalFolder::create([
            'id' => Uuid::uuid4()->toString(),
            'name' => 'proposals',
            'parentFolderId' => null,
            'createdBy' => $userId,
            'createdDate' => $now,
            'modifiedDate' => $now,
        ]);
    }

    private function buildFolderPathWithoutRoot(string $folderId, $folderMap, string $rootFolderId): string
    {
        $parts = [];
        $currentId = $folderId;

        while ($currentId && $folderMap->has($currentId)) {
            $folder = $folderMap->get($currentId);
            if ($folder->id === $rootFolderId) {
                break;
            }

            array_unshift($parts, $folder->name);
            $currentId = $folder->parentFolderId;
        }

        return implode(' / ', $parts);
    }

    private function getUserId(): string
    {
        return Auth::parseToken()->getPayload()->get('userId');
    }
}

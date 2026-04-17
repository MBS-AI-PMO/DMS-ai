<?php

namespace App\Http\Controllers;

use App\Models\ProposalFile;
use App\Models\ProposalFileRequest;
use App\Models\ProposalFolder;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
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
            ->orderByDesc('createdDate')
            ->get();

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
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'folderId' => 'nullable|exists:proposalFolders,id',
        ]);

        $userId = $this->getUserId();
        $rootFolder = $this->ensureRootFolder($userId);

        $fileRequest = ProposalFileRequest::create([
            'id' => Uuid::uuid4()->toString(),
            'folderId' => $request->folderId ?: $rootFolder->id,
            'title' => $request->title,
            'description' => $request->description,
            'status' => 'pending',
            'createdBy' => $userId,
            'createdDate' => Carbon::now(),
        ]);

        return response()->json($fileRequest, 201);
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

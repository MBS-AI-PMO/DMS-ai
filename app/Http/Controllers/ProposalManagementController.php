<?php

namespace App\Http\Controllers;

use App\Models\ProposalFile;
use App\Models\ProposalFileRequest;
use App\Models\ProposalFolder;
use App\Models\ProposalCandidate;
use App\Models\ProposalCandidateCv;
use App\Models\ProposalPost;
use App\Models\ProposalCategory;
use App\Models\ProposalDepartment;
use App\Models\FileRequests;
use App\Models\FileRequestStatusEnum;
use App\Models\Users;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Storage;
use Ramsey\Uuid\Uuid;

class ProposalManagementController extends Controller
{
    private const CANDIDATE_CV_LIMIT = 5;

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

        $filerequests = ProposalFileRequest::where('createdBy', $userId)
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

        $posts = ProposalPost::with(['candidates' => function ($query) {
            $query->orderByDesc('createdDate');
        }])
            ->where('createdBy', $userId)
            ->orderByDesc('createdDate')
            ->get()
            ->map(function (ProposalPost $post) {
                return [
                    'id' => $post->id,
                    'title' => $post->title,
                    'department' => $post->department,
                    'category' => $post->category,
                    'experienceYears' => $post->experienceYears,
                    'interviewKit' => $post->interviewKit,
                    'basicQuestions' => $post->basicQuestions,
                    'intermediateQuestions' => $post->intermediateQuestions,
                    'expertQuestions' => $post->expertQuestions,
                    'workMode' => $post->workMode,
                    'address' => $post->address,
                    'description' => $post->description,
                    'createdDate' => $this->formatApiDateTime($post->createdDate, $post->modifiedDate),
                    'candidates' => $post->candidates->map(function (ProposalCandidate $candidate) {
                        return $this->mapCandidate($candidate);
                    })->values(),
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
            'filerequests' => $filerequests,
            'posts' => $posts,
            'categories' => $this->listCategoriesData($userId),
            'departments' => $this->listDepartmentsData($userId),
        ]);
    }

    public function postBoard()
    {
        $userId = $this->getUserId();

        $posts = ProposalPost::with(['candidates' => function ($query) {
            $query->orderByDesc('createdDate');
        }])
            ->where('createdBy', $userId)
            ->orderByDesc('createdDate')
            ->get()
            ->map(fn (ProposalPost $post) => $this->mapPost($post))
            ->values();

        return response()->json([
            'categories' => $this->listCategoriesData($userId),
            'departments' => $this->listDepartmentsData($userId),
            'posts' => $posts,
        ]);
    }

    public function assignedInterviews()
    {
        $userId = $this->getUserId();

        $candidates = ProposalCandidate::with('post')
            ->where('interviewerUserId', $userId)
            ->orderByDesc('interviewDate')
            ->orderByDesc('createdDate')
            ->get()
            ->map(function (ProposalCandidate $candidate) {
                return [
                    'id' => $candidate->id,
                    'postId' => $candidate->postId,
                    'postTitle' => $candidate->post?->title ?? '',
                    'candidateName' => $candidate->candidateName,
                    'candidateCode' => $candidate->candidateCode,
                    'phone' => $candidate->phone,
                    'email' => $candidate->email,
                    'stage' => $candidate->stage,
                    'interviewLevel' => $candidate->interviewLevel,
                    'interviewDate' => $this->formatApiDateTime($candidate->interviewDate),
                    'analysisNotes' => $candidate->analysisNotes,
                    'rejectionReason' => $candidate->rejectionReason,
                    'createdDate' => $this->formatApiDateTime($candidate->createdDate, $candidate->modifiedDate),
                ];
            })
            ->values();

        return response()->json([
            'candidates' => $candidates,
        ]);
    }

    public function assignedInterviewHistory(string $id)
    {
        $userId = $this->getUserId();
        $candidate = ProposalCandidate::with('post')->where('id', $id)->firstOrFail();

        if (empty($candidate->interviewerUserId) || $candidate->interviewerUserId !== $userId) {
            return response()->json(['message' => "You don't have right to access this interview."], 403);
        }

        return response()->json([
            'candidateName' => $candidate->candidateName,
            'candidateCode' => $candidate->candidateCode,
            'phone' => $candidate->phone,
            'email' => $candidate->email,
            'postTitle' => $candidate->post?->title ?? '',
            'stage' => $candidate->stage,
            'createdDate' => $this->formatApiDateTime($candidate->createdDate, $candidate->modifiedDate),
            'history' => $this->buildCandidateHistory($candidate),
        ]);
    }

    public function updateAssignedInterview(Request $request, string $id)
    {
        $validated = $request->validate([
            'stage' => 'nullable|string|in:interview_scheduled,approved,rejected,selected',
            'analysisNotes' => 'nullable|string',
            'rejectionReason' => 'required_if:stage,rejected|nullable|string|max:5000',
        ]);

        $userId = $this->getUserId();
        $candidate = ProposalCandidate::with('post')->where('id', $id)->firstOrFail();

        if (empty($candidate->interviewerUserId) || $candidate->interviewerUserId !== $userId) {
            return response()->json(['message' => "You don't have right to access this interview."], 403);
        }

        if (array_key_exists('analysisNotes', $validated)) {
            $candidate->analysisNotes = $validated['analysisNotes'];
        }

        if (array_key_exists('stage', $validated) && $validated['stage'] !== null) {
            $candidate->stage = $validated['stage'];

            if ($validated['stage'] === 'rejected') {
                $candidate->rejectionReason = isset($validated['rejectionReason'])
                    ? trim((string) $validated['rejectionReason'])
                    : null;
            } elseif (array_key_exists('rejectionReason', $validated)) {
                $candidate->rejectionReason = $validated['rejectionReason'] !== null
                    ? trim((string) $validated['rejectionReason'])
                    : null;
            }
        }

        $candidate->modifiedDate = Carbon::now();
        $candidate->save();

        return response()->json([
            'id' => $candidate->id,
            'postId' => $candidate->postId,
            'postTitle' => $candidate->post?->title ?? '',
            'candidateName' => $candidate->candidateName,
            'candidateCode' => $candidate->candidateCode,
            'phone' => $candidate->phone,
            'email' => $candidate->email,
            'stage' => $candidate->stage,
            'interviewLevel' => $candidate->interviewLevel,
            'interviewDate' => $this->formatApiDateTime($candidate->interviewDate),
            'analysisNotes' => $candidate->analysisNotes,
            'rejectionReason' => $candidate->rejectionReason,
            'createdDate' => $this->formatApiDateTime($candidate->createdDate, $candidate->modifiedDate),
        ]);
    }

    public function createCategory(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
        ]);

        $now = Carbon::now();
        $category = ProposalCategory::create([
            'id' => Uuid::uuid4()->toString(),
            'name' => trim($validated['name']),
            'createdBy' => $this->getUserId(),
            'createdDate' => $now,
            'modifiedDate' => $now,
        ]);

        return response()->json($this->mapCategory($category), 201);
    }

    public function updateCategory(Request $request, string $id)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
        ]);

        $category = ProposalCategory::where('id', $id)
            ->where('createdBy', $this->getUserId())
            ->firstOrFail();

        $category->name = trim($validated['name']);
        $category->modifiedDate = Carbon::now();
        $category->save();

        return response()->json($this->mapCategory($category));
    }

    public function deleteCategory(string $id)
    {
        $category = ProposalCategory::where('id', $id)
            ->where('createdBy', $this->getUserId())
            ->firstOrFail();

        $hasDepartments = ProposalDepartment::where('categoryId', $category->id)->exists();
        if ($hasDepartments) {
            return response()->json([
                'message' => 'Remove departments in this category first.',
            ], 422);
        }

        $category->delete();

        return response()->json([], 200);
    }

    public function createDepartment(Request $request)
    {
        $validated = $request->validate([
            'categoryId' => 'required|string',
            'name' => 'required|string|max:255',
            'basicQuestions' => 'nullable|string',
            'intermediateQuestions' => 'nullable|string',
            'expertQuestions' => 'nullable|string',
        ]);

        $this->findOwnedCategory($validated['categoryId']);
        $now = Carbon::now();

        $department = ProposalDepartment::create([
            'id' => Uuid::uuid4()->toString(),
            'categoryId' => $validated['categoryId'],
            'name' => trim($validated['name']),
            'basicQuestions' => $validated['basicQuestions'] ?? null,
            'intermediateQuestions' => $validated['intermediateQuestions'] ?? null,
            'expertQuestions' => $validated['expertQuestions'] ?? null,
            'createdBy' => $this->getUserId(),
            'createdDate' => $now,
            'modifiedDate' => $now,
        ]);

        $department->load('category');

        return response()->json($this->mapDepartment($department), 201);
    }

    public function updateDepartment(Request $request, string $id)
    {
        $validated = $request->validate([
            'categoryId' => 'required|string',
            'name' => 'required|string|max:255',
            'basicQuestions' => 'nullable|string',
            'intermediateQuestions' => 'nullable|string',
            'expertQuestions' => 'nullable|string',
        ]);

        $department = ProposalDepartment::where('id', $id)
            ->where('createdBy', $this->getUserId())
            ->firstOrFail();

        $this->findOwnedCategory($validated['categoryId']);

        $department->categoryId = $validated['categoryId'];
        $department->name = trim($validated['name']);
        $department->basicQuestions = $validated['basicQuestions'] ?? null;
        $department->intermediateQuestions = $validated['intermediateQuestions'] ?? null;
        $department->expertQuestions = $validated['expertQuestions'] ?? null;
        $department->modifiedDate = Carbon::now();
        $department->save();
        $department->load('category');

        return response()->json($this->mapDepartment($department));
    }

    public function deleteDepartment(string $id)
    {
        $department = ProposalDepartment::where('id', $id)
            ->where('createdBy', $this->getUserId())
            ->firstOrFail();

        $inUse = ProposalPost::where('departmentId', $department->id)->exists();
        if ($inUse) {
            return response()->json([
                'message' => 'This department is used by job posts. Delete those posts first.',
            ], 422);
        }

        $department->delete();

        return response()->json([], 200);
    }

    public function createPost(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'departmentId' => 'required|string',
            'experienceYears' => 'nullable|integer|min:0|max:60',
            'interviewKit' => 'nullable|string|in:basic,expert,intermediate',
            'workMode' => 'nullable|string|in:remote,physical',
            'address' => 'nullable|string|max:500',
            'description' => 'nullable|string',
        ]);

        $now = Carbon::now();
        $workMode = $validated['workMode'] ?? 'physical';
        $postColumns = Schema::getColumnListing('proposalposts');
        $department = $this->findOwnedDepartment($validated['departmentId']);

        $postPayload = [
            'id' => Uuid::uuid4()->toString(),
            'title' => trim($validated['title']),
            'department' => $department->name,
            'description' => !empty($validated['description']) ? trim($validated['description']) : null,
            'createdBy' => $this->getUserId(),
            'createdDate' => $now,
            'modifiedDate' => $now,
        ];

        if (in_array('departmentId', $postColumns, true)) {
            $postPayload['departmentId'] = $department->id;
        }
        if (in_array('category', $postColumns, true)) {
            $postPayload['category'] = $department->category?->name;
        }
        if (in_array('experienceYears', $postColumns, true)) {
            $postPayload['experienceYears'] = $validated['experienceYears'] ?? null;
        }
        if (in_array('interviewKit', $postColumns, true)) {
            $postPayload['interviewKit'] = $validated['interviewKit'] ?? 'basic';
        }
        if (in_array('basicQuestions', $postColumns, true)) {
            $postPayload['basicQuestions'] = $department->basicQuestions;
        }
        if (in_array('intermediateQuestions', $postColumns, true)) {
            $postPayload['intermediateQuestions'] = $department->intermediateQuestions;
        }
        if (in_array('expertQuestions', $postColumns, true)) {
            $postPayload['expertQuestions'] = $department->expertQuestions;
        }
        if (in_array('workMode', $postColumns, true)) {
            $postPayload['workMode'] = $workMode;
        }
        if (in_array('address', $postColumns, true)) {
            $postPayload['address'] = $workMode === 'physical' && !empty($validated['address']) ? trim($validated['address']) : null;
        }

        $post = ProposalPost::create($postPayload);

        return response()->json($post, 201);
    }

    public function updatePost(Request $request, string $id)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'departmentId' => 'required|string',
            'experienceYears' => 'nullable|integer|min:0|max:60',
            'interviewKit' => 'nullable|string|in:basic,expert,intermediate',
            'workMode' => 'nullable|string|in:remote,physical',
            'address' => 'nullable|string|max:500',
            'description' => 'nullable|string',
        ]);

        $post = ProposalPost::where('id', $id)
            ->where('createdBy', $this->getUserId())
            ->firstOrFail();

        $department = $this->findOwnedDepartment($validated['departmentId']);
        $workMode = $validated['workMode'] ?? 'physical';
        $postColumns = Schema::getColumnListing('proposalposts');
        $post->title = trim($validated['title']);
        $post->department = $department->name;
        $post->description = !empty($validated['description']) ? trim($validated['description']) : null;
        if (in_array('departmentId', $postColumns, true)) {
            $post->departmentId = $department->id;
        }
        if (in_array('category', $postColumns, true)) {
            $post->category = $department->category?->name;
        }
        if (in_array('experienceYears', $postColumns, true)) {
            $post->experienceYears = $validated['experienceYears'] ?? null;
        }
        if (in_array('interviewKit', $postColumns, true)) {
            $post->interviewKit = $validated['interviewKit'] ?? 'basic';
        }
        if (in_array('basicQuestions', $postColumns, true)) {
            $post->basicQuestions = $department->basicQuestions;
        }
        if (in_array('intermediateQuestions', $postColumns, true)) {
            $post->intermediateQuestions = $department->intermediateQuestions;
        }
        if (in_array('expertQuestions', $postColumns, true)) {
            $post->expertQuestions = $department->expertQuestions;
        }
        if (in_array('workMode', $postColumns, true)) {
            $post->workMode = $workMode;
        }
        if (in_array('address', $postColumns, true)) {
            $post->address = $workMode === 'physical' && !empty($validated['address']) ? trim($validated['address']) : null;
        }
        $post->modifiedDate = Carbon::now();
        $post->save();

        return response()->json($post);
    }

    public function deletePost(string $id)
    {
        $post = ProposalPost::where('id', $id)
            ->where('createdBy', $this->getUserId())
            ->firstOrFail();

        $post->delete();

        return response()->json([], 200);
    }

    public function createCandidate(Request $request, string $postId)
    {
        $userId = $this->getUserId();
        $post = ProposalPost::where('id', $postId)
            ->where('createdBy', $userId)
            ->firstOrFail();

        return response()->json($this->storeCandidate($request, $post, $userId), 201);
    }

    public function allCandidates()
    {
        $userId = $this->getUserId();

        $records = ProposalCandidate::with('post')
            ->where('createdBy', $userId)
            ->orderByDesc('createdDate')
            ->get();

        $groups = [];

        foreach ($records as $candidate) {
            $groupKey = $this->resolveCandidateGroupKey($candidate);

            if (!isset($groups[$groupKey])) {
                $groups[$groupKey] = [
                    'groupKey' => $groupKey,
                    'candidateName' => $candidate->candidateName,
                    'candidateCode' => $candidate->candidateCode,
                    'phone' => $candidate->phone,
                    'email' => $candidate->email,
                    'experienceYears' => $candidate->experienceYears,
                    'applicationCount' => 0,
                    'applications' => [],
                ];
            }

            $groups[$groupKey]['applications'][] = $this->mapGroupedApplication($candidate);

            $groups[$groupKey]['applicationCount']++;
        }

        $candidates = collect($groups)
            ->map(function (array $group) {
                $latest = $group['applications'][0] ?? null;

                return [
                    'groupKey' => $group['groupKey'],
                    'candidateName' => $group['candidateName'],
                    'candidateCode' => $group['candidateCode'],
                    'phone' => $group['phone'],
                    'email' => $group['email'],
                    'experienceYears' => $group['experienceYears'],
                    'applicationCount' => $group['applicationCount'],
                    'latestApplicationId' => $latest['id'] ?? null,
                    'latestPostId' => $latest['postId'] ?? null,
                    'latestPostTitle' => $latest['postTitle'] ?? '',
                    'latestStage' => $latest['stage'] ?? 'cv_received',
                    'latestAppliedDate' => $latest['createdDate'] ?? null,
                    'latestRejectionReason' => ($latest['stage'] ?? '') === 'rejected'
                        ? ($latest['rejectionReason'] ?? null)
                        : null,
                    'hasCv' => $latest['hasCv'] ?? false,
                    'cvOriginalName' => $latest['cvOriginalName'] ?? null,
                    'applications' => $group['applications'],
                ];
            })
            ->sortByDesc(fn (array $group) => $group['latestAppliedDate'] ?? '')
            ->values()
            ->all();

        return response()->json(['candidates' => $candidates]);
    }

    public function allCandidateHistory(string $candidateId)
    {
        $userId = $this->getUserId();

        $anchor = ProposalCandidate::where('id', $candidateId)
            ->where('createdBy', $userId)
            ->firstOrFail();

        $historyQuery = ProposalCandidate::with('post')
            ->where('createdBy', $userId)
            ->orderByDesc('createdDate');

        $this->applyCandidateHistoryMatch($historyQuery, $anchor);

        $records = $historyQuery->get();
        $applications = $records
            ->map(fn (ProposalCandidate $candidate) => $this->mapGroupedApplication($candidate))
            ->values()
            ->all();

        return response()->json([
            'candidate' => [
                'groupKey' => $this->resolveCandidateGroupKey($anchor),
                'candidateName' => $anchor->candidateName,
                'candidateCode' => $anchor->candidateCode,
                'phone' => $anchor->phone,
                'email' => $anchor->email,
                'experienceYears' => $anchor->experienceYears,
                'applicationCount' => count($applications),
                'applications' => $applications,
            ],
        ]);
    }

    private function mapGroupedApplication(ProposalCandidate $candidate): array
    {
        return [
            'id' => $candidate->id,
            'postId' => $candidate->postId,
            'postTitle' => $candidate->post ? $candidate->post->title : '',
            'stage' => $candidate->stage,
            'createdDate' => $this->formatApiDateTime($candidate->createdDate, $candidate->modifiedDate),
            'interviewDate' => $this->formatApiDateTime($candidate->interviewDate),
            'interviewer' => $candidate->interviewer ?? null,
            'hasCv' => !empty($candidate->cvPath),
            'cvOriginalName' => $candidate->cvOriginalName,
            'rejectionReason' => $candidate->rejectionReason ?? null,
        ];
    }

    private function resolveCandidateGroupKey(ProposalCandidate $candidate): string
    {
        $cnicDigits = $this->normalizeCnicDigits($candidate->candidateCode);
        if ($cnicDigits) {
            return 'cnic:' . $cnicDigits;
        }

        $email = !empty($candidate->email) ? strtolower(trim($candidate->email)) : null;
        if ($email) {
            return 'email:' . $email;
        }

        return 'id:' . $candidate->id;
    }

    public function getPublicPost(string $postId)
    {
        $post = ProposalPost::where('id', $postId)->firstOrFail();

        return response()->json([
            'id' => $post->id,
            'title' => $post->title,
            'department' => $post->department,
            'category' => $post->category,
            'experienceYears' => $post->experienceYears,
            'workMode' => $post->workMode,
            'address' => $post->address,
            'description' => $post->description,
        ]);
    }

    public function lookupPublicCandidate(Request $request, string $postId)
    {
        $request->validate([
            'candidateCode' => 'nullable|string|max:20',
            'email' => 'nullable|email|max:255',
        ]);

        $post = ProposalPost::where('id', $postId)->firstOrFail();
        $cnicDigits = $this->normalizeCnicDigits($request->input('candidateCode'));
        $email = !empty($request->email) ? strtolower(trim($request->email)) : null;

        if (!$cnicDigits && !$email) {
            return response()->json([
                'appliedOnThisPost' => false,
                'profile' => null,
                'cvs' => [],
                'maxCvs' => self::CANDIDATE_CV_LIMIT,
            ]);
        }

        $this->syncApplicationCvsToVault($post->createdBy, $cnicDigits, $email);
        $cvs = $this->getCandidateCvVault($post->createdBy, $cnicDigits, $email);

        $onPostQuery = ProposalCandidate::where('postId', $post->id);
        $this->applyCandidateLookupMatch($onPostQuery, $cnicDigits, $email);
        $existingOnPost = $onPostQuery->first();

        if ($existingOnPost) {
            $selectedCvId = $this->findVaultCvIdByPath($post->createdBy, $cnicDigits, $email, $existingOnPost->cvPath);

            return response()->json([
                'appliedOnThisPost' => true,
                'application' => [
                    'id' => $existingOnPost->id,
                    'candidateName' => $existingOnPost->candidateName,
                    'candidateCode' => $existingOnPost->candidateCode,
                    'phone' => $existingOnPost->phone,
                    'email' => $existingOnPost->email,
                    'experienceYears' => $existingOnPost->experienceYears,
                    'cvOriginalName' => $existingOnPost->cvOriginalName,
                    'hasCv' => !empty($existingOnPost->cvPath),
                    'selectedCvId' => $selectedCvId,
                    'stage' => $existingOnPost->stage,
                    'createdDate' => $this->formatApiDateTime($existingOnPost->createdDate, $existingOnPost->modifiedDate),
                ],
                'cvs' => $cvs,
                'maxCvs' => self::CANDIDATE_CV_LIMIT,
            ]);
        }

        $profileQuery = ProposalCandidate::where('createdBy', $post->createdBy);
        $this->applyCandidateLookupMatch($profileQuery, $cnicDigits, $email);
        $profile = $profileQuery->orderByDesc('createdDate')->first();

        return response()->json([
            'appliedOnThisPost' => false,
            'profile' => $profile ? [
                'candidateName' => $profile->candidateName,
                'candidateCode' => $profile->candidateCode,
                'phone' => $profile->phone,
                'email' => $profile->email,
                'experienceYears' => $profile->experienceYears,
            ] : null,
            'cvs' => $cvs,
            'maxCvs' => self::CANDIDATE_CV_LIMIT,
        ]);
    }

    public function openPublicVaultCv(Request $request, string $postId, string $cvId)
    {
        $request->validate([
            'candidateCode' => ['required', 'string', 'max:20', function ($attribute, $value, $fail) {
                if ($this->normalizeCnicDigits($value) === null) {
                    $fail('CNIC must be 13 digits.');
                }
            }],
        ]);

        $post = ProposalPost::where('id', $postId)->firstOrFail();
        $vaultCv = $this->findVaultCvForCandidate(
            $post->createdBy,
            $cvId,
            $request->input('candidateCode'),
            !empty($request->email) ? strtolower(trim($request->email)) : null
        );

        if (!$vaultCv->cvPath || !Storage::disk('local')->exists($vaultCv->cvPath)) {
            abort(404, 'CV not found.');
        }

        $path = Storage::disk('local')->path($vaultCv->cvPath);
        $mimeType = Storage::disk('local')->mimeType($vaultCv->cvPath) ?: 'application/octet-stream';
        $fileName = $vaultCv->cvOriginalName ?: 'candidate-cv';

        return response()->file($path, [
            'Content-Type' => $mimeType,
            'Content-Disposition' => 'inline; filename="' . $fileName . '"',
        ]);
    }

    public function openPublicApplicationCv(Request $request, string $postId)
    {
        $request->validate([
            'candidateCode' => ['required', 'string', 'max:20', function ($attribute, $value, $fail) {
                if ($this->normalizeCnicDigits($value) === null) {
                    $fail('CNIC must be 13 digits.');
                }
            }],
        ]);

        $post = ProposalPost::where('id', $postId)->firstOrFail();
        $cnicDigits = $this->normalizeCnicDigits($request->input('candidateCode'));

        $query = ProposalCandidate::where('postId', $post->id);
        $this->applyCandidateLookupMatch($query, $cnicDigits, null);
        $candidate = $query->firstOrFail();

        if (!$candidate->cvPath || !Storage::disk('local')->exists($candidate->cvPath)) {
            abort(404, 'CV not found.');
        }

        $path = Storage::disk('local')->path($candidate->cvPath);
        $mimeType = Storage::disk('local')->mimeType($candidate->cvPath) ?: 'application/octet-stream';
        $fileName = $candidate->cvOriginalName ?: ($candidate->candidateName . '-cv');

        return response()->file($path, [
            'Content-Type' => $mimeType,
            'Content-Disposition' => 'inline; filename="' . $fileName . '"',
        ]);
    }

    public function submitPublicCandidate(Request $request, string $postId)
    {
        $post = ProposalPost::where('id', $postId)->firstOrFail();

        return response()->json($this->storeCandidate($request, $post, $post->createdBy), 201);
    }

    private function storeCandidate(Request $request, ProposalPost $post, string $createdBy): array
    {
        $isUpdateCvOnly = $request->boolean('updateCvOnly');

        $validated = $request->validate([
            'candidateName' => 'required|string|max:255',
            'candidateCode' => ['required', 'string', 'max:20', function ($attribute, $value, $fail) {
                if ($this->normalizeCnicDigits($value) === null) {
                    $fail('CNIC must be 13 digits (e.g. 35201-1234567-1).');
                }
            }],
            'phone' => 'required|string|max:50',
            'email' => 'required|email|max:255',
            'experienceYears' => 'required|integer|min:0|max:60',
            'workMode' => 'nullable|string|in:remote,physical',
            'address' => 'nullable|string|max:500',
            'cv' => 'nullable|file',
            'selectedCvId' => 'nullable|uuid',
            'updateCvOnly' => 'sometimes|boolean',
        ]);

        $existing = $this->findCandidateOnPost(
            $post->id,
            $validated['candidateCode'],
            $validated['email']
        );

        if ($existing) {
            abort(422, 'You have already applied for this job. Your application cannot be changed.');
        }

        if ($isUpdateCvOnly) {
            abort(422, 'No existing application found for this job.');
        }

        $resolvedCv = $this->resolveApplicationCv(
            $request,
            $post,
            $validated['candidateCode'],
            $validated['email'],
            false
        );

        $now = Carbon::now();
        $candidateColumns = Schema::getColumnListing('proposalcandidates');
        $candidatePayload = [
            'id' => Uuid::uuid4()->toString(),
            'postId' => $post->id,
            'candidateName' => trim($validated['candidateName']),
            'candidateCode' => $this->formatCnicFromInput($validated['candidateCode']),
            'phone' => !empty($validated['phone']) ? trim($validated['phone']) : null,
            'email' => !empty($validated['email']) ? strtolower(trim($validated['email'])) : null,
            'cvOriginalName' => $resolvedCv['cvOriginalName'],
            'cvPath' => $resolvedCv['cvPath'],
            'stage' => 'cv_received',
            'createdBy' => $createdBy,
            'createdDate' => $now,
            'modifiedDate' => $now,
        ];

        if (in_array('experienceYears', $candidateColumns, true)) {
            $candidatePayload['experienceYears'] = $validated['experienceYears'] ?? null;
        }
        if (in_array('workMode', $candidateColumns, true)) {
            $candidatePayload['workMode'] = $validated['workMode'] ?? null;
        }
        if (in_array('address', $candidateColumns, true)) {
            $candidatePayload['address'] = !empty($validated['address']) ? trim($validated['address']) : null;
        }

        $candidate = ProposalCandidate::create($candidatePayload);

        return $this->mapCandidate($candidate);
    }

    private function findCandidateOnPost(string $postId, string $candidateCode, string $email): ?ProposalCandidate
    {
        $query = ProposalCandidate::where('postId', $postId);
        $this->applyCandidateLookupMatch(
            $query,
            $this->normalizeCnicDigits($candidateCode),
            strtolower(trim($email))
        );

        return $query->first();
    }

    private function updateCandidateCv(ProposalCandidate $candidate, Request $request, ProposalPost $post): array
    {
        if (!$request->hasFile('cv') && !$request->filled('selectedCvId')) {
            return $this->mapCandidate($candidate);
        }

        $resolvedCv = $this->resolveApplicationCv(
            $request,
            $post,
            $candidate->candidateCode ?? '',
            $candidate->email ?? '',
            true
        );

        if ($resolvedCv) {
            $candidate->cvOriginalName = $resolvedCv['cvOriginalName'];
            $candidate->cvPath = $resolvedCv['cvPath'];
            $candidate->modifiedDate = Carbon::now();
            $candidate->save();
        }

        return $this->mapCandidate($candidate->fresh());
    }

    public function updateCandidate(Request $request, string $id)
    {
        $validated = $request->validate([
            'stage' => 'required|string|in:cv_received,shortlisted,interview_scheduled,approved,rejected,selected',
            'interviewLevel' => 'nullable|string|in:basic,intermediate,advanced',
            'interviewDate' => 'nullable|date',
            'interviewer' => 'nullable|string|max:255',
            'interviewerUserId' => 'nullable|uuid|exists:users,id',
            'analysisNotes' => 'nullable|string',
            'rejectionReason' => 'required_if:stage,rejected|nullable|string|max:5000',
            'isReschedule' => 'sometimes|boolean',
            'sendCandidateEmail' => 'sometimes|boolean',
            'candidateEmailMessage' => 'nullable|string|max:10000',
        ]);

        $candidate = ProposalCandidate::with('post')
            ->where('id', $id)
            ->where('createdBy', $this->getUserId())
            ->firstOrFail();

        $candidate->stage = $validated['stage'];
        $candidate->interviewLevel = $validated['interviewLevel'] ?? $candidate->interviewLevel;
        $candidate->interviewDate = !empty($validated['interviewDate'])
            ? Carbon::parse($validated['interviewDate'])
            : $candidate->interviewDate;
        $candidate->analysisNotes = array_key_exists('analysisNotes', $validated)
            ? $validated['analysisNotes']
            : $candidate->analysisNotes;

        if ($validated['stage'] === 'rejected') {
            $candidate->rejectionReason = isset($validated['rejectionReason'])
                ? trim((string) $validated['rejectionReason'])
                : null;
            $candidate->interviewer = null;
            $candidate->interviewerUserId = null;
        } elseif ($validated['stage'] === 'interview_scheduled') {
            $candidate->rejectionReason = null;

            if (empty($validated['interviewerUserId'])) {
                return response()->json(['message' => 'Please select an interviewer from the user list.'], 422);
            }

            if (empty($validated['interviewDate'])) {
                return response()->json(['message' => 'Interview date and time are required.'], 422);
            }

            $interviewerUser = Users::find($validated['interviewerUserId']);
            if (!$interviewerUser) {
                return response()->json(['message' => 'Selected interviewer was not found.'], 422);
            }

            $candidate->interviewerUserId = $interviewerUser->id;
            $candidate->interviewer = trim(
                ($interviewerUser->firstName ?? '') . ' ' . ($interviewerUser->lastName ?? '')
            ) ?: $interviewerUser->userName;

        } elseif (array_key_exists('rejectionReason', $validated) && $validated['rejectionReason'] !== null) {
            $candidate->rejectionReason = trim((string) $validated['rejectionReason']);
        }

        if (array_key_exists('interviewer', $validated) && $validated['stage'] !== 'interview_scheduled') {
            $candidate->interviewer = $validated['interviewer'] !== null && $validated['interviewer'] !== ''
                ? trim($validated['interviewer'])
                : null;
        }

        $candidate->modifiedDate = Carbon::now();
        $candidate->save();

        if (
            $validated['stage'] === 'interview_scheduled'
            && $candidate->interviewDate
            && !empty($candidate->interviewerUserId)
        ) {
            $interviewerUser = Users::find($candidate->interviewerUserId);
            if ($interviewerUser && $candidate->post) {
                $this->sendInterviewScheduleEmails(
                    $candidate,
                    $candidate->post,
                    $interviewerUser,
                    $request->boolean('isReschedule'),
                    $request->boolean('sendCandidateEmail'),
                    isset($validated['candidateEmailMessage'])
                        ? trim((string) $validated['candidateEmailMessage'])
                        : null
                );
            }
        }

        return response()->json($this->mapCandidate($candidate->fresh()));
    }

    public function sendCandidateEmail(Request $request, string $id)
    {
        $validated = $request->validate([
            'message' => 'required|string|max:10000',
            'subject' => 'nullable|string|max:255',
        ]);

        $candidate = ProposalCandidate::with('post')
            ->where('id', $id)
            ->where('createdBy', $this->getUserId())
            ->firstOrFail();

        if (empty($candidate->email)) {
            return response()->json(['message' => 'Candidate has no email on file.'], 422);
        }

        if ($candidate->stage !== 'interview_scheduled') {
            return response()->json(['message' => 'Email can only be sent for scheduled interviews.'], 422);
        }

        $interviewerUser = !empty($candidate->interviewerUserId)
            ? Users::find($candidate->interviewerUserId)
            : null;

        $postTitle = $candidate->post?->title ?? 'Job post';
        $message = trim((string) $validated['message']);
        $subject = !empty($validated['subject'])
            ? trim((string) $validated['subject'])
            : 'Regarding your interview – ' . $postTitle;

        $body = '<p>Dear ' . e($candidate->candidateName) . ',</p>'
            . '<p>' . nl2br(e($message)) . '</p>';

        if ($candidate->interviewDate) {
            $interviewAt = Carbon::parse($candidate->interviewDate)->format('d M Y, h:i A');
            $interviewerName = $candidate->interviewer ?? '—';
            $body .= '<p><strong>Scheduled interview:</strong> ' . e($interviewAt) . '<br>'
                . '<strong>Interviewer:</strong> ' . e($interviewerName) . '</p>';
        }

        try {
            $emailPayload = [
                'to_address' => $candidate->email,
                'subject' => $subject,
                'message' => $body,
                'path' => null,
            ];

            if ($interviewerUser && !empty($interviewerUser->email)) {
                $emailPayload['cc_address'] = $interviewerUser->email;
            }

            app(\App\Repositories\Contracts\EmailRepositoryInterface::class)->sendEmail($emailPayload);
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Failed to send email. Please check SMTP settings.'], 500);
        }

        return response()->json(['message' => 'Email sent successfully.']);
    }

    public function openCandidateCv(string $id)
    {
        $candidate = ProposalCandidate::where('id', $id)
            ->where('createdBy', $this->getUserId())
            ->firstOrFail();

        if (!$candidate->cvPath || !Storage::disk('local')->exists($candidate->cvPath)) {
            abort(404, 'CV not found.');
        }

        $path = Storage::disk('local')->path($candidate->cvPath);
        $mimeType = Storage::disk('local')->mimeType($candidate->cvPath) ?: 'application/octet-stream';
        $fileName = $candidate->cvOriginalName ?: ($candidate->candidateName . '-cv');

        return response()->file($path, [
            'Content-Type' => $mimeType,
            'Content-Disposition' => 'inline; filename="' . $fileName . '"',
        ]);
    }

    public function createFolder(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:100',
            'parentFolderId' => 'nullable|exists:proposalfolders,id',
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
            'folderId' => 'nullable|exists:proposalfolders,id',
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
            'folderId' => 'nullable|exists:proposalfolders,id',
            'baseUrl' => 'nullable|string|max:500',
        ]);

        $userId = $this->getUserId();
        $rootFolder = $this->ensureRootFolder($userId);
        $requestColumns = Schema::getColumnListing('proposalfilerequests');
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

    private function mapCandidate(ProposalCandidate $candidate): array
    {
        return [
            'id' => $candidate->id,
            'postId' => $candidate->postId,
            'candidateName' => $candidate->candidateName,
            'candidateCode' => $candidate->candidateCode,
            'phone' => $candidate->phone,
            'email' => $candidate->email,
            'category' => $candidate->category,
            'experienceYears' => $candidate->experienceYears,
            'workMode' => $candidate->workMode,
            'address' => $candidate->address,
            'cvOriginalName' => $candidate->cvOriginalName,
            'hasCv' => !empty($candidate->cvPath),
            'stage' => $candidate->stage,
            'interviewLevel' => $candidate->interviewLevel,
            'interviewDate' => $this->formatApiDateTime($candidate->interviewDate),
            'interviewer' => $candidate->interviewer ?? null,
            'interviewerUserId' => $candidate->interviewerUserId ?? null,
            'analysisNotes' => $candidate->analysisNotes,
            'rejectionReason' => $candidate->rejectionReason ?? null,
            'createdDate' => $this->formatApiDateTime($candidate->createdDate, $candidate->modifiedDate),
            'history' => $this->buildCandidateHistory($candidate),
        ];
    }

    private function buildCandidateHistory(ProposalCandidate $candidate): array
    {
        $historyQuery = ProposalCandidate::with('post')
            ->where('createdBy', $candidate->createdBy)
            ->where('id', '!=', $candidate->id);

        $this->applyCandidateHistoryMatch($historyQuery, $candidate);

        return $historyQuery
            ->orderByDesc('createdDate')
            ->limit(10)
            ->get()
            ->map(function (ProposalCandidate $historyCandidate) {
                return [
                    'postTitle' => $historyCandidate->post ? $historyCandidate->post->title : '',
                    'stage' => $historyCandidate->stage,
                    'createdDate' => $this->formatApiDateTime($historyCandidate->createdDate, $historyCandidate->modifiedDate),
                    'interviewDate' => $this->formatApiDateTime($historyCandidate->interviewDate),
                    'interviewer' => $historyCandidate->interviewer ?? null,
                ];
            })
            ->values()
            ->all();
    }

    private function getUserId(): string
    {
        return Auth::parseToken()->getPayload()->get('userId');
    }

    /** ISO-8601 string for Angular date pipes (avoids null / invalid DB values). */
    private function formatApiDateTime(mixed $value, mixed $fallback = null): ?string
    {
        foreach ([$value, $fallback] as $candidate) {
            if ($candidate === null || $candidate === '') {
                continue;
            }

            try {
                return Carbon::parse($candidate)->toIso8601String();
            } catch (\Throwable $th) {
                continue;
            }
        }

        return null;
    }

    /** @return string|null 13-digit CNIC without separators */
    private function normalizeCnicDigits(?string $cnic): ?string
    {
        if ($cnic === null || trim($cnic) === '') {
            return null;
        }

        $digits = preg_replace('/\D/', '', trim($cnic));

        return strlen($digits) === 13 ? $digits : null;
    }

    private function formatCnicFromInput(string $cnic): string
    {
        $digits = $this->normalizeCnicDigits($cnic);

        return $digits
            ? substr($digits, 0, 5) . '-' . substr($digits, 5, 7) . '-' . substr($digits, 12, 1)
            : trim($cnic);
    }

    private function sendInterviewScheduleEmails(
        ProposalCandidate $candidate,
        ProposalPost $post,
        Users $interviewerUser,
        bool $isReschedule = false,
        bool $sendCandidateEmail = false,
        ?string $candidateEmailMessage = null
    ): void {
        try {
            $interviewAt = Carbon::parse($candidate->interviewDate)->format('d M Y, h:i A');
            $postTitle = $post->title;
            $levelLabels = [
                'basic' => 'Beginner',
                'intermediate' => 'Intermediate',
                'advanced' => 'Advanced',
            ];
            $levelLabel = $levelLabels[$candidate->interviewLevel] ?? ($candidate->interviewLevel ?? 'Not set');
            $interviewerName = trim(
                ($interviewerUser->firstName ?? '') . ' ' . ($interviewerUser->lastName ?? '')
            ) ?: $interviewerUser->userName;

            if ($isReschedule) {
                if (!$sendCandidateEmail || empty($candidate->email)) {
                    return;
                }

                $candidateBody = '<p>Dear ' . e($candidate->candidateName) . ',</p>'
                    . '<p>Your interview for <strong>' . e($postTitle) . '</strong> has been <strong>rescheduled</strong>.</p>'
                    . '<p><strong>Date &amp; time:</strong> ' . e($interviewAt) . '<br>'
                    . '<strong>Interviewer:</strong> ' . e($interviewerName) . '<br>'
                    . '<strong>Interview kit:</strong> ' . e($levelLabel) . '</p>';

                if ($candidateEmailMessage !== null && $candidateEmailMessage !== '') {
                    $candidateBody .= '<p><strong>Message:</strong></p>'
                        . '<p>' . nl2br(e($candidateEmailMessage)) . '</p>';
                }

                $candidateBody .= '<p>Please be available at the updated time.</p>';

                $emailPayload = [
                    'to_address' => $candidate->email,
                    'subject' => 'Interview rescheduled – ' . $postTitle,
                    'message' => $candidateBody,
                    'path' => null,
                ];

                if (!empty($interviewerUser->email)) {
                    $emailPayload['cc_address'] = $interviewerUser->email;
                }

                app(\App\Repositories\Contracts\EmailRepositoryInterface::class)->sendEmail($emailPayload);

                return;
            }

            if (!empty($candidate->email)) {
                $candidateBody = '<p>Dear ' . e($candidate->candidateName) . ',</p>'
                    . '<p>Your interview for <strong>' . e($postTitle) . '</strong> has been scheduled.</p>'
                    . '<p><strong>Date &amp; time:</strong> ' . e($interviewAt) . '<br>'
                    . '<strong>Interviewer:</strong> ' . e($interviewerName) . '<br>'
                    . '<strong>Interview kit:</strong> ' . e($levelLabel) . '</p>'
                    . '<p>Please be available at the scheduled time.</p>';

                app(\App\Repositories\Contracts\EmailRepositoryInterface::class)->sendEmail([
                    'to_address' => $candidate->email,
                    'subject' => 'Interview scheduled – ' . $postTitle,
                    'message' => $candidateBody,
                    'path' => null,
                ]);
            }

            if (!empty($interviewerUser->email)) {
                $interviewerBody = '<p>Dear ' . e($interviewerName) . ',</p>'
                    . '<p>You are assigned to interview <strong>' . e($candidate->candidateName) . '</strong> for <strong>'
                    . e($postTitle) . '</strong>.</p>'
                    . '<p><strong>Date &amp; time:</strong> ' . e($interviewAt) . '<br>'
                    . '<strong>Candidate email:</strong> ' . e($candidate->email ?: '—') . '<br>'
                    . '<strong>Candidate phone:</strong> ' . e($candidate->phone ?: '—') . '<br>'
                    . '<strong>Interview kit:</strong> ' . e($levelLabel) . '</p>';

                app(\App\Repositories\Contracts\EmailRepositoryInterface::class)->sendEmail([
                    'to_address' => $interviewerUser->email,
                    'subject' => 'Interview assignment – ' . $postTitle,
                    'message' => $interviewerBody,
                    'path' => null,
                ]);
            }
        } catch (\Throwable $th) {
            // Email failure should not block candidate status update.
        }
    }

    private function listCategoriesData(string $userId): \Illuminate\Support\Collection
    {
        if (!Schema::hasTable('proposalcategories')) {
            return collect();
        }

        return ProposalCategory::where('createdBy', $userId)
            ->orderBy('name')
            ->get()
            ->map(fn (ProposalCategory $c) => $this->mapCategory($c))
            ->values();
    }

    private function listDepartmentsData(string $userId): \Illuminate\Support\Collection
    {
        if (!Schema::hasTable('proposaldepartments')) {
            return collect();
        }

        return ProposalDepartment::with('category')
            ->where('createdBy', $userId)
            ->orderBy('name')
            ->get()
            ->map(fn (ProposalDepartment $d) => $this->mapDepartment($d))
            ->values();
    }

    private function mapCategory(ProposalCategory $category): array
    {
        return [
            'id' => $category->id,
            'name' => $category->name,
            'createdDate' => $this->formatApiDateTime($category->createdDate, $category->modifiedDate),
        ];
    }

    private function mapDepartment(ProposalDepartment $department): array
    {
        return [
            'id' => $department->id,
            'categoryId' => $department->categoryId,
            'categoryName' => $department->category?->name,
            'name' => $department->name,
            'basicQuestions' => $department->basicQuestions,
            'intermediateQuestions' => $department->intermediateQuestions,
            'expertQuestions' => $department->expertQuestions,
            'createdDate' => $this->formatApiDateTime($department->createdDate, $department->modifiedDate),
        ];
    }

    private function mapPost(ProposalPost $post): array
    {
        return [
            'id' => $post->id,
            'title' => $post->title,
            'departmentId' => $post->departmentId ?? null,
            'department' => $post->department,
            'category' => $post->category,
            'experienceYears' => $post->experienceYears,
            'interviewKit' => $post->interviewKit,
            'basicQuestions' => $post->basicQuestions,
            'intermediateQuestions' => $post->intermediateQuestions,
            'expertQuestions' => $post->expertQuestions,
            'workMode' => $post->workMode,
            'address' => $post->address,
            'description' => $post->description,
            'createdDate' => $this->formatApiDateTime($post->createdDate, $post->modifiedDate),
            'candidates' => $post->candidates->map(fn (ProposalCandidate $c) => $this->mapCandidate($c))->values(),
        ];
    }

    private function findOwnedCategory(string $categoryId): ProposalCategory
    {
        return ProposalCategory::where('id', $categoryId)
            ->where('createdBy', $this->getUserId())
            ->firstOrFail();
    }

    private function findOwnedDepartment(string $departmentId): ProposalDepartment
    {
        return ProposalDepartment::with('category')
            ->where('id', $departmentId)
            ->where('createdBy', $this->getUserId())
            ->firstOrFail();
    }

    private function applyCandidateHistoryMatch($query, ProposalCandidate $candidate): void
    {
        $cnicDigits = $this->normalizeCnicDigits($candidate->candidateCode);
        $email = !empty($candidate->email) ? strtolower(trim($candidate->email)) : null;
        $this->applyCandidateLookupMatch($query, $cnicDigits, $email);
    }

    private function applyCandidateLookupMatch($query, ?string $cnicDigits, ?string $email): void
    {
        if (!$cnicDigits && !$email) {
            $query->whereRaw('0 = 1');

            return;
        }

        $query->where(function ($matchQuery) use ($cnicDigits, $email) {
            if ($cnicDigits) {
                $matchQuery->whereRaw(
                    "REPLACE(REPLACE(REPLACE(candidateCode, '-', ''), ' ', ''), '.', '') = ?",
                    [$cnicDigits]
                );
            }
            if ($email) {
                if ($cnicDigits) {
                    $matchQuery->orWhereRaw('LOWER(TRIM(email)) = ?', [$email]);
                } else {
                    $matchQuery->whereRaw('LOWER(TRIM(email)) = ?', [$email]);
                }
            }
        });
    }

    private function mapVaultCv(ProposalCandidateCv $cv): array
    {
        return [
            'id' => $cv->id,
            'cvOriginalName' => $cv->cvOriginalName,
            'createdDate' => $this->formatApiDateTime($cv->createdDate, $cv->modifiedDate),
        ];
    }

    private function syncApplicationCvsToVault(string $createdBy, ?string $cnicDigits, ?string $email): void
    {
        if (!Schema::hasTable('proposalcandidatecvs') || (!$cnicDigits && !$email)) {
            return;
        }

        $applicationsQuery = ProposalCandidate::where('createdBy', $createdBy)
            ->whereNotNull('cvPath')
            ->where('cvPath', '!=', '');
        $this->applyCandidateLookupMatch($applicationsQuery, $cnicDigits, $email);

        $existingPaths = ProposalCandidateCv::where('createdBy', $createdBy)
            ->where(function ($query) use ($cnicDigits, $email) {
                $this->applyVaultLookupMatch($query, $cnicDigits, $email);
            })
            ->pluck('cvPath')
            ->all();

        foreach ($applicationsQuery->orderBy('createdDate')->get() as $application) {
            if (!$application->cvPath || in_array($application->cvPath, $existingPaths, true)) {
                continue;
            }

            $now = Carbon::now();
            ProposalCandidateCv::create([
                'id' => Uuid::uuid4()->toString(),
                'createdBy' => $createdBy,
                'candidateCode' => $this->formatCnicFromInput($application->candidateCode ?? ''),
                'email' => !empty($application->email) ? strtolower(trim($application->email)) : null,
                'cvOriginalName' => $application->cvOriginalName,
                'cvPath' => $application->cvPath,
                'createdDate' => $application->createdDate ?? $now,
                'modifiedDate' => $application->modifiedDate ?? $now,
            ]);
            $existingPaths[] = $application->cvPath;
        }

        $this->enforceCvVaultLimit($createdBy, $cnicDigits, $email);
    }

    private function getCandidateCvVault(string $createdBy, ?string $cnicDigits, ?string $email): array
    {
        if (!Schema::hasTable('proposalcandidatecvs') || (!$cnicDigits && !$email)) {
            return [];
        }

        return ProposalCandidateCv::where('createdBy', $createdBy)
            ->where(function ($query) use ($cnicDigits, $email) {
                $this->applyVaultLookupMatch($query, $cnicDigits, $email);
            })
            ->orderByDesc('createdDate')
            ->limit(self::CANDIDATE_CV_LIMIT)
            ->get()
            ->map(fn (ProposalCandidateCv $cv) => $this->mapVaultCv($cv))
            ->values()
            ->all();
    }

    private function applyVaultLookupMatch($query, ?string $cnicDigits, ?string $email): void
    {
        if (!$cnicDigits && !$email) {
            $query->whereRaw('0 = 1');

            return;
        }

        $query->where(function ($matchQuery) use ($cnicDigits, $email) {
            if ($cnicDigits) {
                $matchQuery->whereRaw(
                    "REPLACE(REPLACE(REPLACE(candidateCode, '-', ''), ' ', ''), '.', '') = ?",
                    [$cnicDigits]
                );
            }
            if ($email) {
                if ($cnicDigits) {
                    $matchQuery->orWhereRaw('LOWER(TRIM(email)) = ?', [$email]);
                } else {
                    $matchQuery->whereRaw('LOWER(TRIM(email)) = ?', [$email]);
                }
            }
        });
    }

    private function addCvToVault(
        string $createdBy,
        string $candidateCode,
        ?string $email,
        $uploadedFile
    ): ProposalCandidateCv {
        if (!Schema::hasTable('proposalcandidatecvs')) {
            abort(500, 'CV storage is not available.');
        }

        $cvPath = $uploadedFile->storeAs(
            'proposal-candidates',
            Uuid::uuid4()->toString() . '.' . $uploadedFile->getClientOriginalExtension(),
            'local'
        );

        $now = Carbon::now();
        $vaultCv = ProposalCandidateCv::create([
            'id' => Uuid::uuid4()->toString(),
            'createdBy' => $createdBy,
            'candidateCode' => $this->formatCnicFromInput($candidateCode),
            'email' => !empty($email) ? strtolower(trim($email)) : null,
            'cvOriginalName' => $uploadedFile->getClientOriginalName(),
            'cvPath' => $cvPath,
            'createdDate' => $now,
            'modifiedDate' => $now,
        ]);

        $this->enforceCvVaultLimit(
            $createdBy,
            $this->normalizeCnicDigits($candidateCode),
            !empty($email) ? strtolower(trim($email)) : null
        );

        return $vaultCv->fresh();
    }

    private function enforceCvVaultLimit(string $createdBy, ?string $cnicDigits, ?string $email): void
    {
        if (!Schema::hasTable('proposalcandidatecvs') || (!$cnicDigits && !$email)) {
            return;
        }

        $entries = ProposalCandidateCv::where('createdBy', $createdBy)
            ->where(function ($query) use ($cnicDigits, $email) {
                $this->applyVaultLookupMatch($query, $cnicDigits, $email);
            })
            ->orderBy('createdDate')
            ->get();

        if ($entries->count() <= self::CANDIDATE_CV_LIMIT) {
            return;
        }

        $toDelete = $entries->slice(0, $entries->count() - self::CANDIDATE_CV_LIMIT);
        foreach ($toDelete as $entry) {
            if ($entry->cvPath && Storage::disk('local')->exists($entry->cvPath)) {
                Storage::disk('local')->delete($entry->cvPath);
            }
            $entry->delete();
        }
    }

    private function findVaultCvIdByPath(
        string $createdBy,
        ?string $cnicDigits,
        ?string $email,
        ?string $cvPath
    ): ?string {
        if (!$cvPath || !Schema::hasTable('proposalcandidatecvs')) {
            return null;
        }

        return ProposalCandidateCv::where('createdBy', $createdBy)
            ->where('cvPath', $cvPath)
            ->where(function ($query) use ($cnicDigits, $email) {
                $this->applyVaultLookupMatch($query, $cnicDigits, $email);
            })
            ->value('id');
    }

    private function findVaultCvForCandidate(
        string $createdBy,
        string $cvId,
        string $candidateCode,
        ?string $email
    ): ProposalCandidateCv {
        $cnicDigits = $this->normalizeCnicDigits($candidateCode);
        $normalizedEmail = !empty($email) ? strtolower(trim($email)) : null;

        return ProposalCandidateCv::where('id', $cvId)
            ->where('createdBy', $createdBy)
            ->where(function ($query) use ($cnicDigits, $normalizedEmail) {
                $this->applyVaultLookupMatch($query, $cnicDigits, $normalizedEmail);
            })
            ->firstOrFail();
    }

    private function resolveApplicationCv(
        Request $request,
        ProposalPost $post,
        string $candidateCode,
        ?string $email,
        bool $allowSkip
    ): ?array {
        $normalizedEmail = !empty($email) ? strtolower(trim($email)) : null;

        if ($request->filled('selectedCvId')) {
            $vaultCv = $this->findVaultCvForCandidate(
                $post->createdBy,
                $request->input('selectedCvId'),
                $candidateCode,
                $normalizedEmail
            );

            return [
                'cvPath' => $vaultCv->cvPath,
                'cvOriginalName' => $vaultCv->cvOriginalName,
            ];
        }

        if ($request->hasFile('cv')) {
            $vaultCv = $this->addCvToVault(
                $post->createdBy,
                $candidateCode,
                $normalizedEmail,
                $request->file('cv')
            );

            return [
                'cvPath' => $vaultCv->cvPath,
                'cvOriginalName' => $vaultCv->cvOriginalName,
            ];
        }

        if ($allowSkip) {
            return null;
        }

        abort(422, 'Please select an existing CV or upload a new one.');
    }
}

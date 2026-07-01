<?php

namespace App\Http\Controllers;

use App\Models\CandidateProfile;
use App\Models\ProposalCandidate;
use App\Models\ProposalCandidateCv;
use App\Models\ProposalPost;
use App\Models\Users;
use App\Services\CandidateAccountService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;
use Ramsey\Uuid\Uuid;

class CandidatePortalController extends Controller
{
    private const CV_DISPLAY_LIMIT = 5;

    private const CV_RETENTION_DAYS = 365;
    public function __construct(
        private readonly CandidateAccountService $candidateAccountService
    ) {}

    public function dashboard()
    {
        $profile = $this->requireProfile();
        $applications = $this->applicationsQuery($profile->userId)->get();

        $byStage = $applications->groupBy('stage')->map->count();

        return response()->json([
            'summary' => [
                'totalApplications' => $applications->count(),
                'cvReceived' => (int) ($byStage['cv_received'] ?? 0),
                'shortlisted' => (int) ($byStage['shortlisted'] ?? 0),
                'interviewScheduled' => (int) ($byStage['interview_scheduled'] ?? 0),
                'approved' => (int) ($byStage['approved'] ?? 0),
                'rejected' => (int) ($byStage['rejected'] ?? 0),
                'selected' => (int) ($byStage['selected'] ?? 0),
            ],
            'recentApplications' => $applications->take(5)->map(fn ($c) => $this->mapApplication($c))->values(),
        ]);
    }

    public function applications()
    {
        $profile = $this->requireProfile();
        $applications = $this->applicationsQuery($profile->userId)->get();

        return response()->json(
            $applications->map(fn ($c) => $this->mapApplication($c))->values()
        );
    }

    public function application(string $id)
    {
        $profile = $this->requireProfile();
        $candidate = $this->applicationsQuery($profile->userId)
            ->where('proposalcandidates.id', $id)
            ->firstOrFail();

        return response()->json($this->mapApplication($candidate, true));
    }

    public function history()
    {
        $profile = $this->requireProfile();
        $applications = $this->applicationsQuery($profile->userId)->get();

        return response()->json([
            'candidateName' => $profile->user?->firstName . ' ' . ($profile->user?->lastName ?? ''),
            'candidateCode' => $profile->candidateCode,
            'email' => $profile->email,
            'applications' => $applications->map(fn ($c) => $this->mapApplication($c))->values(),
        ]);
    }

    public function recommendedJobs()
    {
        $profile = $this->requireProfile();
        $appliedPostIds = ProposalCandidate::where('candidateUserId', $profile->userId)
            ->pluck('postId')
            ->all();

        $categories = array_values(array_filter(array_unique(array_merge(
            $profile->preferredCategory ? [$profile->preferredCategory] : [],
            ProposalCandidate::where('candidateUserId', $profile->userId)
                ->with('post')
                ->get()
                ->map(fn ($c) => $c->post?->category)
                ->filter()
                ->all()
        ))));

        $query = ProposalPost::query()->orderByDesc('createdDate');
        if (!empty($categories)) {
            $query->whereIn('category', $categories);
        }

        if (!empty($appliedPostIds)) {
            $query->whereNotIn('id', $appliedPostIds);
        }

        $posts = $query->limit(24)->get();

        return response()->json(
            $posts->map(fn (ProposalPost $post) => [
                'id' => $post->id,
                'title' => $post->title,
                'department' => $post->department,
                'category' => $post->category,
                'experienceYears' => $post->experienceYears,
                'workMode' => $post->workMode,
                'address' => $post->address,
                'createdDate' => $post->createdDate?->toIso8601String(),
                'applyUrl' => rtrim((string) config('app.url'), '/') . '/post-apply/' . $post->id,
            ])->values()
        );
    }

    public function profile()
    {
        $profile = $this->requireProfile()->load('user');

        return response()->json($this->mapProfile($profile));
    }

    public function updateProfile(Request $request)
    {
        $profile = $this->requireProfile()->load('user');
        $userId = $profile->userId;

        $validated = $request->validate([
            'candidateName' => 'required|string|max:255',
            'email' => [
                'required',
                'email',
                'max:255',
                Rule::unique('users', 'email')->ignore($userId),
                Rule::unique('candidateprofiles', 'email')->ignore($profile->id),
            ],
            'phone' => 'nullable|string|max:50',
            'experienceYears' => 'nullable|integer|min:0|max:60',
            'workMode' => 'nullable|string|in:remote,physical',
            'address' => 'nullable|string|max:500',
            'preferredCategory' => 'nullable|string|max:255',
        ]);

        $email = strtolower(trim($validated['email']));
        $nameParts = $this->splitName(trim($validated['candidateName']));

        $profile->email = $email;
        $profile->phone = $validated['phone'] ?? $profile->phone;
        $profile->experienceYears = $validated['experienceYears'] ?? $profile->experienceYears;
        $profile->workMode = $validated['workMode'] ?? $profile->workMode;
        $profile->address = $validated['address'] ?? $profile->address;
        if (array_key_exists('preferredCategory', $validated)) {
            $profile->preferredCategory = $validated['preferredCategory'];
        }
        $profile->modifiedDate = Carbon::now();
        $profile->save();

        if ($profile->user) {
            $profile->user->firstName = $nameParts['first'];
            $profile->user->lastName = $nameParts['last'];
            $profile->user->email = $email;
            $profile->user->userName = $email;
            $profile->user->normalizedEmail = strtoupper($email);
            $profile->user->normalizedUserName = strtoupper($email);
            $profile->user->phoneNumber = $validated['phone'] ?? $profile->user->phoneNumber;
            $profile->user->save();
        }

        ProposalCandidate::where('candidateUserId', $profile->userId)->update([
            'candidateName' => trim($validated['candidateName']),
            'email' => $email,
            'phone' => $profile->phone,
            'experienceYears' => $profile->experienceYears,
            'workMode' => $profile->workMode,
            'address' => $profile->address,
            'modifiedDate' => Carbon::now(),
        ]);

        return response()->json($this->mapProfile($profile->fresh()->load('user')));
    }

    public function uploadCv(Request $request)
    {
        $profile = $this->requireProfile();

        $request->validate([
            'cv' => 'required|file|mimes:pdf,doc,docx|max:10240',
        ]);

        if (!Schema::hasTable('proposalcandidatecvs')) {
            abort(500, 'CV storage is not available.');
        }

        $cnicDigits = preg_replace('/\D+/', '', $profile->candidateCode);
        $email = strtolower(trim($profile->email));
        $createdBy = $this->resolveVaultCreatedBy($profile);

        $currentCount = $this->vaultQuery($cnicDigits, $email)->count();
        if ($currentCount >= self::CV_DISPLAY_LIMIT) {
            abort(422, 'You can save up to ' . self::CV_DISPLAY_LIMIT . ' CVs. Remove old ones or wait for expiry.');
        }

        $file = $request->file('cv');
        $cvPath = $file->storeAs(
            'proposal-candidates',
            Uuid::uuid4()->toString() . '.' . $file->getClientOriginalExtension(),
            'local'
        );

        $now = Carbon::now();
        $vaultCv = ProposalCandidateCv::create([
            'id' => Uuid::uuid4()->toString(),
            'createdBy' => $createdBy,
            'candidateCode' => $profile->candidateCode,
            'email' => $email,
            'cvOriginalName' => $file->getClientOriginalName(),
            'cvPath' => $cvPath,
            'createdDate' => $now,
            'modifiedDate' => $now,
        ]);

        $this->purgeExpiredVaultCvs($cnicDigits, $email);

        return response()->json([
            'cv' => $this->mapVaultCv($vaultCv),
            'cvs' => $this->listVaultCvs($profile),
        ], 201);
    }

    public function applyCvToApplications(Request $request)
    {
        $profile = $this->requireProfile();

        $validated = $request->validate([
            'cvId' => 'required|uuid',
        ]);

        $cnicDigits = preg_replace('/\D+/', '', $profile->candidateCode);
        $email = strtolower(trim($profile->email));

        $vaultCv = $this->vaultQuery($cnicDigits, $email)
            ->where('id', $validated['cvId'])
            ->firstOrFail();

        $updated = ProposalCandidate::where('candidateUserId', $profile->userId)
            ->whereIn('stage', ['cv_received', 'shortlisted'])
            ->update([
                'cvPath' => $vaultCv->cvPath,
                'cvOriginalName' => $vaultCv->cvOriginalName,
                'modifiedDate' => Carbon::now(),
            ]);

        return response()->json([
            'updatedApplications' => $updated,
            'cv' => $this->mapVaultCv($vaultCv),
        ]);
    }

    public function downloadCv(string $id)
    {
        $profile = $this->requireProfile();
        $cnicDigits = preg_replace('/\D+/', '', $profile->candidateCode);
        $email = strtolower(trim($profile->email));

        $vaultCv = $this->vaultQuery($cnicDigits, $email)
            ->where('id', $id)
            ->firstOrFail();

        if (!$vaultCv->cvPath || !Storage::disk('local')->exists($vaultCv->cvPath)) {
            abort(404, 'CV file not found.');
        }

        return Storage::disk('local')->download(
            $vaultCv->cvPath,
            $vaultCv->cvOriginalName ?: 'cv.pdf'
        );
    }

    public function cvs()
    {
        $profile = $this->requireProfile();
        if (!Schema::hasTable('proposalcandidatecvs')) {
            return response()->json([
                'items' => [],
                'maxCvs' => self::CV_DISPLAY_LIMIT,
                'cvRetentionDays' => self::CV_RETENTION_DAYS,
            ]);
        }

        return response()->json([
            'items' => $this->listVaultCvs($profile),
            'maxCvs' => self::CV_DISPLAY_LIMIT,
            'cvRetentionDays' => self::CV_RETENTION_DAYS,
        ]);
    }

    private function requireProfile(): CandidateProfile
    {
        $userId = Auth::id();
        $profile = $this->candidateAccountService->findProfileForUser($userId);

        if (!$profile) {
            abort(403, 'Candidate profile not found for this account.');
        }

        return $profile;
    }

    private function applicationsQuery(string $userId)
    {
        return ProposalCandidate::with('post')
            ->where('candidateUserId', $userId)
            ->orderByDesc('createdDate');
    }

    private function mapProfile(CandidateProfile $profile): array
    {
        $user = $profile->user;

        return [
            'userId' => $profile->userId,
            'candidateName' => trim(($user?->firstName ?? '') . ' ' . ($user?->lastName ?? '')),
            'userName' => $user?->userName ?? $profile->email,
            'candidateCode' => $profile->candidateCode,
            'email' => $profile->email,
            'phone' => $profile->phone,
            'experienceYears' => $profile->experienceYears,
            'workMode' => $profile->workMode,
            'address' => $profile->address,
            'preferredCategory' => $profile->preferredCategory,
        ];
    }

    private function mapApplication(ProposalCandidate $candidate, bool $detailed = false): array
    {
        $post = $candidate->post;
        $payload = [
            'id' => $candidate->id,
            'postId' => $candidate->postId,
            'postTitle' => $post?->title ?? '',
            'department' => $post?->department,
            'category' => $post?->category,
            'stage' => $candidate->stage,
            'stageLabel' => $this->stageLabel($candidate->stage),
            'experienceYears' => $candidate->experienceYears,
            'workMode' => $candidate->workMode,
            'hasCv' => !empty($candidate->cvPath),
            'cvOriginalName' => $candidate->cvOriginalName,
            'createdDate' => $candidate->createdDate?->toIso8601String(),
            'modifiedDate' => $candidate->modifiedDate?->toIso8601String(),
        ];

        if (in_array($candidate->stage, ['interview_scheduled', 'approved', 'selected'], true)) {
            $payload['interviewDate'] = $candidate->interviewDate?->toIso8601String();
            $payload['interviewer'] = $candidate->interviewer;
        }

        if ($detailed && $post?->description) {
            $payload['postDescription'] = $post->description;
        }

        return $payload;
    }

    private function stageLabel(string $stage): string
    {
        return match ($stage) {
            'cv_received' => 'CV Received',
            'shortlisted' => 'Shortlisted',
            'interview_scheduled' => 'Interview Scheduled',
            'approved' => 'Approved',
            'rejected' => 'Rejected',
            'selected' => 'Selected',
            default => $stage,
        };
    }

    private function splitName(string $fullName): array
    {
        $fullName = trim($fullName);
        if ($fullName === '') {
            return ['first' => 'Candidate', 'last' => ''];
        }

        $parts = preg_split('/\s+/', $fullName) ?: [];
        $first = array_shift($parts) ?: 'Candidate';
        $last = implode(' ', $parts);

        return ['first' => $first, 'last' => $last];
    }

    private function resolveVaultCreatedBy(CandidateProfile $profile): string
    {
        $fromApplication = ProposalCandidate::where('candidateUserId', $profile->userId)
            ->orderByDesc('createdDate')
            ->value('createdBy');

        if ($fromApplication) {
            return (string) $fromApplication;
        }

        return (string) (Users::withoutGlobalScopes()->where('isSystemUser', true)->value('id')
            ?? Users::withoutGlobalScopes()->value('id'));
    }

    private function vaultQuery(?string $cnicDigits, ?string $email)
    {
        return ProposalCandidateCv::query()->where(function ($query) use ($cnicDigits, $email) {
            if ($cnicDigits) {
                $query->whereRaw(
                    "REPLACE(REPLACE(REPLACE(candidateCode, '-', ''), ' ', ''), '.', '') = ?",
                    [$cnicDigits]
                );
            }
            if ($email) {
                if ($cnicDigits) {
                    $query->orWhereRaw('LOWER(TRIM(email)) = ?', [$email]);
                } else {
                    $query->whereRaw('LOWER(TRIM(email)) = ?', [$email]);
                }
            }
        });
    }

    private function listVaultCvs(CandidateProfile $profile): array
    {
        $cnicDigits = preg_replace('/\D+/', '', $profile->candidateCode);
        $email = strtolower(trim($profile->email));

        return $this->vaultQuery($cnicDigits, $email)
            ->orderByDesc('createdDate')
            ->limit(self::CV_DISPLAY_LIMIT)
            ->get()
            ->map(fn ($cv) => $this->mapVaultCv($cv))
            ->values()
            ->all();
    }

    private function mapVaultCv(ProposalCandidateCv $cv): array
    {
        return [
            'id' => $cv->id,
            'cvOriginalName' => $cv->cvOriginalName,
            'createdDate' => $cv->createdDate?->toIso8601String(),
        ];
    }

    private function purgeExpiredVaultCvs(?string $cnicDigits, ?string $email): void
    {
        if (!Schema::hasTable('proposalcandidatecvs') || (!$cnicDigits && !$email)) {
            return;
        }

        $cutoff = Carbon::now()->subDays(self::CV_RETENTION_DAYS);
        $entries = $this->vaultQuery($cnicDigits, $email)
            ->orderByDesc('createdDate')
            ->get();

        $expired = $entries->filter(function (ProposalCandidateCv $entry) use ($cutoff) {
            if (!$entry->createdDate) {
                return false;
            }

            return Carbon::parse($entry->createdDate)->lt($cutoff);
        })->values();

        if ($expired->count() <= 1) {
            return;
        }

        foreach ($expired->slice(1) as $entry) {
            $path = $entry->cvPath;
            $entry->delete();
            if ($path && Storage::disk('local')->exists($path)) {
                Storage::disk('local')->delete($path);
            }
        }
    }
}

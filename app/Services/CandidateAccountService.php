<?php

namespace App\Services;

use App\Models\CandidateProfile;
use App\Models\ProposalCandidate;
use App\Models\ProposalPost;
use App\Models\UserRoles;
use App\Models\Users;
use App\Repositories\Contracts\EmailRepositoryInterface;
use Carbon\Carbon;
use Database\Seeders\PermissionSeederV58;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Str;
use Ramsey\Uuid\Uuid;

class CandidateAccountService
{
    public function __construct(
        private readonly EmailRepositoryInterface $emailRepository
    ) {}

    /**
     * Ensure a portal user exists for this applicant. Returns account meta for API responses.
     *
     * @return array{userId: string, created: bool, credentialsEmailed: bool}
     */
    public function ensurePortalAccount(ProposalCandidate $candidate, ProposalPost $post): array
    {
        if (!Schema::hasTable('candidateprofiles')) {
            return ['userId' => '', 'created' => false, 'credentialsEmailed' => false];
        }

        $email = strtolower(trim((string) $candidate->email));
        $cnicFormatted = $this->formatCnic((string) $candidate->candidateCode);
        $cnicDigits = $this->normalizeCnicDigits($cnicFormatted);

        if ($email === '' || !$cnicDigits) {
            return ['userId' => '', 'created' => false, 'credentialsEmailed' => false];
        }

        $existingProfile = CandidateProfile::where('candidateCode', $cnicFormatted)
            ->orWhere('email', $email)
            ->first();

        if ($existingProfile) {
            $this->linkApplicationsToUser($existingProfile->userId, $cnicDigits, $email);
            $this->syncProfileFromCandidate($existingProfile, $candidate, $post);

            return [
                'userId' => $existingProfile->userId,
                'created' => false,
                'credentialsEmailed' => false,
            ];
        }

        $orphanUser = $this->findUserByEmail($email);
        if ($orphanUser) {
            return $this->completePortalAccountForUser(
                $orphanUser,
                $candidate,
                $post,
                $cnicFormatted,
                $cnicDigits,
                true
            );
        }

        $plainPassword = $this->generatePassword();
        $now = Carbon::now();
        $nameParts = $this->splitName((string) $candidate->candidateName);

        $userId = DB::transaction(function () use (
            $nameParts,
            $email,
            $plainPassword,
            $now,
            $candidate,
            $post,
            $cnicFormatted,
            $cnicDigits
        ) {
            $user = Users::create([
                'firstName' => $nameParts['first'],
                'lastName' => $nameParts['last'],
                'userName' => $email,
                'normalizedUserName' => strtoupper($email),
                'email' => $email,
                'normalizedEmail' => strtoupper($email),
                'phoneNumber' => $candidate->phone,
                'password' => Hash::make($plainPassword),
                'isDeleted' => 0,
                'emailConfirmed' => 1,
                'phoneNumberConfirmed' => 0,
                'twoFactorEnabled' => 0,
                'lockoutEnabled' => 0,
                'accessFailedCount' => 0,
                'isSystemUser' => 0,
            ]);

            $userId = (string) $user->id;

            UserRoles::create([
                'userId' => $userId,
                'roleId' => PermissionSeederV58::CANDIDATE_ROLE_ID,
            ]);

            CandidateProfile::create([
                'id' => Uuid::uuid4()->toString(),
                'userId' => $userId,
                'candidateCode' => $cnicFormatted,
                'email' => $email,
                'phone' => $candidate->phone,
                'experienceYears' => $candidate->experienceYears,
                'workMode' => $candidate->workMode,
                'address' => $candidate->address,
                'preferredCategory' => $post->category,
                'createdDate' => $now,
                'modifiedDate' => $now,
            ]);

            $this->linkApplicationsToUser($userId, $cnicDigits, $email);

            return $userId;
        });

        $credentialsEmailed = $this->sendWelcomeEmail(
            $candidate->candidateName,
            $email,
            $email,
            $plainPassword
        );

        return [
            'userId' => $userId,
            'created' => true,
            'credentialsEmailed' => $credentialsEmailed,
        ];
    }

    public function linkApplicationsToUser(string $userId, ?string $cnicDigits, ?string $email): void
    {
        if (!Schema::hasColumn('proposalcandidates', 'candidateUserId')) {
            return;
        }

        $query = ProposalCandidate::query()->whereNull('candidateUserId');

        $query->where(function ($inner) use ($cnicDigits, $email) {
            $matched = false;
            if ($cnicDigits) {
                $inner->orWhereRaw(
                    "REPLACE(REPLACE(REPLACE(candidateCode, '-', ''), ' ', ''), '.', '') = ?",
                    [$cnicDigits]
                );
                $matched = true;
            }
            if ($email) {
                $inner->orWhereRaw('LOWER(TRIM(email)) = ?', [strtolower(trim($email))]);
                $matched = true;
            }
            if (!$matched) {
                $inner->whereRaw('1 = 0');
            }
        });

        $query->update([
            'candidateUserId' => $userId,
            'modifiedDate' => Carbon::now(),
        ]);
    }

    public function findProfileForUser(string $userId): ?CandidateProfile
    {
        return CandidateProfile::where('userId', $userId)->first();
    }

    /**
     * @return array{userId: string, created: bool, credentialsEmailed: bool}
     */
    private function completePortalAccountForUser(
        Users $user,
        ProposalCandidate $candidate,
        ProposalPost $post,
        string $cnicFormatted,
        ?string $cnicDigits,
        bool $sendCredentialsEmail
    ): array {
        $email = strtolower(trim((string) $candidate->email));
        $userId = (string) $user->id;
        $plainPassword = $this->generatePassword();
        $now = Carbon::now();

        DB::transaction(function () use (
            $user,
            $userId,
            $plainPassword,
            $now,
            $candidate,
            $post,
            $cnicFormatted,
            $cnicDigits,
            $email
        ) {
            $user->password = Hash::make($plainPassword);
            $user->phoneNumber = $candidate->phone ?: $user->phoneNumber;
            $user->save();

            $hasRole = UserRoles::where('userId', $userId)
                ->where('roleId', PermissionSeederV58::CANDIDATE_ROLE_ID)
                ->exists();

            if (!$hasRole) {
                UserRoles::create([
                    'userId' => $userId,
                    'roleId' => PermissionSeederV58::CANDIDATE_ROLE_ID,
                ]);
            }

            if (!CandidateProfile::where('userId', $userId)->exists()) {
                CandidateProfile::create([
                    'id' => Uuid::uuid4()->toString(),
                    'userId' => $userId,
                    'candidateCode' => $cnicFormatted,
                    'email' => $email,
                    'phone' => $candidate->phone,
                    'experienceYears' => $candidate->experienceYears,
                    'workMode' => $candidate->workMode,
                    'address' => $candidate->address,
                    'preferredCategory' => $post->category,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                ]);
            }

            $this->linkApplicationsToUser($userId, $cnicDigits, $email);
        });

        $credentialsEmailed = false;
        if ($sendCredentialsEmail) {
            $credentialsEmailed = $this->sendWelcomeEmail(
                $candidate->candidateName,
                $email,
                $email,
                $plainPassword
            );
        }

        return [
            'userId' => $userId,
            'created' => true,
            'credentialsEmailed' => $credentialsEmailed,
        ];
    }

    private function findUserByEmail(string $email): ?Users
    {
        return Users::withoutGlobalScopes()
            ->where('isDeleted', 0)
            ->where(function ($query) use ($email) {
                $query->whereRaw('LOWER(TRIM(email)) = ?', [$email])
                    ->orWhereRaw('LOWER(TRIM(userName)) = ?', [$email]);
            })
            ->first();
    }

    private function syncProfileFromCandidate(
        CandidateProfile $profile,
        ProposalCandidate $candidate,
        ProposalPost $post
    ): void {
        $profile->phone = $candidate->phone ?: $profile->phone;
        $profile->experienceYears = $candidate->experienceYears ?? $profile->experienceYears;
        $profile->workMode = $candidate->workMode ?: $profile->workMode;
        $profile->address = $candidate->address ?: $profile->address;
        if (!$profile->preferredCategory && $post->category) {
            $profile->preferredCategory = $post->category;
        }
        $profile->modifiedDate = Carbon::now();
        $profile->save();
    }

    private function sendWelcomeEmail(
        string $candidateName,
        string $email,
        string $username,
        string $plainPassword
    ): bool {
        $loginUrl = rtrim((string) config('app.url'), '/') . '/login';
        $body = '<p>Dear ' . e($candidateName) . ',</p>'
            . '<p>Thank you for applying. Your <strong>Candidate Portal</strong> account has been created.</p>'
            . '<p><strong>Username:</strong> ' . e($username) . '<br>'
            . '<strong>Password:</strong> ' . e($plainPassword) . '</p>'
            . '<p>Login here: <a href="' . e($loginUrl) . '">' . e($loginUrl) . '</a></p>'
            . '<p>After login you can view your applications, update your profile, and browse recommended jobs.</p>'
            . '<p>Please change your password after your first login.</p>';

        try {
            $this->emailRepository->sendEmail([
                'to_address' => $email,
                'subject' => 'Your Candidate Portal account',
                'message' => $body,
                'path' => null,
            ]);

            return true;
        } catch (\Throwable) {
            return false;
        }
    }

    private function generatePassword(): string
    {
        return Str::upper(Str::random(4)) . random_int(1000, 9999) . Str::lower(Str::random(2));
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

    private function normalizeCnicDigits(?string $value): ?string
    {
        if ($value === null || $value === '') {
            return null;
        }

        $digits = preg_replace('/\D+/', '', $value);

        return strlen($digits) === 13 ? $digits : null;
    }

    private function formatCnic(string $cnic): string
    {
        $digits = $this->normalizeCnicDigits($cnic);

        return $digits
            ? substr($digits, 0, 5) . '-' . substr($digits, 5, 7) . '-' . substr($digits, 12, 1)
            : trim($cnic);
    }
}

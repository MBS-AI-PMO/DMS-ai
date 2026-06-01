<?php

namespace App\Http\Controllers;

use App\Models\LoginAudit;
use App\Models\Users;
use App\Repositories\Contracts\CompanyProfileRepositoryInterface;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Http\Request;
use App\Repositories\Contracts\UserRepositoryInterface;
use Carbon\Carbon;
use PHPOpenSourceSaver\JWTAuth\Facades\JWTAuth;
use Illuminate\Support\Facades\Schema;
use App\Support\TableName;

class AuthController extends Controller
{
    private $userRepository;
    private $companyprofileRepository;

    /** Last login failure (for logs + debug JSON when APP_DEBUG / LOGIN_DEBUG). */
    private ?string $loginFailureReason = null;
    private array $loginFailureDetail = [];
    private ?string $loginJwtError = null;

    public function __construct(UserRepositoryInterface $userRepository, CompanyProfileRepositoryInterface $companyprofileRepository)
    {
        $this->userRepository = $userRepository;
        $this->companyprofileRepository = $companyprofileRepository;
    }

    public function login(Request $request)
    {
        $this->resetLoginDebug();

        $loginId = trim((string) $request->input('email', ''));
        $password = (string) $request->input('password', '');
        $remoteIP = $this->getIp();
        $auditStatus = 'Error';
        $token = null;
        $user = null;
        $userclaims = [];

        if ($loginId === '' || $password === '') {
            $this->setLoginFailure('EMPTY_CREDENTIALS', [
                'emailProvided' => $loginId !== '',
                'passwordProvided' => $password !== '',
            ]);
        } else {
            try {
                $user = $this->findUserForLogin($loginId);

                if (!$user) {
                    // reason already set in findUserForLogin
                } elseif (!$this->verifyPassword($user, $password)) {
                    // reason set in verifyPassword
                } else {
                    $license = $this->getLicenseFromCompanyProfile();
                    $userclaims = $this->resolveUserClaims($user->id);
                    $token = $this->issueAuthToken($user, $userclaims, $license);
                    $auditStatus = $token ? 'Success' : 'Error';

                    if (!$token) {
                        $this->setLoginFailure('JWT_TOKEN_NOT_CREATED', [
                            'userId' => $user->id,
                            'jwtError' => $this->loginJwtError,
                            'jwtSecretSet' => (bool) config('jwt.secret'),
                            'hint' => 'Run: php artisan jwt:secret — then php artisan config:clear',
                        ]);
                    }
                }
            } catch (\Throwable $e) {
                $this->setLoginFailure('EXCEPTION', [
                    'message' => $e->getMessage(),
                    'file' => $e->getFile(),
                    'line' => $e->getLine(),
                ]);
                Log::error('Login exception', [
                    'message' => $e->getMessage(),
                    'trace' => $e->getTraceAsString(),
                ]);
            }
        }

        $this->recordLoginAudit(
            $loginId,
            $remoteIP,
            $auditStatus,
            $request->input('latitude'),
            $request->input('longitude')
        );

        if (!$token || !$user) {
            $this->logLoginFailure($loginId);

            $debugPayload = $this->buildLoginDebugPayload();

            // Hard stop: .env LOGIN_DD=true OR ?debug_login=1 with APP_DEBUG
            if ($this->shouldDdLoginDebug($request)) {
                dd($debugPayload);
            }

            $response = [
                'status' => 'error',
                'message' => 'Unauthorized',
            ];

            if ($this->shouldExposeLoginDebug($request)) {
                $response['debug'] = $debugPayload;
            }

            return response()->json($response, 401);
        }

        $user->claims = $userclaims;

        return response()->json([
            'status' => 'success',
            'claims' => $userclaims,
            'user' => [
                'id' => $user->id,
                'firstName' =>  $user->firstName,
                'lastName' => $user->lastName,
                'email' => $user->email,
                'userName' => $user->userName,
                'phoneNumber' => $user->phoneNumber
            ],
            'authorisation' => [
                'token' => $token,
                'type' => 'bearer',
            ]
        ]);
    }

    private function resolveUserClaims(string $userId): array
    {
        $userrolesTable = TableName::resolve('userRoles') ?? 'userroles';
        $rolesTable = TableName::resolve('roles') ?? 'roles';
        $roleclaimsTable = TableName::resolve('roleClaims') ?? 'roleclaims';
        $userclaimsTable = TableName::resolve('userClaims') ?? 'userclaims';

        if (!TableName::has('userRoles') || !TableName::has('roles') || !TableName::has('roleClaims')) {
            Log::warning('[LOGIN] Claims tables not found — login continues with empty permissions', [
                'database' => DB::connection()->getDatabaseName(),
                'userRoles' => $userrolesTable,
                'roles' => $rolesTable,
                'roleClaims' => $roleclaimsTable,
                'hint' => 'Import dms-ahi.sql into DB_DATABASE in .env',
            ]);

            return [];
        }

        try {
            $userclaimsFromRole = DB::table($userrolesTable)
                ->select($roleclaimsTable . '.claimType')
                ->leftJoin($rolesTable, $rolesTable . '.id', '=', $userrolesTable . '.roleId')
                ->leftJoin($roleclaimsTable, $roleclaimsTable . '.roleId', '=', $rolesTable . '.id')
                ->where($userrolesTable . '.userId', '=', $userId)
                ->get()
                ->toArray();

            $userIndividualClaims = [];
            if ($userclaimsTable) {
                $userIndividualClaims = DB::table($userclaimsTable)
                    ->select('claimType')
                    ->where($userclaimsTable . '.userId', '=', $userId)
                    ->get()
                    ->toArray();
            }
        } catch (\Throwable $e) {
            Log::error('[LOGIN] resolveUserClaims failed: ' . $e->getMessage());
            $this->setLoginFailure('CLAIMS_QUERY_FAILED', ['message' => $e->getMessage()]);

            return [];
        }

        $allClaimsObjArray = array_merge($userclaimsFromRole, $userIndividualClaims);

        $userclaims = array_map(function ($value) {
            return $value->claimType;
        }, $allClaimsObjArray);

        $userclaims = array_unique($userclaims);
        sort($userclaims);

        return $userclaims;
    }

    private function resetLoginDebug(): void
    {
        $this->loginFailureReason = null;
        $this->loginFailureDetail = [];
        $this->loginJwtError = null;
    }

    private function setLoginFailure(string $reason, array $detail = []): void
    {
        $this->loginFailureReason = $reason;
        $this->loginFailureDetail = $detail;
    }

    private function logLoginFailure(string $loginId): void
    {
        Log::error('[LOGIN_FAIL]', [
            'reason' => $this->loginFailureReason ?? 'UNKNOWN',
            'loginId' => $loginId,
            'detail' => $this->loginFailureDetail,
            'jwtError' => $this->loginJwtError,
            'ip' => request()->ip(),
        ]);
    }

    private function buildLoginDebugPayload(): array
    {
        return [
            'reason' => $this->loginFailureReason ?? 'UNKNOWN',
            'detail' => $this->loginFailureDetail,
            'jwtError' => $this->loginJwtError,
            'jwtSecretConfigured' => filled(config('jwt.secret')),
            'appDebug' => (bool) config('app.debug'),
        ];
    }

    /** Show debug in 401 JSON: APP_DEBUG=true or LOGIN_DEBUG=true in .env */
    private function shouldExposeLoginDebug(Request $request): bool
    {
        if (config('app.debug')) {
            return true;
        }

        return filter_var(env('LOGIN_DEBUG', false), FILTER_VALIDATE_BOOLEAN)
            || $request->boolean('debug_login');
    }

    /** dd() on fail: LOGIN_DD=true in .env and (APP_DEBUG or ?debug_login=1) */
    private function shouldDdLoginDebug(Request $request): bool
    {
        if (!filter_var(env('LOGIN_DD', false), FILTER_VALIDATE_BOOLEAN)) {
            return false;
        }

        return config('app.debug') || $request->boolean('debug_login');
    }

    private function findUserForLogin(string $loginId): ?Users
    {
        $candidates = Users::withoutGlobalScopes()
            ->where(function ($query) use ($loginId) {
                $query->where('email', $loginId)
                    ->orWhere('userName', $loginId);
            })
            ->get();

        if ($candidates->isEmpty()) {
            $this->setLoginFailure('USER_NOT_FOUND', [
                'loginId' => $loginId,
                'hint' => 'No row in users with this email or userName',
            ]);
            return null;
        }

        $user = $candidates->first();

        if ((int) ($user->isDeleted ?? 0) !== 0) {
            $this->setLoginFailure('USER_DELETED', [
                'userId' => $user->id,
                'email' => $user->email,
                'isDeleted' => $user->isDeleted,
            ]);
            return null;
        }

        if (
            Schema::hasColumn('users', 'isSystemUser')
            && (int) ($user->isSystemUser ?? 0) !== 0
        ) {
            $this->setLoginFailure('USER_IS_SYSTEM', [
                'userId' => $user->id,
                'isSystemUser' => $user->isSystemUser,
            ]);
            return null;
        }

        return $user;
    }

    private function verifyPassword(Users $user, string $password): bool
    {
        $stored = (string) ($user->password ?? '');
        if ($stored === '') {
            $this->setLoginFailure('PASSWORD_EMPTY_IN_DB', [
                'userId' => $user->id,
                'email' => $user->email,
            ]);
            return false;
        }

        if (Hash::check($password, $stored)) {
            return true;
        }

        $isBcrypt = str_starts_with($stored, '$2y$')
            || str_starts_with($stored, '$2a$')
            || str_starts_with($stored, '$2b$');

        if (!$isBcrypt && hash_equals($stored, $password)) {
            return true;
        }

        $this->setLoginFailure('WRONG_PASSWORD', [
            'userId' => $user->id,
            'email' => $user->email,
            'passwordIsBcrypt' => $isBcrypt,
            'passwordPrefix' => substr($stored, 0, 7),
            'hint' => $isBcrypt
                ? 'Password does not match bcrypt hash — reset password in DB'
                : 'Plain-text compare also failed',
        ]);

        return false;
    }

    private function getLicenseFromCompanyProfile(): array
    {
        try {
            $profile = $this->companyprofileRepository->getCompanyProfile();
            if (is_array($profile)) {
                return [
                    'licensekey' => $profile['licenseKey'] ?? '',
                    'purchasecode' => $profile['purchaseCode'] ?? '',
                ];
            }

            return [
                'licensekey' => $profile->licenseKey ?? '',
                'purchasecode' => $profile->purchaseCode ?? '',
            ];
        } catch (\Throwable $e) {
            Log::warning('Company profile skipped for login: ' . $e->getMessage());
            return ['licensekey' => '', 'purchasecode' => ''];
        }
    }

    private function issueAuthToken(Users $user, array $userclaims, array $license): ?string
    {
        $customClaims = array_merge([
            'claims' => $userclaims,
            'email' => $user->email,
            'userId' => $user->id,
        ], $license);

        try {
            $token = Auth::claims($customClaims)->login($user);
            if ($token) {
                return $token;
            }
            $this->loginJwtError = 'Auth::login returned empty token';
        } catch (\Throwable $e) {
            $this->loginJwtError = 'Auth::login: ' . $e->getMessage();
            Log::warning($this->loginJwtError);
        }

        try {
            $token = JWTAuth::claims($customClaims)->fromUser($user);
            if ($token) {
                return $token;
            }
            $this->loginJwtError = ($this->loginJwtError ? $this->loginJwtError . ' | ' : '')
                . 'JWTAuth::fromUser returned empty token';
        } catch (\Throwable $e) {
            $this->loginJwtError = ($this->loginJwtError ? $this->loginJwtError . ' | ' : '')
                . 'JWTAuth::fromUser: ' . $e->getMessage();
            Log::error($this->loginJwtError);
        }

        return null;
    }

    private function recordLoginAudit(
        string $loginId,
        ?string $remoteIP,
        string $status,
        $latitude,
        $longitude
    ): void {
        try {
            LoginAudit::create([
                'userName' => $loginId,
                'loginTime' => Carbon::now(),
                'remoteIP' => $remoteIP,
                'status' => $status,
                'latitude' => $latitude,
                'longitude' => $longitude,
            ]);
        } catch (\Throwable $e) {
            Log::warning('Login audit not saved: ' . $e->getMessage());
        }
    }

    public function refresh()
    {
        $userId = Auth::parseToken()->getPayload()->get('userId');
        $token = Auth::getToken();
        $user = $this->userRepository->findUser($userId);
        $license = $this->getLicenseFromCompanyProfile();
        $userclaims = $this->resolveUserClaims($user->id);
        $user->claims = $userclaims;

        $token = Auth::claims(array_merge([
            'claims' => $userclaims,
            'email' => $user->email,
            'userId' => $user->id,
        ], $license))->refresh($token);

        return response()->json([
            'status' => 'success',
            'claims' => $userclaims,
            'user' => [
                'id' => $user->id,
                'firstName' =>  $user->firstName,
                'lastName' => $user->lastName,
                'email' => $user->email,
                'userName' => $user->userName,
                'phoneNumber' => $user->phoneNumber
            ],
            'authorisation' => [
                'token' => $token,
                'type' => 'bearer',
            ]
        ]);
    }

    public function testToken()
    {
        $token = Auth::parseToken();
        return $token->getPayload()->get('Peter');
    }

    public function getIp()
    {
        foreach (array('HTTP_CLIENT_IP', 'HTTP_X_FORWARDED_FOR', 'HTTP_X_FORWARDED', 'HTTP_X_CLUSTER_CLIENT_IP', 'HTTP_FORWARDED_FOR', 'HTTP_FORWARDED', 'REMOTE_ADDR') as $key) {
            if (array_key_exists($key, $_SERVER) === true) {
                foreach (explode(',', $_SERVER[$key]) as $ip) {
                    $ip = trim($ip); // just to be safe
                    if (filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE) !== false) {
                        return $ip;
                    }
                }
            }
        }
        return request()->ip(); // it will return the server IP if the client IP is not found using this method.
    }
}

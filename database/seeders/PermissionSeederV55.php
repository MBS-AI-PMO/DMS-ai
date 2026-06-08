<?php

namespace Database\Seeders;

use App\Models\Actions;
use App\Models\RoleClaims;
use App\Models\Users;
use Carbon\Carbon;
use Illuminate\Support\Str;

class PermissionSeederV55 extends BaseSeeder
{
    public function run()
    {
        $this->runOnce(function () {
            $systemUser = Users::withoutGlobalScope('isSystemUser')->where('isSystemUser', true)->first();

            if (!$systemUser) {
                $systemUser = Users::first();
            }

            if (!$systemUser) {
                return;
            }

            $now = Carbon::now();
            $postManagementPageId = '3d1b8a03-1b4d-4b8d-9ed0-1f0a74a08f40';
            $allCandidatesActionId = 'd4e5f6a7-8b9c-4d0e-1f2a-3b4c5d6e7f8a';

            if (!Actions::where('code', 'ALL_CANDIDATES_VIEW')->exists()) {
                Actions::insert([
                    'id' => $allCandidatesActionId,
                    'name' => 'View All Candidates',
                    'order' => 2,
                    'pageId' => $postManagementPageId,
                    'code' => 'ALL_CANDIDATES_VIEW',
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                    'isDeleted' => 0,
                ]);
            } else {
                $allCandidatesActionId = Actions::where('code', 'ALL_CANDIDATES_VIEW')->value('id');
            }

            $superAdminRoleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4';

            $exists = RoleClaims::where('roleId', $superAdminRoleId)
                ->where('claimType', 'ALL_CANDIDATES_VIEW')
                ->exists();

            if (!$exists) {
                RoleClaims::insert([
                    'id' => Str::uuid(36),
                    'actionId' => $allCandidatesActionId,
                    'roleId' => $superAdminRoleId,
                    'claimType' => 'ALL_CANDIDATES_VIEW',
                    'claimValue' => '',
                ]);
            }
        });
    }
}

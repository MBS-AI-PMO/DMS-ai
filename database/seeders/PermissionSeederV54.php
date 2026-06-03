<?php

namespace Database\Seeders;

use App\Models\Actions;
use App\Models\Pages;
use App\Models\RoleClaims;
use App\Models\Users;
use Carbon\Carbon;
use Illuminate\Support\Str;

class PermissionSeederV54 extends BaseSeeder
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

            // --- Pages ---
            $postManagementPageId = '3d1b8a03-1b4d-4b8d-9ed0-1f0a74a08f40';
            $interviewsPageId = 'e7af6f86-3f4c-4c7c-8c5f-7b1e7c0f1a2b';

            $pagesToInsert = [];

            if (!Pages::where('id', $postManagementPageId)->exists()) {
                $pagesToInsert[] = [
                    'id' => $postManagementPageId,
                    'name' => 'Post Management',
                    'order' => 50,
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                    'isDeleted' => 0,
                ];
            }

            if (!Pages::where('id', $interviewsPageId)->exists()) {
                $pagesToInsert[] = [
                    'id' => $interviewsPageId,
                    'name' => 'Interviews',
                    'order' => 51,
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                    'isDeleted' => 0,
                ];
            }

            if (!empty($pagesToInsert)) {
                Pages::insert($pagesToInsert);
            }

            // --- Actions ---
            $actionsToAdd = [
                [
                    'id' => '8a03d1c7-3b1d-4f14-9a7e-9b44f1b3a2a1',
                    'name' => 'View Post Management',
                    'order' => 1,
                    'pageId' => $postManagementPageId,
                    'code' => 'POST_MANAGEMENT_VIEW',
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                    'isDeleted' => 0,
                ],
                [
                    'id' => 'b2a1c3d4-5e6f-4a7b-8c9d-0e1f2a3b4c5d',
                    'name' => 'View Assigned Interviews',
                    'order' => 1,
                    'pageId' => $interviewsPageId,
                    'code' => 'INTERVIEWS_VIEW_ASSIGNED',
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                    'isDeleted' => 0,
                ],
                [
                    'id' => 'c3d4e5f6-7a8b-4c9d-0e1f-2a3b4c5d6e7f',
                    'name' => 'Update Assigned Interviews',
                    'order' => 2,
                    'pageId' => $interviewsPageId,
                    'code' => 'INTERVIEWS_UPDATE_ASSIGNED',
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                    'isDeleted' => 0,
                ],
            ];

            $existingCodes = Actions::whereIn('code', [
                'POST_MANAGEMENT_VIEW',
                'INTERVIEWS_VIEW_ASSIGNED',
                'INTERVIEWS_UPDATE_ASSIGNED',
            ])->pluck('code')->all();

            $actionsToInsert = array_values(array_filter($actionsToAdd, function ($a) use ($existingCodes) {
                return !in_array($a['code'], $existingCodes, true);
            }));

            if (!empty($actionsToInsert)) {
                Actions::insert($actionsToInsert);
            }

            // --- Role claims ---
            $superAdminRoleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4';
            $employeeRoleId = 'ff635a8f-4bb3-4d70-a3ed-c7749030696c';

            $roleClaims = [
                [
                    'id' => Str::uuid(36),
                    'actionId' => '8a03d1c7-3b1d-4f14-9a7e-9b44f1b3a2a1',
                    'roleId' => $superAdminRoleId,
                    'claimType' => 'POST_MANAGEMENT_VIEW',
                    'claimValue' => '',
                ],
                [
                    'id' => Str::uuid(36),
                    'actionId' => 'b2a1c3d4-5e6f-4a7b-8c9d-0e1f2a3b4c5d',
                    'roleId' => $employeeRoleId,
                    'claimType' => 'INTERVIEWS_VIEW_ASSIGNED',
                    'claimValue' => '',
                ],
                [
                    'id' => Str::uuid(36),
                    'actionId' => 'c3d4e5f6-7a8b-4c9d-0e1f-2a3b4c5d6e7f',
                    'roleId' => $employeeRoleId,
                    'claimType' => 'INTERVIEWS_UPDATE_ASSIGNED',
                    'claimValue' => '',
                ],
            ];

            $claimsToInsert = [];
            foreach ($roleClaims as $claim) {
                $exists = RoleClaims::where('roleId', $claim['roleId'])
                    ->where('claimType', $claim['claimType'])
                    ->exists();
                if (!$exists) {
                    $claimsToInsert[] = $claim;
                }
            }

            if (!empty($claimsToInsert)) {
                RoleClaims::insert($claimsToInsert);
            }
        });
    }
}


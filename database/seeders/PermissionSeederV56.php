<?php

namespace Database\Seeders;

use App\Models\Actions;
use App\Models\Pages;
use App\Models\RoleClaims;
use App\Models\Users;
use Carbon\Carbon;
use Illuminate\Support\Str;

class PermissionSeederV56 extends BaseSeeder
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
            $proposalManagementPageId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c6e';
            $superAdminRoleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4';

            if (!Pages::where('id', $proposalManagementPageId)->exists()) {
                Pages::insert([
                    'id' => $proposalManagementPageId,
                    'name' => 'Proposal Management',
                    'order' => 52,
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                    'isDeleted' => 0,
                ]);
            }

            $actionsToAdd = [
                [
                    'id' => 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b',
                    'name' => 'Create Post Management',
                    'order' => 3,
                    'pageId' => $postManagementPageId,
                    'code' => 'POST_MANAGEMENT_CREATE',
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                    'isDeleted' => 0,
                ],
                [
                    'id' => 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c',
                    'name' => 'Edit Post Management',
                    'order' => 4,
                    'pageId' => $postManagementPageId,
                    'code' => 'POST_MANAGEMENT_EDIT',
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                    'isDeleted' => 0,
                ],
                [
                    'id' => 'a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d',
                    'name' => 'Delete Post Management',
                    'order' => 5,
                    'pageId' => $postManagementPageId,
                    'code' => 'POST_MANAGEMENT_DELETE',
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                    'isDeleted' => 0,
                ],
                [
                    'id' => 'b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e',
                    'name' => 'View Proposal Management',
                    'order' => 1,
                    'pageId' => $proposalManagementPageId,
                    'code' => 'PROPOSAL_MANAGEMENT_VIEW',
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                    'isDeleted' => 0,
                ],
                [
                    'id' => 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f',
                    'name' => 'Create Proposal Management',
                    'order' => 2,
                    'pageId' => $proposalManagementPageId,
                    'code' => 'PROPOSAL_MANAGEMENT_CREATE',
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                    'isDeleted' => 0,
                ],
                [
                    'id' => 'd0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f40',
                    'name' => 'Edit Proposal Management',
                    'order' => 3,
                    'pageId' => $proposalManagementPageId,
                    'code' => 'PROPOSAL_MANAGEMENT_EDIT',
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                    'isDeleted' => 0,
                ],
                [
                    'id' => 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4051',
                    'name' => 'Delete Proposal Management',
                    'order' => 4,
                    'pageId' => $proposalManagementPageId,
                    'code' => 'PROPOSAL_MANAGEMENT_DELETE',
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                    'isDeleted' => 0,
                ],
            ];

            $existingCodes = Actions::whereIn('code', array_column($actionsToAdd, 'code'))->pluck('code')->all();
            $actionsToInsert = array_values(array_filter($actionsToAdd, function ($action) use ($existingCodes) {
                return !in_array($action['code'], $existingCodes, true);
            }));

            if (!empty($actionsToInsert)) {
                Actions::insert($actionsToInsert);
            }

            $roleClaimsConfig = [
                ['actionId' => '8a03d1c7-3b1d-4f14-9a7e-9b44f1b3a2a1', 'claimType' => 'POST_MANAGEMENT_VIEW'],
                ['actionId' => 'd4e5f6a7-8b9c-4d0e-1f2a-3b4c5d6e7f8a', 'claimType' => 'ALL_CANDIDATES_VIEW'],
                ['actionId' => 'e5f6a7b8-c9d0-4e1f-2a3b-4c5d6e7f8a9b', 'claimType' => 'POST_MANAGEMENT_CREATE'],
                ['actionId' => 'f6a7b8c9-d0e1-4f2a-3b4c-5d6e7f8a9b0c', 'claimType' => 'POST_MANAGEMENT_EDIT'],
                ['actionId' => 'a7b8c9d0-e1f2-4a3b-4c5d-6e7f8a9b0c1d', 'claimType' => 'POST_MANAGEMENT_DELETE'],
                ['actionId' => 'b8c9d0e1-f2a3-4b4c-5d6e-7f8a9b0c1d2e', 'claimType' => 'PROPOSAL_MANAGEMENT_VIEW'],
                ['actionId' => 'c9d0e1f2-a3b4-4c5d-6e7f-8a9b0c1d2e3f', 'claimType' => 'PROPOSAL_MANAGEMENT_CREATE'],
                ['actionId' => 'd0e1f2a3-b4c5-4d6e-7f8a-9b0c1d2e3f40', 'claimType' => 'PROPOSAL_MANAGEMENT_EDIT'],
                ['actionId' => 'e1f2a3b4-c5d6-4e7f-8a9b-0c1d2e3f4051', 'claimType' => 'PROPOSAL_MANAGEMENT_DELETE'],
            ];

            $claimsToInsert = [];
            foreach ($roleClaimsConfig as $claim) {
                $exists = RoleClaims::where('roleId', $superAdminRoleId)
                    ->where('claimType', $claim['claimType'])
                    ->exists();

                if (!$exists) {
                    $claimsToInsert[] = [
                        'id' => Str::uuid(36),
                        'actionId' => $claim['actionId'],
                        'roleId' => $superAdminRoleId,
                        'claimType' => $claim['claimType'],
                        'claimValue' => '',
                    ];
                }
            }

            if (!empty($claimsToInsert)) {
                RoleClaims::insert($claimsToInsert);
            }
        });
    }
}

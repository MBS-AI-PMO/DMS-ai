<?php

namespace Database\Seeders;

use App\Models\Actions;
use App\Models\RoleClaims;
use App\Models\Users;
use Carbon\Carbon;
use Illuminate\Support\Str;

class PermissionSeederV57 extends BaseSeeder
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
            $assignedDocumentsPageId = 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd';
            $viewActionId = 'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b5c';
            $superAdminRoleId = 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4';
            $employeeRoleId = 'ff635a8f-4bb3-4d70-a3ed-c7749030696c';

            if (!Actions::where('code', 'ASSIGNED_DOCUMENTS_VIEW_DOCUMENTS')->exists()) {
                Actions::insert([
                    'id' => $viewActionId,
                    'name' => 'View Assigned Documents',
                    'order' => 1,
                    'pageId' => $assignedDocumentsPageId,
                    'code' => 'ASSIGNED_DOCUMENTS_VIEW_DOCUMENTS',
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                    'isDeleted' => 0,
                ]);
            } else {
                $viewActionId = Actions::where('code', 'ASSIGNED_DOCUMENTS_VIEW_DOCUMENTS')->value('id');
            }

            $roleClaimsConfig = [
                ['roleId' => $superAdminRoleId, 'claimType' => 'ASSIGNED_DOCUMENTS_VIEW_DOCUMENTS'],
                ['roleId' => $employeeRoleId, 'claimType' => 'ASSIGNED_DOCUMENTS_VIEW_DOCUMENTS'],
            ];

            $claimsToInsert = [];
            foreach ($roleClaimsConfig as $claim) {
                $exists = RoleClaims::where('roleId', $claim['roleId'])
                    ->where('claimType', $claim['claimType'])
                    ->exists();

                if (!$exists) {
                    $claimsToInsert[] = [
                        'id' => Str::uuid(36),
                        'actionId' => $viewActionId,
                        'roleId' => $claim['roleId'],
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

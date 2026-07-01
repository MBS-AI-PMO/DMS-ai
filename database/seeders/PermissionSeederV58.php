<?php

namespace Database\Seeders;

use App\Models\Actions;
use App\Models\Pages;
use App\Models\RoleClaims;
use App\Models\Roles;
use App\Models\Users;
use Carbon\Carbon;
use Illuminate\Support\Str;

class PermissionSeederV58 extends BaseSeeder
{
    public const CANDIDATE_ROLE_ID = 'c1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b58';

    public const CANDIDATE_PORTAL_PAGE_ID = 'd2b3c4d5-e6f7-4a8b-9c0d-1e2f3a4b5c59';

    public function run()
    {
        $this->runOnce(function () {
            $systemUser = Users::withoutGlobalScope('isSystemUser')->where('isSystemUser', true)->first()
                ?? Users::first();

            if (!$systemUser) {
                return;
            }

            $now = Carbon::now();

            if (!Roles::where('id', self::CANDIDATE_ROLE_ID)->exists()) {
                Roles::insert([
                    'id' => self::CANDIDATE_ROLE_ID,
                    'isDeleted' => 0,
                    'name' => 'Candidate',
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                ]);
            }

            if (!Pages::where('id', self::CANDIDATE_PORTAL_PAGE_ID)->exists()) {
                Pages::insert([
                    'id' => self::CANDIDATE_PORTAL_PAGE_ID,
                    'name' => 'Candidate Portal',
                    'order' => 60,
                    'createdBy' => $systemUser->id,
                    'modifiedBy' => $systemUser->id,
                    'createdDate' => $now,
                    'modifiedDate' => $now,
                    'isDeleted' => 0,
                ]);
            }

            $actions = [
                [
                    'id' => 'f2a3b4c5-d6e7-4f8a-9b0c-1d2e3f4a5b60',
                    'code' => 'CANDIDATE_PORTAL_VIEW',
                    'name' => 'View Candidate Portal',
                    'order' => 1,
                ],
                [
                    'id' => 'a3b4c5d6-e7f8-4a9b-0c1d-2e3f4a5b6c71',
                    'code' => 'CANDIDATE_PORTAL_EDIT_PROFILE',
                    'name' => 'Edit Candidate Profile',
                    'order' => 2,
                ],
                [
                    'id' => 'b4c5d6e7-f8a9-4b0c-1d2e-3f4a5b6c7d82',
                    'code' => 'CANDIDATE_PORTAL_BROWSE_JOBS',
                    'name' => 'Browse Recommended Jobs',
                    'order' => 3,
                ],
            ];

            foreach ($actions as $action) {
                if (!Actions::where('code', $action['code'])->exists()) {
                    Actions::insert([
                        'id' => $action['id'],
                        'name' => $action['name'],
                        'order' => $action['order'],
                        'pageId' => self::CANDIDATE_PORTAL_PAGE_ID,
                        'code' => $action['code'],
                        'createdBy' => $systemUser->id,
                        'modifiedBy' => $systemUser->id,
                        'createdDate' => $now,
                        'modifiedDate' => $now,
                        'isDeleted' => 0,
                    ]);
                }
            }

            $claimsToInsert = [];
            foreach ($actions as $action) {
                $actionId = Actions::where('code', $action['code'])->value('id');
                if (!$actionId) {
                    continue;
                }

                $exists = RoleClaims::where('roleId', self::CANDIDATE_ROLE_ID)
                    ->where('claimType', $action['code'])
                    ->exists();

                if (!$exists) {
                    $claimsToInsert[] = [
                        'id' => Str::uuid()->toString(),
                        'actionId' => $actionId,
                        'roleId' => self::CANDIDATE_ROLE_ID,
                        'claimType' => $action['code'],
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

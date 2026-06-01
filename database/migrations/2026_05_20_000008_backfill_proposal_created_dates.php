<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        if (Schema::hasTable('proposalposts') && Schema::hasColumn('proposalposts', 'createdDate')) {
            DB::table('proposalposts')
                ->whereNull('createdDate')
                ->update([
                    'createdDate' => DB::raw('COALESCE(modifiedDate, NOW())'),
                ]);
        }

        if (Schema::hasTable('proposalcandidates') && Schema::hasColumn('proposalcandidates', 'createdDate')) {
            DB::table('proposalcandidates')
                ->whereNull('createdDate')
                ->update([
                    'createdDate' => DB::raw('COALESCE(modifiedDate, NOW())'),
                ]);
        }
    }

    public function down(): void
    {
        // No rollback for data backfill.
    }
};

<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        if (Schema::hasTable('proposalPosts') && Schema::hasColumn('proposalPosts', 'createdDate')) {
            DB::table('proposalPosts')
                ->whereNull('createdDate')
                ->update([
                    'createdDate' => DB::raw('COALESCE(modifiedDate, NOW())'),
                ]);
        }

        if (Schema::hasTable('proposalCandidates') && Schema::hasColumn('proposalCandidates', 'createdDate')) {
            DB::table('proposalCandidates')
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

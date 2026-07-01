<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        if (!Schema::hasTable('proposalcandidates')) {
            return;
        }

        if (!Schema::hasColumn('proposalcandidates', 'candidateUserId')) {
            Schema::table('proposalcandidates', function (Blueprint $table) {
                $table->uuid('candidateUserId')->nullable()->after('postId');
                $table->index('candidateUserId');
            });
        }
    }

    public function down(): void
    {
        if (Schema::hasColumn('proposalcandidates', 'candidateUserId')) {
            Schema::table('proposalcandidates', function (Blueprint $table) {
                $table->dropIndex(['candidateUserId']);
                $table->dropColumn('candidateUserId');
            });
        }
    }
};

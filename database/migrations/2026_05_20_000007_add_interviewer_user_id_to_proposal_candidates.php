<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('proposalcandidates', function (Blueprint $table) {
            if (!Schema::hasColumn('proposalcandidates', 'interviewerUserId')) {
                $table->uuid('interviewerUserId')->nullable()->after('interviewer');
                $table->foreign('interviewerUserId')->references('id')->on('users')->nullOnDelete();
            }
        });
    }

    public function down(): void
    {
        Schema::table('proposalcandidates', function (Blueprint $table) {
            if (Schema::hasColumn('proposalcandidates', 'interviewerUserId')) {
                $table->dropForeign(['interviewerUserId']);
                $table->dropColumn('interviewerUserId');
            }
        });
    }
};

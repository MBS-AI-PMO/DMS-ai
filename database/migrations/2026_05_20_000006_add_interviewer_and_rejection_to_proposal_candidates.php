<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('proposalCandidates', function (Blueprint $table) {
            if (!Schema::hasColumn('proposalCandidates', 'interviewer')) {
                $table->string('interviewer', 255)->nullable()->after('interviewDate');
            }
            if (!Schema::hasColumn('proposalCandidates', 'rejectionReason')) {
                $table->text('rejectionReason')->nullable()->after('analysisNotes');
            }
        });
    }

    public function down(): void
    {
        Schema::table('proposalCandidates', function (Blueprint $table) {
            if (Schema::hasColumn('proposalCandidates', 'rejectionReason')) {
                $table->dropColumn('rejectionReason');
            }
            if (Schema::hasColumn('proposalCandidates', 'interviewer')) {
                $table->dropColumn('interviewer');
            }
        });
    }
};

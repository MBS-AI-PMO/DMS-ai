<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('proposalcandidates', function (Blueprint $table) {
            if (!Schema::hasColumn('proposalcandidates', 'interviewer')) {
                $table->string('interviewer', 255)->nullable()->after('interviewDate');
            }
            if (!Schema::hasColumn('proposalcandidates', 'rejectionReason')) {
                $table->text('rejectionReason')->nullable()->after('analysisNotes');
            }
        });
    }

    public function down(): void
    {
        Schema::table('proposalcandidates', function (Blueprint $table) {
            if (Schema::hasColumn('proposalcandidates', 'rejectionReason')) {
                $table->dropColumn('rejectionReason');
            }
            if (Schema::hasColumn('proposalcandidates', 'interviewer')) {
                $table->dropColumn('interviewer');
            }
        });
    }
};

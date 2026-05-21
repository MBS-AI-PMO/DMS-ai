<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('proposalCandidates', function (Blueprint $table) {
            if (!Schema::hasColumn('proposalCandidates', 'category')) {
                $table->string('category')->nullable()->after('email');
            }
            if (!Schema::hasColumn('proposalCandidates', 'experienceYears')) {
                $table->unsignedSmallInteger('experienceYears')->nullable()->after('category');
            }
            if (!Schema::hasColumn('proposalCandidates', 'workMode')) {
                $table->string('workMode', 20)->nullable()->after('experienceYears');
            }
            if (!Schema::hasColumn('proposalCandidates', 'address')) {
                $table->string('address', 500)->nullable()->after('workMode');
            }
        });
    }

    public function down(): void
    {
        Schema::table('proposalCandidates', function (Blueprint $table) {
            if (Schema::hasColumn('proposalCandidates', 'address')) {
                $table->dropColumn('address');
            }
            if (Schema::hasColumn('proposalCandidates', 'workMode')) {
                $table->dropColumn('workMode');
            }
            if (Schema::hasColumn('proposalCandidates', 'experienceYears')) {
                $table->dropColumn('experienceYears');
            }
            if (Schema::hasColumn('proposalCandidates', 'category')) {
                $table->dropColumn('category');
            }
        });
    }
};

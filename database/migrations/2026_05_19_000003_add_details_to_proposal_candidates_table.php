<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('proposalcandidates', function (Blueprint $table) {
            if (!Schema::hasColumn('proposalcandidates', 'category')) {
                $table->string('category')->nullable()->after('email');
            }
            if (!Schema::hasColumn('proposalcandidates', 'experienceYears')) {
                $table->unsignedSmallInteger('experienceYears')->nullable()->after('category');
            }
            if (!Schema::hasColumn('proposalcandidates', 'workMode')) {
                $table->string('workMode', 20)->nullable()->after('experienceYears');
            }
            if (!Schema::hasColumn('proposalcandidates', 'address')) {
                $table->string('address', 500)->nullable()->after('workMode');
            }
        });
    }

    public function down(): void
    {
        Schema::table('proposalcandidates', function (Blueprint $table) {
            if (Schema::hasColumn('proposalcandidates', 'address')) {
                $table->dropColumn('address');
            }
            if (Schema::hasColumn('proposalcandidates', 'workMode')) {
                $table->dropColumn('workMode');
            }
            if (Schema::hasColumn('proposalcandidates', 'experienceYears')) {
                $table->dropColumn('experienceYears');
            }
            if (Schema::hasColumn('proposalcandidates', 'category')) {
                $table->dropColumn('category');
            }
        });
    }
};

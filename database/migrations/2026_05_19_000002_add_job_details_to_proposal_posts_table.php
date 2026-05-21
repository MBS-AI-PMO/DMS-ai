<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('proposalPosts', function (Blueprint $table) {
            if (!Schema::hasColumn('proposalPosts', 'category')) {
                $table->string('category')->nullable()->after('department');
            }
            if (!Schema::hasColumn('proposalPosts', 'experienceYears')) {
                $table->unsignedSmallInteger('experienceYears')->nullable()->after('category');
            }
            if (!Schema::hasColumn('proposalPosts', 'workMode')) {
                $table->string('workMode', 20)->default('physical')->after('experienceYears');
            }
            if (!Schema::hasColumn('proposalPosts', 'address')) {
                $table->string('address', 500)->nullable()->after('workMode');
            }
        });
    }

    public function down(): void
    {
        Schema::table('proposalPosts', function (Blueprint $table) {
            if (Schema::hasColumn('proposalPosts', 'address')) {
                $table->dropColumn('address');
            }
            if (Schema::hasColumn('proposalPosts', 'workMode')) {
                $table->dropColumn('workMode');
            }
            if (Schema::hasColumn('proposalPosts', 'experienceYears')) {
                $table->dropColumn('experienceYears');
            }
            if (Schema::hasColumn('proposalPosts', 'category')) {
                $table->dropColumn('category');
            }
        });
    }
};

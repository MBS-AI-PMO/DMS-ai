<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('proposalPosts', function (Blueprint $table) {
            if (!Schema::hasColumn('proposalPosts', 'interviewKit')) {
                $table->string('interviewKit', 20)->default('basic')->after('experienceYears');
            }
        });
    }

    public function down(): void
    {
        Schema::table('proposalPosts', function (Blueprint $table) {
            if (Schema::hasColumn('proposalPosts', 'interviewKit')) {
                $table->dropColumn('interviewKit');
            }
        });
    }
};

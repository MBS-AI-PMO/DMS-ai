<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('proposalPosts', function (Blueprint $table) {
            if (!Schema::hasColumn('proposalPosts', 'basicQuestions')) {
                $table->text('basicQuestions')->nullable()->after('interviewKit');
            }
            if (!Schema::hasColumn('proposalPosts', 'intermediateQuestions')) {
                $table->text('intermediateQuestions')->nullable()->after('basicQuestions');
            }
            if (!Schema::hasColumn('proposalPosts', 'expertQuestions')) {
                $table->text('expertQuestions')->nullable()->after('intermediateQuestions');
            }
        });
    }

    public function down(): void
    {
        Schema::table('proposalPosts', function (Blueprint $table) {
            if (Schema::hasColumn('proposalPosts', 'expertQuestions')) {
                $table->dropColumn('expertQuestions');
            }
            if (Schema::hasColumn('proposalPosts', 'intermediateQuestions')) {
                $table->dropColumn('intermediateQuestions');
            }
            if (Schema::hasColumn('proposalPosts', 'basicQuestions')) {
                $table->dropColumn('basicQuestions');
            }
        });
    }
};

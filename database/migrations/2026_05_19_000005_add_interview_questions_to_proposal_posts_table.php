<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('proposalposts', function (Blueprint $table) {
            if (!Schema::hasColumn('proposalposts', 'basicQuestions')) {
                $table->text('basicQuestions')->nullable()->after('interviewKit');
            }
            if (!Schema::hasColumn('proposalposts', 'intermediateQuestions')) {
                $table->text('intermediateQuestions')->nullable()->after('basicQuestions');
            }
            if (!Schema::hasColumn('proposalposts', 'expertQuestions')) {
                $table->text('expertQuestions')->nullable()->after('intermediateQuestions');
            }
        });
    }

    public function down(): void
    {
        Schema::table('proposalposts', function (Blueprint $table) {
            if (Schema::hasColumn('proposalposts', 'expertQuestions')) {
                $table->dropColumn('expertQuestions');
            }
            if (Schema::hasColumn('proposalposts', 'intermediateQuestions')) {
                $table->dropColumn('intermediateQuestions');
            }
            if (Schema::hasColumn('proposalposts', 'basicQuestions')) {
                $table->dropColumn('basicQuestions');
            }
        });
    }
};

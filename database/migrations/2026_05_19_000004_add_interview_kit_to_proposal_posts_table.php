<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('proposalposts', function (Blueprint $table) {
            if (!Schema::hasColumn('proposalposts', 'interviewKit')) {
                $table->string('interviewKit', 20)->default('basic')->after('experienceYears');
            }
        });
    }

    public function down(): void
    {
        Schema::table('proposalposts', function (Blueprint $table) {
            if (Schema::hasColumn('proposalposts', 'interviewKit')) {
                $table->dropColumn('interviewKit');
            }
        });
    }
};

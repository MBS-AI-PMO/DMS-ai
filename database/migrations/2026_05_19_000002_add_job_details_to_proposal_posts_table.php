<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('proposalposts', function (Blueprint $table) {
            if (!Schema::hasColumn('proposalposts', 'category')) {
                $table->string('category')->nullable()->after('department');
            }
            if (!Schema::hasColumn('proposalposts', 'experienceYears')) {
                $table->unsignedSmallInteger('experienceYears')->nullable()->after('category');
            }
            if (!Schema::hasColumn('proposalposts', 'workMode')) {
                $table->string('workMode', 20)->default('physical')->after('experienceYears');
            }
            if (!Schema::hasColumn('proposalposts', 'address')) {
                $table->string('address', 500)->nullable()->after('workMode');
            }
        });
    }

    public function down(): void
    {
        Schema::table('proposalposts', function (Blueprint $table) {
            if (Schema::hasColumn('proposalposts', 'address')) {
                $table->dropColumn('address');
            }
            if (Schema::hasColumn('proposalposts', 'workMode')) {
                $table->dropColumn('workMode');
            }
            if (Schema::hasColumn('proposalposts', 'experienceYears')) {
                $table->dropColumn('experienceYears');
            }
            if (Schema::hasColumn('proposalposts', 'category')) {
                $table->dropColumn('category');
            }
        });
    }
};

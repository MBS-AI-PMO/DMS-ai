<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        if (Schema::hasTable('proposalposts') && !Schema::hasColumn('proposalposts', 'departmentId')) {
            Schema::table('proposalposts', function (Blueprint $table) {
                $table->uuid('departmentId')->nullable()->after('department');
            });
        }
    }

    public function down(): void
    {
        if (Schema::hasColumn('proposalposts', 'departmentId')) {
            Schema::table('proposalposts', function (Blueprint $table) {
                $table->dropColumn('departmentId');
            });
        }
    }
};

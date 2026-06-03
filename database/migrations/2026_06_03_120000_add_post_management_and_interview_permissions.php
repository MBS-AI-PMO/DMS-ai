<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\Artisan;

return new class extends Migration
{
    public function up(): void
    {
        Artisan::call('db:seed', [
            '--class' => 'Database\\Seeders\\PermissionSeederV54',
            '--force' => true,
        ]);
    }

    public function down(): void
    {
        // Permissions are shared; no destructive rollback.
    }
};

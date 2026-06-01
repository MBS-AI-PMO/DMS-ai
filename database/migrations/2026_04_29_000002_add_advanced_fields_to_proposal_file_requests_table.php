<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('proposalfilerequests', function (Blueprint $table) {
            $table->string('email')->nullable()->after('title');
            $table->unsignedInteger('maxDocument')->default(1)->after('description');
            $table->unsignedInteger('sizeInMb')->default(5)->after('maxDocument');
            $table->string('allowExtension')->nullable()->after('sizeInMb');
            $table->boolean('hasPassword')->default(false)->after('allowExtension');
            $table->string('password')->nullable()->after('hasPassword');
            $table->dateTime('linkExpiryTime')->nullable()->after('password');
        });
    }

    public function down(): void
    {
        Schema::table('proposalfilerequests', function (Blueprint $table) {
            $table->dropColumn([
                'email',
                'maxDocument',
                'sizeInMb',
                'allowExtension',
                'hasPassword',
                'password',
                'linkExpiryTime',
            ]);
        });
    }
};

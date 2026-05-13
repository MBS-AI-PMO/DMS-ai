<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('proposalFileRequests', function (Blueprint $table) {
            $table->uuid('fileRequestId')->nullable()->after('folderId');
            $table->foreign('fileRequestId')->references('id')->on('fileRequests')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::table('proposalFileRequests', function (Blueprint $table) {
            $table->dropForeign(['fileRequestId']);
            $table->dropColumn('fileRequestId');
        });
    }
};

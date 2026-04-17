<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('proposalFolders', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('name');
            $table->uuid('parentFolderId')->nullable();
            $table->uuid('createdBy');
            $table->dateTime('createdDate');
            $table->dateTime('modifiedDate')->nullable();

            $table->foreign('createdBy')->references('id')->on('users');
            $table->foreign('parentFolderId')->references('id')->on('proposalFolders')->nullOnDelete();
        });

        Schema::create('proposalFiles', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('folderId');
            $table->string('title');
            $table->string('originalName');
            $table->string('url');
            $table->uuid('createdBy');
            $table->dateTime('createdDate');

            $table->foreign('folderId')->references('id')->on('proposalFolders')->cascadeOnDelete();
            $table->foreign('createdBy')->references('id')->on('users');
        });

        Schema::create('proposalFileRequests', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('folderId');
            $table->string('title');
            $table->text('description')->nullable();
            $table->string('status')->default('pending');
            $table->uuid('createdBy');
            $table->dateTime('createdDate');

            $table->foreign('folderId')->references('id')->on('proposalFolders')->cascadeOnDelete();
            $table->foreign('createdBy')->references('id')->on('users');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('proposalFileRequests');
        Schema::dropIfExists('proposalFiles');
        Schema::dropIfExists('proposalFolders');
    }
};

<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('proposalPosts', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('title');
            $table->string('department')->nullable();
            $table->text('description')->nullable();
            $table->uuid('createdBy');
            $table->dateTime('createdDate');
            $table->dateTime('modifiedDate')->nullable();

            $table->foreign('createdBy')->references('id')->on('users');
        });

        Schema::create('proposalCandidates', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('postId');
            $table->string('candidateName');
            $table->string('candidateCode')->nullable();
            $table->string('phone')->nullable();
            $table->string('email')->nullable();
            $table->string('cvOriginalName')->nullable();
            $table->string('cvPath')->nullable();
            $table->string('stage')->default('cv_received');
            $table->string('interviewLevel')->nullable();
            $table->dateTime('interviewDate')->nullable();
            $table->text('analysisNotes')->nullable();
            $table->uuid('createdBy');
            $table->dateTime('createdDate');
            $table->dateTime('modifiedDate')->nullable();

            $table->foreign('postId')->references('id')->on('proposalPosts')->cascadeOnDelete();
            $table->foreign('createdBy')->references('id')->on('users');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('proposalCandidates');
        Schema::dropIfExists('proposalPosts');
    }
};

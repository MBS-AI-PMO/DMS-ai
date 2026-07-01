<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        if (Schema::hasTable('candidateprofiles')) {
            return;
        }

        Schema::create('candidateprofiles', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('userId')->unique();
            $table->string('candidateCode', 20);
            $table->string('email', 255);
            $table->string('phone', 50)->nullable();
            $table->integer('experienceYears')->nullable();
            $table->string('workMode', 20)->nullable();
            $table->string('address', 500)->nullable();
            $table->string('preferredCategory', 255)->nullable();
            $table->dateTime('createdDate');
            $table->dateTime('modifiedDate')->nullable();

            $table->unique('candidateCode');
            $table->unique('email');
            $table->foreign('userId')->references('id')->on('users');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('candidateprofiles');
    }
};

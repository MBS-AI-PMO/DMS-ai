<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (Schema::hasTable('proposalcandidatecvs')) {
            return;
        }

        Schema::create('proposalcandidatecvs', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('createdBy');
            $table->string('candidateCode', 20);
            $table->string('email', 255)->nullable();
            $table->string('cvOriginalName', 255)->nullable();
            $table->string('cvPath', 500);
            $table->dateTime('createdDate');
            $table->dateTime('modifiedDate');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('proposalcandidatecvs');
    }
};

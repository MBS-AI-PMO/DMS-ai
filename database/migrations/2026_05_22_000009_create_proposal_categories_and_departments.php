<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        if (!Schema::hasTable('proposalcategories')) {
            Schema::create('proposalcategories', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->string('name');
                $table->uuid('createdBy');
                $table->dateTime('createdDate');
                $table->dateTime('modifiedDate')->nullable();
            });
        }

        if (!Schema::hasTable('proposaldepartments')) {
            Schema::create('proposaldepartments', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->uuid('categoryId');
                $table->string('name');
                $table->text('basicQuestions')->nullable();
                $table->text('intermediateQuestions')->nullable();
                $table->text('expertQuestions')->nullable();
                $table->uuid('createdBy');
                $table->dateTime('createdDate');
                $table->dateTime('modifiedDate')->nullable();
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('proposaldepartments');
        Schema::dropIfExists('proposalcategories');
    }
};

<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // Workflows Table
        Schema::create('workflows', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('name');
            $table->text('description')->nullable();
            $table->uuid('createdBy')->nullable(false);
            $table->boolean('isWorkflowSetup');
            $table->uuid('modifiedBy');
            $table->uuid('deletedBy');
            $table->boolean('isDeleted');
            $table->dateTime('createdDate');
            $table->dateTime('modifiedDate');
            $table->softDeletes()->nullable();

            $table->foreign('createdBy')->references('id')->on('users');
            $table->foreign('modifiedBy')->references('id')->on('users');
        });

        // Workflow Steps Table
        Schema::create('workflowsteps', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('workflowId'); // Foreign key to Workflows
            $table->string('name');
            $table->foreign('workflowId')->references('id')->on('workflows');
        });

        // Workflow Transitions Table
        Schema::create('workflowtransitions', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('workflowId'); // Foreign key to Workflows
            $table->uuid('fromStepId'); // Foreign key to Workflow Steps
            $table->uuid('toStepId'); // Foreign key to Workflow Steps
            $table->string('name'); // Transition name, e.g., "Submit for Review"
            $table->string('color');
            $table->integer('orderNo');
            $table->boolean('isFirstTransaction')->default(false);
            $table->foreign('workflowId')->references('id')->on('workflows');
            $table->foreign('fromStepId')->references('id')->on('workflowsteps');
            $table->foreign('toStepId')->references('id')->on('workflowsteps');
        });

        // Workflow Transitions users Table
        Schema::create('workflowtransitionusers', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('userId'); // Foreign key to Users
            $table->uuid('transitionId'); // Foreign key to Workflow Transitions

            $table->foreign('userId')->references('id')->on('users');
            $table->foreign('transitionId')->references('id')->on('workflowtransitions');
        });

        // Workflow Transitions Roles Table
        Schema::create('workflowtransitionroles', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('roleId'); // Foreign key to roles
            $table->uuid('transitionId'); // Foreign key to Workflow Transitions

            $table->foreign('roleId')->references('id')->on('roles');
            $table->foreign('transitionId')->references('id')->on('workflowtransitions');
        });

        // Document Workflow Table
        Schema::create('documentworkflow', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('documentId'); // Foreign key to Documents
            $table->uuid('workflowId'); // Foreign key to Workflows
            $table->uuid('currentStepId'); // Foreign key to Workflow Steps
            $table->enum('status', ['Initiated', 'InProgress', 'Completed', 'Cancelled'])->default('Initiated');
            $table->uuid('createdBy')->nullable(false);
            $table->uuid('deletedBy');
            $table->boolean('isDeleted');
            $table->dateTime('createdDate');
            $table->dateTime('modifiedDate');
            $table->string('modifiedBy');
            $table->softDeletes()->nullable();

            $table->foreign('createdBy')->references('id')->on('users');
            $table->foreign('documentId')->references('id')->on('documents');
            $table->foreign('workflowId')->references('id')->on('workflows');
            $table->foreign('currentStepId')->references('id')->on('workflowsteps');
        });

        // Workflow Log Table
        Schema::create('workflowlogs', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->uuid('documentworkflowId'); // Foreign key to Documents
            $table->uuid('transitionId')->nullable(); // Foreign key to Workflow Steps
            $table->text('comment')->nullable(); // Optional comments
            $table->enum('type', ['Transition', 'Initiated', 'Cancelled'])->default('Transition');
            $table->uuid('createdBy')->nullable(false);
            $table->uuid('deletedBy');
            $table->boolean('isDeleted');
            $table->dateTime('createdDate');
            $table->softDeletes()->nullable();

            $table->foreign('documentworkflowId')->references('id')->on('documentworkflow');
            $table->foreign('transitionId')->references('id')->on('workflowtransitions');
            $table->foreign('createdBy')->references('id')->on('users');
        });

        Schema::table('documents', function (Blueprint $table) {
            $table->uuid('documentworkflowId')->nullable();
            $table->foreign('documentworkflowId')->references('id')->on('documentworkflow');
        });
    }


    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('workflowLog');
        Schema::dropIfExists('workflowtransitionusers');
        Schema::dropIfExists('documentworkflow');
        Schema::dropIfExists('workflowtransitions');
        Schema::dropIfExists('workflowsteps');
        Schema::dropIfExists('workflows');

        Schema::table('documents', function (Blueprint $table) {
            $table->dropColumn('documentworkflowId');
        });
    }
};

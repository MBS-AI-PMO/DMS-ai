<?php

namespace App\Repositories\Implementation;

use App\Models\WorkflowLog;
use App\Repositories\Implementation\BaseRepository;
use App\Repositories\Contracts\WorkflowLogRepositoryInterface;
use Illuminate\Support\Facades\DB;

//use Your Model

/**
 * Class UserRoleRepository.
 */
class WorkflowLogRepository extends BaseRepository implements WorkflowLogRepositoryInterface
{
    /**
     * @var Model
     */
    protected $model;

    /**
     * BaseRepository constructor.
     *
     * @param Model $model
     */
    public static function model()
    {
        return WorkflowLog::class;
    }

    public function getWorkflowLogs($attributes)
    {
        $query = WorkflowLog::select([
            'workflowlogs.id',
            'workflows.name as workflowName',
            'workflowlogs.documentworkflowId',
            'workflowlogs.createdDate',
            'workflowlogs.comment',
            'workflowlogs.type',
            'workflowtransitions.name as transitionName',
            'fromStep.name as fromStepName',
            'toStep.name as toStepName',
            'documents.name as documentName',
            'documents.id as documentId',
            DB::raw("CONCAT(users.firstName,' ', users.lastName) as createdByName"),
        ])->join('documentworkflow', 'workflowlogs.documentworkflowId', '=', 'documentworkflow.id')
            ->join('workflows', 'documentworkflow.workflowId', '=', 'workflows.id')
            ->join('documents', 'documents.id', '=', 'documentworkflow.documentId')
            ->leftjoin('users', 'workflowlogs.createdBy', '=', 'users.id')
            ->leftjoin('workflowtransitions', 'workflowtransitions.id', '=', 'workflowlogs.transitionId')
            ->leftjoin('workflowsteps as fromStep', 'fromStep.id', '=', 'workflowtransitions.fromStepId')
            ->leftjoin('workflowsteps as toStep', 'toStep.id', '=', 'workflowtransitions.toStepId');

        // Ordering
        $orderByArray = explode(' ', $attributes->orderBy);
        $orderBy = $orderByArray[0];
        $direction = $orderByArray[1] ?? 'asc';

        if ($orderBy == 'workflowName') {
            $query = $query->orderBy('workflows.name', $direction);
        } else if ($orderBy == 'createdDate') {
            $query = $query->orderBy('workflowlogs.createdDate', $direction);
        } else if ($orderBy == 'status') {
            $query = $query->orderBy('documentworkflow.status', $direction);
        } else if ($orderBy == 'createdByName') {
            $query = $query->orderBy('users.firstName', $direction);
        } else if ($orderBy == 'documentName') {
            $query = $query->orderBy('documents.name', $direction);
        }

        // Filters
        if ($attributes->workflowName) {
            $query = $query->where('workflows.name', 'like', '%' . $attributes->workflowName . '%');
        }

        if ($attributes->status) {
            $query = $query->where('documentworkflow.status', $attributes->status);
        }

        if ($attributes->documentName) {
            $query = $query->where('documents.name', 'like', '%' . $attributes->documentName . '%');
        }

        if ($attributes->documentId) {
            $query = $query->where('documents.id', $attributes->documentId);
        }

        // Pagination
        $result = $query->skip($attributes->skip)->take($attributes->pageSize)->get();

        return $result;
    }

    public function getWorkflowLogCount($attributes)
    {
        $query = WorkflowLog::query()
            ->join('documentworkflow', 'workflowlogs.documentworkflowId', '=', 'documentworkflow.id')
            ->join('workflows', 'documentworkflow.workflowId', '=', 'workflows.id')
            ->join('documents', 'documents.id', '=', 'documentworkflow.documentId');

        // // Filters
        if ($attributes->workflowName) {
            $query = $query->where('workflows.name', 'like', '%' . $attributes->workflowName . '%');
        }

        if ($attributes->status) {
            $query = $query->where('documentworkflow.status', $attributes->status);
        }

        if ($attributes->documentName) {
            $query = $query->where('documents.name', 'like', '%' . $attributes->documentName . '%');
        }

        if ($attributes->documentId) {
            $query = $query->where('documents.id', $attributes->documentId);
        }

        $count = $query->count();
        return $count;
    }
}

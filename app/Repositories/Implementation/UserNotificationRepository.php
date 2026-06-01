<?php

namespace App\Repositories\Implementation;

use App\Models\UserNotifications;
use App\Repositories\Contracts\UserNotificationRepositoryInterface;
use Illuminate\Support\Facades\Auth;
use App\Repositories\Implementation\BaseRepository;
use App\Repositories\Exceptions\RepositoryException;
use Carbon\Carbon;

//use Your Model

/**
 * Class UserRepository.
 */
class UserNotificationRepository extends BaseRepository implements UserNotificationRepositoryInterface
{
    /**
     * @var Model
     */
    protected $model;

    /**
     * BaseRepository constructor..
     *
     *
     * @param Model $model
     */


    public static function model()
    {
        return UserNotifications::class;
    }


    public function getTop10Notification()
    {
        $userId = Auth::parseToken()->getPayload()->get('userId');
        if ($userId == null) {
            return [];
        }

        $query = UserNotifications::select([
            'usernotifications.*',
            'documents.id as documentId',
            'documents.name as documentName',
            'workflows.name as workflowName',
            'workflowDocument.name as workflowDocumentName',
            'filerequests.subject as fileRequestSubject',
        ])->where('usernotifications.userId', '=', $userId)
            ->where('usernotifications.createdDate', '<=', Carbon::now())
            ->leftJoin('documents', function ($join) {
                $join->on('usernotifications.documentId', '=', 'documents.id')
                    ->where('documents.isDeleted', '=', false)
                    ->where('documents.isPermanentDelete', '=', false);
            })
            ->leftJoin('documentworkflow', 'usernotifications.documentworkflowId', '=', 'documentworkflow.id')
            ->leftJoin('documents as workflowDocument', 'workflowDocument.id', '=', 'documentworkflow.documentId')
            ->leftJoin('workflows', 'documentworkflow.workflowId', '=', 'workflows.id')
            ->leftJoin('filerequests', 'usernotifications.fileRequestId', '=', 'filerequests.id')
            ->orderBy('usernotifications.isRead', 'DESC')
            ->orderBy('usernotifications.createdDate', 'DESC');

        $results = $query->take(10)->get();

        return $results;
    }

    public function getUserNotifications($attributes)
    {
        $userId = Auth::parseToken()->getPayload()->get('userId');
        if ($userId == null) {
            throw new RepositoryException('User does not exist.');
        }

        $query = UserNotifications::select([
            'usernotifications.*',
            'documents.id as documentId',
            'documents.name as documentName',
            'workflows.name as workflowName',
            'workflowDocument.name as workflowDocumentName',
            'filerequests.subject as fileRequestSubject',
        ])->where('usernotifications.userId', '=', $userId)
            ->where('usernotifications.createdDate', '<=', Carbon::now())
            ->leftJoin('documents', function ($join) {
                $join->on('usernotifications.documentId', '=', 'documents.id')
                    ->where('documents.isDeleted', '=', false)
                    ->where('documents.isPermanentDelete', '=', false);
            })
            ->leftJoin('documentworkflow', 'usernotifications.documentworkflowId', '=', 'documentworkflow.id')
            ->leftJoin('documents as workflowDocument', 'workflowDocument.id', '=', 'documentworkflow.documentId')
            ->leftJoin('workflows', 'documentworkflow.workflowId', '=', 'workflows.id')
            ->leftJoin('filerequests', 'usernotifications.fileRequestId', '=', 'filerequests.id');

        $orderByArray =  explode(' ', $attributes->orderBy);
        $orderBy = $orderByArray[0];
        $direction = $orderByArray[1] ?? 'asc';

        if ($orderBy == 'message') {
            $query = $query->orderBy('usernotifications.message', $direction);
        }

        if ($orderBy == 'createdDate') {
            $query = $query->orderBy('usernotifications.createdDate', $direction);
        }

        if ($attributes->name) {
            $query = $query->where(function ($query) use ($attributes) {
                $query->where('usernotifications.message', 'like', '%' . $attributes->name . '%')
                    ->orWhere(function ($query) use ($attributes) {
                        $query->where('documents.name', 'like', '%' . $attributes->name . '%');
                    })->orWhere(function ($query) use ($attributes) {
                        $query->where('workflows.name', 'like', '%' . $attributes->name . '%');
                    })->orWhere(function ($query) use ($attributes) {
                        $query->where('workflowDocument.name', 'like', '%' . $attributes->name . '%');
                    })->orWhere(function ($query) use ($attributes) {
                        $query->where('filerequests.subject', 'like', '%' . $attributes->name . '%');
                    });
            });
        }

        $results = $query->skip($attributes->skip)->take($attributes->pageSize)->get();

        return $results;
    }

    public function getUserNotificationCount($attributes)
    {
        $userId = Auth::parseToken()->getPayload()->get('userId');

        if ($userId == null) {
            throw new RepositoryException('User does not exist.');
        }

        $query = UserNotifications::query()
            ->where('usernotifications.userId', '=', $userId)
            ->where('usernotifications.createdDate', '<=', Carbon::now())
            ->leftJoin('documents', function ($join) {
                $join->on('usernotifications.documentId', '=', 'documents.id')
                    ->where('documents.isDeleted', '=', false)
                    ->where('documents.isPermanentDelete', '=', false);
            });

        if ($attributes->name) {
            $query = $query->where(function ($query) use ($attributes) {
                $query->where('usernotifications.message', 'like', '%' . $attributes->name . '%')
                    ->orWhere(function ($query) use ($attributes) {
                        $query->where('documents.name', 'like', '%' . $attributes->name . '%');
                    });
            });
        }

        $count = $query->count();
        return $count;
    }

    public function markAsRead($request)
    {
        $model = $this->model->find($request->id);
        $model->isRead = true;
        $saved = $model->save();
        $this->resetModel();
        $result = $this->parseResult($model);

        if (!$saved) {
            throw new RepositoryException('Error in saving data.');
        }
        return $result;
    }

    public function markAllAsRead()
    {
        $userId = Auth::parseToken()->getPayload()->get('userId');
        if ($userId == null) {
            throw new RepositoryException('User does not exist.');
        }

        $usernotifications = UserNotifications::where('userId', $userId)->get();

        foreach ($usernotifications as $userNotification) {
            $userNotification->isRead = true;
            $userNotification->save();
        }

        return;
    }

    public function markAsReadByDocumentId($documentId)
    {
        $userId = Auth::parseToken()->getPayload()->get('userId');
        if ($userId == null) {
            throw new RepositoryException('User does not exist.');
        }

        $usernotifications = UserNotifications::where('userId', '=', $userId)
            ->where('documentId', '=', $documentId)->get();

        foreach ($usernotifications as $userNotification) {
            $userNotification->isRead = true;
            $userNotification->save();
        }
        return;
    }
}

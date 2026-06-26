<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Auth;
use Ramsey\Uuid\Uuid;

class WorkflowLog extends BaseModel
{
    use HasFactory, SoftDeletes;
    use Notifiable, Uuids;
    protected $primaryKey = "id";
    const CREATED_AT = 'createdDate';
    const UPDATED_AT = null;

    protected $table = 'workflowlogs'; // Table name
    protected $fillable = ['documentworkflowId', 'transitionId', 'type', 'createdBy', 'createdDate', 'comment'];

    /**
     * Get the document this log belongs to.
     */
    public function documentworkflow()
    {
        return $this->belongsTo(DocumentWorkflow::class, 'documentworkflowId');
    }

    /**
     * Get the initial state of the log.
     */
    public function transition()
    {
        return $this->belongsTo(WorkflowTransition::class, 'transitionId');
    }

    /**
     * Get the user who executed the transition.
     */
    public function createdByUser()
    {
        return $this->belongsTo(Users::class, 'createdBy');
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function (Model $model) {
            $userId = Auth::parseToken()->getPayload()->get('userId');
            $model->createdBy = $userId;
            $model->setAttribute($model->getKeyName(), Uuid::uuid4());
        });

        static::addGlobalScope('workflowlogs.isDeleted', function (Builder $builder) {
            $builder->where('workflowlogs.isDeleted', '=', 0);
        });
    }
}

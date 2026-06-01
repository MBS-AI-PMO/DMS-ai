<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Notifications\Notifiable;
use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Builder;

class Documents extends BaseModel
{
    use HasFactory, SoftDeletes;
    use Notifiable, Uuids;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = 'modifiedDate';
    protected $table = 'documents';

    protected $fillable = [
        'categoryId',
        'name',
        'description',
        'url',
        'createdBy',
        'modifiedBy',
        'isIndexed',
        'isDeleted',
        'location',
        'isPermanentDelete',
        'clientId',
        'statusId',
        'documentworkflowId',
        'currentWorkflowStepId',
        'retentionPeriod',
        'retentionAction',
        'signById',
        'signDate',
        'isExpired',
        'expiredDate'
    ];

    protected $casts = [
        'isIndexed' => 'boolean',
        'isDeleted' => 'boolean',
        'isPermanentDelete' => 'boolean',
        'isWorkflowCompleted' => 'boolean',
        'isExpired' => 'boolean',
        'retentionPeriod' => 'integer',
        'retentionAction' => 'integer'
    ];

    public function categories()
    {
        return $this->belongsTo(Categories::class, 'categoryId', 'id');
    }

    public function clients()
    {
        return $this->belongsTo(Clients::class, 'clientId', 'id');
    }

    public function docuementStatus()
    {
        return $this->belongsTo(DocumentStatus::class, 'statusId', 'id');
    }

    public function users()
    {
        return $this->belongsTo(Users::class, 'createdBy', 'id');
    }

    public function signedUser()
    {
        return $this->belongsTo(Users::class, 'signById', 'id');
    }

    public function documentmetadatas()
    {
        return $this->hasMany(DocumentMetaDatas::class, 'documentId');
    }

    public function documentcomments()
    {
        return $this->hasMany(DocumentComments::class, 'documentId');
    }

    public function usernotifications()
    {
        return $this->hasMany(UserNotifications::class, 'documentId');
    }

    public function reminderschedulers()
    {
        return $this->hasMany(ReminderSchedulers::class, 'documentId');
    }

    public function reminders()
    {
        return $this->hasMany(Reminders::class, 'documentId');
    }

    public function documentversions()
    {
        return $this->hasMany(DocumentVersions::class, 'documentId');
    }

    public function documentuserpermissions()
    {
        return $this->hasMany(DocumentUserPermissions::class, 'documentId');
    }

    public function documentrolepermissions()
    {
        return $this->hasMany(DocumentRolePermissions::class, 'documentId');
    }

    public function documentaudittrails()
    {
        return $this->hasMany(DocumentAuditTrails::class, 'documentId');
    }

    public function documentworkflow()
    {
        return $this->belongsTo(DocumentWorkflow::class, 'documentworkflowId', 'id');
    }

    protected static function boot()
    {
        parent::boot();
        static::creating(function (Model $model) {
            $userId = Auth::parseToken()->getPayload()->get('userId');
            $model->createdBy = $userId;
            $model->modifiedBy = $userId;
            $model->setAttribute($model->getKeyName(), Uuid::uuid4());
        });
        static::updating(function (Model $model) {
            if (Auth::check()) {
                $userId = Auth::parseToken()->getPayload()->get('userId');
                $model->modifiedBy = $userId;
            }
        });

        static::addGlobalScope('isDeleted', function (Builder $builder) {
            $builder->where('documents.isDeleted', '=', 0);
        });

        static::addGlobalScope('isPermanentDelete', function (Builder $builder) {
            $builder->where('documents.isPermanentDelete', '=', 0);
        });

        static::addGlobalScope('isExpired', function (Builder $builder) {
            $builder->where('documents.isExpired', '=', 0);
        });
    }
}

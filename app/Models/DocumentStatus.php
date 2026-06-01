<?php

namespace App\Models;
use Ramsey\Uuid\Uuid;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Notifications\Notifiable;
use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletes;

class DocumentStatus extends BaseModel
{
    use HasFactory, SoftDeletes;
    use Notifiable, Uuids;
    protected $primaryKey = "id";
    protected $table = 'documentstatus';
    public $incrementing = false;

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = 'modifiedDate';

    protected $fillable = [
        'name', 'description','colorCode', 'createdBy',
        'modifiedBy', 'isDeleted'
    ];

    protected static function boot()
    {
        parent::boot();

        static::creating(function (Model $model) {
            $userId = Auth::parseToken()->getPayload()->get('userId');
            $model->createdBy= $userId;
            $model->modifiedBy =$userId;
            $model->setAttribute($model->getKeyName(), Uuid::uuid4());
        });
        // static::updating(function (Model $model) {
        //     $userId = Auth::parseToken()->getPayload()->get('userId');
        //     $model->modifiedBy =$userId;
        // });

        static::addGlobalScope('isDeleted', function (Builder $builder) {
            $builder->where('documentstatus.isDeleted', '=', 0);
        });
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;


use Ramsey\Uuid\Uuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Notifications\Notifiable;
use App\Traits\Uuids;

class CronJobLogs extends BaseModel
{
    use HasFactory, Uuids;
    protected $primaryKey = "id";
    protected $table = 'cronjoblogs';
    public $timestamps = false;

    protected $fillable = [
        'jobName',
        'status',
        'output',
        'executionTime',
        'startedAt',
        'endedAt',
    ];

    protected $casts = [
        'startedAt' => 'datetime',
        'endedAt' => 'datetime',
    ];

    protected static function boot()
    {
        parent::boot();

        static::creating(function (Model $model) {
            $model->setAttribute($model->getKeyName(), Uuid::uuid4());
        });
    }
}

<?php

namespace App\Models;

use App\Traits\Uuids;

use Ramsey\Uuid\Uuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class EmailLogAttachments extends BaseModel
{
    use HasFactory, Uuids;
    protected $primaryKey = "id";
    protected $table = 'emaillogattachments';
    public $timestamps = false;

    protected $fillable = [
        'path',
        'name',
        'emailLogId'
    ];

    protected static function boot()
    {
        parent::boot();

        static::creating(function (Model $model) {
            $model->setAttribute($model->getKeyName(), Uuid::uuid4());
        });
    }
}

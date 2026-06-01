<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Notifications\Notifiable;
use Ramsey\Uuid\Uuid;

class AllowFileExtensions extends BaseModel
{
    use HasFactory;
    use Notifiable, Uuids;

    public $timestamps = false;
    protected $table = 'allowfileextensions';
    protected $primaryKey = 'id';
    public $incrementing = false;

    protected $fillable = [
        'id',
        'fileType',
        'extensions'
    ];

    protected $casts = [
        'fileType' => 'integer',
    ];

    protected static function boot()
    {
        parent::boot();

        static::creating(function (Model $model) {
            $model->setAttribute($model->getKeyName(), Uuid::uuid4());
        });
    }
}

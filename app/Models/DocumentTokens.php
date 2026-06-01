<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;


class DocumentTokens extends BaseModel
{
    use HasFactory, Uuids;
    public $timestamps = false;
    public $incrementing = false;
    protected $primaryKey = "id";
    protected $table = 'documenttokens';

    protected $fillable = [
        'documentId',
        'token',
        'createdDate'
    ];

    protected $casts = [
        'createdDate' => 'datetime'
    ];


    protected static function boot()
    {
        parent::boot();

        static::creating(function (Model $model) {
            $model->setAttribute($model->getKeyName(), Uuid::uuid4());
        });
    }
}

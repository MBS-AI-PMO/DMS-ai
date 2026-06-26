<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Ramsey\Uuid\Uuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;

use App\Traits\Uuids;

class DocumentSignature extends BaseModel
{
    use HasFactory, Uuids;
    protected $primaryKey = "id";
    protected $table = 'documentsignatures';
    public $timestamps = false;

    protected $fillable = [
        'documentId',
        'createdBy',
        'signatureUrl',
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

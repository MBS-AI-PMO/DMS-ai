<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Notifications\Notifiable;
use App\Traits\Uuids;

class PageHelper extends BaseModel
{
    use HasFactory;
    use Notifiable, Uuids;
    protected $primaryKey = "id";
    public $timestamps = false;
    protected $table = 'pagehelper';

    protected $fillable = [
        'name',
        'code',
        'description'
    ];

    protected static function boot()
    {
        parent::boot();

        static::creating(function (Model $model) {
            $model->setAttribute($model->getKeyName(), Uuid::uuid4());
        });
    }
}

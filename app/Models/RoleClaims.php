<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Database\Eloquent\Factories\HasFactory;


class RoleClaims extends BaseModel
{
    use HasFactory;
    protected $primaryKey = "id";
    protected $keyType = 'string';
    public $incrementing = false;

    protected $table = 'roleclaims';
    public $timestamps = false;

    protected $fillable = ['roleId', 'actionId', 'claimType'];

    public function action()
    {
        return $this->belongsTo(Actions::class, 'actionId');
    }

    public function role()
    {
        return $this->belongsTo(Roles::class, 'roleId');
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function (Model $model) {
            $model->setAttribute($model->getKeyName(), Uuid::uuid4());
        });
    }
}

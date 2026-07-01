<?php

namespace App\Models;

use Ramsey\Uuid\Uuid;
use Illuminate\Database\Eloquent\Model;
use App\Models\UserRoles;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use PHPOpenSourceSaver\JWTAuth\Contracts\JWTSubject;
use App\Traits\Uuids;
use App\Traits\ResolvesTableName;
use Illuminate\Database\Eloquent\Builder;

class Users extends Authenticatable implements JWTSubject
{
    use HasFactory;
    use Notifiable, Uuids, ResolvesTableName;

    protected $table = 'users';
    protected $primaryKey = "id";
    public $timestamps = false;

    protected $fillable = [
        'firstName',
        'lastName',
        'userName',
        'email',
        'emailConfirmed',
        'phoneNumberConfirmed',
        'twoFactorEnabled',
        'lockoutEnabled',
        'accessFailedCount',
        'password',
        'isDeleted',
        'phoneNumber',
        'resetPasswordCode',
        'isSystemUser',
        'normalizedUserName',
        'normalizedEmail',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function userRoles()
    {
        return $this->hasMany(UserRoles::class, 'userId', 'id');
    }

    public function userClaims()
    {
        return $this->hasMany(UserClaims::class, 'userId', 'id');
    }

    public function documentuserpermissions()
    {
        return $this->hasMany(DocumentUserPermissions::class, 'userId', 'id');
    }

    public function usernotifications()
    {
        return $this->hasMany(UserNotifications::class, 'userId', 'id');
    }

    public function getJWTCustomClaims()
    {
        return [

            // 'picture'         => $this->getPicture(),
            // 'confirmed'       => $this->confirmed,
            // 'registered_at'   => $this->created_at->toIso8601String(),
            // 'last_updated_at' => $this->updated_at->toIso8601String(),
        ];
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function (Model $model) {
            if (empty($model->getAttribute($model->getKeyName()))) {
                $model->setAttribute($model->getKeyName(), Uuid::uuid4()->toString());
            }
        });

        static::addGlobalScope('isDeleted', function (Builder $builder) {
            $builder->where('users.isDeleted', '=', 0);
        });

        static::addGlobalScope('isSystemUser', function (Builder $builder) {
            $builder->where(function (Builder $query) {
                $query->where('isSystemUser', '=', 0)
                    ->orWhereNull('isSystemUser');
            });
        });
    }
}

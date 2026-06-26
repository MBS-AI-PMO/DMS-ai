<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use Ramsey\Uuid\Uuid;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Notifications\Notifiable;
use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Builder;

class Reminders extends BaseModel
{
    use HasFactory, SoftDeletes;
    use Notifiable, Uuids;
    protected $primaryKey = "id";

    protected $table = 'reminders';

    const CREATED_AT = 'createdDate';
    const UPDATED_AT = 'modifiedDate';

    protected $casts = [
        'startDate' => 'datetime',
        'endDate' => 'datetime',
    ];
    
    protected $fillable = [
        'subject',
        'message',
        'frequency',
        'startDate',
        'endDate',
        'dayOfWeek',
        'isRepeated',
        'isEmailNotification',
        'documentId',
        'createdBy',
        'modifiedBy',
        'isDeleted'
    ];

    public function documents()
    {
        return $this->belongsTo(Documents::class, 'documentId');
    }

    public function reminderusers()
    {
        return $this->hasMany(ReminderUsers::class, 'reminderId', 'id');
    }

    public function dailyreminders()
    {
        return $this->hasMany(DailyReminders::class, 'reminderId');
    }

    public function remindernotifications()
    {
        return $this->hasMany(ReminderNotifications::class, 'reminderId');
    }

    public function halfyearlyreminders()
    {
        return $this->hasMany(HalfYearlyReminders::class, 'reminderId');
    }
    public function quarterlyreminders()
    {
        return $this->hasMany(QuarterlyReminders::class, 'reminderId');
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
            $userId = Auth::parseToken()->getPayload()->get('userId');
            $model->modifiedBy = $userId;
        });

        static::addGlobalScope('isDeleted', function (Builder $builder) {
            $builder->where('reminders.isDeleted', '=', 0);
        });

        static::deleting(function (Reminders $reminder) {
            $reminder->reminderusers()->delete();
            $reminder->dailyreminders()->delete();
            $reminder->remindernotifications()->delete();
            $reminder->halfyearlyreminders()->delete();
            $reminder->quarterlyreminders()->delete();
        });
    }
}

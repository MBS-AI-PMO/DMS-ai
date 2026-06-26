<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use Ramsey\Uuid\Uuid;
use Illuminate\Notifications\Notifiable;
use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;


class ReminderNotifications extends BaseModel
{
    use HasFactory;
    use Notifiable, Uuids;
    protected $primaryKey = "id";
    protected $keyType = 'string';
    public $incrementing = false;
    protected $table = 'remindernotifications';
    public $timestamps = false;

    protected $fillable =  [
        'reminderId', 'subject', 'description',
        'fetchDateTime', 'isDeleted', 'isEmailNotification'
    ];

    public function reminders()
    {
        return $this->belongsTo(Reminders::class, 'reminderId', 'id');
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function (Model $model) {
            $model->setAttribute($model->getKeyName(), Uuid::uuid4());
        });
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use Ramsey\Uuid\Uuid;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Notifications\Notifiable;
use App\Traits\Uuids;

class OpenAIDocuments extends BaseModel
{
    use HasFactory;
    use Notifiable, Uuids;

    protected $primaryKey = "id";
    protected $table = 'openaidocuments';
    
    protected $fillable = [
        'id',
        'prompt',
        'model',
        'response',
        'language',
        'maximumLength',
        'creativity',
        'toneOfVoice',
    ];

    protected static function boot()
    {
        parent::boot();

        static::creating(function (Model $model) {
            $model->setAttribute($model->getKeyName(), Uuid::uuid4());
        });
    }
}

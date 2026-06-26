<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use Illuminate\Database\Eloquent\Factories\HasFactory;

use Ramsey\Uuid\Uuid;

class WorkflowStep extends BaseModel
{
    use HasFactory;
    protected $primaryKey = "id";
    public $timestamps = false;
    public $incrementing = false;

    protected $table = 'workflowsteps'; // Table name
    protected $fillable = ['workflowId', 'name'];

    public function workflow()
    {
        return $this->belongsTo(Workflow::class, 'workflowId');
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function (Model $model) {
            $model->setAttribute($model->getKeyName(), Uuid::uuid4());
        });
    }
}

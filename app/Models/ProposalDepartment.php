<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ProposalDepartment extends BaseModel
{
    use HasFactory, Uuids;

    public $timestamps = false;
    protected $table = 'proposaldepartments';
    protected $primaryKey = 'id';

    protected $fillable = [
        'id',
        'categoryId',
        'name',
        'basicQuestions',
        'intermediateQuestions',
        'expertQuestions',
        'createdBy',
        'createdDate',
        'modifiedDate',
    ];

    protected $casts = [
        'createdDate' => 'datetime',
        'modifiedDate' => 'datetime',
    ];

    public function category(): BelongsTo
    {
        return $this->belongsTo(ProposalCategory::class, 'categoryId');
    }

    public function posts(): HasMany
    {
        return $this->hasMany(ProposalPost::class, 'departmentId');
    }
}

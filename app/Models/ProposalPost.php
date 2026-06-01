<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ProposalPost extends BaseModel
{
    use HasFactory, Uuids;

    public $timestamps = false;
    protected $table = 'proposalposts';
    protected $primaryKey = 'id';

    protected $fillable = [
        'id',
        'title',
        'department',
        'departmentId',
        'category',
        'experienceYears',
        'interviewKit',
        'basicQuestions',
        'intermediateQuestions',
        'expertQuestions',
        'workMode',
        'address',
        'description',
        'createdBy',
        'createdDate',
        'modifiedDate',
    ];

    protected $casts = [
        'experienceYears' => 'integer',
        'createdDate' => 'datetime',
        'modifiedDate' => 'datetime',
    ];

    public function departmentRelation(): BelongsTo
    {
        return $this->belongsTo(ProposalDepartment::class, 'departmentId');
    }

    public function candidates(): HasMany
    {
        return $this->hasMany(ProposalCandidate::class, 'postId');
    }
}

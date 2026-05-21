<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ProposalPost extends Model
{
    use HasFactory, Uuids;

    public $timestamps = false;
    protected $table = 'proposalPosts';
    protected $primaryKey = 'id';

    protected $fillable = [
        'id',
        'title',
        'department',
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

    public function candidates(): HasMany
    {
        return $this->hasMany(ProposalCandidate::class, 'postId');
    }
}

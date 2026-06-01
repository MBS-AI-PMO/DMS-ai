<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ProposalCandidate extends BaseModel
{
    use HasFactory, Uuids;

    public $timestamps = false;
    protected $table = 'proposalcandidates';
    protected $primaryKey = 'id';

    protected $fillable = [
        'id',
        'postId',
        'candidateName',
        'candidateCode',
        'phone',
        'email',
        'category',
        'experienceYears',
        'workMode',
        'address',
        'cvOriginalName',
        'cvPath',
        'stage',
        'interviewLevel',
        'interviewDate',
        'interviewer',
        'interviewerUserId',
        'analysisNotes',
        'rejectionReason',
        'createdBy',
        'createdDate',
        'modifiedDate',
    ];

    protected $casts = [
        'experienceYears' => 'integer',
        'createdDate' => 'datetime',
        'modifiedDate' => 'datetime',
        'interviewDate' => 'datetime',
    ];

    public function post(): BelongsTo
    {
        return $this->belongsTo(ProposalPost::class, 'postId');
    }
}

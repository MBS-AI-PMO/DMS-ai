<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class CandidateProfile extends BaseModel
{
    use HasFactory, Uuids;

    public $timestamps = false;
    protected $table = 'candidateprofiles';
    protected $primaryKey = 'id';

    protected $fillable = [
        'id',
        'userId',
        'candidateCode',
        'email',
        'phone',
        'experienceYears',
        'workMode',
        'address',
        'preferredCategory',
        'createdDate',
        'modifiedDate',
    ];

    protected $casts = [
        'experienceYears' => 'integer',
        'createdDate' => 'datetime',
        'modifiedDate' => 'datetime',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(Users::class, 'userId');
    }

    public function applications(): HasMany
    {
        return $this->hasMany(ProposalCandidate::class, 'candidateUserId', 'userId');
    }
}

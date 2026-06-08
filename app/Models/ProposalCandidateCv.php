<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ProposalCandidateCv extends BaseModel
{
    use HasFactory, Uuids;

    public $timestamps = false;
    protected $table = 'proposalcandidatecvs';
    protected $primaryKey = 'id';

    protected $fillable = [
        'id',
        'createdBy',
        'candidateCode',
        'email',
        'cvOriginalName',
        'cvPath',
        'createdDate',
        'modifiedDate',
    ];

    protected $casts = [
        'createdDate' => 'datetime',
        'modifiedDate' => 'datetime',
    ];
}

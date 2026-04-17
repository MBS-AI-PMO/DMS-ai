<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ProposalFileRequest extends Model
{
    use HasFactory, Uuids;

    public $timestamps = false;
    protected $table = 'proposalFileRequests';
    protected $primaryKey = 'id';

    protected $fillable = [
        'id',
        'folderId',
        'title',
        'description',
        'status',
        'createdBy',
        'createdDate',
    ];

    protected $casts = [
        'createdDate' => 'datetime',
    ];

    public function folder(): BelongsTo
    {
        return $this->belongsTo(ProposalFolder::class, 'folderId');
    }
}

<?php

namespace App\Models;

use App\Traits\Uuids;
use App\Models\FileRequests;
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
        'fileRequestId',
        'title',
        'email',
        'description',
        'maxDocument',
        'sizeInMb',
        'allowExtension',
        'hasPassword',
        'password',
        'linkExpiryTime',
        'status',
        'createdBy',
        'createdDate',
    ];

    protected $casts = [
        'createdDate' => 'datetime',
        'linkExpiryTime' => 'datetime',
        'hasPassword' => 'boolean',
        'maxDocument' => 'integer',
        'sizeInMb' => 'integer',
    ];

    public function linkedFileRequest(): BelongsTo
    {
        return $this->belongsTo(FileRequests::class, 'fileRequestId');
    }

    public function folder(): BelongsTo
    {
        return $this->belongsTo(ProposalFolder::class, 'folderId');
    }
}

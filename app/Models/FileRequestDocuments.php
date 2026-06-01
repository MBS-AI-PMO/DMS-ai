<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Database\Eloquent\Relations\BelongsTo;

class FileRequestDocuments extends BaseModel
{
    use HasFactory, Uuids;
    public $timestamps = false;
    public $incrementing = false;

    protected $table = 'filerequestdocuments';
    protected $primaryKey = "id";

    protected $fillable = [
        'id',
        'name',
        'url',
        'fileRequestId',
        'fileRequestDocumentStatus',
        'approvedRejectedDate',
        'approvalOrRejectedById',
        'reason',
        'createdDate'
    ];

    protected $casts = [
        'fileRequestDocumentStatus' => 'integer',
        'approvedRejectedDate' => 'datetime',
        'createdDate' => 'datetime',
    ];

    public function fileRequest(): BelongsTo
    {
        return $this->belongsTo(FileRequests::class, 'fileRequestId');
    }

    public function approvalRejectedBy(): BelongsTo
    {
        return $this->belongsTo(Users::class, 'approvalOrRejectedById');
    }
}

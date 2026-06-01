<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;

use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ProposalFolder extends BaseModel
{
    use HasFactory, Uuids;

    public $timestamps = false;
    protected $table = 'proposalfolders';
    protected $primaryKey = 'id';

    protected $fillable = [
        'id',
        'name',
        'parentFolderId',
        'createdBy',
        'createdDate',
        'modifiedDate',
    ];

    protected $casts = [
        'createdDate' => 'datetime',
        'modifiedDate' => 'datetime',
    ];

    public function parentFolder(): BelongsTo
    {
        return $this->belongsTo(ProposalFolder::class, 'parentFolderId');
    }

    public function childFolders(): HasMany
    {
        return $this->hasMany(ProposalFolder::class, 'parentFolderId');
    }
}

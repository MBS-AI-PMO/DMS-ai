<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ProposalCategory extends BaseModel
{
    use HasFactory, Uuids;

    public $timestamps = false;
    protected $table = 'proposalcategories';
    protected $primaryKey = 'id';

    protected $fillable = [
        'id', 'name', 'createdBy', 'createdDate', 'modifiedDate',
    ];

    protected $casts = [
        'createdDate' => 'datetime',
        'modifiedDate' => 'datetime',
    ];

    public function departments(): HasMany
    {
        return $this->hasMany(ProposalDepartment::class, 'categoryId');
    }
}

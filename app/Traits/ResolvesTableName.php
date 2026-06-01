<?php

namespace App\Traits;

use App\Support\TableName;

trait ResolvesTableName
{
    public function getTable()
    {
        $preferred = $this->table ?? parent::getTable();

        // Case-insensitive: code may say userRoles, DB may have userroles
        return TableName::resolve($preferred) ?? $preferred;
    }
}

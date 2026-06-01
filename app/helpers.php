<?php

use App\Support\TableName;
use Illuminate\Support\Facades\DB;

if (!function_exists('db_table')) {
    /**
     * Case-insensitive table name for DB::table() / joins.
     * Example: db_table('userRoles') works if DB has userroles or userRoles.
     */
    function db_table(string $preferred): string
    {
        return TableName::resolve($preferred) ?? $preferred;
    }
}

if (!function_exists('db_from')) {
    /** Same as db_table — for ->from(db_from('documentMetaDatas')) */
    function db_from(string $preferred): string
    {
        return db_table($preferred);
    }
}

if (!function_exists('db_has_table')) {
    function db_has_table(string $preferred): bool
    {
        return TableName::has($preferred);
    }
}

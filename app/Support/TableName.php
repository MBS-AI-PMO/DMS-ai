<?php

namespace App\Support;

use Illuminate\Support\Facades\DB;

/**
 * Case-insensitive MySQL table names (Windows vs Linux / dms-ahi.sql).
 * Loads real names once from the connected database.
 */
class TableName
{
    /** @var array<string, string>|null lowercase => actual TABLE_NAME */
    private static ?array $tablesByLower = null;

    /** @var array<string, string> */
    private static array $resolveCache = [];

    public static function preload(): void
    {
        if (self::$tablesByLower !== null) {
            return;
        }

        self::$tablesByLower = [];

        try {
            $rows = DB::select(
                'SELECT TABLE_NAME AS name FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE()'
            );
            foreach ($rows as $row) {
                $name = $row->name ?? null;
                if ($name !== null && $name !== '') {
                    self::$tablesByLower[strtolower($name)] = $name;
                }
            }
        } catch (\Throwable $e) {
            // DB not ready during install/artisan
        }
    }

    /** Resolve actual table name; ignores letter case (userRoles = userroles). */
    public static function resolve(string $preferred): ?string
    {
        if (isset(self::$resolveCache[$preferred])) {
            return self::$resolveCache[$preferred];
        }

        self::preload();

        $key = strtolower($preferred);
        if (isset(self::$tablesByLower[$key])) {
            return self::$resolveCache[$preferred] = self::$tablesByLower[$key];
        }

        return self::$resolveCache[$preferred] = null;
    }

    public static function has(string $preferred): bool
    {
        return self::resolve($preferred) !== null;
    }

    public static function clearCache(): void
    {
        self::$tablesByLower = null;
        self::$resolveCache = [];
    }
}

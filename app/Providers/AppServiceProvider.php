<?php

namespace App\Providers;

use App\Support\TableName;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
       
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        try {
            TableName::preload();
        } catch (\Throwable $e) {
            // DB may be unavailable during install
        }

        // Case-insensitive: DB::table('userRoles') → real table name on server
        DB::macro('tableCi', function (string $preferred, $as = null) {
            $table = TableName::resolve($preferred) ?? $preferred;
            return $as === null ? DB::table($table) : DB::table($table . ' as ' . $as);
        });
    }
}

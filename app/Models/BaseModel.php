<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Traits\ResolvesTableName;

/**
 * All app models should extend this class for Linux MySQL table name case resolution.
 */
abstract class BaseModel extends Model
{
    use ResolvesTableName;
}

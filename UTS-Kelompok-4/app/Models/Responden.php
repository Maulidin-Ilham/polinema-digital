<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Responden extends Model
{
    use HasFactory;
    // protected $fillable = ["age","gpa","year","reports"];
    protected $guarded = ["id"];



}

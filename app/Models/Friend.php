<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Friend extends Model
{
    use HasFactory;

    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'id_friend1', 'id_friend2'
    ];

    public function peer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'id_friend2');
    }

}



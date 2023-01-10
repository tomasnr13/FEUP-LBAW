<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Rating extends Model
{
    use HasFactory;

    protected $primaryKey = 'id';
    public $timestamps = false;

            /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id_rating_author','id_post','liked', 'type'
    ];

    public function author(): BelongsTo
    {
        return $this->belongsTo(User::class, 'id_rating_author');
    }

    public function post(): BelongsTo
    {
        return $this->belongsTo(Post::class);
    }
}

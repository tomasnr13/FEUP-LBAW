<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Post extends Model
{
    use HasFactory;

    // Don't add create and update timestamps in database.
    public $timestamps  = false;
    protected $primaryKey = 'id';
    protected $table = 'posts';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id_author', 'description', 'type'
    ];

    /**
     * Get the author of the post.
     */
    public function author(): BelongsTo
    {
        return $this->belongsTo(User::class, 'id_author');
    }

    public function comments(): HasMany
    {
        return $this->hasMany(Comment::class, 'id_post');
    }

    public function commentsByInverseChronologicalOrder(): HasMany {
        return $this->hasMany(Comment::class, 'id_post')->orderByDesc('date_of_post');
    }
}

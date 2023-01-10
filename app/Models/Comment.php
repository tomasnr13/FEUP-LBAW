<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;


class Comment extends Model
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
        'id_comment_author', 'id_post', 'description', 'date_of_post'
    ];

    /**
     * Get the author of the comment.
     */
   public function author(): BelongsTo
    {
        return $this->belongsTo(User::class, 'id_comment_author');
    }

    /**
     * Get the post that this comment belongs to.
     */
    public function post(): BelongsTo
    {
        return $this->belongsTo(Post::class, 'id_post');
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    // use HasFactory;
    use Notifiable;

    // Don't add create and update timestamps in database.
    public $timestamps  = false;
    
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'username', 'birth_date', 'phone', 'bio', 'email', 'password', 'public',
    ];

    
    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'email'
    ];

    /**
     * Get the user's posts.
     */
    public function posts(): HasMany
    {
        return $this->hasMany(Post::class, 'id_author');
    }

    public function postsByInverseChronologicalOrder(): HasMany {
        return $this->hasMany(Post::class, 'id_author')->orderByDesc('date_of_post');
    }
}

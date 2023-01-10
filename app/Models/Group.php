<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Group extends Model
{
    use HasFactory;

    // Don't add create and update timestamps in database.
    public $timestamps  = false;
    protected $primaryKey = 'id';

            /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id_group_owner','name','description','security'
    ];

    public function owner(): BelongsTo
    {
        return $this->belongsTo(User::class, 'id_group_owner');
    }

    public function members(): HasMany
    {
        return $this->hasMany(GroupMember::class, 'id_group');
    }
}

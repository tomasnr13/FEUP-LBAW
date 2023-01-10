<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class GroupMember extends Model
{
    use HasFactory;

    protected $table = 'group_members';
    protected $primaryKey = 'id';
    public $timestamps = false;

        /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id_member', 'id_group'
    ];

    public function group(): BelongsTo
    {
        return $this->belongsTo(User::class, 'id_group');
    }

}

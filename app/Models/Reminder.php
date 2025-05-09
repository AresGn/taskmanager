<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Reminder extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'description',
        'date',
        'time',
        'email_sent',
        'user_id',
    ];

    protected $casts = [
        'email_sent' => 'boolean',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Accesseur pour convertir la date en objet Carbon
    public function getDateAttribute($value)
    {
        return $value ? Carbon::parse($value) : null;
    }
}

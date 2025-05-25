<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Lokasi extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'kode_lokasi',
        'nama_lokasi',
        'alamat',
        'telepon',
        'manager',
        'status',
    ];

    public function produks()
    {
        return $this->belongsToMany(Produk::class, 'produk_lokasi')
                    ->withPivot('stok')
                    ->withTimestamps();
    }

    public function mutasis()
    {
        return $this->hasMany(Mutasi::class);
    }
}

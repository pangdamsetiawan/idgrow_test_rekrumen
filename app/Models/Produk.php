<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes; // Import SoftDeletes

class Produk extends Model
{
    use HasFactory, SoftDeletes;  // gunakan trait SoftDeletes

    protected $fillable = [
        'nama_produk',
        'kode_produk',
        'kategori',
        'satuan',
        'deskripsi',
        'harga_beli',
        'harga_jual',
        'berat',
        'merk',
        'status',
    ];

    public function lokasis()
    {
        return $this->belongsToMany(Lokasi::class, 'produk_lokasi')
                    ->withPivot('stok')
                    ->withTimestamps();
    }

    public function mutasis()
    {
        return $this->hasMany(Mutasi::class);
    }
}

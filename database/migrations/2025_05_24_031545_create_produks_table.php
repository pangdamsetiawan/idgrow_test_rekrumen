<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('produks', function (Blueprint $table) {
            $table->id();
            $table->string('nama_produk');
            $table->string('kode_produk')->unique();
            $table->string('kategori')->nullable();  // Bisa nullable kalau perlu
            $table->string('satuan')->nullable();    // Bisa nullable kalau perlu
            $table->text('deskripsi')->nullable();

            // Kolom baru
            $table->decimal('harga_beli', 15, 2)->nullable();
            $table->decimal('harga_jual', 15, 2)->nullable();
            $table->decimal('berat', 8, 3)->nullable();  // Berat dengan 3 digit desimal
            $table->string('merk')->nullable();
            $table->enum('status', ['aktif', 'nonaktif'])->default('aktif')->index();

            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('produks');
    }
};

<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void {
        Schema::create('lokasis', function (Blueprint $table) {
            $table->id();
            $table->string('kode_lokasi')->unique();
            $table->string('nama_lokasi');
            $table->text('alamat')->nullable();
            $table->string('telepon')->nullable();
            $table->string('manager')->nullable();
            $table->enum('status', ['aktif', 'nonaktif'])->default('aktif')->index();
            $table->timestamps();
            $table->softDeletes();  // kolom deleted_at untuk soft delete
        });
    }

    public function down(): void {
        Schema::dropIfExists('lokasis');
    }
};

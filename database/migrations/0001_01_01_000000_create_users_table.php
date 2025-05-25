<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();

            // Data user dasar
            $table->string('name');
            $table->string('username')->unique()->nullable(); // username opsional
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();

            $table->string('password');

            // Data tambahan
            $table->string('phone_number')->nullable();
            $table->enum('role', ['admin', 'user', 'manager'])->default('user');
            $table->enum('status', ['active', 'inactive'])->default('active');

            $table->rememberToken();

            // Timestamps standar Laravel
            $table->timestamps();

            // Soft delete agar data bisa "dihapus" tapi masih tersimpan
            $table->softDeletes();
        });
    }

    public function down()
    {
        Schema::dropIfExists('users');
    }
};

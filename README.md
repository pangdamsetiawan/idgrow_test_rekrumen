# Laravel Inventory Management API

Project REST API ini dibuat sebagai bagian dari tes rekrutmen Software Engineer oleh **ID-GROW (PT. Clavata Extra Sukses)**.  
Project ini dibangun menggunakan **Laravel 11** dan menggunakan **Docker** untuk kemudahan deployment.

📑 Dokumentasi API (Postman)
📎 Link Dokumentasi Postman:
https://documenter.getpostman.com/view/31181555/2sB2qcCLsE

## 📦 Fitur Utama

- Autentikasi menggunakan Bearer Token (Laravel Sanctum)
- CRUD untuk:
  - User
  - Produk
  - Lokasi
  - Mutasi
- Relasi:
  - Produk <-> Lokasi (Many-to-Many dengan pivot `stok`)
  - Mutasi <-> ProdukLokasi <-> User
- Mutasi otomatis mengubah stok
- Endpoint untuk history mutasi per produk dan user
- Dokumentasi API tersedia di Postman

---

## ⚙️ Teknologi yang Digunakan

Laravel 11

Laravel Sanctum (autentikasi token)

MySQL

Docker + Docker Compose

Postman (dokumentasi API)

---

## 🚀 Instalasi & Menjalankan Proyek

### 🔧 Prasyarat

- Composer
- PHP >= 8.2
- MySQL
- Git
- Docker & Docker Compose

---

### 💻 Jalankan Secara Lokal (XAMPP / Tanpa Docker)
1. Aktifkan Apache dan MySQL di XAMPP

2. Clone Repository
git clone https://github.com/pangdamsetiawan/idgrow_test_rekrumen
cd idgrow_test_rekrumen

3. Install Dependensi
composer install
cp .env.example .env
php artisan key:generate

4. Buat Database via phpMyAdmin
Buat database baru dengan nama idgrow_db.
atau Kamu bisa Import Database yang ada di file ini dengan nama file = idgrow_db.sql

5. Edit Konfigurasi .env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=idgrow_db
DB_USERNAME=root
DB_PASSWORD=


6. Migrasi dan Seed Database
php artisan migrate --seed

7. Jalankan Server Laravel
php artisan serve
Akses Postman dengan  nama di: http://localhost:8000


🐳 Jalankan Menggunakan Docker

1. **Copy .env File**
    cp .env.example .env

2. **Edit Variabel Database di .env**
    DB_CONNECTION=mysql
    DB_HOST=host.docker.internal
    DB_PORT=3306
    DB_DATABASE=idgrow_db
    DB_USERNAME=root
    DB_PASSWORD=

3. **Jalankan Docker**
    docker-compose up -d --build

4. **Masuk ke Container Laravel**
    docker exec -it app bash

5. **Install Dependensi dan Migrate**
    composer install
    php artisan key:generate
    php artisan migrate --seed

6. Akses Aplikasi 

    Laravel: http://localhost:8080

    phpMyAdmin (jika tersedia): http://localhost:8000




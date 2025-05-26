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


6. Migrasi Database
php artisan migrate

7. Tambahkan Untuk Database Untuk Login Terlebih Dahulu :
buka terminal di folder projeck ketik
php artisan tinker
paste ini di terminal untuk set database awal
User::create([
    'name' => 'admin',
    'username' => 'admin',
    'email' => 'admin@example.com',
    'password' => 'password123',  // bcrypt otomatis karena mutator
    'phone_number' => '08123456789',
    'role' => 'admin',
    'status' => 'active',
]);

9. Jalankan Server Laravel
php artisan serve
Akses Postman dengan  nama di: http://localhost:8000

10. coba di postman untuk endpoint tiap database
    
Cara tes di Postman:
1. Login Terlebih Dahulu Agar mendapatkan Barrirar Tokennya 
Masukan
URL: POST http://localhost:8000/api/login

Headers:
Accept: application/json

Body (raw JSON):

{
  "email": "admin@example.com",
  "password": "password123"
}
setelah itu klik Send Maka akan muncul Output dan barriar Tokennya

✅ Response: Token akses (Bearer Token)
📌 Simpan token ini untuk digunakan di semua permintaan berikutnya.


 2. Operasi CRUD untuk masing-masing Model

    sebelum mencoba  Operasi CRUD  copy Bearer token yang muncul ketika login di postman kemudian klik menu Authorization pada Postman pilih Bearer Token paste Token Di tempat yang tersedia Setiap kali mencoba di postman slelau lakukan ini ketika sudh login

    👤 User API
    
1. User → GET : URL http://localhost:8000/api/users   ##GET semua user

2. User → POST : URL http://localhost:8000/api/users  ##POST buat user baru

Headers:
Accept: application/json

Body (raw JSON):
{
  "name": "User Baru",
  "username": "userbaru",
  "email": "userbaru@example.com",
  "phone_number": "081234567891",
  "password": "password123",
  "role": "user",
  "status": "active"
}

3. User → PUT : URL http://localhost:8000/api/users/{id}  ##PUT ubah user Catatan untuk {id} ganti angka misal 1  untuk menganti Id 1

Headers:
Accept: application/json

Body (raw JSON):
{
  "name": "Rian",
  "username": "Rian",
  "email": "RIan@example.com",
  "phone_number": "081234567891",
  "password": "password123",
  "role": "user",
  "status": "active"
}
3. User → DELETE : URL http://localhost:8000/api/users/{id}  ##DELETE ubah user Catatan untuk {id} ganti angka misal 1  untuk menghapus Id 1

   👤 Produk API
    
1. Produk → GET : URL http://localhost:8000/api/produks   ##GET semua Produk

2. Produk → POST : URL http://localhost:8000/api/produks  ##POST buat produk baru

Headers:
Accept: application/json

Body (raw JSON):
{
  "nama_produk": "Hp",
  "kode_produk": "PRD006",
  "kategori": "Elektronik",
  "satuan": "pcs",
  "deskripsi": "Produk contoh untuk testing",
  "harga_beli": 100000,
  "harga_jual": 120000,
  "berat": 0.5,
  "merk": "BrandX",
  "status": "aktif"
}

3. produk → PUT : URL http://localhost:8000/api/produks/{id}  ##PUT ubah produk Catatan untuk {id} ganti angka misal 1  untuk menganti database Id 1

Headers:
Accept: application/json

Body (raw JSON):
{
  "nama_produk": "Laptop",
  "kode_produk": "PRD016",
  "kategori": "Elektronik",
  "satuan": "pcs",
  "deskripsi": "Produk Berkualita",
  "harga_beli": 100000,
  "harga_jual": 120000,
  "berat": 0.5,
  "merk": "Asus",
  "status": "aktif"
}
3. Produk → DELETE : URL http://localhost:8000/api/produks/{id}  ##DELETE ubah produk Catatan untuk {id} ganti angka misal 1  untuk menghapus Id 1

   👤 Lokasi API
    
1. Lokasi → GET : URL http://localhost:8000/api/lokasis   ##GET semua Lokasi

2. Lokasi → POST : URL http://localhost:8000/api/lokasis  ##POST buat Lokasi baru

Headers:
Accept: application/json

Body (raw JSON):
{
  "kode_lokasi": "L001",
  "nama_lokasi": "Gudang Utama",
  "alamat": "Jl. Raya No. 1",
  "telepon": "02112345678",
  "manager": "Budi Santoso",
  "status": "aktif"
}

3. Lokasi → PUT : URL http://localhost:8000/api/lokasis/{id}  ##PUT ubah lokasi Catatan untuk {id} ganti angka misal 1  untuk menganti database Id 1

Headers:
Accept: application/json

Body (raw JSON):
{
  "kode_lokasi": "L023",
  "nama_lokasi": "Gudang cabang",
  "alamat": "manado",
  "telepon": "02112345678",
  "manager": "Budi Santoso",
  "status": "aktif"
}

3. Lokasi → DELETE : URL http://localhost:8000/api/lokasis/{id}  ##DELETE ubah lokasi Catatan untuk {id} ganti angka misal 1  untuk menghapus Id 1

   👤 Muatasi API
    
1. Mutasi → GET : URL http://localhost:8000/api/mutasis   ##GET semua Mutasi

2. Mutasi → POST : URL http://localhost:8000/api/mutasis  ##POST buat Mutasi masuk atau keluar

Headers:
Accept: application/json

Body (raw JSON):
{
  "tanggal": "2025-05-25",
  "jenis_mutasi": "masuk",
  "jumlah": 10,
  "keterangan": "Stok masuk gudang",
  "produk_id": 1,
  "lokasi_id": 1,
  "status_mutasi": "approved",
  "reference": "PO-12345"
}

Catatan Sesuaikan 

  "produk_id": 1,
  "lokasi_id": 1,

sesuai dengn ID produk dan lokasi ID yang ingin di Mutasi 

3. Mutasi → PUT : URL http://localhost:8000/api/mutasis/{id}  ##PUT ubah mutasi Catatan untuk {id} ganti angka misal 1  untuk menganti database Id 1

Headers:
Accept: application/json

Body (raw JSON):
{
  "tanggal": "2025-05-26",
  "jenis_mutasi": "keluar",
  "jumlah": 20,
  "keterangan": "Stok Keluar gudang",
  "produk_id": 1,
  "lokasi_id": 1,
  "status_mutasi": "approved",
  "reference": "PO-12345"
}


3. Mutasi → DELETE : URL http://localhost:8000/api/Mutasis/{id}  ##DELETE ubah mutasi Catatan untuk {id} ganti angka misal 1  untuk menghapus Id 

👤 Relasi ProdukLokasi - menyimpan Stok API

 Relasi ProdukLokasi - menyimpan Stok → POST : URL http://localhost:8000/api/produk/1/lokasi/1/stok
 
 Headers:
Accept: application/json

Body (raw JSON):
{
  "stok": 100
}

👤 Lihat Produk perLokasi  API

 Lihat Produk perLokasi → GET : URL http://localhost:8000/api/produk/1/stok
 
👤 History mutasi produk  API

 History mutasi produk → GET : URL http://localhost:8000/api/mutasis/produk/1

👤 History mutasi user  API

 History mutasi user → GET : URL http://localhost:8000/api/mutasis/user/1

 untuk semua ENDPOINT ini pakai BEARER TOKEN yang didapat KETIKA LOGIN

🐳 Jalankan Menggunakan Docker


1. **Edit Variabel Database di .env**
    DB_CONNECTION=mysql
    DB_HOST=host.docker.internal
    DB_PORT=3306
    DB_DATABASE=idgrow_db
    DB_USERNAME=root
    DB_PASSWORD=

2. **Install Docker**
    docker-compose up -d --build

3. Akses Aplikasi 

    Laravel: http://localhost:8080

    phpMyAdmin (jika tersedia): http://localhost:8000

4. coba di postman untuk endpoint tiap database
    
Cara tes di Postman:
1. Login Terlebih Dahulu Agar mendapatkan Barrirar Tokennya 
Masukan
URL: POST http://localhost:8080/api/login

Headers:
Accept: application/json

Body (raw JSON):

{
  "email": "admin@example.com",
  "password": "password123"
}
setelah itu klik Send Maka akan muncul Output dan barriar Tokennya

✅ Response: Token akses (Bearer Token)
📌 Simpan token ini untuk digunakan di semua permintaan berikutnya.


 2. Operasi CRUD untuk masing-masing Model

    sebelum mencoba  Operasi CRUD  copy Bearer token yang muncul ketika login di postman kemudian klik menu Authorization pada Postman pilih Bearer Token paste Token Di tempat yang tersedia Setiap kali mencoba di postman slelau lakukan ini ketika sudh login

    👤 User API
    
1. User → GET : URL http://localhost:8080/api/users   ##GET semua user

2. User → POST : URL http://localhost:8080/api/users  ##POST buat user baru

Headers:
Accept: application/json

Body (raw JSON):
{
  "name": "User Baru",
  "username": "userbaru",
  "email": "userbaru@example.com",
  "phone_number": "081234567891",
  "password": "password123",
  "role": "user",
  "status": "active"
}

3. User → PUT : URL http://localhost:8080/api/users/{id}  ##PUT ubah user Catatan untuk {id} ganti angka misal 1  untuk menganti Id 1

Headers:
Accept: application/json

Body (raw JSON):
{
  "name": "Rian",
  "username": "Rian",
  "email": "RIan@example.com",
  "phone_number": "081234567891",
  "password": "password123",
  "role": "user",
  "status": "active"
}
3. User → DELETE : URL http://localhost:8080/api/users/{id}  ##DELETE ubah user Catatan untuk {id} ganti angka misal 1  untuk menghapus Id 1

   👤 Produk API
    
1. Produk → GET : URL http://localhost:8080/api/produks   ##GET semua Produk

2. Produk → POST : URL http://localhost:8080/api/produks  ##POST buat produk baru

Headers:
Accept: application/json

Body (raw JSON):
{
  "nama_produk": "Hp",
  "kode_produk": "PRD006",
  "kategori": "Elektronik",
  "satuan": "pcs",
  "deskripsi": "Produk contoh untuk testing",
  "harga_beli": 100000,
  "harga_jual": 120000,
  "berat": 0.5,
  "merk": "BrandX",
  "status": "aktif"
}

3. produk → PUT : URL http://localhost:8080/api/produks/{id}  ##PUT ubah produk Catatan untuk {id} ganti angka misal 1  untuk menganti database Id 1

Headers:
Accept: application/json

Body (raw JSON):
{
  "nama_produk": "Laptop",
  "kode_produk": "PRD016",
  "kategori": "Elektronik",
  "satuan": "pcs",
  "deskripsi": "Produk Berkualita",
  "harga_beli": 100000,
  "harga_jual": 120000,
  "berat": 0.5,
  "merk": "Asus",
  "status": "aktif"
}
3. Produk → DELETE : URL http://localhost:8080/api/produks/{id}  ##DELETE ubah produk Catatan untuk {id} ganti angka misal 1  untuk menghapus Id 1

   👤 Lokasi API
    
1. Lokasi → GET : URL http://localhost:8080/api/lokasis   ##GET semua Lokasi

2. Lokasi → POST : URL http://localhost:8080/api/lokasis  ##POST buat Lokasi baru

Headers:
Accept: application/json

Body (raw JSON):
{
  "kode_lokasi": "L001",
  "nama_lokasi": "Gudang Utama",
  "alamat": "Jl. Raya No. 1",
  "telepon": "02112345678",
  "manager": "Budi Santoso",
  "status": "aktif"
}

3. Lokasi → PUT : URL http://localhost:8080/api/lokasis/{id}  ##PUT ubah lokasi Catatan untuk {id} ganti angka misal 1  untuk menganti database Id 1

Headers:
Accept: application/json

Body (raw JSON):
{
  "kode_lokasi": "L023",
  "nama_lokasi": "Gudang cabang",
  "alamat": "manado",
  "telepon": "02112345678",
  "manager": "Budi Santoso",
  "status": "aktif"
}

3. Lokasi → DELETE : URL http://localhost:8080/api/lokasis/{id}  ##DELETE ubah lokasi Catatan untuk {id} ganti angka misal 1  untuk menghapus Id 1

   👤 Muatasi API
    
1. Mutasi → GET : URL http://localhost:8080/api/mutasis   ##GET semua Mutasi

2. Mutasi → POST : URL http://localhost:8080/api/mutasis  ##POST buat Mutasi masuk atau keluar

Headers:
Accept: application/json

Body (raw JSON):
{
  "tanggal": "2025-05-25",
  "jenis_mutasi": "masuk",
  "jumlah": 10,
  "keterangan": "Stok masuk gudang",
  "produk_id": 1,
  "lokasi_id": 1,
  "status_mutasi": "approved",
  "reference": "PO-12345"
}

Catatan Sesuaikan 

  "produk_id": 1,
  "lokasi_id": 1,

sesuai dengn ID produk dan lokasi ID yang ingin di Mutasi 

3. Mutasi → PUT : URL http://localhost:8080/api/mutasis/{id}  ##PUT ubah mutasi Catatan untuk {id} ganti angka misal 1  untuk menganti database Id 1

Headers:
Accept: application/json

Body (raw JSON):
{
  "tanggal": "2025-05-26",
  "jenis_mutasi": "keluar",
  "jumlah": 20,
  "keterangan": "Stok Keluar gudang",
  "produk_id": 1,
  "lokasi_id": 1,
  "status_mutasi": "approved",
  "reference": "PO-12345"
}


3. Mutasi → DELETE : URL http://localhost:8080/api/Mutasis/{id}  ##DELETE ubah mutasi Catatan untuk {id} ganti angka misal 1  untuk menghapus Id 

👤 Relasi ProdukLokasi - menyimpan Stok API

 Relasi ProdukLokasi - menyimpan Stok → POST : URL http://localhost:8080/api/produk/1/lokasi/1/stok
 
 Headers:
Accept: application/json

Body (raw JSON):
{
  "stok": 100
}

👤 Lihat Produk perLokasi  API

 Lihat Produk perLokasi → GET : URL http://localhost:8080/api/produk/1/stok
 
👤 History mutasi produk  API

 History mutasi produk → GET : URL http://localhost:8080/api/mutasis/produk/1

👤 History mutasi user  API

 History mutasi user → GET : URL http://localhost:8080/api/mutasis/user/1

 untuk semua ENDPOINT ini pakai BEARER TOKEN yang didapat KETIKA LOGIN




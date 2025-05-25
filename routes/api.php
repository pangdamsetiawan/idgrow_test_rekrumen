<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use App\Models\Produk;
use App\Models\Lokasi;
use App\Models\Mutasi;

/*
|--------------------------------------------------------------------------
| AUTH LOGIN
|--------------------------------------------------------------------------
*/
Route::post('/login', function (Request $request) {
    $request->validate([
        'email' => 'required|email',
        'password' => 'required',
    ]);

    // Cari user berdasarkan email
    $user = User::where('email', $request->email)->first();

    // Cek apakah user ditemukan dan password cocok
    if (!$user || !Hash::check($request->password, $user->password)) {
        return response()->json(['message' => 'Invalid credentials'], 401);
    }

    // Hapus token lama jika ingin memastikan hanya satu token aktif
    $user->tokens()->delete();

    // Buat token baru
    $token = $user->createToken('api-token')->plainTextToken;

    return response()->json([
        'user' => $user,
        'token' => $token,
    ]);
});

/*
|--------------------------------------------------------------------------
| Protected route example: get current user info
|--------------------------------------------------------------------------
*/
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
/*
|--------------------------------------------------------------------------
| AUTHENTICATED ROUTES
|--------------------------------------------------------------------------
*/
Route::middleware('auth:sanctum')->group(function () {

 // ========== CRUD USER ==========

// Ambil semua user
Route::get('/users', fn() => response()->json(User::all()));

// Ambil detail user by id, 404 otomatis kalau tidak ada
Route::get('/users/{id}', fn($id) => response()->json(User::findOrFail($id)));

// Buat user baru dengan validasi dan bcrypt password
Route::post('/users', function (Request $request) {
    $validated = $request->validate([
        'name' => 'required|string|max:255',
        'username' => 'nullable|string|max:255|unique:users,username',
        'email' => 'required|email|unique:users,email',
        'password' => 'required|string|min:6',
        'phone_number' => 'nullable|string|max:20',
        'role' => 'nullable|string|max:50',
        'status' => 'nullable|string|max:50',
    ]);

    $user = User::create([
        'name' => $validated['name'],
        'username' => $validated['username'] ?? null,
        'email' => $validated['email'],
        'password' => bcrypt($validated['password']),
        'phone_number' => $validated['phone_number'] ?? null,
        'role' => $validated['role'] ?? 'user',
        'status' => $validated['status'] ?? 'active',
    ]);

    return response()->json($user, 201);
});

// Update user by id, validasi dan password optional
Route::put('/users/{id}', function (Request $request, $id) {
    $user = User::findOrFail($id);

    $validated = $request->validate([
        'name' => 'sometimes|required|string|max:255',
        'username' => 'sometimes|required|string|max:255|unique:users,username,' . $user->id,
        'email' => 'sometimes|required|email|unique:users,email,' . $user->id,
        'password' => 'nullable|string|min:6',
        'phone_number' => 'nullable|string|max:20',
        'role' => 'nullable|string|max:50',
        'status' => 'nullable|string|max:50',
    ]);

    // Update fields kecuali password
    $user->update($request->only('name', 'username', 'email', 'phone_number', 'role', 'status'));

    // Update password jika diisi
    if ($request->filled('password')) {
        $user->password = bcrypt($request->password);
        $user->save();
    }

    return response()->json($user);
});

// Delete user by id
Route::delete('/users/{id}', function ($id) {
    $user = User::findOrFail($id);
    $user->delete();

    return response()->json(['message' => 'User deleted successfully']);
});

  // ========== CRUD PRODUK ==========

// Ambil semua produk (tanpa soft deleted)
Route::get('/produks', function () {
    return Produk::all();
});

// Ambil produk berdasarkan ID (tanpa soft deleted)
Route::get('/produks/{id}', function ($id) {
    return Produk::findOrFail($id);
});

// Simpan produk baru
Route::post('/produks', function (Request $request) {
    $validated = $request->validate([
        'nama_produk' => 'required|string|max:255',
        'kode_produk' => 'required|string|max:100|unique:produks,kode_produk',
        'kategori' => 'nullable|string|max:255',
        'satuan' => 'nullable|string|max:50',
        'deskripsi' => 'nullable|string',
        'harga_beli' => 'nullable|numeric|min:0',
        'harga_jual' => 'nullable|numeric|min:0',
        'berat' => 'nullable|numeric|min:0',
        'merk' => 'nullable|string|max:100',
        'status' => 'nullable|in:aktif,nonaktif',
    ]);

    $produk = Produk::create($validated);

    return response()->json($produk, 201);
});

// Update produk berdasarkan ID
Route::put('/produks/{id}', function (Request $request, $id) {
    $produk = Produk::findOrFail($id);

    $validated = $request->validate([
        'nama_produk' => 'required|string|max:255',
        'kode_produk' => 'required|string|max:100|unique:produks,kode_produk,' . $produk->id,
        'kategori' => 'nullable|string|max:255',
        'satuan' => 'nullable|string|max:50',
        'deskripsi' => 'nullable|string',
        'harga_beli' => 'nullable|numeric|min:0',
        'harga_jual' => 'nullable|numeric|min:0',
        'berat' => 'nullable|numeric|min:0',
        'merk' => 'nullable|string|max:100',
        'status' => 'nullable|in:aktif,nonaktif',
    ]);

    $produk->update($validated);

    return response()->json($produk);
});

// Soft delete produk berdasarkan ID
Route::delete('/produks/{id}', function ($id) {
    $produk = Produk::findOrFail($id);
    $produk->delete();

    return response()->json(['message' => 'Produk berhasil dihapus']);
});

   // ========== CRUD LOKASI ==========

// Ambil semua lokasi (bisa ditambah filter jika diperlukan)
Route::get('/lokasis', fn() => Lokasi::all());

// Ambil detail lokasi berdasarkan ID
Route::get('/lokasis/{id}', fn($id) => Lokasi::findOrFail($id));

// Tambah lokasi baru
Route::post('/lokasis', function (Request $request) {
    $request->validate([
        'kode_lokasi' => 'required|string|max:50|unique:lokasis',
        'nama_lokasi' => 'required|string|max:100',
        'alamat' => 'nullable|string',
        'telepon' => 'nullable|string|max:20',
        'manager' => 'nullable|string|max:100',
        'status' => 'nullable|in:aktif,nonaktif',
    ]);

    $lokasi = Lokasi::create($request->only([
        'kode_lokasi', 'nama_lokasi', 'alamat', 'telepon', 'manager', 'status'
    ]));

    return response()->json($lokasi, 201);
});

// Update lokasi
Route::put('/lokasis/{id}', function (Request $request, $id) {
    $lokasi = Lokasi::findOrFail($id);

    $request->validate([
        'kode_lokasi' => 'required|string|max:50|unique:lokasis,kode_lokasi,' . $lokasi->id,
        'nama_lokasi' => 'required|string|max:100',
        'alamat' => 'nullable|string',
        'telepon' => 'nullable|string|max:20',
        'manager' => 'nullable|string|max:100',
        'status' => 'nullable|in:aktif,nonaktif',
    ]);

    $lokasi->update($request->only([
        'kode_lokasi', 'nama_lokasi', 'alamat', 'telepon', 'manager', 'status'
    ]));

    return response()->json($lokasi);
});

// Hapus lokasi (soft delete)
Route::delete('/lokasis/{id}', fn($id) => tap(Lokasi::findOrFail($id))->delete());

    // ========== STOK PRODUK PER LOKASI ==========
    Route::post('/produk/{produkId}/lokasi/{lokasiId}/stok', function ($produkId, $lokasiId, Request $request) {
        $request->validate([
            'stok' => 'required|integer|min:0',
        ]);

        $produk = Produk::findOrFail($produkId);
        $produk->lokasis()->syncWithoutDetaching([
            $lokasiId => ['stok' => $request->stok],
        ]);

        return response()->json(['message' => 'Stok diperbarui']);
    });

    Route::get('/produk/{produkId}/stok', function ($produkId) {
        $produk = Produk::with('lokasis')->findOrFail($produkId);

        $data = $produk->lokasis->map(function ($lokasi) {
            return [
                'lokasi_id' => $lokasi->id,
                'nama_lokasi' => $lokasi->nama_lokasi,
                'stok' => $lokasi->pivot->stok,
            ];
        });

        return response()->json($data);
    });

    // ========== MUTASI ==========

    // GET semua mutasi dengan relasi user, produk, lokasi
    Route::get('/mutasis', function () {
        return Mutasi::with(['user', 'produk', 'lokasi'])->get();
    });

    // POST buat mutasi baru
    Route::post('/mutasis', function (Request $request) {
        $request->validate([
            'tanggal' => 'required|date',
            'jenis_mutasi' => 'required|in:masuk,keluar',
            'jumlah' => 'required|integer|min:1',
            'keterangan' => 'nullable|string',
            'produk_id' => 'required|exists:produks,id',
            'lokasi_id' => 'required|exists:lokasis,id',
            'status_mutasi' => 'nullable|in:pending,approved,rejected',
            'reference' => 'nullable|string|max:255',
        ]);

        $user = $request->user();
        $produk = Produk::findOrFail($request->produk_id);
        $lokasiId = $request->lokasi_id;

        // Ambil stok saat ini untuk produk di lokasi tertentu
        $currentStock = $produk->lokasis()->where('lokasi_id', $lokasiId)->first()?->pivot->stok ?? 0;

        if ($request->jenis_mutasi === 'masuk') {
            $newStock = $currentStock + $request->jumlah;
        } else {
            if ($request->jumlah > $currentStock) {
                return response()->json(['message' => 'Stok tidak mencukupi'], 400);
            }
            $newStock = $currentStock - $request->jumlah;
        }

        // Update stok produk di lokasi (pivot table)
        $produk->lokasis()->syncWithoutDetaching([
            $lokasiId => ['stok' => $newStock],
        ]);

        // Simpan data mutasi baru
        $mutasi = Mutasi::create([
            'user_id' => $user->id,
            'produk_id' => $produk->id,
            'lokasi_id' => $lokasiId,
            'tanggal' => $request->tanggal,
            'jenis_mutasi' => $request->jenis_mutasi,
            'jumlah' => $request->jumlah,
            'keterangan' => $request->keterangan,
            'status_mutasi' => $request->status_mutasi ?? 'pending',  // default pending
            'reference' => $request->reference,
        ]);

        return response()->json($mutasi->load(['user', 'produk', 'lokasi']), 201);
    });

    // GET history mutasi berdasarkan produk
    Route::get('/mutasis/produk/{produkId}', function ($produkId) {
        $mutasis = Mutasi::with(['user', 'produk', 'lokasi'])
            ->where('produk_id', $produkId)
            ->orderBy('tanggal', 'desc')
            ->get();

        return response()->json($mutasis);
    });

    // GET history mutasi berdasarkan user
    Route::get('/mutasis/user/{userId}', function ($userId) {
        $mutasis = Mutasi::with(['user', 'produk', 'lokasi'])
            ->where('user_id', $userId)
            ->orderBy('tanggal', 'desc')
            ->get();

        return response()->json($mutasis);
    });

});

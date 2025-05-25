-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 25, 2025 at 05:51 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `idgrow_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lokasis`
--

CREATE TABLE `lokasis` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode_lokasi` varchar(255) NOT NULL,
  `nama_lokasi` varchar(255) NOT NULL,
  `alamat` text DEFAULT NULL,
  `telepon` varchar(255) DEFAULT NULL,
  `manager` varchar(255) DEFAULT NULL,
  `status` enum('aktif','nonaktif') NOT NULL DEFAULT 'aktif',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lokasis`
--

INSERT INTO `lokasis` (`id`, `kode_lokasi`, `nama_lokasi`, `alamat`, `telepon`, `manager`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'L001-REV', 'Gudang Pusat', 'Jl. Baru No. 123', '08123456789', 'Andi Wijaya', 'nonaktif', '2025-05-25 07:09:30', '2025-05-25 08:27:28', '2025-05-25 08:27:28'),
(2, 'L023', 'Gudang cabang', 'manado', '02112345678', 'Budi Santoso', 'aktif', '2025-05-25 08:23:26', '2025-05-25 08:25:43', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_05_24_024809_create_personal_access_tokens_table', 1),
(5, '2025_05_24_031545_create_produks_table', 1),
(6, '2025_05_24_052629_create_lokasis_table', 1),
(7, '2025_05_24_052935_create_produk_lokasis_table', 1),
(8, '2025_05_24_090040_create_mutasis_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `mutasis`
--

CREATE TABLE `mutasis` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tanggal` date NOT NULL,
  `jenis_mutasi` enum('masuk','keluar') NOT NULL,
  `jumlah` int(11) NOT NULL,
  `keterangan` text DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `produk_id` bigint(20) UNSIGNED NOT NULL,
  `lokasi_id` bigint(20) UNSIGNED NOT NULL,
  `status_mutasi` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `reference` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mutasis`
--

INSERT INTO `mutasis` (`id`, `tanggal`, `jenis_mutasi`, `jumlah`, `keterangan`, `user_id`, `produk_id`, `lokasi_id`, `status_mutasi`, `reference`, `created_at`, `updated_at`) VALUES
(1, '2025-05-25', 'masuk', 10, 'Stok masuk gudang', 1, 1, 1, 'approved', 'PO-12345', '2025-05-25 07:10:38', '2025-05-25 07:10:38'),
(2, '2025-05-25', 'masuk', 10, 'Stok masuk gudang', 1, 1, 2, 'approved', 'PO-12345', '2025-05-25 08:30:13', '2025-05-25 08:30:13');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(3, 'App\\Models\\User', 1, 'api-token', '9e47ec156aaf5378681e0cd30c32bc1e990f616c0b4ab2afed949bf6c22e02e0', '[\"*\"]', '2025-05-25 08:39:11', NULL, '2025-05-25 08:01:19', '2025-05-25 08:39:11');

-- --------------------------------------------------------

--
-- Table structure for table `produks`
--

CREATE TABLE `produks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_produk` varchar(255) NOT NULL,
  `kode_produk` varchar(255) NOT NULL,
  `kategori` varchar(255) DEFAULT NULL,
  `satuan` varchar(255) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `harga_beli` decimal(15,2) DEFAULT NULL,
  `harga_jual` decimal(15,2) DEFAULT NULL,
  `berat` decimal(8,3) DEFAULT NULL,
  `merk` varchar(255) DEFAULT NULL,
  `status` enum('aktif','nonaktif') NOT NULL DEFAULT 'aktif',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produks`
--

INSERT INTO `produks` (`id`, `nama_produk`, `kode_produk`, `kategori`, `satuan`, `deskripsi`, `harga_beli`, `harga_jual`, `berat`, `merk`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Contoh Produk', 'PRD001', 'Elektronik', 'pcs', 'Produk contoh untuk testing', 100000.00, 120000.00, 0.500, 'BrandX', 'aktif', '2025-05-25 07:08:51', '2025-05-25 07:08:51', NULL),
(2, 'Laptop', 'PRD0043', 'Elektronik', 'pcs', 'Produk contoh untuk testing', 100000.00, 120000.00, 0.500, 'BrandX', 'aktif', '2025-05-25 08:09:28', '2025-05-25 08:17:41', '2025-05-25 08:17:41');

-- --------------------------------------------------------

--
-- Table structure for table `produk_lokasi`
--

CREATE TABLE `produk_lokasi` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `produk_id` bigint(20) UNSIGNED NOT NULL,
  `lokasi_id` bigint(20) UNSIGNED NOT NULL,
  `stok` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produk_lokasi`
--

INSERT INTO `produk_lokasi` (`id`, `produk_id`, `lokasi_id`, `stok`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 100, '2025-05-25 07:10:38', '2025-05-25 07:28:43'),
(2, 1, 2, 100, '2025-05-25 08:30:13', '2025-05-25 08:34:11');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `role` enum('admin','user','manager') NOT NULL DEFAULT 'user',
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `email`, `email_verified_at`, `password`, `phone_number`, `role`, `status`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Admin User', 'adminuser', 'admin@example.com', NULL, '$2y$12$UW7GOEYdsLtef3hX5yECfeFxf/ZXPFNn0rnIhWsxh/jMcBLwj35FO', '081234567890', 'admin', 'active', NULL, '2025-05-25 07:05:17', '2025-05-25 07:05:17', NULL),
(2, 'Test User', 'testuser', 'testuser@example.com', NULL, '$2y$12$f3MIBatPZObseGhb1bSZGuTHNiqkWAUbrXZGCpqfdI8T9X0JxTDFy', '08123456789', 'user', 'active', NULL, '2025-05-25 07:08:11', '2025-05-25 07:08:11', NULL),
(3, 'User Baru', 'userbaru', 'userbaru@example.com', NULL, '$2y$12$7CdrgGg95NhBtej.6rhFCOgNZtLonDE6aUHgbO1ttxd5KaMCWYgtW', '081234567891', 'user', 'active', NULL, '2025-05-25 08:04:53', '2025-05-25 08:04:53', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lokasis`
--
ALTER TABLE `lokasis`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `lokasis_kode_lokasi_unique` (`kode_lokasi`),
  ADD KEY `lokasis_status_index` (`status`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mutasis`
--
ALTER TABLE `mutasis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mutasis_user_id_foreign` (`user_id`),
  ADD KEY `mutasis_produk_id_foreign` (`produk_id`),
  ADD KEY `mutasis_lokasi_id_foreign` (`lokasi_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `produks`
--
ALTER TABLE `produks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `produks_kode_produk_unique` (`kode_produk`),
  ADD KEY `produks_status_index` (`status`);

--
-- Indexes for table `produk_lokasi`
--
ALTER TABLE `produk_lokasi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `produk_lokasi_produk_id_lokasi_id_unique` (`produk_id`,`lokasi_id`),
  ADD KEY `produk_lokasi_lokasi_id_foreign` (`lokasi_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lokasis`
--
ALTER TABLE `lokasis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `mutasis`
--
ALTER TABLE `mutasis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `produks`
--
ALTER TABLE `produks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `produk_lokasi`
--
ALTER TABLE `produk_lokasi`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `mutasis`
--
ALTER TABLE `mutasis`
  ADD CONSTRAINT `mutasis_lokasi_id_foreign` FOREIGN KEY (`lokasi_id`) REFERENCES `lokasis` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mutasis_produk_id_foreign` FOREIGN KEY (`produk_id`) REFERENCES `produks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mutasis_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `produk_lokasi`
--
ALTER TABLE `produk_lokasi`
  ADD CONSTRAINT `produk_lokasi_lokasi_id_foreign` FOREIGN KEY (`lokasi_id`) REFERENCES `lokasis` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `produk_lokasi_produk_id_foreign` FOREIGN KEY (`produk_id`) REFERENCES `produks` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

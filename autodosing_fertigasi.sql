-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 22 Nov 2026 pada 13.53
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `autodosing_fertigasi`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `operator`
--

CREATE TABLE `operator` (
  `id_operator` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `operator`
--

INSERT INTO `operator` (`id_operator`, `nama`) VALUES
(1, 'Alvin');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengukuran`
--

CREATE TABLE `pengukuran` (
  `id_pengukuran` int(11) NOT NULL,
  `id_sensor` varchar(10) NOT NULL,
  `nilai` decimal(8,2) NOT NULL,
  `waktu` datetime DEFAULT current_timestamp(),
  `nilai_min` decimal(8,2) DEFAULT NULL,
  `nilai_max` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pengukuran`
--

INSERT INTO `pengukuran` (`id_pengukuran`, `id_sensor`, `nilai`, `waktu`, `nilai_min`, `nilai_max`) VALUES
(1, 'S1', 6.25, '2026-11-17 21:38:19', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pompa`
--

CREATE TABLE `pompa` (
  `id_pompa` int(11) NOT NULL,
  `nama_pompa` varchar(100) NOT NULL,
  `status_pompa` enum('ON','OFF') NOT NULL DEFAULT 'OFF',
  `waktu` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pompa`
--

INSERT INTO `pompa` (`id_pompa`, `nama_pompa`, `status_pompa`, `waktu`) VALUES
(1, 'Pompa Pengaduk', 'OFF', '2026-11-17 12:01:08'),
(2, 'Pompa Nutrisi', 'OFF', '2026-11-17 12:01:08'),
(3, 'Pompa pH Down', 'OFF', '2026-11-17 12:01:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sensor`
--

CREATE TABLE `sensor` (
  `id_sensor` varchar(10) NOT NULL,
  `id_pompa` int(11) NOT NULL,
  `nama_sensor` varchar(100) NOT NULL,
  `tipe_sensor` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `sensor`
--

INSERT INTO `sensor` (`id_sensor`, `id_pompa`, `nama_sensor`, `tipe_sensor`) VALUES
('S1', 1, 'Sensor pH', 'pH'),
('S2', 1, 'Sensor TDS', 'TDS'),
('S3', 1, 'Sensor Suhu', 'Suhu'),
('S4', 1, 'Flow Meter', 'Flow');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sensor_operator`
--

CREATE TABLE `sensor_operator` (
  `id_sensor` varchar(10) NOT NULL,
  `id_operator` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `setpoint`
--

CREATE TABLE `setpoint` (
  `id_setpoint` int(11) NOT NULL,
  `id_operator` int(11) NOT NULL,
  `parameter` enum('pH','TDS') NOT NULL,
  `nilai` decimal(8,2) NOT NULL,
  `waktu_perubahan` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `setpoint`
--

INSERT INTO `setpoint` (`id_setpoint`, `id_operator`, `parameter`, `nilai`, `waktu_perubahan`) VALUES
(1, 1, 'pH', 6.00, '2026-11-17 12:06:43'),
(2, 1, 'TDS', 800.00, '2026-11-17 12:06:43');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `operator`
--
ALTER TABLE `operator`
  ADD PRIMARY KEY (`id_operator`);

--
-- Indeks untuk tabel `pengukuran`
--
ALTER TABLE `pengukuran`
  ADD PRIMARY KEY (`id_pengukuran`),
  ADD KEY `fk_pengukuran_sensor` (`id_sensor`);

--
-- Indeks untuk tabel `pompa`
--
ALTER TABLE `pompa`
  ADD PRIMARY KEY (`id_pompa`);

--
-- Indeks untuk tabel `sensor`
--
ALTER TABLE `sensor`
  ADD PRIMARY KEY (`id_sensor`),
  ADD KEY `fk_sensor_pompa` (`id_pompa`);

--
-- Indeks untuk tabel `sensor_operator`
--
ALTER TABLE `sensor_operator`
  ADD PRIMARY KEY (`id_sensor`,`id_operator`),
  ADD KEY `fk_so_operator` (`id_operator`);

--
-- Indeks untuk tabel `setpoint`
--
ALTER TABLE `setpoint`
  ADD PRIMARY KEY (`id_setpoint`),
  ADD KEY `fk_setpoint_operator` (`id_operator`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `operator`
--
ALTER TABLE `operator`
  MODIFY `id_operator` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `pengukuran`
--
ALTER TABLE `pengukuran`
  MODIFY `id_pengukuran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `pompa`
--
ALTER TABLE `pompa`
  MODIFY `id_pompa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `setpoint`
--
ALTER TABLE `setpoint`
  MODIFY `id_setpoint` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `pengukuran`
--
ALTER TABLE `pengukuran`
  ADD CONSTRAINT `fk_pengukuran_sensor` FOREIGN KEY (`id_sensor`) REFERENCES `sensor` (`id_sensor`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `sensor`
--
ALTER TABLE `sensor`
  ADD CONSTRAINT `fk_sensor_pompa` FOREIGN KEY (`id_pompa`) REFERENCES `pompa` (`id_pompa`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `sensor_operator`
--
ALTER TABLE `sensor_operator`
  ADD CONSTRAINT `fk_so_operator` FOREIGN KEY (`id_operator`) REFERENCES `operator` (`id_operator`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_so_sensor` FOREIGN KEY (`id_sensor`) REFERENCES `sensor` (`id_sensor`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `setpoint`
--
ALTER TABLE `setpoint`
  ADD CONSTRAINT `fk_setpoint_operator` FOREIGN KEY (`id_operator`) REFERENCES `operator` (`id_operator`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

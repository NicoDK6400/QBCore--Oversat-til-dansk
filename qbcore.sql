-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Vært: 127.0.0.1
-- Genereringstid: 07. 12 2021 kl. 20:51:22
-- Serverversion: 10.4.14-MariaDB
-- PHP-version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `qbcore`
--

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `apartments`
--

CREATE TABLE `apartments` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `citizenid` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `bank_accounts`
--

CREATE TABLE `bank_accounts` (
  `record_id` bigint(255) NOT NULL,
  `citizenid` varchar(250) DEFAULT NULL,
  `buisness` varchar(50) DEFAULT NULL,
  `buisnessid` int(11) DEFAULT NULL,
  `gangid` varchar(50) DEFAULT NULL,
  `amount` bigint(255) NOT NULL DEFAULT 0,
  `account_type` enum('Current','Savings','Buisness','Gang') NOT NULL DEFAULT 'Current'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `bank_statements`
--

CREATE TABLE `bank_statements` (
  `record_id` bigint(255) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `account` varchar(50) DEFAULT NULL,
  `buisness` varchar(50) DEFAULT NULL,
  `buisnessid` int(11) DEFAULT NULL,
  `gangid` varchar(50) DEFAULT NULL,
  `deposited` int(11) DEFAULT NULL,
  `withdraw` int(11) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `bans`
--

CREATE TABLE `bans` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `expire` int(11) DEFAULT NULL,
  `bannedby` varchar(255) NOT NULL DEFAULT 'LeBanhammer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `crypto`
--

CREATE TABLE `crypto` (
  `crypto` varchar(50) NOT NULL DEFAULT 'qbit',
  `worth` int(11) NOT NULL DEFAULT 0,
  `history` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `crypto_transactions`
--

CREATE TABLE `crypto_transactions` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `message` varchar(50) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `dealers`
--

CREATE TABLE `dealers` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `coords` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `time` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `createdby` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `fine_types`
--

CREATE TABLE `fine_types` (
  `id` int(11) NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  `jailtime` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `gloveboxitems`
--

CREATE TABLE `gloveboxitems` (
  `id` int(11) NOT NULL,
  `plate` varchar(255) NOT NULL DEFAULT '[]',
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `houselocations`
--

CREATE TABLE `houselocations` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `owned` tinyint(1) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `tier` tinyint(1) DEFAULT NULL,
  `garage` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `house_plants`
--

CREATE TABLE `house_plants` (
  `id` int(11) NOT NULL,
  `building` varchar(50) DEFAULT NULL,
  `stage` varchar(50) DEFAULT 'stage-a',
  `sort` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `food` int(11) DEFAULT 100,
  `health` int(11) DEFAULT 100,
  `progress` int(11) DEFAULT 0,
  `coords` text DEFAULT NULL,
  `plantid` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `lapraces`
--

CREATE TABLE `lapraces` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `checkpoints` text DEFAULT NULL,
  `records` text DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `distance` int(11) DEFAULT NULL,
  `raceid` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `mdt_reports`
--

CREATE TABLE `mdt_reports` (
  `id` int(11) NOT NULL,
  `char_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `incident` longtext DEFAULT NULL,
  `charges` longtext DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `mdt_warrants`
--

CREATE TABLE `mdt_warrants` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `char_id` int(11) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL,
  `report_title` varchar(255) DEFAULT NULL,
  `charges` longtext DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `expire` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `occasion_vehicles`
--

CREATE TABLE `occasion_vehicles` (
  `id` int(11) NOT NULL,
  `seller` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `mods` text DEFAULT NULL,
  `occasionid` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `license` varchar(255) NOT NULL,
  `permission` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `phone_gallery`
--

CREATE TABLE `phone_gallery` (
  `citizenid` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `date` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `phone_invoices`
--

CREATE TABLE `phone_invoices` (
  `id` int(10) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `society` tinytext DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `sendercitizenid` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `phone_messages`
--

CREATE TABLE `phone_messages` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `messages` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `phone_tweets`
--

CREATE TABLE `phone_tweets` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) NOT NULL,
  `cid` int(11) DEFAULT NULL,
  `license` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `money` text NOT NULL,
  `charinfo` text DEFAULT NULL,
  `job` text NOT NULL,
  `gang` text DEFAULT NULL,
  `position` text NOT NULL,
  `metadata` text NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `playerskins`
--

CREATE TABLE `playerskins` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `tattoos` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `player_boats`
--

CREATE TABLE `player_boats` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `boathouse` varchar(50) DEFAULT NULL,
  `fuel` int(11) NOT NULL DEFAULT 100,
  `state` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `player_contacts`
--

CREATE TABLE `player_contacts` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `iban` varchar(50) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `player_houses`
--

CREATE TABLE `player_houses` (
  `id` int(255) NOT NULL,
  `house` varchar(50) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `keyholders` text DEFAULT NULL,
  `decorations` text DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `player_mails`
--

CREATE TABLE `player_mails` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `read` tinyint(1) DEFAULT 0,
  `mailid` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `button` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `player_outfits`
--

CREATE TABLE `player_outfits` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `outfitname` varchar(50) NOT NULL,
  `model` varchar(50) DEFAULT NULL,
  `skin` text DEFAULT NULL,
  `outfitId` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `player_vehicles`
--

CREATE TABLE `player_vehicles` (
  `id` int(11) NOT NULL,
  `license` varchar(50) DEFAULT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `vehicle` varchar(50) DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `mods` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `plate` varchar(50) NOT NULL,
  `fakeplate` varchar(50) DEFAULT NULL,
  `garage` varchar(50) DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `engine` float DEFAULT 1000,
  `body` float DEFAULT 1000,
  `state` int(11) DEFAULT 1,
  `depotprice` int(11) NOT NULL DEFAULT 0,
  `drivingdistance` int(50) DEFAULT NULL,
  `status` text DEFAULT NULL,
  `balance` int(11) NOT NULL DEFAULT 0,
  `paymentamount` int(11) NOT NULL DEFAULT 0,
  `paymentsleft` int(11) NOT NULL DEFAULT 0,
  `financetime` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `player_warns`
--

CREATE TABLE `player_warns` (
  `id` int(11) NOT NULL,
  `senderIdentifier` varchar(50) DEFAULT NULL,
  `targetIdentifier` varchar(50) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `warnId` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `stashitems`
--

CREATE TABLE `stashitems` (
  `id` int(11) NOT NULL,
  `stash` varchar(255) NOT NULL DEFAULT '[]',
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `trunkitems`
--

CREATE TABLE `trunkitems` (
  `id` int(11) NOT NULL,
  `plate` varchar(255) NOT NULL DEFAULT '[]',
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `user_convictions`
--

CREATE TABLE `user_convictions` (
  `id` int(11) NOT NULL,
  `char_id` int(11) DEFAULT NULL,
  `offense` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `user_mdt`
--

CREATE TABLE `user_mdt` (
  `id` int(11) NOT NULL,
  `char_id` int(11) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `mugshot_url` varchar(255) DEFAULT NULL,
  `bail` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur-dump for tabellen `vehicle_mdt`
--

CREATE TABLE `vehicle_mdt` (
  `id` int(11) NOT NULL,
  `plate` varchar(255) DEFAULT NULL,
  `stolen` bit(1) DEFAULT b'0',
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Begrænsninger for dumpede tabeller
--

--
-- Indeks for tabel `apartments`
--
ALTER TABLE `apartments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`),
  ADD KEY `name` (`name`);

--
-- Indeks for tabel `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD PRIMARY KEY (`record_id`),
  ADD UNIQUE KEY `citizenid` (`citizenid`),
  ADD KEY `buisness` (`buisness`),
  ADD KEY `buisnessid` (`buisnessid`),
  ADD KEY `gangid` (`gangid`);

--
-- Indeks for tabel `bank_statements`
--
ALTER TABLE `bank_statements`
  ADD PRIMARY KEY (`record_id`),
  ADD KEY `buisness` (`buisness`),
  ADD KEY `buisnessid` (`buisnessid`),
  ADD KEY `gangid` (`gangid`);

--
-- Indeks for tabel `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `license` (`license`),
  ADD KEY `discord` (`discord`),
  ADD KEY `ip` (`ip`);

--
-- Indeks for tabel `crypto`
--
ALTER TABLE `crypto`
  ADD PRIMARY KEY (`crypto`);

--
-- Indeks for tabel `crypto_transactions`
--
ALTER TABLE `crypto_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`);

--
-- Indeks for tabel `dealers`
--
ALTER TABLE `dealers`
  ADD PRIMARY KEY (`id`);

--
-- Indeks for tabel `fine_types`
--
ALTER TABLE `fine_types`
  ADD PRIMARY KEY (`id`);

--
-- Indeks for tabel `gloveboxitems`
--
ALTER TABLE `gloveboxitems`
  ADD PRIMARY KEY (`plate`),
  ADD KEY `id` (`id`);

--
-- Indeks for tabel `houselocations`
--
ALTER TABLE `houselocations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Indeks for tabel `house_plants`
--
ALTER TABLE `house_plants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `building` (`building`),
  ADD KEY `plantid` (`plantid`);

--
-- Indeks for tabel `lapraces`
--
ALTER TABLE `lapraces`
  ADD PRIMARY KEY (`id`),
  ADD KEY `raceid` (`raceid`);

--
-- Indeks for tabel `mdt_reports`
--
ALTER TABLE `mdt_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indeks for tabel `mdt_warrants`
--
ALTER TABLE `mdt_warrants`
  ADD PRIMARY KEY (`id`);

--
-- Indeks for tabel `occasion_vehicles`
--
ALTER TABLE `occasion_vehicles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `occasionId` (`occasionid`);

--
-- Indeks for tabel `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `license` (`license`);

--
-- Indeks for tabel `phone_invoices`
--
ALTER TABLE `phone_invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`);

--
-- Indeks for tabel `phone_messages`
--
ALTER TABLE `phone_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`),
  ADD KEY `number` (`number`);

--
-- Indeks for tabel `phone_tweets`
--
ALTER TABLE `phone_tweets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`);

--
-- Indeks for tabel `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`citizenid`),
  ADD KEY `id` (`id`),
  ADD KEY `last_updated` (`last_updated`),
  ADD KEY `license` (`license`),
  ADD KEY `license_2` (`license`);

--
-- Indeks for tabel `playerskins`
--
ALTER TABLE `playerskins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`),
  ADD KEY `active` (`active`);

--
-- Indeks for tabel `player_boats`
--
ALTER TABLE `player_boats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`);

--
-- Indeks for tabel `player_contacts`
--
ALTER TABLE `player_contacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`);

--
-- Indeks for tabel `player_houses`
--
ALTER TABLE `player_houses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `house` (`house`),
  ADD KEY `citizenid` (`citizenid`),
  ADD KEY `identifier` (`identifier`);

--
-- Indeks for tabel `player_mails`
--
ALTER TABLE `player_mails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`);

--
-- Indeks for tabel `player_outfits`
--
ALTER TABLE `player_outfits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`),
  ADD KEY `outfitId` (`outfitId`);

--
-- Indeks for tabel `player_vehicles`
--
ALTER TABLE `player_vehicles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plate` (`plate`),
  ADD KEY `citizenid` (`citizenid`),
  ADD KEY `license` (`license`);

--
-- Indeks for tabel `player_warns`
--
ALTER TABLE `player_warns`
  ADD PRIMARY KEY (`id`);

--
-- Indeks for tabel `stashitems`
--
ALTER TABLE `stashitems`
  ADD PRIMARY KEY (`stash`),
  ADD KEY `id` (`id`);

--
-- Indeks for tabel `trunkitems`
--
ALTER TABLE `trunkitems`
  ADD PRIMARY KEY (`plate`),
  ADD KEY `id` (`id`);

--
-- Indeks for tabel `user_convictions`
--
ALTER TABLE `user_convictions`
  ADD PRIMARY KEY (`id`);

--
-- Indeks for tabel `user_mdt`
--
ALTER TABLE `user_mdt`
  ADD PRIMARY KEY (`id`);

--
-- Indeks for tabel `vehicle_mdt`
--
ALTER TABLE `vehicle_mdt`
  ADD PRIMARY KEY (`id`);

--
-- Brug ikke AUTO_INCREMENT for slettede tabeller
--

--
-- Tilføj AUTO_INCREMENT i tabel `apartments`
--
ALTER TABLE `apartments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `bank_accounts`
--
ALTER TABLE `bank_accounts`
  MODIFY `record_id` bigint(255) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `bank_statements`
--
ALTER TABLE `bank_statements`
  MODIFY `record_id` bigint(255) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `bans`
--
ALTER TABLE `bans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `crypto_transactions`
--
ALTER TABLE `crypto_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `dealers`
--
ALTER TABLE `dealers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `fine_types`
--
ALTER TABLE `fine_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `gloveboxitems`
--
ALTER TABLE `gloveboxitems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `houselocations`
--
ALTER TABLE `houselocations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `house_plants`
--
ALTER TABLE `house_plants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `lapraces`
--
ALTER TABLE `lapraces`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `mdt_reports`
--
ALTER TABLE `mdt_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `mdt_warrants`
--
ALTER TABLE `mdt_warrants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `occasion_vehicles`
--
ALTER TABLE `occasion_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `phone_invoices`
--
ALTER TABLE `phone_invoices`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `phone_messages`
--
ALTER TABLE `phone_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `phone_tweets`
--
ALTER TABLE `phone_tweets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `playerskins`
--
ALTER TABLE `playerskins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `player_boats`
--
ALTER TABLE `player_boats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `player_contacts`
--
ALTER TABLE `player_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `player_houses`
--
ALTER TABLE `player_houses`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `player_mails`
--
ALTER TABLE `player_mails`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `player_outfits`
--
ALTER TABLE `player_outfits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `player_vehicles`
--
ALTER TABLE `player_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `player_warns`
--
ALTER TABLE `player_warns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `stashitems`
--
ALTER TABLE `stashitems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `trunkitems`
--
ALTER TABLE `trunkitems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `user_convictions`
--
ALTER TABLE `user_convictions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `user_mdt`
--
ALTER TABLE `user_mdt`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tilføj AUTO_INCREMENT i tabel `vehicle_mdt`
--
ALTER TABLE `vehicle_mdt`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

INSERT INTO `fine_types` (`id`, `label`, `amount`, `category`, `jailtime`) VALUES
(1, 'Mord', 25000, 0, 0),
(2, 'Ufrivilligt manddrab', 10000, 0, 120),
(3, 'Køretøjsmanddrab', 7500, 0, 100),
(4, 'Drabsforsøg på LEO', 1500, 0, 60),
(5, 'Drabsforsøg', 1000, 0, 50),
(6, 'Overfald med dødbringende våben på LEO', 700, 0, 45),
(7, 'Overfald med dødbringende våben', 350, 0, 30),
(8, 'Angreb på LEO', 150, 0, 15),
(9, 'Angreb', 100, 0, 10),
(10, 'Kidnapning af en LEO', 400, 0, 40),
(11, 'Kidnapning / gidseltagning', 200, 0, 20),
(12, 'Bankrøveri', 800, 0, 50),
(13, 'Pengetransports røveri', 650, 0, 40),
(14, 'Smykkeforretnings røveri', 500, 0, 30),
(15, 'Butiksrøveri', 150, 0, 15),
(16, 'Husrøveri', 100, 0, 10),
(17, 'Korruption', 10000, 0, 650),
(18, 'Forbrydelse kørsel under indflydelse', 300, 0, 30),
(19, 'Biltyveri med flugt', 300, 0, 20),
(20, 'Adlyder ikke politiets anvisninger', 200, 0, 20),
(21, 'Spiritus kørsel', 150, 0, 15),
(22, 'Flugt pga. uheld', 150, 0, 15),
(23, 'Betjening af et motorkøretøj uden føreret', 100, 0, 10),
(24, 'Kriminel hastighedsoverskridelse', 300, 0, 10),
(25, 'Overdreven hastighed 4', 250, 0, 0),
(26, 'Overdreven hastighed 3', 200, 0, 0),
(27, 'Overdreven hastighed 2', 150, 0, 0),
(28, 'Overdreven hastighed', 100, 0, 0),
(29, 'Operating an Unregisted Motor Vehicle', 100, 0, 5),
(30, 'Hensynsløs trussel', 150, 0, 5),
(31, 'Skødesløs kørsel', 100, 0, 0),
(32, 'Betjening af et ikke gade lovligt køretøj', 200, 0, 5),
(33, 'Undladelse af at stoppe', 100, 0, 0),
(34, 'Blokering af trafik', 150, 0, 0),
(35, 'Ulovligt vognbaneskift', 100, 0, 0),
(36, 'Undladelse af at give efter for et udrykningskøretøj', 150, 0, 0),
(37, 'Ulovlig parkering', 100, 0, 0),
(38, 'Overdreven køretøjsstøj', 100, 0, 0),
(39, 'Kørsel uden korrekt brug af forlygter', 100, 0, 0),
(40, 'Ulovlig U-vending', 100, 0, 0),
(41, 'Lægemiddelfremstilling/-dyrkning', 550, 0, 40),
(42, 'Besiddelse af skema 1-stof', 150, 0, 15),
(43, 'Besiddelse af skema 2-stof', 250, 0, 20),
(44, 'Salg/Distribution af skema 1 Drug', 250, 0, 20),
(45, 'Salg/distribution af skema 2 lægemiddel', 400, 0, 30),
(46, 'Narkotikahandel', 500, 0, 40),
(47, 'Våbenlagring af klasse 2', 2500, 0, 120),
(48, 'Våbenlagring af klasse 1', 1250, 0, 60),
(49, 'Våbenhandel af klasse 2', 1700, 0, 80),
(50, 'Våbenhandel af klasse 1', 800, 0, 45),
(51, 'Besiddelse af et klasse 2 skydevåben', 800, 0, 40),
(52, 'Besiddelse af et klasse 1 skydevåben', 150, 0, 15),
(53, 'Brandishing a Firearm', 100, 0, 5),
(54, 'Ulovlig afgivelse af et skydevåben', 150, 0, 10),
(55, 'Mened', 1000, 0, 60),
(56, 'Brandstiftelse', 500, 0, 30),
(57, 'Falsk efterligning af en embedsmand', 200, 0, 25),
(58, 'Besiddelse af beskidte penge', 200, 0, 25),
(59, 'Besiddelse af stjålne varer', 100, 0, 15),
(60, 'Unlawful Solicitation', 150, 0, 20),
(61, 'Larceny', 150, 0, 20),
(62, 'Forbrydelsesforsøg på en lovovertrædelse/forbrydelse', 350, 0, 20),
(63, 'Tampering With Evidence', 200, 0, 20),
(64, 'Ulovlig gambling', 200, 0, 20),
(65, 'Bestikkelse', 200, 0, 20),
(66, 'Stalking', 350, 0, 20),
(67, 'Organisering af en ulovlig begivenhed', 150, 0, 15),
(68, 'Deltagelse i en ulovlig begivenhed', 50, 0, 5),
(69, 'Criminal Mischief', 100, 0, 15),
(70, 'Prostitution', 250, 0, 15),
(71, 'Manglende identifikation', 150, 0, 15),
(72, 'Obstruktion af retfærdighed', 150, 0, 15),
(73, 'Modstand mod anholdelse', 100, 0, 10),
(74, 'At forstyrre freden', 100, 0, 10),
(75, 'Trussel om at gøre kropslig skade', 100, 0, 10),
(76, 'Terroristisk trussel', 150, 0, 10),
(77, 'Skader på statsejendomme', 150, 0, 10),
(78, 'Foragt for retten', 250, 0, 10),
(79, 'Manglende overholdelse af en lovlig ordre', 150, 0, 10),
(80, 'Falsk rapport', 100, 0, 10),
(81, 'Tredspassing', 100, 0, 10),
(82, 'Loitering', 100, 0, 0),
(83, 'Offentlig beruselse', 100, 0, 0),
(84, 'Uanstændig eksponering', 100, 0, 0),
(85, 'Verbal chikane', 100, 0, 0),
(86, 'Hjælp og væddemål', 100, 0, 0),
(87, 'Hændelsesrapport', 0, 0, 0),
(88, 'Skriftlig henvisning', 0, 0, 0),
(89, 'Verbal advarsel', 0, 0, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

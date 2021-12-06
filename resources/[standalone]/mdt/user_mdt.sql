CREATE TABLE `user_mdt` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`char_id` int(11) DEFAULT NULL,
	`notes` varchar(255) DEFAULT NULL,
	`mugshot_url` varchar(255) DEFAULT NULL,
	`bail` bit DEFAULT NULL,

	PRIMARY KEY (`id`)
);

CREATE TABLE `vehicle_mdt` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`plate` varchar(255) DEFAULT NULL,
	`stolen` bit DEFAULT 0,
	`notes` varchar(255) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

CREATE TABLE `user_convictions` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`char_id` int(11) DEFAULT NULL,
	`offense` varchar(255) DEFAULT NULL,
	`count` int(11) DEFAULT NULL,
	
	PRIMARY KEY (`id`)
);

CREATE TABLE `mdt_reports` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`char_id` int(11) DEFAULT NULL,
	`title` varchar(255) DEFAULT NULL,
	`incident` longtext DEFAULT NULL,
    `charges` longtext DEFAULT NULL,
    `author` varchar(255) DEFAULT NULL,
	`name` varchar(255) DEFAULT NULL,
    `date` varchar(255) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

CREATE TABLE `mdt_warrants` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(255) DEFAULT NULL,
	`char_id` int(11) DEFAULT NULL,
	`report_id` int(11) DEFAULT NULL,
	`report_title` varchar(255) DEFAULT NULL,
	`charges` longtext DEFAULT NULL,
	`date` varchar(255) DEFAULT NULL,
	`expire` varchar(255) DEFAULT NULL,
	`notes` varchar(255) DEFAULT NULL,
	`author` varchar(255) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  `jailtime` int(11) DEFAULT NULL,
	
       PRIMARY KEY (`id`)
);

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
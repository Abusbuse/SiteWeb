-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 18 jan. 2023 à 19:58
-- Version du serveur : 5.7.31
-- Version de PHP : 8.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `bdsae`
--

-- --------------------------------------------------------

--
-- Structure de la table `adherent`
--

DROP TABLE IF EXISTS `adherent`;
CREATE TABLE IF NOT EXISTS `adherent` (
  `derniereVisite` date DEFAULT NULL,
  `niveauPratique` varchar(45) DEFAULT NULL,
  `photo` mediumblob,
  `Personne_idPersonne` int(11) NOT NULL,
  PRIMARY KEY (`Personne_idPersonne`),
  KEY `fk_Adherent_Personne1_idx` (`Personne_idPersonne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `adherent`
--

INSERT INTO `adherent` (`derniereVisite`, `niveauPratique`, `photo`, `Personne_idPersonne`) VALUES
(NULL, NULL, NULL, 1),
(NULL, NULL, NULL, 2),
(NULL, NULL, NULL, 3),
(NULL, NULL, NULL, 4),
(NULL, NULL, NULL, 5),
(NULL, NULL, NULL, 6),
(NULL, NULL, NULL, 7),
(NULL, NULL, NULL, 8),
(NULL, NULL, NULL, 9),
(NULL, NULL, NULL, 10),
(NULL, NULL, NULL, 11),
(NULL, NULL, NULL, 12),
(NULL, NULL, NULL, 13),
(NULL, NULL, NULL, 14),
(NULL, NULL, NULL, 15),
(NULL, NULL, NULL, 16),
(NULL, NULL, NULL, 17),
(NULL, NULL, NULL, 18),
(NULL, NULL, NULL, 19),
(NULL, NULL, NULL, 20),
(NULL, NULL, NULL, 21),
(NULL, NULL, NULL, 22),
(NULL, NULL, NULL, 23),
(NULL, NULL, NULL, 24),
(NULL, NULL, NULL, 25),
(NULL, NULL, NULL, 26),
(NULL, NULL, NULL, 27),
(NULL, NULL, NULL, 28),
(NULL, NULL, NULL, 29),
(NULL, NULL, NULL, 30),
(NULL, NULL, NULL, 31),
(NULL, NULL, NULL, 32),
(NULL, NULL, NULL, 33),
(NULL, NULL, NULL, 34),
(NULL, NULL, NULL, 35),
(NULL, NULL, NULL, 36),
(NULL, NULL, NULL, 37),
(NULL, NULL, NULL, 38),
(NULL, NULL, NULL, 39),
(NULL, NULL, NULL, 40),
(NULL, NULL, NULL, 41),
(NULL, NULL, NULL, 42),
(NULL, NULL, NULL, 43),
(NULL, NULL, NULL, 44),
(NULL, NULL, NULL, 45),
(NULL, NULL, NULL, 46),
(NULL, NULL, NULL, 47),
(NULL, NULL, NULL, 48),
(NULL, NULL, NULL, 49),
(NULL, NULL, NULL, 50),
('2023-01-18', 'Intermédiaire', NULL, 51),
('2023-01-18', 'Confirmé', NULL, 52),
(NULL, NULL, NULL, 53),
(NULL, NULL, NULL, 54),
('2023-01-18', NULL, NULL, 68);

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `Personne_idPersonne` int(11) NOT NULL,
  PRIMARY KEY (`Personne_idPersonne`),
  KEY `fk_Admin_Personne1_idx` (`Personne_idPersonne`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `admin`
--

INSERT INTO `admin` (`Personne_idPersonne`) VALUES
(51);

-- --------------------------------------------------------

--
-- Structure de la table `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `idArticle` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(300) NOT NULL,
  `contenu` longtext NOT NULL,
  `dateCreation` date NOT NULL,
  `dateMAJ` date DEFAULT NULL,
  `Admin_Personne_idPersonne` int(11) NOT NULL,
  PRIMARY KEY (`idArticle`),
  KEY `fk_Article_Admin1_idx` (`Admin_Personne_idPersonne`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `article`
--

INSERT INTO `article` (`idArticle`, `titre`, `contenu`, `dateCreation`, `dateMAJ`, `Admin_Personne_idPersonne`) VALUES
(1, 'Bonjour, voici les résultats pour le match du 23 Septembre', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Semper auctor neque vitae tempus quam pellentesque nec. Consectetur purus ut faucibus pulvinar. Faucibus purus in massa tempor. Sit amet consectetur adipiscing elit duis tristique sollicitudin nibh. Purus non enim praesent elementum facilisis leo. Mattis aliquam faucibus purus in massa tempor nec feugiat nisl. A lacus vestibulum sed arcu non odio. Leo integer malesuada nunc vel risus commodo. Massa tincidunt dui ut ornare lectus sit amet est. Neque aliquam vestibulum morbi blandit cursus risus at ultrices. Cras ornare arcu dui vivamus arcu felis bibendum.\r\n\r\nPellentesque nec nam aliquam sem et. Arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque. Amet justo donec enim diam vulputate ut pharetra sit. Convallis tellus id interdum velit laoreet id. Mattis nunc sed blandit libero volutpat. Pharetra vel turpis nunc eget lorem dolor. Eget magna fermentum iaculis eu non diam phasellus vestibulum. Pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum. Nulla posuere sollicitudin aliquam ultrices. Maecenas pharetra convallis posuere morbi leo urna. Commodo sed egestas egestas fringilla phasellus faucibus scelerisque. Neque convallis a cras semper auctor. Nulla at volutpat diam ut venenatis tellus. Dignissim enim sit amet venenatis urna cursus eget nunc scelerisque. Lorem sed risus ultricies tristique. Tortor at risus viverra adipiscing at in. Ultrices eros in cursus turpis massa tincidunt. Dignissim cras tincidunt lobortis feugiat vivamus at augue eget arcu.\r\n\r\nAmet volutpat consequat mauris nunc congue nisi vitae suscipit. Ullamcorper malesuada proin libero nunc consequat interdum varius sit. Viverra suspendisse potenti nullam ac tortor vitae. Pharetra convallis posuere morbi leo. Montes nascetur ridiculus mus mauris vitae ultricies leo. Phasellus vestibulum lorem sed risus ultricies tristique. Ut lectus arcu bibendum at varius. Tempus egestas sed sed risus. Suscipit tellus mauris a diam maecenas sed enim ut. Lacus viverra vitae congue eu consequat ac felis. Pellentesque habitant morbi tristique senectus. Velit sed ullamcorper morbi tincidunt ornare. Placerat vestibulum lectus mauris ultrices eros in cursus turpis.', '2023-01-18', NULL, 51),
(2, 'Annonce : nouveau circuit en vue !!', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Semper auctor neque vitae tempus quam pellentesque nec. Consectetur purus ut faucibus pulvinar. Faucibus purus in massa tempor. Sit amet consectetur adipiscing elit duis tristique sollicitudin nibh. Purus non enim praesent elementum facilisis leo. Mattis aliquam faucibus purus in massa tempor nec feugiat nisl. A lacus vestibulum sed arcu non odio. Leo integer malesuada nunc vel risus commodo. Massa tincidunt dui ut ornare lectus sit amet est. Neque aliquam vestibulum morbi blandit cursus risus at ultrices. Cras ornare arcu dui vivamus arcu felis bibendum.\r\n\r\nPellentesque nec nam aliquam sem et. Arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque. Amet justo donec enim diam vulputate ut pharetra sit. Convallis tellus id interdum velit laoreet id. Mattis nunc sed blandit libero volutpat. Pharetra vel turpis nunc eget lorem dolor. Eget magna fermentum iaculis eu non diam phasellus vestibulum. Pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum. Nulla posuere sollicitudin aliquam ultrices. Maecenas pharetra convallis posuere morbi leo urna. Commodo sed egestas egestas fringilla phasellus faucibus scelerisque. Neque convallis a cras semper auctor. Nulla at volutpat diam ut venenatis tellus. Dignissim enim sit amet venenatis urna cursus eget nunc scelerisque. Lorem sed risus ultricies tristique. Tortor at risus viverra adipiscing at in. Ultrices eros in cursus turpis massa tincidunt. Dignissim cras tincidunt lobortis feugiat vivamus at augue eget arcu.\r\n\r\nAmet volutpat consequat mauris nunc congue nisi vitae suscipit. Ullamcorper malesuada proin libero nunc consequat interdum varius sit. Viverra suspendisse potenti nullam ac tortor vitae. Pharetra convallis posuere morbi leo. Montes nascetur ridiculus mus mauris vitae ultricies leo. Phasellus vestibulum lorem sed risus ultricies tristique. Ut lectus arcu bibendum at varius. Tempus egestas sed sed risus. Suscipit tellus mauris a diam maecenas sed enim ut. Lacus viverra vitae congue eu consequat ac felis. Pellentesque habitant morbi tristique senectus. Velit sed ullamcorper morbi tincidunt ornare. Placerat vestibulum lectus mauris ultrices eros in cursus turpis.', '2023-01-18', NULL, 51),
(3, 'Nouveau partenaire majeur, TotalEnergies', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Semper auctor neque vitae tempus quam pellentesque nec. Consectetur purus ut faucibus pulvinar. Faucibus purus in massa tempor. Sit amet consectetur adipiscing elit duis tristique sollicitudin nibh. Purus non enim praesent elementum facilisis leo. Mattis aliquam faucibus purus in massa tempor nec feugiat nisl. A lacus vestibulum sed arcu non odio. Leo integer malesuada nunc vel risus commodo. Massa tincidunt dui ut ornare lectus sit amet est. Neque aliquam vestibulum morbi blandit cursus risus at ultrices. Cras ornare arcu dui vivamus arcu felis bibendum.\r\n\r\nPellentesque nec nam aliquam sem et. Arcu cursus vitae congue mauris rhoncus aenean vel elit scelerisque. Amet justo donec enim diam vulputate ut pharetra sit. Convallis tellus id interdum velit laoreet id. Mattis nunc sed blandit libero volutpat. Pharetra vel turpis nunc eget lorem dolor. Eget magna fermentum iaculis eu non diam phasellus vestibulum. Pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum. Nulla posuere sollicitudin aliquam ultrices. Maecenas pharetra convallis posuere morbi leo urna. Commodo sed egestas egestas fringilla phasellus faucibus scelerisque. Neque convallis a cras semper auctor. Nulla at volutpat diam ut venenatis tellus. Dignissim enim sit amet venenatis urna cursus eget nunc scelerisque. Lorem sed risus ultricies tristique. Tortor at risus viverra adipiscing at in. Ultrices eros in cursus turpis massa tincidunt. Dignissim cras tincidunt lobortis feugiat vivamus at augue eget arcu.\r\n\r\nAmet volutpat consequat mauris nunc congue nisi vitae suscipit. Ullamcorper malesuada proin libero nunc consequat interdum varius sit. Viverra suspendisse potenti nullam ac tortor vitae. Pharetra convallis posuere morbi leo. Montes nascetur ridiculus mus mauris vitae ultricies leo. Phasellus vestibulum lorem sed risus ultricies tristique. Ut lectus arcu bibendum at varius. Tempus egestas sed sed risus. Suscipit tellus mauris a diam maecenas sed enim ut. Lacus viverra vitae congue eu consequat ac felis. Pellentesque habitant morbi tristique senectus. Velit sed ullamcorper morbi tincidunt ornare. Placerat vestibulum lectus mauris ultrices eros in cursus turpis.', '2023-01-18', NULL, 51);

-- --------------------------------------------------------

--
-- Structure de la table `circuit`
--

DROP TABLE IF EXISTS `circuit`;
CREATE TABLE IF NOT EXISTS `circuit` (
  `idCircuit` int(11) NOT NULL AUTO_INCREMENT,
  `adresse` varchar(120) NOT NULL,
  `nbrMaxPlace` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  PRIMARY KEY (`idCircuit`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `circuit`
--

INSERT INTO `circuit` (`idCircuit`, `adresse`, `nbrMaxPlace`, `nom`) VALUES
(3, 'Saint-Gorgon, 16 rue du Paradis', 30, 'Saint-Gorgon'),
(4, 'Saint-Dié des Vosges', 20, 'SaintKart');

-- --------------------------------------------------------

--
-- Structure de la table `match`
--

DROP TABLE IF EXISTS `match`;
CREATE TABLE IF NOT EXISTS `match` (
  `idMatch` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `heureDebut` time NOT NULL,
  `heureFin` time NOT NULL,
  `nbrPartNecessaire` int(11) NOT NULL,
  `Gagnant` int(11) DEFAULT NULL,
  `resultatFinal` varchar(45) DEFAULT NULL,
  `Circuit_idCircuit` int(11) NOT NULL,
  PRIMARY KEY (`idMatch`),
  KEY `fk_Match_Circuit1_idx` (`Circuit_idCircuit`),
  KEY `fk_Match_Adherent2_idx` (`Gagnant`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `match`
--

INSERT INTO `match` (`idMatch`, `date`, `heureDebut`, `heureFin`, `nbrPartNecessaire`, `Gagnant`, `resultatFinal`, `Circuit_idCircuit`) VALUES
(1, '2023-01-20', '13:00:00', '15:00:00', 20, NULL, NULL, 3),
(2, '2023-01-20', '13:00:00', '15:00:00', 20, NULL, NULL, 4),
(5, '2023-01-21', '19:59:00', '22:00:00', 2, NULL, NULL, 3),
(7, '2022-12-12', '15:00:00', '18:00:00', 12, NULL, NULL, 3),
(8, '2024-01-05', '16:00:00', '22:00:00', 30, NULL, NULL, 3),
(9, '2026-12-12', '12:00:00', '13:00:00', 23, NULL, NULL, 3);

-- --------------------------------------------------------

--
-- Structure de la table `match_has_adherent`
--

DROP TABLE IF EXISTS `match_has_adherent`;
CREATE TABLE IF NOT EXISTS `match_has_adherent` (
  `Match_idMatch` int(11) NOT NULL,
  `Adherent_Personne_idPersonne` int(11) NOT NULL,
  PRIMARY KEY (`Match_idMatch`,`Adherent_Personne_idPersonne`),
  KEY `fk_Match_has_Adherent_Adherent1_idx` (`Adherent_Personne_idPersonne`),
  KEY `fk_Match_has_Adherent_Match1_idx` (`Match_idMatch`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `match_has_adherent`
--

INSERT INTO `match_has_adherent` (`Match_idMatch`, `Adherent_Personne_idPersonne`) VALUES
(7, 12),
(7, 15),
(1, 51),
(5, 51),
(2, 52);

-- --------------------------------------------------------

--
-- Structure de la table `personne`
--

DROP TABLE IF EXISTS `personne`;
CREATE TABLE IF NOT EXISTS `personne` (
  `idPersonne` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `prenom` varchar(45) NOT NULL,
  `adresse` varchar(120) NOT NULL,
  `telephone` varchar(12) NOT NULL,
  `mail` varchar(45) NOT NULL,
  `mdp` varchar(255) NOT NULL,
  PRIMARY KEY (`idPersonne`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `personne`
--

INSERT INTO `personne` (`idPersonne`, `nom`, `prenom`, `adresse`, `telephone`, `mail`, `mdp`) VALUES
(1, 'Macey', 'Fuller', 'Ap #247-422 Sed Rd.', '0820288737', 'mauris.elit@icloud.ca', '$2y$10$kUCTUe/6soSSok8xETGN..our.bMJWbxPxTm8g/OunuAyP4sqfK2m'),
(2, 'Gavin', 'Duncan', 'P.O. Box 862, 2022 Lorem Street', '0468636581', 'consectetuer.adipiscing@protonmail.net', '$2y$10$r9T.2ZTkX8mlNmZBb4fCEOELrHNqMDpLjHwjNwErGdwi4XyBuAaPu'),
(3, 'Emerson', 'Weaver', '104-8822 Mollis. Avenue', '0815748292', 'aliquam.tincidunt.nunc@protonmail.net', '$2y$10$U9S2FdF2r.SiT45Mtg1c7emPX9UG3yhswGgSllCSMsQfrlMt3vH5C'),
(4, 'Lara', 'Lee', 'P.O. Box 839, 3683 Ante. Avenue', '0577275438', 'nulla.semper.tellus@hotmail.edu', '$2y$10$7U6t88A6gqQhJtCZLK.owuQV/rWbdDgF0EgivDiEckSCGyvPon0sa'),
(5, 'Reagan', 'Boone', '4701 Odio St.', '0873561086', 'duis.volutpat@icloud.couk', '$2y$10$lxgkV6DIpybj4.eb.N9.u.I.WshcT00eN7LAPqeXk7t3WPfFrHytm'),
(6, 'Miriam', 'Cook', '865-2546 Nisi. Av.', '0210152887', 'tellus.nunc@aol.net', '$2y$10$BZJ0TqPtMStEP4beGFzSe.o6BM4DHHBYCIMDQoHoOFPQRxpLGOaH6'),
(7, 'Austin', 'Clark', 'Ap #792-4844 Lorem Av.', '0167551738', 'velit.cras.lorem@outlook.ca', '$2y$10$IfGl7qBUOJfl/pvKAbGv2ecWzrB48wNNMyrtGQGYoVdGlX5UUcZ22'),
(8, 'Jolie', 'Cummings', 'Ap #587-2782 Nibh Ave', '0661858485', 'ligula.eu@hotmail.com', '$2y$10$NLoqAVzS5H6Hf21SKYGN0e87XX/obQtLXMDpikMxCYZba.74gsNCK'),
(9, 'Vincent', 'Hubbard', '873-7271 Velit Avenue', '0848678135', 'ligula.elit.pretium@yahoo.ca', '$2y$10$hxcvu7W/jUCN9jVnTCgoguGJ/4Watr3YIQHa7ZoIC5.mZH/TmkMrO'),
(10, 'Hilary', 'Stone', '141-2304 Tortor, St.', '0706454461', 'mi.lorem.vehicula@icloud.net', '$2y$10$68lih489aelVOOVqR2Vqp.EJVxRpy8jfGxw4PBSjMq.qUDn6dvNmi'),
(11, 'Conan', 'Frank', 'P.O. Box 129, 5659 Proin Ave', '0377783876', 'nunc@protonmail.org', '$2y$10$Dtx3gNILEsb1tMXe80QvSuQb3W7TvTdGWCkBq43kwNoAfQqQOurlG'),
(12, 'Lacota', 'Greene', '8833 Inceptos Ave', '0637669744', 'a.ultricies@yahoo.org', '$2y$10$O0FjjXELs667YNNLvUtSz.GKSn/upokDmv1XVwvGrf6GZXJEkxwvu'),
(13, 'Julie', 'Hess', 'Ap #603-1678 Quisque St.', '0454687432', 'vulputate.lacus@icloud.com', '$2y$10$AZ.o0iQKLJAzecuWgOUAZ.Y0oZsjGAd9tbFfi.jFmNaeT7DClXBES'),
(14, 'Theodore', 'Haynes', 'Ap #416-9368 Tellus, St.', '0687481672', 'sed.hendrerit@protonmail.ca', '$2y$10$Ecm3sIeCdtvs6fpTcPYx6OP2t.fBchjjd5r1p8L.ClX4/bXuUbNpK'),
(15, 'Garrison', 'Guy', 'Ap #290-4358 Cursus. St.', '0681177458', 'egestas.urna.justo@icloud.edu', '$2y$10$7XPtF5Gic/0iDOvmIbsb.OXnbYtJW9H.8C6rlddOq1EswpmZM/rEa'),
(16, 'Lewis', 'Burt', 'Ap #933-5788 Aliquet Street', '0436482261', 'arcu.et@hotmail.net', '$2y$10$BHUutnn.im2JuN3Ork4Glua.0JFIFvTl1co.S2hh/Y/dZd8obIVJe'),
(17, 'Fitzgerald', 'Crane', '133-8747 Enim, Street', '0186575226', 'nec.luctus@protonmail.com', '$2y$10$LJbe78wMlGJHuOm2rIJ6Xeemi0VtUeyWRGpo6isqRauWscpva0poa'),
(18, 'Jayme', 'White', 'P.O. Box 563, 222 Vitae Rd.', '0308109853', 'eu.nibh.vulputate@google.couk', '$2y$10$0bt6tf2LXW/gFsjDxdrt3uVgaUwFIZsZ0w7KlFZXPicZ93IZG3uJ.'),
(19, 'Mari', 'Watts', 'P.O. Box 894, 9612 In Av.', '0729006706', 'laoreet.ipsum.curabitur@icloud.org', '$2y$10$0EykmHJJ6YbrNH5SX7UgVeAhNJpOiu0SxL7ekFTnEgBjysrxyk05G'),
(20, 'Nathan', 'Kent', '2009 Tempor St.', '0724835615', 'nonummy.fusce.fermentum@outlook.ca', '$2y$10$QoytUsNX621lr0euJkjGaO5qHPhytfS/AlzOlIio0Jsj.V/oAgsD6'),
(21, 'Adara', 'Boyd', '4395 Et, Avenue', '0977111771', 'et.malesuada.fames@icloud.org', '$2y$10$9DKdw8fHB0d35ick/liG1e11ZNZpiqRibq7r6krpKf/1xnQ2.9h1q'),
(22, 'Cole', 'Daniel', 'P.O. Box 659, 5872 Augue Av.', '0841646083', 'adipiscing.elit@outlook.net', '$2y$10$I2eoPMlbXAckkVBBjGEfC.5hHBq43VvE4LyuO23RCe9mB8NCmf4nm'),
(23, 'Haley', 'Cannon', 'Ap #819-4554 Fusce Rd.', '0793211258', 'suspendisse.sagittis@protonmail.ca', '$2y$10$zVvSjSvpWONNFeiL6aIaVuXinLNwR/NMvp/7NaA2jZjujwJDdHGZ6'),
(24, 'Leonard', 'Craig', 'Ap #942-6209 Donec St.', '0286821614', 'tempus.lorem.fringilla@yahoo.ca', '$2y$10$NARkMzRwFfHMyIwTD20wEONydVSeQVwvEsfmd7cfLtmPYiCIv3Dz.'),
(25, 'Baker', 'Olsen', 'Ap #254-6990 In Rd.', '0735517885', 'vulputate.dui@protonmail.com', '$2y$10$YmXLqM5wweaXXhT1eWkl3.6bjlR9r9wYp7aqS7lO6NOWyLGJRELta'),
(26, 'Quamar', 'Davidson', 'Ap #596-2374 Libero Av.', '0278304950', 'donec@hotmail.org', '$2y$10$Tz.IEwTGe3pyk4XHZeZATe5cPvc7x8TeDTwLK3FvF0jj48ZL8IrXy'),
(27, 'Louis', 'Reese', 'P.O. Box 544, 532 Duis Avenue', '0978565649', 'consectetuer@aol.ca', '$2y$10$s0ktSqgpGBWSjs45VE2WZ.YjfCIY2l7Bo9ZAO1DsoLfRRoKEfixw.'),
(28, 'Leroy', 'Crawford', 'Ap #773-4668 Ante, Road', '0993353660', 'ornare.elit@google.com', '$2y$10$avjtdQA1uxkl.XHsyXZqkeNBPghDvXZBLv2508EqQg7v2IHlyrk1K'),
(29, 'Vanna', 'Hardin', '5922 Morbi Rd.', '0545762732', 'tempor.lorem@protonmail.com', '$2y$10$oueEehXKMQNJC0pR97flvOmv5XKdgurirQKQw2ijxUcm7HTIsPSTC'),
(30, 'Brynn', 'Francis', '165-5206 Quis Ave', '0667232418', 'interdum.ligula@aol.org', '$2y$10$l5YKVeRj0YXsvH2rZ6.oFeDuhkG/hK5DVDcGg7T1KpDsXe.elFZX2'),
(31, 'Russell', 'Blake', '6674 Proin Avenue', '0211238464', 'faucibus.ut@yahoo.ca', '$2y$10$14GccvVl4T41VEWZYFjej.XfP333ivEuFyEeGItqLN4SOSRUEYUHu'),
(32, 'Kasimir', 'Gillespie', 'Ap #427-4970 Sed Rd.', '0596042466', 'in.faucibus@hotmail.couk', '$2y$10$Io/q/IeshOHxr7Wiql7HX.7yllNjKKJeXUOaDMxhWTflIoWXkyPtO'),
(33, 'Denise', 'Dillard', '733-1951 Mauris St.', '0883704248', 'et.nunc@icloud.net', '$2y$10$cAFjMP2Pfve9xcOyGnoXhOiQuPdQnEG1dMIoWNEokPz2CRGh/5tmq'),
(34, 'Jacob', 'Gould', '615-8111 Dictum Ave', '0944181639', 'primis@protonmail.net', '$2y$10$jiKkw0sX4ZLm4VW4Vz8uzeZmJZpxN2/aPu1dvG.MnNqimfSQHS93.'),
(35, 'Hiram', 'Mays', '168-9951 Enim. Street', '0654765925', 'aliquam.gravida.mauris@yahoo.org', '$2y$10$7.grV1zKOx2J0coJ5NTG1.4cdjPzL50vk0ADci/4yuA0RkSWFsUBa'),
(36, 'Jaquelyn', 'Washington', 'P.O. Box 763, 2344 Curabitur St.', '0689760511', 'et.nunc@aol.ca', '$2y$10$TUzqHbEBhge3/jv9ENqYb.Dm5COl7wdULct.0LuIBSuzv40YTHKYS'),
(37, 'Ian', 'Mueller', '544 Ipsum St.', '0283584573', 'a.enim@protonmail.edu', '$2y$10$LyVwvjsjz0aueJjVfPRMFukerKAPC5TgcRCXuAPk/TNyhri2O8Gse'),
(38, 'Vivian', 'Christensen', '9672 Netus Av.', '0116388135', 'vitae@outlook.com', '$2y$10$XnisYslJbhBv/DkQ41oqLOLwOfRLyIPy1wjL3PjnRYeAp6AbEwmHG'),
(39, 'Moana', 'Morse', '3874 Nulla Street', '0531916237', 'libero@outlook.ca', '$2y$10$SEdX8nMh3xkKMjTV2VJCE.mRi5HYloJS5/lrmyH4DvghbZzNnl2fC'),
(40, 'Unity', 'Burks', 'P.O. Box 225, 2893 Donec Avenue', '0495012333', 'fusce@yahoo.net', '$2y$10$KqJR9fgsDr01rUP4rhh3iufWEMLT9uYa6NWLr6SOq4Pbxh7IX9Nfq'),
(41, 'Fallon', 'Kirkland', '734 Per Av.', '0428035484', 'proin.ultrices@outlook.org', '$2y$10$I1Mp.sD3AqYuuYTOECEs3.0M/zubRbmvOjbCxdNYmqPkTihZCsBAO'),
(42, 'Kennan', 'Mcdaniel', 'Ap #259-7519 Purus Av.', '0766500474', 'turpis@aol.edu', '$2y$10$YB3y2.ehm20e6N2FsERVkOQJF5HhogbYdiZtSj1qGPylx5/iFSrG.'),
(43, 'Carter', 'Mcdonald', 'Ap #776-4104 Nunc St.', '0787242756', 'parturient.montes@protonmail.edu', '$2y$10$rJzR1bGZgKweOp1cf4uJxO9QIKL3B5dk.8BYRjL4JvOvuaOrwV8i.'),
(44, 'Farrah', 'Hunt', '550-1140 Pede Avenue', '0692405097', 'in.molestie@google.org', '$2y$10$udcQvDLyjKMekoLxLMHK2eRoZbOMl9qCgU74B9CZVPV80GYpj3H4u'),
(45, 'Yvette', 'Raymond', 'Ap #888-7682 Aliquam Ave', '0306829406', 'sem@yahoo.couk', '$2y$10$C0D6rT8Lj0kfl.6xVe/bQ.PtjpxY2Va1lUwTAH6f8VWUL/rNMU0He'),
(46, 'Thor', 'Aguilar', '9084 Massa St.', '0880387886', 'luctus.aliquet@icloud.net', '$2y$10$se1Q5Ay5342pKi3B1d/zYujAnaIK3c0f6zaInqewEzrR9xqnIycpm'),
(47, 'Libby', 'Barton', 'Ap #684-9086 Quam. Road', '0545807106', 'mauris.morbi@icloud.ca', '$2y$10$sAiD112165gevqTl8Js9jOY1Y250MJhVpRUmWR5WdVapy09ehWOma'),
(48, 'Charde', 'Frazier', '549-2342 Sem Av.', '0336691386', 'lorem.ipsum@protonmail.edu', '$2y$10$xwAgCQLTzc4V4qcDHqhaFu496iSAa8gFqBtQVjtxHTfUpRknUlEZO'),
(49, 'Sopoline', 'Evans', '627-7147 Semper St.', '0227940127', 'sagittis.augue@google.ca', '$2y$10$Rg7VzKG2YNQE8fqu43kW/.0nIPxMErprxJqQAkyigeljXPeWm1BkS'),
(50, 'Alexander', 'Daugherty', '617 Donec Street', '0311827441', 'sed.et@protonmail.edu', '$2y$10$H1Y9jCupZYiYGVg/2GC9KOIU.5QQzX9bZl8sakBfJIqYxK9eMRuYm'),
(51, 'Rouillon', 'Tom', '16 rue des Lisières du Kemberg', '0329888888', 'tom.rouillon88@gmail.com', '$2y$10$hVAexbK7YhlN3N/2BSjGXuRzA6V4Njs1QEYv1BxthTmYV4DdxbiHO'),
(52, 'Grégory', 'Wittmann', 'feur', '0329888888', 'feur@feur.com', '$2y$10$90WMvvhZjdq.EnJZ3vvaXOg9rx23rcDSxd8ee1tBSS4qeLBaX01VO'),
(53, 'Castex', 'Jean', 'Matignon', '0767654345', 'jeanCastex@bebou.com', '$2y$10$B.MMMo9AobIrwafhu9h9aObOx3YFUCydETytWwl0txAE/5qRl8nqS'),
(54, 'Michel', 'Polnareff', 'Feur', '0767654345', 'a@a.com', '$2y$10$r.i4NtWqQtJpMzpFdDQBrOtei1yxJ19orpH/2G0wlxjKnJYDQ88mq'),
(68, 'azer', 'azer', 'zer', '0669696969', 'bc@bc.com', '$2y$10$qgK9ok7WbEp1mvPr6rsR/OllwJ/MukvKyCIvhDQnsLdRumVBYRPqy');

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `idReservation` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `heureDebut` time NOT NULL,
  `heureFin` time NOT NULL,
  `nombreParticipant` int(11) NOT NULL,
  `Circuit_idCircuit` int(11) NOT NULL,
  `Adherent_Personne_idPersonne` int(11) NOT NULL,
  `autorisation` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idReservation`),
  KEY `fk_Reservation_Circuit1_idx` (`Circuit_idCircuit`),
  KEY `fk_Reservation_Adherent1_idx` (`Adherent_Personne_idPersonne`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `reservation`
--

INSERT INTO `reservation` (`idReservation`, `date`, `heureDebut`, `heureFin`, `nombreParticipant`, `Circuit_idCircuit`, `Adherent_Personne_idPersonne`, `autorisation`) VALUES
(1, '2023-01-09', '20:00:00', '21:00:00', 5, 4, 51, 1),
(2, '2023-01-02', '13:00:00', '15:00:00', 5, 3, 51, 1),
(3, '2023-01-26', '10:00:00', '11:00:00', 6, 3, 51, 1);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `adherent`
--
ALTER TABLE `adherent`
  ADD CONSTRAINT `fk_Adherent_Personne1` FOREIGN KEY (`Personne_idPersonne`) REFERENCES `personne` (`idPersonne`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `fk_Admin_Personne1` FOREIGN KEY (`Personne_idPersonne`) REFERENCES `personne` (`idPersonne`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `fk_Article_Admin1` FOREIGN KEY (`Admin_Personne_idPersonne`) REFERENCES `admin` (`Personne_idPersonne`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `match`
--
ALTER TABLE `match`
  ADD CONSTRAINT `fk_Match_Adherent2` FOREIGN KEY (`Gagnant`) REFERENCES `match_has_adherent` (`Adherent_Personne_idPersonne`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Match_Circuit1` FOREIGN KEY (`Circuit_idCircuit`) REFERENCES `circuit` (`idCircuit`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `match_has_adherent`
--
ALTER TABLE `match_has_adherent`
  ADD CONSTRAINT `fk_Match_has_Adherent_Match1` FOREIGN KEY (`Match_idMatch`) REFERENCES `match` (`idMatch`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `fk_Reservation_Adherent1` FOREIGN KEY (`Adherent_Personne_idPersonne`) REFERENCES `adherent` (`Personne_idPersonne`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Reservation_Circuit1` FOREIGN KEY (`Circuit_idCircuit`) REFERENCES `circuit` (`idCircuit`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

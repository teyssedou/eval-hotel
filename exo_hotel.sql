-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Client :  localhost:3306
-- Généré le :  Mar 05 Juin 2018 à 10:34
-- Version du serveur :  5.7.22-0ubuntu0.17.10.1
-- Version de PHP :  7.1.17-0ubuntu0.17.10.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `exo_hotel`
--

-- --------------------------------------------------------

--
-- Structure de la table `Authentification`
--

CREATE TABLE `Authentification` (
  `id-authentification` int(11) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `mot-de-passe` varchar(45) DEFAULT NULL,
  `Client_id-client` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Chambre`
--

CREATE TABLE `Chambre` (
  `id-chambre` int(11) NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `superficie` varchar(45) DEFAULT NULL,
  `étage` varchar(45) DEFAULT NULL,
  `vue` varchar(45) DEFAULT NULL,
  `mobilité-réduite` enum('oui','non') DEFAULT NULL,
  `lit` enum('simple','double King Size','double Queen Size') DEFAULT NULL,
  `salle-de-bain` enum('douche','baignoire','douche et baignoire') DEFAULT NULL,
  `prix` varchar(45) DEFAULT NULL,
  `Service_id-service` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Client`
--

CREATE TABLE `Client` (
  `id-client` int(11) NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `prénom` varchar(45) DEFAULT NULL COMMENT '	',
  `téléphone` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `Reservation_id-reservation` int(11) NOT NULL,
  `Reservation_Chambre_id-chambre` int(11) NOT NULL,
  `Reservation_Chambre_Service_id-service` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Facture`
--

CREATE TABLE `Facture` (
  `id-facture` int(11) NOT NULL,
  `Chambre_id-chambre` int(11) NOT NULL,
  `Chambre_Service_id-service` int(11) NOT NULL,
  `Service_id-service` int(11) NOT NULL,
  `Reservation_id-reservation` int(11) NOT NULL,
  `Reservation_Chambre_id-chambre` int(11) NOT NULL,
  `Reservation_Chambre_Service_id-service` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Gérant`
--

CREATE TABLE `Gérant` (
  `id-gerant` int(11) NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `Client_id-client` int(11) NOT NULL,
  `Client_Reservation_id-reservation` int(11) NOT NULL,
  `Client_Reservation_Chambre_id-chambre` int(11) NOT NULL,
  `Client_Reservation_Chambre_Service_id-service` int(11) NOT NULL,
  `Facture_id-facture` int(11) NOT NULL,
  `Facture_Chambre_id-chambre` int(11) NOT NULL,
  `Facture_Chambre_Service_id-service` int(11) NOT NULL,
  `Facture_Service_id-service` int(11) NOT NULL,
  `Facture_Reservation_id-reservation` int(11) NOT NULL,
  `Facture_Reservation_Chambre_id-chambre` int(11) NOT NULL,
  `Facture_Reservation_Chambre_Service_id-service` int(11) NOT NULL,
  `Reservation_id-reservation` int(11) NOT NULL,
  `Reservation_Chambre_id-chambre` int(11) NOT NULL,
  `Reservation_Chambre_Service_id-service` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Reservation`
--

CREATE TABLE `Reservation` (
  `id-reservation` int(11) NOT NULL,
  `date-arrivée` datetime DEFAULT NULL,
  `date-depart` datetime DEFAULT NULL,
  `Chambre_id-chambre` int(11) NOT NULL,
  `Chambre_Service_id-service` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Service`
--

CREATE TABLE `Service` (
  `id-service` int(11) NOT NULL,
  `nom` varchar(45) DEFAULT NULL COMMENT '	',
  `categorie` enum('materiel','bien-être','repas','spécial') DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `prix` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `Authentification`
--
ALTER TABLE `Authentification`
  ADD PRIMARY KEY (`id-authentification`,`Client_id-client`),
  ADD KEY `fk_Authentification_Client1_idx` (`Client_id-client`);

--
-- Index pour la table `Chambre`
--
ALTER TABLE `Chambre`
  ADD PRIMARY KEY (`id-chambre`,`Service_id-service`),
  ADD KEY `fk_Chambre_Service1_idx` (`Service_id-service`);

--
-- Index pour la table `Client`
--
ALTER TABLE `Client`
  ADD PRIMARY KEY (`id-client`,`Reservation_id-reservation`,`Reservation_Chambre_id-chambre`,`Reservation_Chambre_Service_id-service`),
  ADD KEY `fk_Client_Reservation1_idx` (`Reservation_id-reservation`,`Reservation_Chambre_id-chambre`,`Reservation_Chambre_Service_id-service`);

--
-- Index pour la table `Facture`
--
ALTER TABLE `Facture`
  ADD PRIMARY KEY (`id-facture`,`Chambre_id-chambre`,`Chambre_Service_id-service`,`Service_id-service`,`Reservation_id-reservation`,`Reservation_Chambre_id-chambre`,`Reservation_Chambre_Service_id-service`),
  ADD KEY `fk_Facture_Chambre1_idx` (`Chambre_id-chambre`,`Chambre_Service_id-service`),
  ADD KEY `fk_Facture_Service1_idx` (`Service_id-service`),
  ADD KEY `fk_Facture_Reservation1_idx` (`Reservation_id-reservation`,`Reservation_Chambre_id-chambre`,`Reservation_Chambre_Service_id-service`);

--
-- Index pour la table `Gérant`
--
ALTER TABLE `Gérant`
  ADD PRIMARY KEY (`id-gerant`,`Client_id-client`,`Client_Reservation_id-reservation`,`Client_Reservation_Chambre_id-chambre`,`Client_Reservation_Chambre_Service_id-service`,`Facture_id-facture`,`Facture_Chambre_id-chambre`,`Facture_Chambre_Service_id-service`,`Facture_Service_id-service`,`Facture_Reservation_id-reservation`,`Facture_Reservation_Chambre_id-chambre`,`Facture_Reservation_Chambre_Service_id-service`,`Reservation_id-reservation`,`Reservation_Chambre_id-chambre`,`Reservation_Chambre_Service_id-service`),
  ADD KEY `fk_Gérant_Client1_idx` (`Client_id-client`,`Client_Reservation_id-reservation`,`Client_Reservation_Chambre_id-chambre`,`Client_Reservation_Chambre_Service_id-service`),
  ADD KEY `fk_Gérant_Facture1_idx` (`Facture_id-facture`,`Facture_Chambre_id-chambre`,`Facture_Chambre_Service_id-service`,`Facture_Service_id-service`,`Facture_Reservation_id-reservation`,`Facture_Reservation_Chambre_id-chambre`,`Facture_Reservation_Chambre_Service_id-service`),
  ADD KEY `fk_Gérant_Reservation1_idx` (`Reservation_id-reservation`,`Reservation_Chambre_id-chambre`,`Reservation_Chambre_Service_id-service`);

--
-- Index pour la table `Reservation`
--
ALTER TABLE `Reservation`
  ADD PRIMARY KEY (`id-reservation`,`Chambre_id-chambre`,`Chambre_Service_id-service`),
  ADD KEY `fk_Reservation_Chambre1_idx` (`Chambre_id-chambre`,`Chambre_Service_id-service`);

--
-- Index pour la table `Service`
--
ALTER TABLE `Service`
  ADD PRIMARY KEY (`id-service`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `Authentification`
--
ALTER TABLE `Authentification`
  MODIFY `id-authentification` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Chambre`
--
ALTER TABLE `Chambre`
  MODIFY `id-chambre` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Client`
--
ALTER TABLE `Client`
  MODIFY `id-client` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Facture`
--
ALTER TABLE `Facture`
  MODIFY `id-facture` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Gérant`
--
ALTER TABLE `Gérant`
  MODIFY `id-gerant` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Reservation`
--
ALTER TABLE `Reservation`
  MODIFY `id-reservation` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Service`
--
ALTER TABLE `Service`
  MODIFY `id-service` int(11) NOT NULL AUTO_INCREMENT;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `Authentification`
--
ALTER TABLE `Authentification`
  ADD CONSTRAINT `fk_Authentification_Client1` FOREIGN KEY (`Client_id-client`) REFERENCES `Client` (`id-client`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `Chambre`
--
ALTER TABLE `Chambre`
  ADD CONSTRAINT `fk_Chambre_Service1` FOREIGN KEY (`Service_id-service`) REFERENCES `Service` (`id-service`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `Client`
--
ALTER TABLE `Client`
  ADD CONSTRAINT `fk_Client_Reservation1` FOREIGN KEY (`Reservation_id-reservation`,`Reservation_Chambre_id-chambre`,`Reservation_Chambre_Service_id-service`) REFERENCES `Reservation` (`id-reservation`, `Chambre_id-chambre`, `Chambre_Service_id-service`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `Facture`
--
ALTER TABLE `Facture`
  ADD CONSTRAINT `fk_Facture_Chambre1` FOREIGN KEY (`Chambre_id-chambre`,`Chambre_Service_id-service`) REFERENCES `Chambre` (`id-chambre`, `Service_id-service`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Facture_Reservation1` FOREIGN KEY (`Reservation_id-reservation`,`Reservation_Chambre_id-chambre`,`Reservation_Chambre_Service_id-service`) REFERENCES `Reservation` (`id-reservation`, `Chambre_id-chambre`, `Chambre_Service_id-service`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Facture_Service1` FOREIGN KEY (`Service_id-service`) REFERENCES `Service` (`id-service`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `Gérant`
--
ALTER TABLE `Gérant`
  ADD CONSTRAINT `fk_Gérant_Client1` FOREIGN KEY (`Client_id-client`,`Client_Reservation_id-reservation`,`Client_Reservation_Chambre_id-chambre`,`Client_Reservation_Chambre_Service_id-service`) REFERENCES `Client` (`id-client`, `Reservation_id-reservation`, `Reservation_Chambre_id-chambre`, `Reservation_Chambre_Service_id-service`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Gérant_Facture1` FOREIGN KEY (`Facture_id-facture`,`Facture_Chambre_id-chambre`,`Facture_Chambre_Service_id-service`,`Facture_Service_id-service`,`Facture_Reservation_id-reservation`,`Facture_Reservation_Chambre_id-chambre`,`Facture_Reservation_Chambre_Service_id-service`) REFERENCES `Facture` (`id-facture`, `Chambre_id-chambre`, `Chambre_Service_id-service`, `Service_id-service`, `Reservation_id-reservation`, `Reservation_Chambre_id-chambre`, `Reservation_Chambre_Service_id-service`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Gérant_Reservation1` FOREIGN KEY (`Reservation_id-reservation`,`Reservation_Chambre_id-chambre`,`Reservation_Chambre_Service_id-service`) REFERENCES `Reservation` (`id-reservation`, `Chambre_id-chambre`, `Chambre_Service_id-service`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `Reservation`
--
ALTER TABLE `Reservation`
  ADD CONSTRAINT `fk_Reservation_Chambre1` FOREIGN KEY (`Chambre_id-chambre`,`Chambre_Service_id-service`) REFERENCES `Chambre` (`id-chambre`, `Service_id-service`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

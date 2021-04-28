-- MariaDB dump 10.18  Distrib 10.5.8-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: TELEFONIA
-- ------------------------------------------------------
-- Server version	10.5.8-MariaDB-1:10.5.8+maria~focal

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `TELEFONIA`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `TELEFONIA` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `TELEFONIA`;

--
-- Table structure for table `CALLS`
--

DROP TABLE IF EXISTS `CALLS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CALLS` (
  `Num_Llamante` varchar(13) NOT NULL,
  `Num_Llamado` varchar(13) NOT NULL,
  `Date` datetime NOT NULL,
  `Time` int(11) NOT NULL CHECK (`Time` > 0 and `Time` < 9999999),
  PRIMARY KEY (`Num_Llamante`,`Num_Llamado`),
  KEY `fk_CALLS_PHONES1_idx` (`Num_Llamante`),
  KEY `fk_CALLS_PHONES2_idx` (`Num_Llamado`),
  CONSTRAINT `fk_CALLS_PHONES1` FOREIGN KEY (`Num_Llamante`) REFERENCES `PHONES` (`Numero`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CALLS_PHONES2` FOREIGN KEY (`Num_Llamado`) REFERENCES `PHONES` (`Numero`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `chk_REGISTRATION_DATE` CHECK (`Date` > str_to_date('1990-01-01','yyyy-mm-dd'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CALLS`
--

LOCK TABLES `CALLS` WRITE;
/*!40000 ALTER TABLE `CALLS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CALLS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPANIES`
--

DROP TABLE IF EXISTS `COMPANIES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COMPANIES` (
  `ID_Compania` int(11) NOT NULL CHECK (`ID_Compania` > 0 and `ID_Compania` < 9999),
  `Name` varchar(20) NOT NULL,
  `Anio_Fundacion` int(11) NOT NULL CHECK (`Anio_Fundacion` > 1900 and `Anio_Fundacion` < 2010),
  PRIMARY KEY (`ID_Compania`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPANIES`
--

LOCK TABLES `COMPANIES` WRITE;
/*!40000 ALTER TABLE `COMPANIES` DISABLE KEYS */;
/*!40000 ALTER TABLE `COMPANIES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMERS`
--

DROP TABLE IF EXISTS `CUSTOMERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CUSTOMERS` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(20) NOT NULL,
  `AGE` int(11) NOT NULL,
  `ADDRESS` char(25) DEFAULT NULL,
  `SALARY` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMERS`
--

LOCK TABLES `CUSTOMERS` WRITE;
/*!40000 ALTER TABLE `CUSTOMERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CUSTOMERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OCCUPATIONS`
--

DROP TABLE IF EXISTS `OCCUPATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OCCUPATIONS` (
  `code` varchar(3) NOT NULL,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OCCUPATIONS`
--

LOCK TABLES `OCCUPATIONS` WRITE;
/*!40000 ALTER TABLE `OCCUPATIONS` DISABLE KEYS */;
/*!40000 ALTER TABLE `OCCUPATIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PHONES`
--

DROP TABLE IF EXISTS `PHONES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PHONES` (
  `Numero` varchar(13) NOT NULL,
  `ID_Compania` int(11) NOT NULL CHECK (`ID_Compania` > 0 and `ID_Compania` < 9999),
  `NIF_Usuario` varchar(9) NOT NULL,
  PRIMARY KEY (`Numero`),
  KEY `fk_PHONES_COMPANIES_idx` (`ID_Compania`),
  KEY `fk_PHONES_USERS1_idx` (`NIF_Usuario`),
  CONSTRAINT `fk_PHONES_COMPANIES` FOREIGN KEY (`ID_Compania`) REFERENCES `COMPANIES` (`ID_Compania`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PHONES_USERS1` FOREIGN KEY (`NIF_Usuario`) REFERENCES `USERS` (`NIF`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PHONES`
--

LOCK TABLES `PHONES` WRITE;
/*!40000 ALTER TABLE `PHONES` DISABLE KEYS */;
/*!40000 ALTER TABLE `PHONES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERS`
--

DROP TABLE IF EXISTS `USERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USERS` (
  `NIF` varchar(9) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Last_name1` varchar(20) NOT NULL,
  `Last_name2` varchar(20) DEFAULT NULL,
  `Fec_nacim` date DEFAULT NULL CHECK (`Fec_nacim` > '1900-01-01'),
  PRIMARY KEY (`NIF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERS`
--

LOCK TABLES `USERS` WRITE;
/*!40000 ALTER TABLE `USERS` DISABLE KEYS */;
/*!40000 ALTER TABLE `USERS` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-28 14:44:44

-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: dbPrudhvi
-- ------------------------------------------------------
-- Server version	8.0.32-0ubuntu0.22.10.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `BankAccount`
--

DROP TABLE IF EXISTS `BankAccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BankAccount` (
  `AccountNumber` varchar(15) DEFAULT NULL,
  `AccountHolder` varchar(20) DEFAULT NULL,
  `Balance` int DEFAULT NULL,
  UNIQUE KEY `AccountNumber` (`AccountNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BankAccount`
--

LOCK TABLES `BankAccount` WRITE;
/*!40000 ALTER TABLE `BankAccount` DISABLE KEYS */;
INSERT INTO `BankAccount` VALUES ('150001335','Prudhvi',79000),('150001225','Manikanta',90000),('150001331','Ravi',90000);
/*!40000 ALTER TABLE `BankAccount` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Prudhvi`@`%`*/ /*!50003 TRIGGER `TestTrigger` BEFORE INSERT ON `BankAccount` FOR EACH ROW BEGIN
SIGNAL SQLSTATE '45000'
SET MYSQL_ERRNO = 10003;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `BillDetails`
--

DROP TABLE IF EXISTS `BillDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BillDetails` (
  `BillNumber` int NOT NULL,
  `ItemID` int NOT NULL,
  `SoldQty` int DEFAULT '1',
  PRIMARY KEY (`BillNumber`,`ItemID`),
  KEY `fk_ItemID` (`ItemID`),
  CONSTRAINT `fk_BillID` FOREIGN KEY (`BillNumber`) REFERENCES `BillHeader` (`BillNumber`),
  CONSTRAINT `fk_ItemID` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BillDetails`
--

LOCK TABLES `BillDetails` WRITE;
/*!40000 ALTER TABLE `BillDetails` DISABLE KEYS */;
INSERT INTO `BillDetails` VALUES (1001,101,2),(1002,101,1),(1003,103,1),(1003,105,10),(1004,101,3),(1004,104,2),(1004,105,2);
/*!40000 ALTER TABLE `BillDetails` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Prudhvi`@`%`*/ /*!50003 TRIGGER `CheckStock` BEFORE INSERT ON `BillDetails` FOR EACH ROW BEGIN
DECLARE StockQty INTEGER;
DECLARE RecordCount INTEGER;
SELECT COUNT(*) INTO RecordCount FROM BillDetails WHERE ItemID = NEW.ItemID AND BillNumber = NEW.BillNumber;
SELECT StockQty INTO StockQty FROM dbPrudhvi.Item WHERE ItemID = NEW.ItemID;
IF NEW.SoldQty > StockQty THEN
SIGNAL SQLSTATE '45000'
SET MYSQL_ERRNO = 10001;
ELSEIF RecordCount > 0 THEN
UPDATE BillDeatails SET SoldQty = SoldQty + NEW.SoldQty WHERE BillNumber = NEW.BillNumber AND ItemID = NEW.ItemID;
SIGNAL SQLSTATE '45000'
SET MYSQL_ERRNO = 10004;
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`Prudhvi`@`%`*/ /*!50003 TRIGGER `UpdateStock` AFTER INSERT ON `BillDetails` FOR EACH ROW BEGIN
DECLARE Qty integer;
SELECT StockQty INTO Qty FROM Item WHERE ItemID = NEW.ItemID;
IF NEW.SoldQty <= Qty THEN
UPDATE Item SET StockQty = StockQty - NEW.SoldQty WHERE ItemID = NEW.ItemID;
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `BillHeader`
--

DROP TABLE IF EXISTS `BillHeader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BillHeader` (
  `BillNumber` int NOT NULL,
  `BillDate` date DEFAULT (now()),
  `CasheirID` int DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  PRIMARY KEY (`BillNumber`),
  KEY `fk_cashierID` (`CasheirID`),
  KEY `fk_customerID` (`CustomerID`),
  CONSTRAINT `fk_cashierID` FOREIGN KEY (`CasheirID`) REFERENCES `Cashier` (`CashierID`),
  CONSTRAINT `fk_customerID` FOREIGN KEY (`CustomerID`) REFERENCES `Customer` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BillHeader`
--

LOCK TABLES `BillHeader` WRITE;
/*!40000 ALTER TABLE `BillHeader` DISABLE KEYS */;
INSERT INTO `BillHeader` VALUES (1001,'2023-04-05',110001,2001),(1002,'2023-04-05',110001,2002),(1003,'2023-04-06',110002,2003),(1004,'2023-04-11',110003,2003);
/*!40000 ALTER TABLE `BillHeader` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `BusinessReport`
--

DROP TABLE IF EXISTS `BusinessReport`;
/*!50001 DROP VIEW IF EXISTS `BusinessReport`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `BusinessReport` AS SELECT 
 1 AS `Name_exp_1`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Cashier`
--

DROP TABLE IF EXISTS `Cashier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cashier` (
  `CashierID` int NOT NULL,
  `Name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`CashierID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cashier`
--

LOCK TABLES `Cashier` WRITE;
/*!40000 ALTER TABLE `Cashier` DISABLE KEYS */;
INSERT INTO `Cashier` VALUES (110001,'Shiva'),(110002,'Ram'),(110003,'Krishna'),(110004,'Sathya'),(110005,'Manikanta');
/*!40000 ALTER TABLE `Cashier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `CustomerID` int NOT NULL,
  `CustomerName` varchar(20) DEFAULT NULL,
  `MobileNumber` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (2001,'Prudhvi','8008171053'),(2002,'Harsha','8008171052'),(2003,'Ravi','9009171053');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DeletedAccounts`
--

DROP TABLE IF EXISTS `DeletedAccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DeletedAccounts` (
  `AccountNumber` varchar(15) DEFAULT NULL,
  `AccountHolder` varchar(20) DEFAULT NULL,
  UNIQUE KEY `AccountNumber` (`AccountNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DeletedAccounts`
--

LOCK TABLES `DeletedAccounts` WRITE;
/*!40000 ALTER TABLE `DeletedAccounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `DeletedAccounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Error`
--

DROP TABLE IF EXISTS `Error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Error` (
  `Code` int NOT NULL AUTO_INCREMENT,
  `Message` text,
  PRIMARY KEY (`Code`)
) ENGINE=InnoDB AUTO_INCREMENT=10005 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Error`
--

LOCK TABLES `Error` WRITE;
/*!40000 ALTER TABLE `Error` DISABLE KEYS */;
INSERT INTO `Error` VALUES (10001,'No more quantity. Please add the stock first!'),(10002,'Invalid ItemID. Please check once!'),(10003,'Something is wrong. Please check the connection!'),(10004,'SoldQty is Updated');
/*!40000 ALTER TABLE `Error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Item`
--

DROP TABLE IF EXISTS `Item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Item` (
  `ItemID` int NOT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `StockQty` int DEFAULT NULL,
  `UnitPrice` int DEFAULT NULL,
  `SupplierID` int DEFAULT NULL,
  PRIMARY KEY (`ItemID`),
  KEY `fk_supplierID` (`SupplierID`),
  CONSTRAINT `fk_supplierID` FOREIGN KEY (`SupplierID`) REFERENCES `Supplier` (`SupplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Item`
--

LOCK TABLES `Item` WRITE;
/*!40000 ALTER TABLE `Item` DISABLE KEYS */;
INSERT INTO `Item` VALUES (101,'Ajanta Wall Clock',17,500,11001),(102,'Luggage Bags',30,300,11002),(103,'HP Pevilion Laptops',9,58000,11004),(104,'POCO M4Pro Mobile',8,12000,11003),(105,'Orient Supper Speed Fans',8,400,11005);
/*!40000 ALTER TABLE `Item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Messages`
--

DROP TABLE IF EXISTS `Messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Messages` (
  `Sno` int NOT NULL AUTO_INCREMENT,
  `Message` varchar(30) DEFAULT NULL,
  `Created_At` datetime DEFAULT NULL,
  PRIMARY KEY (`Sno`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Messages`
--

LOCK TABLES `Messages` WRITE;
/*!40000 ALTER TABLE `Messages` DISABLE KEYS */;
INSERT INTO `Messages` VALUES (1,'Test MySQL Event1','2023-04-06 06:39:34'),(2,'Test MySQL Event2','2023-04-06 06:48:00'),(3,'Test MySQL Event3','2023-04-06 07:01:30'),(4,'Test MySQL Event3','2023-04-06 07:02:30'),(5,'Test MySQL Event3','2023-04-06 07:03:30'),(6,'Test MySQL Event3','2023-04-06 07:04:30'),(7,'Test MySQL Event3','2023-04-06 07:05:30'),(8,'Test MySQL Event3','2023-04-06 07:06:30'),(9,'Test MySQL Event3','2023-04-06 07:07:30'),(10,'Test MySQL Event3','2023-04-06 07:08:30'),(11,'Test MySQL Event3','2023-04-06 07:09:30'),(12,'Test MySQL Event3','2023-04-06 07:10:30'),(13,'Test MySQL Event3','2023-04-06 07:11:30'),(14,'Test MySQL Event3','2023-04-06 07:12:30'),(15,'Test MySQL Event3','2023-04-06 07:13:30'),(16,'Test MySQL Event3','2023-04-06 07:14:30'),(17,'Test MySQL Event3','2023-04-06 07:15:30'),(18,'Test MySQL Event3','2023-04-06 07:16:30'),(19,'Test MySQL Event3','2023-04-06 07:17:30'),(20,'Test MySQL Event3','2023-04-06 07:18:30'),(21,'Test MySQL Event3','2023-04-06 07:19:30'),(22,'Test MySQL Event3','2023-04-06 07:20:30'),(23,'Test MySQL Event3','2023-04-06 07:21:30');
/*!40000 ALTER TABLE `Messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NewBillDetails`
--

DROP TABLE IF EXISTS `NewBillDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NewBillDetails` (
  `BillNumber` int NOT NULL,
  `ItemID` int NOT NULL,
  `SoldQty` int DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NewBillDetails`
--

LOCK TABLES `NewBillDetails` WRITE;
/*!40000 ALTER TABLE `NewBillDetails` DISABLE KEYS */;
INSERT INTO `NewBillDetails` VALUES (1001,101,2),(1002,101,1),(1003,103,1),(1003,105,10),(1004,101,3),(1004,104,2),(1004,105,2);
/*!40000 ALTER TABLE `NewBillDetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NewItem`
--

DROP TABLE IF EXISTS `NewItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NewItem` (
  `ItemID` int NOT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `StockQty` int DEFAULT NULL,
  `UnitPrice` int DEFAULT NULL,
  `SupplierID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NewItem`
--

LOCK TABLES `NewItem` WRITE;
/*!40000 ALTER TABLE `NewItem` DISABLE KEYS */;
INSERT INTO `NewItem` VALUES (101,'Ajanta Wall Clock',17,500,11001),(102,'Luggage Bags',30,300,11002),(103,'HP Pevilion Laptops',9,58000,11004),(104,'POCO M4Pro Mobile',8,12000,11003),(105,'Orient Supper Speed Fans',8,400,11005);
/*!40000 ALTER TABLE `NewItem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Person`
--

DROP TABLE IF EXISTS `Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Person` (
  `Name` varchar(100) NOT NULL,
  `Age` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Person`
--

LOCK TABLES `Person` WRITE;
/*!40000 ALTER TABLE `Person` DISABLE KEYS */;
INSERT INTO `Person` VALUES ('George',20),('Emma',22),('Harry',15),('Ava',17),('Olivia',25),('Thomas',23);
/*!40000 ALTER TABLE `Person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Supplier`
--

DROP TABLE IF EXISTS `Supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Supplier` (
  `SupplierID` int NOT NULL,
  `Name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`SupplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Supplier`
--

LOCK TABLES `Supplier` WRITE;
/*!40000 ALTER TABLE `Supplier` DISABLE KEYS */;
INSERT INTO `Supplier` VALUES (11001,'Ajanta Clocks'),(11002,'Amazon'),(11003,'Xiaomi'),(11004,'HP Computers'),(11005,'Orient');
/*!40000 ALTER TABLE `Supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WeatherData`
--

DROP TABLE IF EXISTS `WeatherData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WeatherData` (
  `LocationID` int NOT NULL AUTO_INCREMENT,
  `Location` text,
  `Temperature` int DEFAULT NULL,
  `Humidity` int DEFAULT NULL,
  `Description` text,
  PRIMARY KEY (`LocationID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WeatherData`
--

LOCK TABLES `WeatherData` WRITE;
/*!40000 ALTER TABLE `WeatherData` DISABLE KEYS */;
INSERT INTO `WeatherData` VALUES (1,'Elamanchili',37,38,'clear sky'),(2,'Anakapalle',37,34,'clear sky'),(3,'Australia',31,17,'clear sky'),(4,'Egypt',1,82,'clear sky'),(5,'Africa',33,38,'overcast clouds');
/*!40000 ALTER TABLE `WeatherData` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testItem`
--

DROP TABLE IF EXISTS `testItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testItem` (
  `ItemID` int NOT NULL,
  `Description` varchar(20) DEFAULT NULL,
  `Qty` int DEFAULT NULL,
  PRIMARY KEY (`ItemID`),
  CONSTRAINT `testItem_chk_1` CHECK ((`Qty` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testItem`
--

LOCK TABLES `testItem` WRITE;
/*!40000 ALTER TABLE `testItem` DISABLE KEYS */;
INSERT INTO `testItem` VALUES (101,'Rice Bags',10),(102,'Milk Packets',10);
/*!40000 ALTER TABLE `testItem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `BusinessReport`
--

/*!50001 DROP VIEW IF EXISTS `BusinessReport`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`Prudhvi`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `BusinessReport` AS select concat('\nTitle: BusinessReport\nBranch: Elamanchili\nDate: ',(select curdate()),'\n\n	Our Super Market name is RP-SuperMarket. It started ',(select (curdate() - `dbPrudhvi`.`getSuperMarketOpenDate`())),' days ago. It has ',(select count(0) from `Item`),' different types of items. We provide a 5% discount on those items until a week. The stocked items are ',`dbPrudhvi`.`getItemsList`(),'. The price of the most costliest item in our RP-SuperMarket is Rs.',(select max(`Item`.`UnitPrice`) from `Item`),'(',(select `Item`.`Description` from `Item` where (`Item`.`UnitPrice` = (select max(`Item`.`UnitPrice`) from `Item`))),').\n\n	 We provide item prices within the range of Rs.',(select min(`Item`.`UnitPrice`) from `Item`),' - Rs.',(select max(`Item`.`UnitPrice`) from `Item`),'. Our SuperMarket has totally ',(select count(0) from `Customer`),'+ customers , ',(select count(0) from `Supplier`),'+ Suppliers[',`dbPrudhvi`.`getSuppliersList`(),'] and ',(select count(0) from `Cashier`),' cashiers. The ID of the maximum sold item until today is (',(select `BillDetails`.`ItemID` from `BillDetails` group by `BillDetails`.`ItemID` order by sum(`BillDetails`.`SoldQty`) desc limit 1),'). The total sales price of today is Rs.',convert(`dbPrudhvi`.`getSalesPriceOfToday`() using utf8mb4),'. The average sales price of today is ',(select (`dbPrudhvi`.`getSalesPriceOfToday`() / (select count(0) from `Item`))),'.\n\nThank You!\n') AS `Name_exp_1` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-13  5:32:00

CREATE DATABASE  IF NOT EXISTS `atividade_bdii` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `atividade_bdii`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: atividade_bdii
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `log_violacoes_regras`
--

DROP TABLE IF EXISTS `log_violacoes_regras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_violacoes_regras` (
  `id_log` int NOT NULL AUTO_INCREMENT,
  `timestamp_ocorrencia` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario_db` varchar(255) DEFAULT NULL,
  `tabela_afetada` varchar(255) DEFAULT NULL,
  `tipo_operacao` varchar(50) DEFAULT NULL,
  `descricao_violacao` text,
  `dados_tentativa` text,
  PRIMARY KEY (`id_log`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_violacoes_regras`
--

LOCK TABLES `log_violacoes_regras` WRITE;
/*!40000 ALTER TABLE `log_violacoes_regras` DISABLE KEYS */;
INSERT INTO `log_violacoes_regras` VALUES (1,'2025-11-04 01:27:09','root@localhost','olist_order_reviews_dataset','INSERT','Erro: A pontuação do review (review_score) deve estar entre 1 e 5.','order_id: order_teste_99, review_id: review_teste_99, review_score: 9'),(2,'2025-11-04 19:38:26','root@localhost','olist_order_reviews_dataset','INSERT','Erro: A pontuação do review (review_score) deve estar entre 1 e 5.','order_id: order_teste_99, review_id: review_teste_99, review_score: 9');
/*!40000 ALTER TABLE `log_violacoes_regras` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-04 17:05:01

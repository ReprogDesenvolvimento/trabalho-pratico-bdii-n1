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
-- Temporary view structure for view `view_entregas`
--

DROP TABLE IF EXISTS `view_entregas`;
/*!50001 DROP VIEW IF EXISTS `view_entregas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_entregas` AS SELECT 
 1 AS `tipo_analise`,
 1 AS `chave`,
 1 AS `total_pedidos`,
 1 AS `atrasos_criticos`,
 1 AS `porcentagem_criticos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_painel_vendas_gerencial`
--

DROP TABLE IF EXISTS `vw_painel_vendas_gerencial`;
/*!50001 DROP VIEW IF EXISTS `vw_painel_vendas_gerencial`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_painel_vendas_gerencial` AS SELECT 
 1 AS `ano`,
 1 AS `mes`,
 1 AS `total_pedidos`,
 1 AS `receita_total`,
 1 AS `receita_bruta`,
 1 AS `ticket_medio`,
 1 AS `ranking_receita`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_painel_vendas_detalhadas`
--

DROP TABLE IF EXISTS `vw_painel_vendas_detalhadas`;
/*!50001 DROP VIEW IF EXISTS `vw_painel_vendas_detalhadas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_painel_vendas_detalhadas` AS SELECT 
 1 AS `order_id`,
 1 AS `order_purchase_timestamp`,
 1 AS `product_id`,
 1 AS `product_category_name`,
 1 AS `price`,
 1 AS `freight_value`,
 1 AS `payment_type`,
 1 AS `payment_value`,
 1 AS `customer_id`,
 1 AS `customer_state`,
 1 AS `seller_id`,
 1 AS `seller_state`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `view_entregas`
--

/*!50001 DROP VIEW IF EXISTS `view_entregas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_entregas` AS with `pedidos_prioridade` as (select `o`.`order_id` AS `order_id`,`o`.`customer_id` AS `customer_id`,`o`.`order_status` AS `order_status`,`o`.`order_purchase_timestamp` AS `order_purchase_timestamp`,`o`.`order_delivered_customer_date` AS `order_delivered_customer_date`,`o`.`order_estimated_delivery_date` AS `order_estimated_delivery_date`,(to_days(`o`.`order_delivered_customer_date`) - to_days(`o`.`order_estimated_delivery_date`)) AS `dias_atraso`,(case when (`o`.`order_delivered_customer_date` is null) then 1 when ((to_days(`o`.`order_delivered_customer_date`) - to_days(`o`.`order_estimated_delivery_date`)) > 10) then 1 when ((to_days(`o`.`order_delivered_customer_date`) - to_days(`o`.`order_estimated_delivery_date`)) between 5 and 10) then 2 when ((to_days(`o`.`order_delivered_customer_date`) - to_days(`o`.`order_estimated_delivery_date`)) between 1 and 4) then 3 else 4 end) AS `prioridade_score` from `olist_orders_dataset` `o` where (`o`.`order_status` in ('delivered','shipped','invoiced','processing'))), `atrasos_por_mes` as (select year(`pedidos_prioridade`.`order_purchase_timestamp`) AS `ano`,month(`pedidos_prioridade`.`order_purchase_timestamp`) AS `mes`,count(0) AS `total_pedidos`,sum((case when (`pedidos_prioridade`.`prioridade_score` = 1) then 1 else 0 end)) AS `atrasos_criticos`,round(((sum((case when (`pedidos_prioridade`.`prioridade_score` = 1) then 1 else 0 end)) / count(0)) * 100),2) AS `porcentagem_criticos` from `pedidos_prioridade` group by `ano`,`mes`), `atrasos_por_estado` as (select `c`.`customer_state` AS `estado`,count(0) AS `total_pedidos`,sum((case when (`p`.`prioridade_score` = 1) then 1 else 0 end)) AS `atrasos_criticos`,round(((sum((case when (`p`.`prioridade_score` = 1) then 1 else 0 end)) / count(0)) * 100),2) AS `porcentagem_criticos` from (`pedidos_prioridade` `p` join `olist_customers_dataset` `c` on((`p`.`customer_id` = `c`.`customer_id`))) group by `c`.`customer_state`), `atrasos_por_categoria` as (select `pr`.`product_category_name` AS `categoria`,count(0) AS `total_pedidos`,sum((case when (`p`.`prioridade_score` = 1) then 1 else 0 end)) AS `atrasos_criticos`,round(((sum((case when (`p`.`prioridade_score` = 1) then 1 else 0 end)) / count(0)) * 100),2) AS `porcentagem_criticos` from ((`pedidos_prioridade` `p` join `olist_order_items_dataset` `i` on((`p`.`order_id` = `i`.`order_id`))) join `olist_products_dataset` `pr` on((`i`.`product_id` = `pr`.`product_id`))) group by `pr`.`product_category_name`) select 'por_mes' AS `tipo_analise`,concat(convert(lpad(`atrasos_por_mes`.`mes`,2,'0') using utf8mb4),'/',`atrasos_por_mes`.`ano`) AS `chave`,`atrasos_por_mes`.`total_pedidos` AS `total_pedidos`,`atrasos_por_mes`.`atrasos_criticos` AS `atrasos_criticos`,`atrasos_por_mes`.`porcentagem_criticos` AS `porcentagem_criticos` from `atrasos_por_mes` union all select 'por_estado' AS `tipo_analise`,`atrasos_por_estado`.`estado` AS `chave`,`atrasos_por_estado`.`total_pedidos` AS `total_pedidos`,`atrasos_por_estado`.`atrasos_criticos` AS `atrasos_criticos`,`atrasos_por_estado`.`porcentagem_criticos` AS `porcentagem_criticos` from `atrasos_por_estado` union all select 'por_categoria' AS `tipo_analise`,`atrasos_por_categoria`.`categoria` AS `chave`,`atrasos_por_categoria`.`total_pedidos` AS `total_pedidos`,`atrasos_por_categoria`.`atrasos_criticos` AS `atrasos_criticos`,`atrasos_por_categoria`.`porcentagem_criticos` AS `porcentagem_criticos` from `atrasos_por_categoria` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_painel_vendas_gerencial`
--

/*!50001 DROP VIEW IF EXISTS `vw_painel_vendas_gerencial`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_painel_vendas_gerencial` AS select year(`o`.`order_purchase_timestamp`) AS `ano`,month(`o`.`order_purchase_timestamp`) AS `mes`,count(distinct `o`.`order_id`) AS `total_pedidos`,sum(`oi`.`price`) AS `receita_total`,sum((`oi`.`price` + `oi`.`freight_value`)) AS `receita_bruta`,round((sum(`oi`.`price`) / count(distinct `o`.`order_id`)),2) AS `ticket_medio`,rank() OVER (ORDER BY sum(`oi`.`price`) desc )  AS `ranking_receita` from (`olist_orders_dataset` `o` join `olist_order_items_dataset` `oi` on((`o`.`order_id` = `oi`.`order_id`))) group by `ano`,`mes` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_painel_vendas_detalhadas`
--

/*!50001 DROP VIEW IF EXISTS `vw_painel_vendas_detalhadas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_painel_vendas_detalhadas` AS select `o`.`order_id` AS `order_id`,`o`.`order_purchase_timestamp` AS `order_purchase_timestamp`,`pr`.`product_id` AS `product_id`,`pr`.`product_category_name` AS `product_category_name`,`oi`.`price` AS `price`,`oi`.`freight_value` AS `freight_value`,`pa`.`payment_type` AS `payment_type`,`pa`.`payment_value` AS `payment_value`,`c`.`customer_id` AS `customer_id`,`c`.`customer_state` AS `customer_state`,`s`.`seller_id` AS `seller_id`,`s`.`seller_state` AS `seller_state` from (((((`olist_orders_dataset` `o` join `olist_order_items_dataset` `oi` on((`o`.`order_id` = `oi`.`order_id`))) join `olist_products_dataset` `pr` on((`oi`.`product_id` = `pr`.`product_id`))) join `olist_customers_dataset` `c` on((`o`.`customer_id` = `c`.`customer_id`))) join `olist_sellers_dataset` `s` on((`oi`.`seller_id` = `s`.`seller_id`))) join `olist_order_payments_dataset` `pa` on((`o`.`order_id` = `pa`.`order_id`))) */;
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

-- Dump completed on 2025-11-04 17:05:24

-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: changde_trace
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `access_grant`
--

DROP TABLE IF EXISTS `access_grant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `access_grant` (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `grantor_org_id` bigint NOT NULL,
  `grantee_org_id` bigint NOT NULL,
  `field_scope` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `valid_from` datetime(6) NOT NULL,
  `valid_until` datetime(6) DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `fk_grant_batch` (`batch_id`),
  KEY `fk_grant_grantor` (`grantor_org_id`),
  KEY `fk_grant_grantee` (`grantee_org_id`),
  CONSTRAINT `fk_grant_batch` FOREIGN KEY (`batch_id`) REFERENCES `trace_batch` (`id`),
  CONSTRAINT `fk_grant_grantee` FOREIGN KEY (`grantee_org_id`) REFERENCES `organization` (`id`),
  CONSTRAINT `fk_grant_grantor` FOREIGN KEY (`grantor_org_id`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_grant`
--

LOCK TABLES `access_grant` WRITE;
/*!40000 ALTER TABLE `access_grant` DISABLE KEYS */;
/*!40000 ALTER TABLE `access_grant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `org_id` bigint DEFAULT NULL,
  `action` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `object_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `object_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `detail_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ip_address` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
INSERT INTO `audit_log` VALUES (53,11,8,'CREATE_BATCH','TRACE_BATCH','B-5F5F88B14FD949B0B074','{\"batchId\":\"B-5F5F88B14FD949B0B074\",\"batchNo\":\"YL-20261108104748-F38A\",\"batchType\":\"RAW_DUCK\",\"createdAt\":\"2026-11-08T10:47:48.869180200\",\"custodianOrgId\":\"8\",\"expiryDate\":\"\",\"lastEventId\":\"\",\"lastHash\":\"376a34485e27e34e61d5faf553d9e656cacf84778da098387e7434d174069be5\",\"ownerOrgId\":\"8\",\"parentBatchIds\":[],\"productName\":\"常德麻鸭\",\"productionDate\":\"2026-11-08\",\"quantity\":\"100\",\"spec\":\"活鸭，约2.5kg/只\",\"stage\":\"SOURCE\",\"status\":\"ACTIVE\",\"traceCode\":\"\",\"unit\":\"只\"}',NULL,'2026-11-08 10:47:50.977849'),(54,18,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-595A810DE1884A52B393','{\"batchId\":\"B-5F5F88B14FD949B0B074\",\"businessTime\":\"2026-11-08T02:48:37\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-595A810DE1884A52B393\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"常德市鼎城区1号麻鸭养殖场\",\"operatorUserId\":\"18\",\"prevEventId\":\"\",\"prevHash\":\"376a34485e27e34e61d5faf553d9e656cacf84778da098387e7434d174069be5\",\"processData\":{\"breedingBatchNo\":\"：YZ-20261107-01\",\"feedBatchNo\":\"SL-20261105-02\",\"healthStatus\":\"正常\",\"medicationRecord\":\"YY-20261101-03\",\"remark\":\"\",\"stockQuantity\":\"100\",\"vaccineRecord\":\"YM-20261020-01\",\"withdrawalPeriodEnd\":\"2026-11-08\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 10:49:16.017496'),(55,19,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-0E6C75AB0B984091A618','{\"batchId\":\"B-5F5F88B14FD949B0B074\",\"businessTime\":\"2026-11-08T02:53:52\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-0E6C75AB0B984091A618\",\"eventType\":\"QUALITY_CHECK\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"供应商内部质检室\",\"operatorUserId\":\"19\",\"prevEventId\":\"\",\"prevHash\":\"376a34485e27e34e61d5faf553d9e656cacf84778da098387e7434d174069be5\",\"processData\":{\"inspectionType\":\"工序抽检\",\"microbialResult\":\"PASS\",\"moisture\":\"68.5\",\"overallResult\":\"PASS\",\"remark\":\"\",\"sampleNo\":\"SUP-QC-20261107-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 10:54:44.962007'),(56,21,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-C6368B2E98284FB897D5','{\"batchId\":\"B-5F5F88B14FD949B0B074\",\"businessTime\":\"2026-11-08T02:55:14\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-C6368B2E98284FB897D5\",\"eventType\":\"QUARANTINE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"常德市动物检疫申报点\",\"operatorUserId\":\"21\",\"prevEventId\":\"\",\"prevHash\":\"376a34485e27e34e61d5faf553d9e656cacf84778da098387e7434d174069be5\",\"processData\":{\"issuerOrg\":\"常德市动物疫病预防控制中心\",\"quarantineCertNo\":\"JY-430700-20261107-001\",\"quarantineDate\":\"2026-11-08\",\"quarantineResult\":\"PASS\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"QUARANTINED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 10:55:34.391298'),(57,20,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-1A1B8A44F5AD42DBB6E5','{\"batchId\":\"B-5F5F88B14FD949B0B074\",\"businessTime\":\"2026-11-08T02:56:03\",\"carrierOrgId\":\"3\",\"discrepancyCode\":\"\",\"eventId\":\"E-1A1B8A44F5AD42DBB6E5\",\"eventType\":\"DISPATCH\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"yuanyuanyuan供应商发货区\",\"operatorUserId\":\"20\",\"prevEventId\":\"\",\"prevHash\":\"376a34485e27e34e61d5faf553d9e656cacf84778da098387e7434d174069be5\",\"processData\":{\"destination\":\"常德酱板鸭食品有限公司原料仓库\",\"sealNo\":\"SEAL-SUP-20261107-001\",\"temperature\":\"4\",\"vehicleRef\":\"湘JB1688\"},\"resultStatus\":\"DISPATCHED\",\"stage\":\"DISPATCHED\",\"targetOrgId\":\"2\"}',NULL,'2026-11-08 10:56:38.656872'),(58,17,8,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-595A810DE1884A52B393','{\"prevEventId\":\"\",\"prevHash\":\"376a34485e27e34e61d5faf553d9e656cacf84778da098387e7434d174069be5\"}',NULL,'2026-11-08 10:57:05.050382'),(59,17,8,'APPROVE_EVENT','TRACE_EVENT','E-595A810DE1884A52B393','{\"comment\":\"\"}',NULL,'2026-11-08 10:57:07.157752'),(60,17,8,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-0E6C75AB0B984091A618','{\"prevEventId\":\"E-595A810DE1884A52B393\",\"prevHash\":\"b5e7b8dbf87d8a218daea4f7776dc5ca205ad8187a335fe76844a7b1b63da419\"}',NULL,'2026-11-08 10:57:10.012174'),(61,17,8,'APPROVE_EVENT','TRACE_EVENT','E-0E6C75AB0B984091A618','{\"comment\":\"\"}',NULL,'2026-11-08 10:57:12.062294'),(62,17,8,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-C6368B2E98284FB897D5','{\"prevEventId\":\"E-0E6C75AB0B984091A618\",\"prevHash\":\"86679021e58b9c7793a3b5ff13c5ed6776387a272844ac7e37532c68f316be81\"}',NULL,'2026-11-08 10:57:14.853546'),(63,17,8,'APPROVE_EVENT','TRACE_EVENT','E-C6368B2E98284FB897D5','{\"comment\":\"\"}',NULL,'2026-11-08 10:57:16.902624'),(64,17,8,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-1A1B8A44F5AD42DBB6E5','{\"prevEventId\":\"E-C6368B2E98284FB897D5\",\"prevHash\":\"9496d94998c52f7e114b7940ecaa370806ab416daa8f5d17f12299e94d167964\"}',NULL,'2026-11-08 10:57:20.911272'),(65,17,8,'APPROVE_EVENT','TRACE_EVENT','E-1A1B8A44F5AD42DBB6E5','{\"comment\":\"\"}',NULL,'2026-11-08 10:57:22.964248'),(66,23,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-E06BBAB1A95A443E99CB','{\"batchId\":\"B-5F5F88B14FD949B0B074\",\"businessTime\":\"2026-11-08T02:57:37\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-E06BBAB1A95A443E99CB\",\"eventType\":\"RECEIVE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"加工企业原料收货区\",\"operatorUserId\":\"23\",\"prevEventId\":\"E-1A1B8A44F5AD42DBB6E5\",\"prevHash\":\"3e8b99c8314868762ec59f09a238ade434916a13ad7739451e4c675223ef2a99\",\"processData\":{\"discrepancyCode\":\"\",\"packageIntact\":\"是\",\"quantityReceived\":\"：100\",\"temperature\":\"4\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"RECEIVED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 10:57:59.711311'),(67,22,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-E06BBAB1A95A443E99CB','{\"prevEventId\":\"E-1A1B8A44F5AD42DBB6E5\",\"prevHash\":\"3e8b99c8314868762ec59f09a238ade434916a13ad7739451e4c675223ef2a99\"}',NULL,'2026-11-08 11:02:00.537137'),(68,22,2,'APPROVE_EVENT','TRACE_EVENT','E-E06BBAB1A95A443E99CB','{\"comment\":\"\"}',NULL,'2026-11-08 11:02:02.659124'),(69,22,2,'CREATE_BATCH','TRACE_BATCH','B-18CF4FC0976E4873BE62','{\"batchId\":\"B-18CF4FC0976E4873BE62\",\"batchNo\":\"CP-20261108110742-AD69\",\"batchType\":\"FINISHED\",\"createdAt\":\"2026-11-08T11:07:42.765691400\",\"custodianOrgId\":\"2\",\"expiryDate\":\"2026-11-14\",\"lastEventId\":\"\",\"lastHash\":\"599daf8cc00faf0e21b05d8092e033e2681bbcca94f836923c39f04304d54c25\",\"ownerOrgId\":\"2\",\"parentBatchIds\":[\"B-5F5F88B14FD949B0B074\"],\"productName\":\"常德酱板鸭\",\"productionDate\":\"2026-11-08\",\"quantity\":\"100\",\"spec\":\"600g/袋\",\"stage\":\"CREATED\",\"status\":\"ACTIVE\",\"traceCode\":\"CDJBY-20261108110742-9DC5B5\",\"unit\":\"袋\"}',NULL,'2026-11-08 11:07:44.845069');
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_party`
--

DROP TABLE IF EXISTS `batch_party`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `batch_party` (
  `batch_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint NOT NULL,
  `party_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `visible_scope` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'FULL',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`batch_id`,`org_id`,`party_type`),
  KEY `fk_party_org` (`org_id`),
  CONSTRAINT `fk_party_batch` FOREIGN KEY (`batch_id`) REFERENCES `trace_batch` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_party_org` FOREIGN KEY (`org_id`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_party`
--

LOCK TABLES `batch_party` WRITE;
/*!40000 ALTER TABLE `batch_party` DISABLE KEYS */;
INSERT INTO `batch_party` VALUES ('B-18CF4FC0976E4873BE62',2,'OWNER','FULL','2026-11-08 11:07:42.782409'),('B-5F5F88B14FD949B0B074',2,'RECEIVER','FULL','2026-11-08 10:57:22.949850'),('B-5F5F88B14FD949B0B074',3,'CARRIER','FULL','2026-11-08 10:57:22.950172'),('B-5F5F88B14FD949B0B074',8,'OWNER','FULL','2026-11-08 10:47:48.882855');
/*!40000 ALTER TABLE `batch_party` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_relation`
--

DROP TABLE IF EXISTS `batch_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `batch_relation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `parent_batch_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `child_batch_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `relation_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` decimal(16,3) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_relation` (`parent_batch_id`,`child_batch_id`),
  KEY `fk_rel_child` (`child_batch_id`),
  CONSTRAINT `fk_rel_child` FOREIGN KEY (`child_batch_id`) REFERENCES `trace_batch` (`id`),
  CONSTRAINT `fk_rel_parent` FOREIGN KEY (`parent_batch_id`) REFERENCES `trace_batch` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_relation`
--

LOCK TABLES `batch_relation` WRITE;
/*!40000 ALTER TABLE `batch_relation` DISABLE KEYS */;
INSERT INTO `batch_relation` VALUES (2,'B-5F5F88B14FD949B0B074','B-18CF4FC0976E4873BE62','MERGE',100.000,'2026-11-08 11:07:42.786859');
/*!40000 ALTER TABLE `batch_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumer_favorite`
--

DROP TABLE IF EXISTS `consumer_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consumer_favorite` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `consumer_id` bigint NOT NULL,
  `batch_id` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_consumer_favorite` (`consumer_id`,`batch_id`),
  KEY `fk_consumer_favorite_batch` (`batch_id`),
  CONSTRAINT `fk_consumer_favorite_batch` FOREIGN KEY (`batch_id`) REFERENCES `trace_batch` (`id`),
  CONSTRAINT `fk_consumer_favorite_user` FOREIGN KEY (`consumer_id`) REFERENCES `consumer_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumer_favorite`
--

LOCK TABLES `consumer_favorite` WRITE;
/*!40000 ALTER TABLE `consumer_favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `consumer_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumer_trace_history`
--

DROP TABLE IF EXISTS `consumer_trace_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consumer_trace_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `consumer_id` bigint NOT NULL,
  `batch_id` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trace_code` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `viewed_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_consumer_trace` (`consumer_id`,`batch_id`),
  KEY `fk_consumer_history_batch` (`batch_id`),
  CONSTRAINT `fk_consumer_history_batch` FOREIGN KEY (`batch_id`) REFERENCES `trace_batch` (`id`),
  CONSTRAINT `fk_consumer_history_user` FOREIGN KEY (`consumer_id`) REFERENCES `consumer_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumer_trace_history`
--

LOCK TABLES `consumer_trace_history` WRITE;
/*!40000 ALTER TABLE `consumer_trace_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `consumer_trace_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumer_user`
--

DROP TABLE IF EXISTS `consumer_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consumer_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nickname` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `region_code` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile_completed` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `last_login_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumer_user`
--

LOCK TABLES `consumer_user` WRITE;
/*!40000 ALTER TABLE `consumer_user` DISABLE KEYS */;
INSERT INTO `consumer_user` VALUES (4,'15347361610','$2a$10$ncrCDX4ggh/zRc84w.hgwOS4aTGCVoWvmxe3UnAfX4WvCXNwK.OM6','用户1610',NULL,NULL,0,1,'2026-11-07 10:07:27.311254','2026-11-01 10:55:42.804325','2026-11-08 10:35:09.728978'),(5,'18912345678','$2a$10$KGy6uDvoEJXQ/cg72Of9NeFgVtynfVtExh2CEWkRqHrglALK8W/WC','用户5678',NULL,NULL,0,1,'2026-11-07 14:49:47.411491','2026-11-07 12:29:18.233225','2026-11-08 10:35:09.728978');
/*!40000 ALTER TABLE `consumer_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custody_transfer`
--

DROP TABLE IF EXISTS `custody_transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custody_transfer` (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_org_id` bigint NOT NULL,
  `to_org_id` bigint NOT NULL,
  `carrier_org_id` bigint DEFAULT NULL,
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `outbound_at` datetime(6) DEFAULT NULL,
  `received_at` datetime(6) DEFAULT NULL,
  `discrepancy_code` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `fk_transfer_from` (`from_org_id`),
  KEY `fk_transfer_to` (`to_org_id`),
  KEY `fk_transfer_carrier` (`carrier_org_id`),
  KEY `idx_transfer_batch_status` (`batch_id`,`status`),
  CONSTRAINT `fk_transfer_batch` FOREIGN KEY (`batch_id`) REFERENCES `trace_batch` (`id`),
  CONSTRAINT `fk_transfer_carrier` FOREIGN KEY (`carrier_org_id`) REFERENCES `organization` (`id`),
  CONSTRAINT `fk_transfer_from` FOREIGN KEY (`from_org_id`) REFERENCES `organization` (`id`),
  CONSTRAINT `fk_transfer_to` FOREIGN KEY (`to_org_id`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custody_transfer`
--

LOCK TABLES `custody_transfer` WRITE;
/*!40000 ALTER TABLE `custody_transfer` DISABLE KEYS */;
INSERT INTO `custody_transfer` VALUES ('T-E232A799C0D841E18CB3','B-5F5F88B14FD949B0B074','E-E06BBAB1A95A443E99CB',8,2,3,'RECEIVED','2026-11-08 10:57:22.948626','2026-11-08 11:02:02.639415','','2026-11-08 10:57:22.949494');
/*!40000 ALTER TABLE `custody_transfer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_review`
--

DROP TABLE IF EXISTS `event_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_review` (
  `event_id` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `submitted_role_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `review_status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING_REVIEW',
  `reviewer_user_id` bigint DEFAULT NULL,
  `reviewed_at` datetime(6) DEFAULT NULL,
  `review_comment` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`event_id`),
  KEY `fk_review_user` (`reviewer_user_id`),
  CONSTRAINT `fk_review_event` FOREIGN KEY (`event_id`) REFERENCES `trace_event` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_review_user` FOREIGN KEY (`reviewer_user_id`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_review`
--

LOCK TABLES `event_review` WRITE;
/*!40000 ALTER TABLE `event_review` DISABLE KEYS */;
INSERT INTO `event_review` VALUES ('E-0E6C75AB0B984091A618','SUPPLIER_QA','APPROVED',17,'2026-11-08 10:57:12.056237','','2026-11-08 10:54:44.956602'),('E-1A1B8A44F5AD42DBB6E5','SUPPLIER_SHIPPER','APPROVED',17,'2026-11-08 10:57:22.950450','','2026-11-08 10:56:38.651564'),('E-595A810DE1884A52B393','SUPPLIER_BREEDER','APPROVED',17,'2026-11-08 10:57:07.151004','','2026-11-08 10:49:16.011874'),('E-C6368B2E98284FB897D5','SUPPLIER_OPERATOR','APPROVED',17,'2026-11-08 10:57:16.895842','','2026-11-08 10:55:34.386489'),('E-E06BBAB1A95A443E99CB','PROCESSOR_OPERATOR','APPROVED',22,'2026-11-08 11:02:02.653038','','2026-11-08 10:57:59.704850');
/*!40000 ALTER TABLE `event_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evidence`
--

DROP TABLE IF EXISTS `evidence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evidence` (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uploaded_by` bigint NOT NULL,
  `object_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_size` bigint NOT NULL,
  `sha256` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `fk_evidence_event` (`event_id`),
  KEY `fk_evidence_user` (`uploaded_by`),
  KEY `idx_evidence_batch` (`batch_id`),
  CONSTRAINT `fk_evidence_batch` FOREIGN KEY (`batch_id`) REFERENCES `trace_batch` (`id`),
  CONSTRAINT `fk_evidence_event` FOREIGN KEY (`event_id`) REFERENCES `trace_event` (`id`),
  CONSTRAINT `fk_evidence_user` FOREIGN KEY (`uploaded_by`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evidence`
--

LOCK TABLES `evidence` WRITE;
/*!40000 ALTER TABLE `evidence` DISABLE KEYS */;
/*!40000 ALTER TABLE `evidence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inspection_record`
--

DROP TABLE IF EXISTS `inspection_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inspection_record` (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `inspection_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sample_no` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `indicators_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `overall_result` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `report_no` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `report_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `issued_by` bigint NOT NULL,
  `issued_at` datetime(6) NOT NULL,
  `decision` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `fk_inspection_batch` (`batch_id`),
  KEY `fk_inspection_event` (`event_id`),
  KEY `fk_inspection_org` (`issued_by`),
  CONSTRAINT `fk_inspection_batch` FOREIGN KEY (`batch_id`) REFERENCES `trace_batch` (`id`),
  CONSTRAINT `fk_inspection_event` FOREIGN KEY (`event_id`) REFERENCES `trace_event` (`id`),
  CONSTRAINT `fk_inspection_org` FOREIGN KEY (`issued_by`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inspection_record`
--

LOCK TABLES `inspection_record` WRITE;
/*!40000 ALTER TABLE `inspection_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `inspection_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organization` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `org_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `region_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `msp_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `org_code` (`org_code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (1,'SUP001','常德金鸭养殖基地','SUPPLIER','430700','SupplierMSP','ACTIVE','2026-11-01 00:14:27.710112'),(2,'PRO001','常德酱板鸭食品有限公司','PROCESSOR','430700','ProcessorMSP','ACTIVE','2026-11-01 00:14:27.710112'),(3,'LOG001','沅水冷链物流有限公司','LOGISTICS','430700','LogisticsMSP','ACTIVE','2026-11-01 00:14:27.710112'),(4,'RET001','常德老街特产店','RETAILER','430700','RetailerMSP','ACTIVE','2026-11-01 00:14:27.710112'),(5,'REG001','常德市市场监督管理局','REGULATOR','430700','SupplierMSP','ACTIVE','2026-11-01 00:14:27.710112'),(6,'PLATFORM001','溯源平台管理中心','ADMIN','430700','SupplierMSP','ACTIVE','2026-11-01 00:14:27.710112'),(8,'SUP003','yuanyuanyuan供应商','SUPPLIER','430700','SupplierMSP','ACTIVE','2026-11-01 10:22:17.035944');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_code` (`role_code`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'SUPPLIER_OPERATOR','原料供应商操作员'),(2,'PROCESSOR_OPERATOR','生产加工操作员'),(3,'PROCESSOR_QA','生产质检员'),(4,'LOGISTICS_OPERATOR','物流操作员'),(5,'RETAILER_OPERATOR','销售商操作员'),(6,'REGULATOR','监管人员'),(7,'PLATFORM_ADMIN','平台管理员'),(8,'ORG_MANAGER','企业管理员'),(9,'SUPPLIER_BREEDER','养殖记录员'),(10,'SUPPLIER_QA','供应商内部质检员'),(11,'SUPPLIER_SHIPPER','仓储发货员'),(12,'PROCESSOR_WAREHOUSE','加工仓储员'),(13,'LOGISTICS_DISPATCHER','物流调度员'),(14,'LOGISTICS_DRIVER','运输员'),(15,'RETAIL_RECEIVER','门店收货员'),(16,'RETAIL_SALESPERSON','门店销售员'),(17,'REGULATOR_INSPECTOR','监管抽检员');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `fk_user_org` (`org_id`),
  CONSTRAINT `fk_user_org` FOREIGN KEY (`org_id`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'legacy_supplier','$2a$10$Not078x8lQmStLyHfAW6x.uhwIy4rQfw/O5sOUX6VUFLwSFZRDGHa','历史审计账号-supplier',1,0,'2026-11-01 00:14:29.488742'),(2,'legacy_processor','$2a$10$qmO6jKMb2k1cZf6BcMBMVuKJRA.6/8WwYu5GUYSpU1QOQrvWbYn7u','历史审计账号-processor',2,0,'2026-11-01 00:14:29.559243'),(3,'legacy_quality','$2a$10$XkeRat2b.d4zl74w3sYppe0zQRSRe93dyxTfeyPCyr683ZS8ydx9m','历史审计账号-quality',2,0,'2026-11-01 00:14:29.630130'),(4,'legacy_logistics','$2a$10$jwDk/b0OdpZY0vgCwG4B9Oq7N/DNCiwAaIDtHxTZpG9iklw3WyTla','历史审计账号-logistics',3,0,'2026-11-01 00:14:29.700493'),(5,'legacy_retailer','$2a$10$OrzsYvsv1ea0yHrTqIAk7OINsLib6kHkTg4ieAerw8KJYtHi5mLsu','历史审计账号-retailer',4,0,'2026-11-01 00:14:29.771165'),(6,'legacy_regulator','$2a$10$S1pV0VtnZykWEu.im0aWLOo4I0qp.ZMBuDb3qjBu710BR5oS4E0Gm','历史审计账号-regulator',5,0,'2026-11-01 00:14:29.846472'),(7,'legacy_admin','$2a$10$9oz.5PoGUtPp1tGZlgy7pOcth0eSB3LuaN98VAhLYE6GM2zGEX0l6','历史审计账号-admin',6,0,'2026-11-01 00:14:29.925112'),(8,'admin','$2a$10$GqJ5gHG7KzXgvARyNFoTOOMeykWvypwVoA30CWsSyO6YQqWqcmb6.','平台管理员',6,1,'2026-11-01 10:00:58.167706'),(11,'15347361610','$2a$10$3LW1wVUbDReOZEeAWeJqheoS5pjnYl76.HUTeTVvzXan2lEyZktfi','袁文平',8,1,'2026-11-01 10:22:17.111204'),(15,'19958162153','$2a$10$M8wznaeEU5Q4nSv7yp/AWuR7ciqX9NVTOX/8mFSvx3ISjBbpXlyUO','yanyy',8,1,'2026-11-01 10:57:17.508632'),(17,'13910000001','$2a$10$haTSsWWxCRLgOLMMrqLj6ercXlJHlXFwjbfpOT9mcoUxCUEBtzKa6','张三',8,1,'2026-11-01 11:21:21.446747'),(18,'13910000002','$2a$10$0zAiVlpFSjre6naqLLIVqeJgWtpXZuhNqwI7V6NiPVU6HWZ0o9I6u','李四',8,1,'2026-11-01 11:21:21.540022'),(19,'13910000003','$2a$10$WdIm7U9k65vZi7uUBSGJe..gVx8Y98h1exZYk2A1uXblXBG7bLtBG','王五',8,1,'2026-11-01 11:21:21.613139'),(20,'13910000004','$2a$10$pEeh5UhYsAOnUycZodMWHO5FXacVysqsFHwNnEnPL/Z.NBRnd4VzC','赵六',8,1,'2026-11-01 11:21:21.688756'),(21,'13910000005','$2a$10$6AO3S9PR0rR.ghIX9ML7d.DDchpsLYxpXfM.CZGoRV21yrPQVOXbK','陈七',8,1,'2026-11-01 11:21:21.761510'),(22,'13920000001','$2a$10$4GxzE7Bxb4sCl2t15lxQyeuj66GuqWxTZRB269CvkDuzrvuPgpSsi','刘洋',2,1,'2026-11-01 11:21:21.837100'),(23,'13920000002','$2a$10$IFO4GOxlyMTIjfoU.T8zXe.62BOhSJMe5kRvun2vRIsuuTbAj0vHC','周强',2,1,'2026-11-01 11:21:21.912602'),(24,'13920000003','$2a$10$awFb4qbdOjrAlK6dpl2Yserf1R8OZ5MqI0c1ml.kQJLOUiWFnU6ey','吴敏',2,1,'2026-11-01 11:21:21.984776'),(25,'13920000004','$2a$10$Lr4MlrQHSwDwSIRdK.lpieEBM7XxTTTrwGakrFA7SrZ6eHZOfEmnG','郑伟',2,1,'2026-11-01 11:21:22.059789'),(26,'13930000001','$2a$10$ahPiHSXie0GnAmt69j1zle9hlT.UkfN3yTFN1/MWaI3wNJ.VeHDTa','孙磊',3,1,'2026-11-01 11:21:22.132350'),(27,'13930000002','$2a$10$5quS6KGNpkzmzJxVYiecXOaNrw4LhrFsLDR48pOPh9VyycvhIaA7e','何静',3,1,'2026-11-01 11:21:22.205894'),(28,'13930000003','$2a$10$v3IZe8eHBpW3q9MJW0HvkucgTV2InyivoJ1izx60IDmGrDG/txcby','林涛',3,1,'2026-11-01 11:21:22.277240'),(29,'13940000001','$2a$10$aHTomcHsoeWGqU4X0U55Beln.2at2SHIYznh6WiCFd235nwv6Wrdy','徐丽',4,1,'2026-11-01 11:21:22.351307'),(30,'13940000002','$2a$10$TlxzX93lJMny8V1rJyS1zu4KW/vfLLyj9dGjK.vff47WdSwJEBf4W','马超',4,1,'2026-11-01 11:21:22.424046'),(31,'13940000003','$2a$10$z5EBQAGizqY0RZ3/WK7NCuBw71qfzE6kcnFFcAsFhO6hFBKHEamJ2','朱琳',4,1,'2026-11-01 11:21:22.496112'),(32,'13950000001','$2a$10$HHj2qWNNxk91CJp18i39B.GDZAipg.hMlOxS7ayO0wvggMkzn1gcG','高峰',5,1,'2026-11-01 11:21:22.577613'),(33,'13950000002','$2a$10$al9UUPCNbAT5jwgxxBXLhOTz2InMoZBGvwmADMCbNTNt6vFLPED6q','罗敏',5,1,'2026-11-01 11:21:22.655479'),(34,'platform_admin','$2a$10$nKSMvwI9M413fohzueCckexJMM1XEN0YBMQBIqG6GD4W8.6MnIdmu','平台管理员',6,0,'2026-11-08 10:14:45.866307');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `fk_ur_role` (`role_id`),
  CONSTRAINT `fk_ur_role` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ur_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(11,1),(15,1),(17,1),(21,1),(2,2),(22,2),(23,2),(3,3),(24,3),(4,4),(26,4),(5,5),(29,5),(6,6),(32,6),(7,7),(8,7),(34,7),(11,8),(17,8),(22,8),(26,8),(29,8),(32,8),(18,9),(19,10),(20,11),(25,12),(27,13),(28,14),(30,15),(31,16),(33,17);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trace_batch`
--

DROP TABLE IF EXISTS `trace_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trace_batch` (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch_no` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `trace_code` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `batch_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_org_id` bigint NOT NULL,
  `custodian_org_id` bigint NOT NULL,
  `product_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `spec` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` decimal(16,3) NOT NULL DEFAULT '0.000',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'kg',
  `current_stage` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `production_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `last_event_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `chain_status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `tx_id` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `batch_no` (`batch_no`),
  UNIQUE KEY `trace_code` (`trace_code`),
  KEY `fk_batch_owner` (`owner_org_id`),
  KEY `fk_batch_custodian` (`custodian_org_id`),
  KEY `fk_batch_user` (`created_by`),
  KEY `idx_batch_status` (`status`),
  KEY `idx_batch_stage` (`current_stage`),
  KEY `idx_batch_created` (`created_at`),
  CONSTRAINT `fk_batch_custodian` FOREIGN KEY (`custodian_org_id`) REFERENCES `organization` (`id`),
  CONSTRAINT `fk_batch_owner` FOREIGN KEY (`owner_org_id`) REFERENCES `organization` (`id`),
  CONSTRAINT `fk_batch_user` FOREIGN KEY (`created_by`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trace_batch`
--

LOCK TABLES `trace_batch` WRITE;
/*!40000 ALTER TABLE `trace_batch` DISABLE KEYS */;
INSERT INTO `trace_batch` VALUES ('B-18CF4FC0976E4873BE62','CP-20261108110742-AD69','CDJBY-20261108110742-9DC5B5','FINISHED',2,2,'常德酱板鸭','600g/袋',100.000,'袋','CREATED','ACTIVE','2026-11-08','2026-11-14',NULL,'599daf8cc00faf0e21b05d8092e033e2681bbcca94f836923c39f04304d54c25','COMMITTED','5cf8d0953da401345a0603ae75790ac9306d9a83aaa0b8eec205906c0007e3f4',22,'2026-11-08 11:07:42.767192','2026-11-08 11:07:44.829277'),('B-5F5F88B14FD949B0B074','YL-20261108104748-F38A',NULL,'RAW_DUCK',8,2,'常德麻鸭','活鸭，约2.5kg/只',100.000,'只','RECEIVED','ACTIVE','2026-11-08',NULL,'E-E06BBAB1A95A443E99CB','20342caeccb9996def1a14e71bddd12f97065dc9384039709c9af1ac96b61f1c','COMMITTED','3c834cbbe11f0c75309f7241c90a932efc32e5896401e286beabe7b579175ecc',11,'2026-11-08 10:47:48.876769','2026-11-08 11:02:02.652188');
/*!40000 ALTER TABLE `trace_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trace_event`
--

DROP TABLE IF EXISTS `trace_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trace_event` (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_type` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stage` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `result_status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `issuer_org_id` bigint NOT NULL,
  `operator_user_id` bigint NOT NULL,
  `business_time` datetime(6) NOT NULL,
  `location_code` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `evidence_root` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prev_event_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prev_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `chain_status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `tx_id` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `block_number` bigint DEFAULT NULL,
  `chain_error` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correction_of` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `request_id` (`request_id`),
  KEY `fk_event_org` (`issuer_org_id`),
  KEY `fk_event_user` (`operator_user_id`),
  KEY `idx_event_batch_time` (`batch_id`,`business_time`),
  CONSTRAINT `fk_event_batch` FOREIGN KEY (`batch_id`) REFERENCES `trace_batch` (`id`),
  CONSTRAINT `fk_event_org` FOREIGN KEY (`issuer_org_id`) REFERENCES `organization` (`id`),
  CONSTRAINT `fk_event_user` FOREIGN KEY (`operator_user_id`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trace_event`
--

LOCK TABLES `trace_event` WRITE;
/*!40000 ALTER TABLE `trace_event` DISABLE KEYS */;
INSERT INTO `trace_event` VALUES ('E-0E6C75AB0B984091A618','B-5F5F88B14FD949B0B074','QUALITY_CHECK','SOURCE','ACTIVE',8,19,'2026-11-08 02:53:52.000000','供应商内部质检室','{\"batchId\":\"B-5F5F88B14FD949B0B074\",\"businessTime\":\"2026-11-08T02:53:52\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-0E6C75AB0B984091A618\",\"eventType\":\"QUALITY_CHECK\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"供应商内部质检室\",\"operatorUserId\":\"19\",\"prevEventId\":\"E-595A810DE1884A52B393\",\"prevHash\":\"b5e7b8dbf87d8a218daea4f7776dc5ca205ad8187a335fe76844a7b1b63da419\",\"processData\":{\"inspectionType\":\"工序抽检\",\"microbialResult\":\"PASS\",\"moisture\":\"68.5\",\"overallResult\":\"PASS\",\"remark\":\"\",\"sampleNo\":\"SUP-QC-20261107-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}','86679021e58b9c7793a3b5ff13c5ed6776387a272844ac7e37532c68f316be81',NULL,'E-595A810DE1884A52B393','b5e7b8dbf87d8a218daea4f7776dc5ca205ad8187a335fe76844a7b1b63da419','0a26efce-ef1a-4314-a71d-43cf22854758','COMMITTED','7ac0349aaa631fa7b2a2f8e7747390cfc8f1c4f516ce126121ed8fe6e797788f',12,NULL,NULL,'2026-11-08 10:54:44.940013'),('E-1A1B8A44F5AD42DBB6E5','B-5F5F88B14FD949B0B074','DISPATCH','DISPATCHED','DISPATCHED',8,20,'2026-11-08 02:56:03.000000','yuanyuanyuan供应商发货区','{\"batchId\":\"B-5F5F88B14FD949B0B074\",\"businessTime\":\"2026-11-08T02:56:03\",\"carrierOrgId\":\"3\",\"discrepancyCode\":\"\",\"eventId\":\"E-1A1B8A44F5AD42DBB6E5\",\"eventType\":\"DISPATCH\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"yuanyuanyuan供应商发货区\",\"operatorUserId\":\"20\",\"prevEventId\":\"E-C6368B2E98284FB897D5\",\"prevHash\":\"9496d94998c52f7e114b7940ecaa370806ab416daa8f5d17f12299e94d167964\",\"processData\":{\"destination\":\"常德酱板鸭食品有限公司原料仓库\",\"sealNo\":\"SEAL-SUP-20261107-001\",\"temperature\":\"4\",\"vehicleRef\":\"湘JB1688\"},\"resultStatus\":\"DISPATCHED\",\"stage\":\"DISPATCHED\",\"targetOrgId\":\"2\"}','3e8b99c8314868762ec59f09a238ade434916a13ad7739451e4c675223ef2a99',NULL,'E-C6368B2E98284FB897D5','9496d94998c52f7e114b7940ecaa370806ab416daa8f5d17f12299e94d167964','6e1373a5-33a2-4877-8fb7-c697121079fe','COMMITTED','7553b7b0d4e148221b4142722545fea59afa766d2d836280e293d5c4893a1e6a',14,NULL,NULL,'2026-11-08 10:56:38.634412'),('E-595A810DE1884A52B393','B-5F5F88B14FD949B0B074','BREEDING_RECORD','SOURCE','ACTIVE',8,18,'2026-11-08 02:48:37.000000','常德市鼎城区1号麻鸭养殖场','{\"batchId\":\"B-5F5F88B14FD949B0B074\",\"businessTime\":\"2026-11-08T02:48:37\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-595A810DE1884A52B393\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"常德市鼎城区1号麻鸭养殖场\",\"operatorUserId\":\"18\",\"prevEventId\":\"\",\"prevHash\":\"376a34485e27e34e61d5faf553d9e656cacf84778da098387e7434d174069be5\",\"processData\":{\"breedingBatchNo\":\"：YZ-20261107-01\",\"feedBatchNo\":\"SL-20261105-02\",\"healthStatus\":\"正常\",\"medicationRecord\":\"YY-20261101-03\",\"remark\":\"\",\"stockQuantity\":\"100\",\"vaccineRecord\":\"YM-20261020-01\",\"withdrawalPeriodEnd\":\"2026-11-08\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}','b5e7b8dbf87d8a218daea4f7776dc5ca205ad8187a335fe76844a7b1b63da419',NULL,NULL,'376a34485e27e34e61d5faf553d9e656cacf84778da098387e7434d174069be5','4f0faa1c-6ee8-4f35-83de-52fd4e26b623','COMMITTED','e106cb44771fa91b9df3335792378335efb4113f98aa620d71a7db2514e3d859',11,NULL,NULL,'2026-11-08 10:49:16.006253'),('E-C6368B2E98284FB897D5','B-5F5F88B14FD949B0B074','QUARANTINE','QUARANTINED','ACTIVE',8,21,'2026-11-08 02:55:14.000000','常德市动物检疫申报点','{\"batchId\":\"B-5F5F88B14FD949B0B074\",\"businessTime\":\"2026-11-08T02:55:14\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-C6368B2E98284FB897D5\",\"eventType\":\"QUARANTINE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"常德市动物检疫申报点\",\"operatorUserId\":\"21\",\"prevEventId\":\"E-0E6C75AB0B984091A618\",\"prevHash\":\"86679021e58b9c7793a3b5ff13c5ed6776387a272844ac7e37532c68f316be81\",\"processData\":{\"issuerOrg\":\"常德市动物疫病预防控制中心\",\"quarantineCertNo\":\"JY-430700-20261107-001\",\"quarantineDate\":\"2026-11-08\",\"quarantineResult\":\"PASS\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"QUARANTINED\",\"targetOrgId\":\"\"}','9496d94998c52f7e114b7940ecaa370806ab416daa8f5d17f12299e94d167964',NULL,'E-0E6C75AB0B984091A618','86679021e58b9c7793a3b5ff13c5ed6776387a272844ac7e37532c68f316be81','081bb64f-f371-4791-b1fc-582e8a065eb8','COMMITTED','4ce51d3e7bc9a20d190f9237ca3e6ed20ea82b25f280b098300a9a082f33446b',13,NULL,NULL,'2026-11-08 10:55:34.371629'),('E-E06BBAB1A95A443E99CB','B-5F5F88B14FD949B0B074','RECEIVE','RECEIVED','ACTIVE',2,23,'2026-11-08 02:57:37.000000','加工企业原料收货区','{\"batchId\":\"B-5F5F88B14FD949B0B074\",\"businessTime\":\"2026-11-08T02:57:37\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-E06BBAB1A95A443E99CB\",\"eventType\":\"RECEIVE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"加工企业原料收货区\",\"operatorUserId\":\"23\",\"prevEventId\":\"E-1A1B8A44F5AD42DBB6E5\",\"prevHash\":\"3e8b99c8314868762ec59f09a238ade434916a13ad7739451e4c675223ef2a99\",\"processData\":{\"discrepancyCode\":\"\",\"packageIntact\":\"是\",\"quantityReceived\":\"：100\",\"temperature\":\"4\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"RECEIVED\",\"targetOrgId\":\"\"}','20342caeccb9996def1a14e71bddd12f97065dc9384039709c9af1ac96b61f1c',NULL,'E-1A1B8A44F5AD42DBB6E5','3e8b99c8314868762ec59f09a238ade434916a13ad7739451e4c675223ef2a99','b4f7d359-29cc-4d32-9a85-05514d3f5658','COMMITTED','3c834cbbe11f0c75309f7241c90a932efc32e5896401e286beabe7b579175ecc',15,NULL,NULL,'2026-11-08 10:57:59.699149');
/*!40000 ALTER TABLE `trace_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'changde_trace'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-08 11:13:35

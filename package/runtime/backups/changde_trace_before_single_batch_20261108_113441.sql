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
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
INSERT INTO `audit_log` VALUES (70,39,8,'CREATE_BATCH','TRACE_BATCH','B-D584BC5A5AA54C5291CF','{\"batchId\":\"B-D584BC5A5AA54C5291CF\",\"batchNo\":\"YL-20261108111732-807D\",\"batchType\":\"RAW_DUCK\",\"createdAt\":\"2026-11-08T11:17:32.963489600\",\"custodianOrgId\":\"8\",\"expiryDate\":\"\",\"lastEventId\":\"\",\"lastHash\":\"16d973d7d5e8adec4bfc4288cfe22e90e10049f0adfd416c972ca07490cbf04a\",\"ownerOrgId\":\"8\",\"parentBatchIds\":[],\"productName\":\"常德麻鸭\",\"productionDate\":\"2026-11-08\",\"quantity\":\"100\",\"spec\":\"活鸭，约2.5kg/只\",\"stage\":\"SOURCE\",\"status\":\"ACTIVE\",\"traceCode\":\"\",\"unit\":\"只\"}',NULL,'2026-11-08 11:17:36.791988'),(71,36,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-4BDDE4AB6BE7407AA87F','{\"batchId\":\"B-D584BC5A5AA54C5291CF\",\"businessTime\":\"2026-11-08T08:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-4BDDE4AB6BE7407AA87F\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"常德市鼎城区1号麻鸭养殖场\",\"operatorUserId\":\"36\",\"prevEventId\":\"\",\"prevHash\":\"16d973d7d5e8adec4bfc4288cfe22e90e10049f0adfd416c972ca07490cbf04a\",\"processData\":{\"breedingBatchNo\":\"YZ-20261108-01\",\"feedBatchNo\":\"SL-20261106-02\",\"healthStatus\":\"正常\",\"medicationRecord\":\"YY-20261101-03\",\"remark\":\"养殖周期120天，鸭群健康，休药期已结束\",\"stockQuantity\":\"100\",\"vaccineRecord\":\"YM-20261020-01\",\"withdrawalPeriodEnd\":\"2026-11-06\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:17:36.866624'),(72,37,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-87D486CFF6DD4EC3AC0E','{\"batchId\":\"B-D584BC5A5AA54C5291CF\",\"businessTime\":\"2026-11-08T08:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-87D486CFF6DD4EC3AC0E\",\"eventType\":\"QUALITY_CHECK\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"供应商内部质检室\",\"operatorUserId\":\"37\",\"prevEventId\":\"\",\"prevHash\":\"16d973d7d5e8adec4bfc4288cfe22e90e10049f0adfd416c972ca07490cbf04a\",\"processData\":{\"inspectionType\":\"工序抽检\",\"microbialResult\":\"PASS\",\"moisture\":\"68.5\",\"overallResult\":\"PASS\",\"remark\":\"感官正常，微生物指标符合要求\",\"sampleNo\":\"SUP-QC-20261108-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:17:36.909647'),(73,39,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-5FA896BA43C4405FABDA','{\"batchId\":\"B-D584BC5A5AA54C5291CF\",\"businessTime\":\"2026-11-08T09:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-5FA896BA43C4405FABDA\",\"eventType\":\"QUARANTINE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"常德市动物检疫申报点\",\"operatorUserId\":\"39\",\"prevEventId\":\"\",\"prevHash\":\"16d973d7d5e8adec4bfc4288cfe22e90e10049f0adfd416c972ca07490cbf04a\",\"processData\":{\"issuerOrg\":\"常德市动物疫病预防控制中心\",\"quarantineCertNo\":\"JY-430700-20261108-001\",\"quarantineDate\":\"2026-11-08\",\"quarantineResult\":\"PASS\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"QUARANTINED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:17:36.937534'),(74,35,8,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-4BDDE4AB6BE7407AA87F','{\"prevEventId\":\"\",\"prevHash\":\"16d973d7d5e8adec4bfc4288cfe22e90e10049f0adfd416c972ca07490cbf04a\"}',NULL,'2026-11-08 11:17:36.965521'),(75,35,8,'APPROVE_EVENT','TRACE_EVENT','E-4BDDE4AB6BE7407AA87F','{\"comment\":\"供应商三类记录统一审核通过\"}',NULL,'2026-11-08 11:17:39.033640'),(76,35,8,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-87D486CFF6DD4EC3AC0E','{\"prevEventId\":\"E-4BDDE4AB6BE7407AA87F\",\"prevHash\":\"487fefb18f2b416d4cf07712d906d7a40fb194b3a0402f377d11726b06e6c16d\"}',NULL,'2026-11-08 11:17:39.050695'),(77,35,8,'APPROVE_EVENT','TRACE_EVENT','E-87D486CFF6DD4EC3AC0E','{\"comment\":\"供应商三类记录统一审核通过\"}',NULL,'2026-11-08 11:17:41.102764'),(78,35,8,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-5FA896BA43C4405FABDA','{\"prevEventId\":\"E-87D486CFF6DD4EC3AC0E\",\"prevHash\":\"e03f6be24a41f52fb3906697114b84ec5f5485388d3bfabe05a316b5f3255036\"}',NULL,'2026-11-08 11:17:41.118058'),(79,35,8,'APPROVE_EVENT','TRACE_EVENT','E-5FA896BA43C4405FABDA','{\"comment\":\"供应商三类记录统一审核通过\"}',NULL,'2026-11-08 11:17:43.179244'),(80,38,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-C3B6BE45E07D4EA5BBF3','{\"batchId\":\"B-D584BC5A5AA54C5291CF\",\"businessTime\":\"2026-11-08T09:30\",\"carrierOrgId\":\"3\",\"discrepancyCode\":\"\",\"eventId\":\"E-C3B6BE45E07D4EA5BBF3\",\"eventType\":\"DISPATCH\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"供应商发货区\",\"operatorUserId\":\"38\",\"prevEventId\":\"E-5FA896BA43C4405FABDA\",\"prevHash\":\"1ca2f51943e450c2f96cfcec569aa21494dd5e128bc60bd7d96456143b6d15c5\",\"processData\":{\"destination\":\"常德酱板鸭食品有限公司原料仓库\",\"sealNo\":\"SEAL-SUP-20261108-001\",\"temperature\":\"4\",\"vehicleRef\":\"湘JB1688\"},\"resultStatus\":\"DISPATCHED\",\"stage\":\"DISPATCHED\",\"targetOrgId\":\"2\"}',NULL,'2026-11-08 11:17:43.212740'),(81,35,8,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-C3B6BE45E07D4EA5BBF3','{\"prevEventId\":\"E-5FA896BA43C4405FABDA\",\"prevHash\":\"1ca2f51943e450c2f96cfcec569aa21494dd5e128bc60bd7d96456143b6d15c5\"}',NULL,'2026-11-08 11:17:43.234453'),(82,35,8,'APPROVE_EVENT','TRACE_EVENT','E-C3B6BE45E07D4EA5BBF3','{\"comment\":\"供应商发货审核通过\"}',NULL,'2026-11-08 11:17:45.291552'),(83,41,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-546B7DDF767E4FF5B1A4','{\"batchId\":\"B-D584BC5A5AA54C5291CF\",\"businessTime\":\"2026-11-08T10:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-546B7DDF767E4FF5B1A4\",\"eventType\":\"RECEIVE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"加工企业原料收货区\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-C3B6BE45E07D4EA5BBF3\",\"prevHash\":\"7eb5d2270606a9b71571414cf6b99ad741b236b1e6c1a159f39939ac8edbf9db\",\"processData\":{\"discrepancyCode\":\"\",\"packageIntact\":\"是\",\"quantityReceived\":\"100\",\"temperature\":\"4\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"RECEIVED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:17:45.321790'),(84,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-546B7DDF767E4FF5B1A4','{\"prevEventId\":\"E-C3B6BE45E07D4EA5BBF3\",\"prevHash\":\"7eb5d2270606a9b71571414cf6b99ad741b236b1e6c1a159f39939ac8edbf9db\"}',NULL,'2026-11-08 11:17:45.337380'),(85,40,2,'APPROVE_EVENT','TRACE_EVENT','E-546B7DDF767E4FF5B1A4','{\"comment\":\"加工企业收货审核通过\"}',NULL,'2026-11-08 11:17:47.522347'),(86,41,2,'CREATE_BATCH','TRACE_BATCH','B-C5BB618A6E6342F4A6D7','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"batchNo\":\"CP-20261108111747-62EA\",\"batchType\":\"FINISHED\",\"createdAt\":\"2026-11-08T11:17:47.539790\",\"custodianOrgId\":\"2\",\"expiryDate\":\"2027-05-08\",\"lastEventId\":\"\",\"lastHash\":\"3b68b6a6e80f04d3cac6e8442c78099b8df5c305b856196ed3a54f695422ce6a\",\"ownerOrgId\":\"2\",\"parentBatchIds\":[\"B-D584BC5A5AA54C5291CF\"],\"productName\":\"常德酱板鸭\",\"productionDate\":\"2026-11-08\",\"quantity\":\"100\",\"spec\":\"600g/袋\",\"stage\":\"CREATED\",\"status\":\"ACTIVE\",\"traceCode\":\"CDJBY-20261108111747-E6C62F\",\"unit\":\"袋\"}',NULL,'2026-11-08 11:17:49.597391'),(87,41,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-C5E8443572734B60B4ED','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T10:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-C5E8443572734B60B4ED\",\"eventType\":\"SLAUGHTER\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司屠宰车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"\",\"prevHash\":\"3b68b6a6e80f04d3cac6e8442c78099b8df5c305b856196ed3a54f695422ce6a\",\"processData\":{\"brineTemperature\":\"4\",\"carcassWeight\":\"180\",\"liveWeight\":\"250\",\"marinadeDurationMin\":\"240\",\"marinadeEndAt\":\"2026-11-08T15:00:00\",\"marinadeStartAt\":\"2026-11-08T11:00:00\",\"preSlaughterQuarantineResult\":\"PASS\",\"saltBatchNo\":\"SY-20261106-01\",\"slaughterhouseId\":\"CZDY-SL-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SLAUGHTERED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:17:49.628219'),(88,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-C5E8443572734B60B4ED','{\"prevEventId\":\"\",\"prevHash\":\"3b68b6a6e80f04d3cac6e8442c78099b8df5c305b856196ed3a54f695422ce6a\"}',NULL,'2026-11-08 11:17:49.644309'),(89,40,2,'APPROVE_EVENT','TRACE_EVENT','E-C5E8443572734B60B4ED','{\"comment\":\"屠宰记录审核通过\"}',NULL,'2026-11-08 11:17:51.707939'),(90,41,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-427F6062552748F1A6CE','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T15:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-427F6062552748F1A6CE\",\"eventType\":\"MARINATE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"一号腌制车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-C5E8443572734B60B4ED\",\"prevHash\":\"c3cde6e4f2e5181ef09245b804a2a49b8f9276c21200cc0ff1fa705b2e2df213\",\"processData\":{\"durationMin\":\"240\",\"endAt\":\"2026-11-08T15:00:00\",\"equipmentId\":\"YAN-01\",\"saltBatchNo\":\"SY-20261106-01\",\"sensorFileHash\":\"\",\"startAt\":\"2026-11-08T11:00:00\",\"temperature\":\"4\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"MARINATED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:17:51.753692'),(91,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-427F6062552748F1A6CE','{\"prevEventId\":\"E-C5E8443572734B60B4ED\",\"prevHash\":\"c3cde6e4f2e5181ef09245b804a2a49b8f9276c21200cc0ff1fa705b2e2df213\"}',NULL,'2026-11-08 11:17:51.769086'),(92,40,2,'APPROVE_EVENT','TRACE_EVENT','E-427F6062552748F1A6CE','{\"comment\":\"腌制记录审核通过\"}',NULL,'2026-11-08 11:17:53.819976'),(93,41,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-88A811F982A84030958F','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T16:50\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-88A811F982A84030958F\",\"eventType\":\"SAUCE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"一号酱卤车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-427F6062552748F1A6CE\",\"prevHash\":\"d5a7f132c218f664865054831563dfde13cb10f34992b1a2565f79336243a85a\",\"processData\":{\"actualTemperature\":\"94.5\",\"ccpResult\":\"PASS\",\"durationMin\":\"90\",\"endAt\":\"2026-11-08T16:50:00\",\"equipmentId\":\"LU-02\",\"formulaVersion\":\"CDJBY-FORMULA-V3\",\"pH\":\"6.2\",\"pressureKPa\":\"101\",\"salinity\":\"3.5\",\"setTemperature\":\"95\",\"startAt\":\"2026-11-08T15:20:00\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SAUCED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:17:53.850123'),(94,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-88A811F982A84030958F','{\"prevEventId\":\"E-427F6062552748F1A6CE\",\"prevHash\":\"d5a7f132c218f664865054831563dfde13cb10f34992b1a2565f79336243a85a\"}',NULL,'2026-11-08 11:17:53.866441'),(95,40,2,'APPROVE_EVENT','TRACE_EVENT','E-88A811F982A84030958F','{\"comment\":\"酱卤记录审核通过\"}',NULL,'2026-11-08 11:17:55.925679'),(96,41,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-92B55180A9D24E40A7DB','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T18:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-92B55180A9D24E40A7DB\",\"eventType\":\"ROAST\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"烘烤一车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-88A811F982A84030958F\",\"prevHash\":\"ebbaee41f1ae98769027a05b203e08bc6bbb0709a62299875b1a19afbca99af5\",\"processData\":{\"ccpCompliant\":\"PASS\",\"coreTemperature\":\"78\",\"endAt\":\"2026-11-08T18:30:00\",\"equipmentId\":\"HK-01\",\"exceptionCode\":\"\",\"humidity\":\"35\",\"processType\":\"烘烤\",\"setTemperature\":\"180\",\"startAt\":\"2026-11-08T17:00:00\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"ROASTED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:17:55.955463'),(97,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-92B55180A9D24E40A7DB','{\"prevEventId\":\"E-88A811F982A84030958F\",\"prevHash\":\"ebbaee41f1ae98769027a05b203e08bc6bbb0709a62299875b1a19afbca99af5\"}',NULL,'2026-11-08 11:17:55.970601'),(98,40,2,'APPROVE_EVENT','TRACE_EVENT','E-92B55180A9D24E40A7DB','{\"comment\":\"烘烤记录审核通过\"}',NULL,'2026-11-08 11:17:58.025681'),(99,42,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-6FF2C27B73E649829771','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T19:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-6FF2C27B73E649829771\",\"eventType\":\"QUALITY_CHECK\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"加工企业质检室\",\"operatorUserId\":\"42\",\"prevEventId\":\"E-92B55180A9D24E40A7DB\",\"prevHash\":\"185ca152c2c88507e16fd3a227f784716f30a07035690820a6a98925e7f0b4de\",\"processData\":{\"inspectionType\":\"微生物检测\",\"microbialResult\":\"PASS\",\"moisture\":\"45.2\",\"overallResult\":\"PASS\",\"remark\":\"菌落总数和大肠菌群均符合企业标准\",\"sampleNo\":\"PRO-QA-20261108-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"ROASTED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:17:58.068285'),(100,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-6FF2C27B73E649829771','{\"prevEventId\":\"E-92B55180A9D24E40A7DB\",\"prevHash\":\"185ca152c2c88507e16fd3a227f784716f30a07035690820a6a98925e7f0b4de\"}',NULL,'2026-11-08 11:17:58.081409'),(101,40,2,'APPROVE_EVENT','TRACE_EVENT','E-6FF2C27B73E649829771','{\"comment\":\"加工质检审核通过\"}',NULL,'2026-11-08 11:18:00.140030'),(102,41,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-8B77E313EF184E908392','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T20:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-8B77E313EF184E908392\",\"eventType\":\"PACKAGE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"真空包装一车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-6FF2C27B73E649829771\",\"prevHash\":\"9293d5f454cd3d6a98dfd97bf27357dd5ba367cc40eef111912308ed2b752b68\",\"processData\":{\"expiryDate\":\"2027-05-08\",\"netWeight\":\"600\",\"packageMaterialBatchNo\":\"BZ-20261107-01\",\"packageQuantity\":\"100\",\"productCode\":\"CDJBY-600\",\"productionLineNo\":\"PACK-LINE-01\",\"qaResult\":\"PASS\",\"sealTemperature\":\"145\",\"spec\":\"600g/袋\",\"vacuumDegree\":\"-0.095MPa\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"PACKAGED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:18:00.167015'),(103,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-8B77E313EF184E908392','{\"prevEventId\":\"E-6FF2C27B73E649829771\",\"prevHash\":\"9293d5f454cd3d6a98dfd97bf27357dd5ba367cc40eef111912308ed2b752b68\"}',NULL,'2026-11-08 11:18:00.181793'),(104,40,2,'APPROVE_EVENT','TRACE_EVENT','E-8B77E313EF184E908392','{\"comment\":\"包装记录审核通过\"}',NULL,'2026-11-08 11:18:02.241806'),(105,43,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-85743BE0BEAA46258CBF','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T20:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-85743BE0BEAA46258CBF\",\"eventType\":\"WAREHOUSE_IN\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"成品冷库一号库\",\"operatorUserId\":\"43\",\"prevEventId\":\"E-8B77E313EF184E908392\",\"prevHash\":\"7110999b5f25bf56ab5785d3991c575042c165a3825aa9dcb608d5b91950bcc9\",\"processData\":{\"binNo\":\"A-01-03\",\"coldChainStatus\":\"NORMAL\",\"quantity\":\"100\",\"temperature\":\"4\",\"warehouseId\":\"CZDY-WH-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"WAREHOUSED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:18:02.268759'),(106,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-85743BE0BEAA46258CBF','{\"prevEventId\":\"E-8B77E313EF184E908392\",\"prevHash\":\"7110999b5f25bf56ab5785d3991c575042c165a3825aa9dcb608d5b91950bcc9\"}',NULL,'2026-11-08 11:18:02.283860'),(107,40,2,'APPROVE_EVENT','TRACE_EVENT','E-85743BE0BEAA46258CBF','{\"comment\":\"成品入库审核通过\"}',NULL,'2026-11-08 11:18:04.352620'),(108,41,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-10DC4BF6F734497AAA47','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T21:00\",\"carrierOrgId\":\"3\",\"discrepancyCode\":\"\",\"eventId\":\"E-10DC4BF6F734497AAA47\",\"eventType\":\"DISPATCH\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"成品冷库发货区\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-85743BE0BEAA46258CBF\",\"prevHash\":\"a6acdc3d7eac703cdf198a7981d84f162f83cdf8fe0bef2f183517d99815f0b7\",\"processData\":{\"destination\":\"常德老街特产店\",\"sealNo\":\"SEAL-PRO-20261108-001\",\"temperature\":\"4\",\"vehicleRef\":\"湘J-LOG-03\"},\"resultStatus\":\"DISPATCHED\",\"stage\":\"DISPATCHED\",\"targetOrgId\":\"4\"}',NULL,'2026-11-08 11:18:04.381719'),(109,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-10DC4BF6F734497AAA47','{\"prevEventId\":\"E-85743BE0BEAA46258CBF\",\"prevHash\":\"a6acdc3d7eac703cdf198a7981d84f162f83cdf8fe0bef2f183517d99815f0b7\"}',NULL,'2026-11-08 11:18:04.397020'),(110,40,2,'APPROVE_EVENT','TRACE_EVENT','E-10DC4BF6F734497AAA47','{\"comment\":\"加工发货审核通过\"}',NULL,'2026-11-08 11:18:06.450852'),(111,45,3,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-58D22977D67A4B98B1DF','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T21:20\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-58D22977D67A4B98B1DF\",\"eventType\":\"TRANSPORT\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"3\",\"locationCode\":\"沅水冷链物流运输节点\",\"operatorUserId\":\"45\",\"prevEventId\":\"E-10DC4BF6F734497AAA47\",\"prevHash\":\"74265e795a8511e781b0e352734502abf3d2ed094542b945e0fd95a3dfff9f3c\",\"processData\":{\"alarmCount\":\"0\",\"coldChainCompliant\":\"PASS\",\"fromPlace\":\"常德酱板鸭食品有限公司\",\"sealNo\":\"SEAL-PRO-20261108-001\",\"temperature\":\"4\",\"toPlace\":\"常德老街特产店\",\"vehicleRef\":\"湘J-LOG-03\"},\"resultStatus\":\"IN_TRANSIT\",\"stage\":\"IN_TRANSIT\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:18:06.476488'),(112,44,3,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-58D22977D67A4B98B1DF','{\"prevEventId\":\"E-10DC4BF6F734497AAA47\",\"prevHash\":\"74265e795a8511e781b0e352734502abf3d2ed094542b945e0fd95a3dfff9f3c\"}',NULL,'2026-11-08 11:18:06.489468'),(113,44,3,'APPROVE_EVENT','TRACE_EVENT','E-58D22977D67A4B98B1DF','{\"comment\":\"运输登记审核通过\"}',NULL,'2026-11-08 11:18:08.648125'),(114,46,3,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-39FC6BBB9A914CE5A789','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T22:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-39FC6BBB9A914CE5A789\",\"eventType\":\"DELIVER\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"3\",\"locationCode\":\"常德老街特产店收货区\",\"operatorUserId\":\"46\",\"prevEventId\":\"E-58D22977D67A4B98B1DF\",\"prevHash\":\"0aa44f5952c37edd56b345679c669a8c446dd7b90ea06cbb6f3e20cfe6ade93d\",\"processData\":{\"deliveredAt\":\"2026-11-08T22:00:00\",\"discrepancyCode\":\"\",\"receiptResult\":\"正常\",\"temperature\":\"4\"},\"resultStatus\":\"DELIVERED\",\"stage\":\"DELIVERED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:18:08.676035'),(115,44,3,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-39FC6BBB9A914CE5A789','{\"prevEventId\":\"E-58D22977D67A4B98B1DF\",\"prevHash\":\"0aa44f5952c37edd56b345679c669a8c446dd7b90ea06cbb6f3e20cfe6ade93d\"}',NULL,'2026-11-08 11:18:08.690317'),(116,44,3,'APPROVE_EVENT','TRACE_EVENT','E-39FC6BBB9A914CE5A789','{\"comment\":\"交付记录审核通过\"}',NULL,'2026-11-08 11:18:10.741434'),(117,48,4,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-477CBBEAF95849FBA5B8','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T22:10\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-477CBBEAF95849FBA5B8\",\"eventType\":\"RECEIVE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"4\",\"locationCode\":\"常德老街特产店\",\"operatorUserId\":\"48\",\"prevEventId\":\"E-39FC6BBB9A914CE5A789\",\"prevHash\":\"4c65cafe22f3df90720932bdcc4eff0d9b9d85de00bf4758e2f8e0112c36fcdd\",\"processData\":{\"discrepancyCode\":\"\",\"packageIntact\":\"是\",\"quantityReceived\":\"100\",\"temperature\":\"4\"},\"resultStatus\":\"ON_SALE\",\"stage\":\"ON_SALE\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:18:10.769176'),(118,47,4,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-477CBBEAF95849FBA5B8','{\"prevEventId\":\"E-39FC6BBB9A914CE5A789\",\"prevHash\":\"4c65cafe22f3df90720932bdcc4eff0d9b9d85de00bf4758e2f8e0112c36fcdd\"}',NULL,'2026-11-08 11:18:10.785121'),(119,47,4,'APPROVE_EVENT','TRACE_EVENT','E-477CBBEAF95849FBA5B8','{\"comment\":\"门店收货审核通过\"}',NULL,'2026-11-08 11:18:12.951793'),(120,49,4,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-D8A20BF537FF4A2694D8','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T23:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-D8A20BF537FF4A2694D8\",\"eventType\":\"SALE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"4\",\"locationCode\":\"常德老街特产店\",\"operatorUserId\":\"49\",\"prevEventId\":\"E-477CBBEAF95849FBA5B8\",\"prevHash\":\"57317132fea2b152dc258d17b0e105de0973c42c10857873b022d648f71de9ac\",\"processData\":{\"quantitySold\":\"100\",\"remainingQuantity\":\"0\",\"saleOrderHash\":\"SALE-20261108-001\",\"salesChannel\":\"门店\",\"storageTemperature\":\"4\"},\"resultStatus\":\"SOLD\",\"stage\":\"SOLD\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:18:12.978672'),(121,47,4,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-D8A20BF537FF4A2694D8','{\"prevEventId\":\"E-477CBBEAF95849FBA5B8\",\"prevHash\":\"57317132fea2b152dc258d17b0e105de0973c42c10857873b022d648f71de9ac\"}',NULL,'2026-11-08 11:18:12.994061'),(122,47,4,'APPROVE_EVENT','TRACE_EVENT','E-D8A20BF537FF4A2694D8','{\"comment\":\"终端销售审核通过\"}',NULL,'2026-11-08 11:18:15.058944'),(123,39,8,'CREATE_BATCH','TRACE_BATCH','B-39D9C2A4FB694E9B86EE','{\"batchId\":\"B-39D9C2A4FB694E9B86EE\",\"batchNo\":\"YL-20261108112929-7C1F\",\"batchType\":\"RAW_DUCK\",\"createdAt\":\"2026-11-08T11:29:29.843847400\",\"custodianOrgId\":\"8\",\"expiryDate\":\"\",\"lastEventId\":\"\",\"lastHash\":\"f7fd465092bdda40422f0c2ab9b3c19a90edf218627b27024b61fb4288eca4e1\",\"ownerOrgId\":\"8\",\"parentBatchIds\":[],\"productName\":\"常德麻鸭\",\"productionDate\":\"2026-11-08\",\"quantity\":\"100\",\"spec\":\"活鸭，约2.5kg/只\",\"stage\":\"SOURCE\",\"status\":\"ACTIVE\",\"traceCode\":\"\",\"unit\":\"只\"}',NULL,'2026-11-08 11:29:33.478886'),(124,36,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-4C041B7ADAB34EF1900E','{\"batchId\":\"B-39D9C2A4FB694E9B86EE\",\"businessTime\":\"2026-11-08T08:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-4C041B7ADAB34EF1900E\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"常德市鼎城区1号麻鸭养殖场\",\"operatorUserId\":\"36\",\"prevEventId\":\"\",\"prevHash\":\"f7fd465092bdda40422f0c2ab9b3c19a90edf218627b27024b61fb4288eca4e1\",\"processData\":{\"breedingBatchNo\":\"YZ-20261108-01\",\"feedBatchNo\":\"SL-20261106-02\",\"healthStatus\":\"正常\",\"medicationRecord\":\"YY-20261101-03\",\"remark\":\"养殖周期120天，鸭群健康，休药期已结束\",\"stockQuantity\":\"100\",\"vaccineRecord\":\"YM-20261020-01\",\"withdrawalPeriodEnd\":\"2026-11-06\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:29:33.548612'),(125,37,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-3623D186C3124F099421','{\"batchId\":\"B-39D9C2A4FB694E9B86EE\",\"businessTime\":\"2026-11-08T08:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-3623D186C3124F099421\",\"eventType\":\"QUALITY_CHECK\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"供应商内部质检室\",\"operatorUserId\":\"37\",\"prevEventId\":\"\",\"prevHash\":\"f7fd465092bdda40422f0c2ab9b3c19a90edf218627b27024b61fb4288eca4e1\",\"processData\":{\"inspectionType\":\"工序抽检\",\"microbialResult\":\"PASS\",\"moisture\":\"68.5\",\"overallResult\":\"PASS\",\"remark\":\"感官正常，微生物指标符合要求\",\"sampleNo\":\"SUP-QC-20261108-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:29:33.593514'),(126,39,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-BE6604CA9D6444A48854','{\"batchId\":\"B-39D9C2A4FB694E9B86EE\",\"businessTime\":\"2026-11-08T09:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-BE6604CA9D6444A48854\",\"eventType\":\"QUARANTINE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"常德市动物检疫申报点\",\"operatorUserId\":\"39\",\"prevEventId\":\"\",\"prevHash\":\"f7fd465092bdda40422f0c2ab9b3c19a90edf218627b27024b61fb4288eca4e1\",\"processData\":{\"issuerOrg\":\"常德市动物疫病预防控制中心\",\"quarantineCertNo\":\"JY-430700-20261108-001\",\"quarantineDate\":\"2026-11-08\",\"quarantineResult\":\"PASS\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"QUARANTINED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:29:33.620670'),(127,35,8,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-4C041B7ADAB34EF1900E','{\"prevEventId\":\"\",\"prevHash\":\"f7fd465092bdda40422f0c2ab9b3c19a90edf218627b27024b61fb4288eca4e1\"}',NULL,'2026-11-08 11:29:33.645458'),(128,35,8,'APPROVE_EVENT','TRACE_EVENT','E-4C041B7ADAB34EF1900E','{\"comment\":\"供应商三类记录统一审核通过\"}',NULL,'2026-11-08 11:29:35.695893'),(129,35,8,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-3623D186C3124F099421','{\"prevEventId\":\"E-4C041B7ADAB34EF1900E\",\"prevHash\":\"d698102786d535e310b61d6d5b8713338380c151e98f22439925464799cd0fed\"}',NULL,'2026-11-08 11:29:35.711381'),(130,35,8,'APPROVE_EVENT','TRACE_EVENT','E-3623D186C3124F099421','{\"comment\":\"供应商三类记录统一审核通过\"}',NULL,'2026-11-08 11:29:37.761427'),(131,35,8,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-BE6604CA9D6444A48854','{\"prevEventId\":\"E-3623D186C3124F099421\",\"prevHash\":\"b74e3e8d374288f07552296b05ae2f059d0d249895abc769343d7907775f030b\"}',NULL,'2026-11-08 11:29:37.778371'),(132,35,8,'APPROVE_EVENT','TRACE_EVENT','E-BE6604CA9D6444A48854','{\"comment\":\"供应商三类记录统一审核通过\"}',NULL,'2026-11-08 11:29:39.829355'),(133,38,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-F08202E599F14EB9A64D','{\"batchId\":\"B-39D9C2A4FB694E9B86EE\",\"businessTime\":\"2026-11-08T09:30\",\"carrierOrgId\":\"3\",\"discrepancyCode\":\"\",\"eventId\":\"E-F08202E599F14EB9A64D\",\"eventType\":\"DISPATCH\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"供应商发货区\",\"operatorUserId\":\"38\",\"prevEventId\":\"E-BE6604CA9D6444A48854\",\"prevHash\":\"93cb95cec763bf781416b204a42861f556bf1183ed4398ede8d62d9019732f96\",\"processData\":{\"destination\":\"常德酱板鸭食品有限公司原料仓库\",\"sealNo\":\"SEAL-SUP-20261108-001\",\"temperature\":\"4\",\"vehicleRef\":\"湘JB1688\"},\"resultStatus\":\"DISPATCHED\",\"stage\":\"DISPATCHED\",\"targetOrgId\":\"2\"}',NULL,'2026-11-08 11:29:39.860951'),(134,35,8,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-F08202E599F14EB9A64D','{\"prevEventId\":\"E-BE6604CA9D6444A48854\",\"prevHash\":\"93cb95cec763bf781416b204a42861f556bf1183ed4398ede8d62d9019732f96\"}',NULL,'2026-11-08 11:29:39.881163'),(135,35,8,'APPROVE_EVENT','TRACE_EVENT','E-F08202E599F14EB9A64D','{\"comment\":\"供应商发货审核通过\"}',NULL,'2026-11-08 11:29:41.932568'),(136,41,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-356D2FB950DD439587CD','{\"batchId\":\"B-39D9C2A4FB694E9B86EE\",\"businessTime\":\"2026-11-08T10:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-356D2FB950DD439587CD\",\"eventType\":\"RECEIVE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"加工企业原料收货区\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-F08202E599F14EB9A64D\",\"prevHash\":\"2fc3438b08c01f108de381d0293317dde488dfd4b8db48544e6ea6d9aee093f3\",\"processData\":{\"discrepancyCode\":\"\",\"packageIntact\":\"是\",\"quantityReceived\":\"100\",\"temperature\":\"4\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"RECEIVED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:29:41.962467'),(137,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-356D2FB950DD439587CD','{\"prevEventId\":\"E-F08202E599F14EB9A64D\",\"prevHash\":\"2fc3438b08c01f108de381d0293317dde488dfd4b8db48544e6ea6d9aee093f3\"}',NULL,'2026-11-08 11:29:41.979530'),(138,40,2,'APPROVE_EVENT','TRACE_EVENT','E-356D2FB950DD439587CD','{\"comment\":\"加工企业收货审核通过\"}',NULL,'2026-11-08 11:29:44.158668'),(139,41,2,'CREATE_BATCH','TRACE_BATCH','B-3CC9C77146D240D18BEE','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"batchNo\":\"CP-20261108112944-D8F3\",\"batchType\":\"FINISHED\",\"createdAt\":\"2026-11-08T11:29:44.177447100\",\"custodianOrgId\":\"2\",\"expiryDate\":\"2027-05-08\",\"lastEventId\":\"\",\"lastHash\":\"37e4d56ae84c6c474717a00e092a55be69d0e487867b035640806d516f66c81e\",\"ownerOrgId\":\"2\",\"parentBatchIds\":[\"B-39D9C2A4FB694E9B86EE\"],\"productName\":\"常德酱板鸭\",\"productionDate\":\"2026-11-08\",\"quantity\":\"100\",\"spec\":\"600g/袋\",\"stage\":\"CREATED\",\"status\":\"ACTIVE\",\"traceCode\":\"CDJBY-20261108112944-FC8033\",\"unit\":\"袋\"}',NULL,'2026-11-08 11:29:46.228356'),(140,41,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-0D194EBB3E2F4CC9A142','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T10:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-0D194EBB3E2F4CC9A142\",\"eventType\":\"SLAUGHTER\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司屠宰车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"\",\"prevHash\":\"37e4d56ae84c6c474717a00e092a55be69d0e487867b035640806d516f66c81e\",\"processData\":{\"brineTemperature\":\"4\",\"carcassWeight\":\"180\",\"liveWeight\":\"250\",\"marinadeDurationMin\":\"240\",\"marinadeEndAt\":\"2026-11-08T15:00:00\",\"marinadeStartAt\":\"2026-11-08T11:00:00\",\"preSlaughterQuarantineResult\":\"PASS\",\"saltBatchNo\":\"SY-20261106-01\",\"slaughterhouseId\":\"CZDY-SL-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SLAUGHTERED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:29:46.271961'),(141,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-0D194EBB3E2F4CC9A142','{\"prevEventId\":\"\",\"prevHash\":\"37e4d56ae84c6c474717a00e092a55be69d0e487867b035640806d516f66c81e\"}',NULL,'2026-11-08 11:29:46.288145'),(142,40,2,'APPROVE_EVENT','TRACE_EVENT','E-0D194EBB3E2F4CC9A142','{\"comment\":\"屠宰记录审核通过\"}',NULL,'2026-11-08 11:29:48.342154'),(143,41,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-118BD66E78F04C9BA940','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T15:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-118BD66E78F04C9BA940\",\"eventType\":\"MARINATE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"一号腌制车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-0D194EBB3E2F4CC9A142\",\"prevHash\":\"5d5c04cd4b2784058446591ad990ec131ea3f7013ddc1e58269e0a82daa53442\",\"processData\":{\"durationMin\":\"240\",\"endAt\":\"2026-11-08T15:00:00\",\"equipmentId\":\"YAN-01\",\"saltBatchNo\":\"SY-20261106-01\",\"sensorFileHash\":\"\",\"startAt\":\"2026-11-08T11:00:00\",\"temperature\":\"4\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"MARINATED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:29:48.377597'),(144,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-118BD66E78F04C9BA940','{\"prevEventId\":\"E-0D194EBB3E2F4CC9A142\",\"prevHash\":\"5d5c04cd4b2784058446591ad990ec131ea3f7013ddc1e58269e0a82daa53442\"}',NULL,'2026-11-08 11:29:48.392906'),(145,40,2,'APPROVE_EVENT','TRACE_EVENT','E-118BD66E78F04C9BA940','{\"comment\":\"腌制记录审核通过\"}',NULL,'2026-11-08 11:29:50.442459'),(146,41,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-4CEDB67D14554BEDAEE8','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T16:50\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-4CEDB67D14554BEDAEE8\",\"eventType\":\"SAUCE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"一号酱卤车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-118BD66E78F04C9BA940\",\"prevHash\":\"ae4b5ddcd08048126d024f2c211e78d77528c097639c2ca98f991bf94190cf09\",\"processData\":{\"actualTemperature\":\"94.5\",\"ccpResult\":\"PASS\",\"durationMin\":\"90\",\"endAt\":\"2026-11-08T16:50:00\",\"equipmentId\":\"LU-02\",\"formulaVersion\":\"CDJBY-FORMULA-V3\",\"pH\":\"6.2\",\"pressureKPa\":\"101\",\"salinity\":\"3.5\",\"setTemperature\":\"95\",\"startAt\":\"2026-11-08T15:20:00\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SAUCED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:29:50.473041'),(147,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-4CEDB67D14554BEDAEE8','{\"prevEventId\":\"E-118BD66E78F04C9BA940\",\"prevHash\":\"ae4b5ddcd08048126d024f2c211e78d77528c097639c2ca98f991bf94190cf09\"}',NULL,'2026-11-08 11:29:50.492650'),(148,40,2,'APPROVE_EVENT','TRACE_EVENT','E-4CEDB67D14554BEDAEE8','{\"comment\":\"酱卤记录审核通过\"}',NULL,'2026-11-08 11:29:52.548846'),(149,41,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-9270FE70A7C54835BA54','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T18:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-9270FE70A7C54835BA54\",\"eventType\":\"ROAST\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"烘烤一车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-4CEDB67D14554BEDAEE8\",\"prevHash\":\"d6772c1b68fb48782199e4850ee1e9554146aa4cbaee785c7e3fa3a0d2e4969f\",\"processData\":{\"ccpCompliant\":\"PASS\",\"coreTemperature\":\"78\",\"endAt\":\"2026-11-08T18:30:00\",\"equipmentId\":\"HK-01\",\"exceptionCode\":\"\",\"humidity\":\"35\",\"processType\":\"烘烤\",\"setTemperature\":\"180\",\"startAt\":\"2026-11-08T17:00:00\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"ROASTED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:29:52.578335'),(150,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-9270FE70A7C54835BA54','{\"prevEventId\":\"E-4CEDB67D14554BEDAEE8\",\"prevHash\":\"d6772c1b68fb48782199e4850ee1e9554146aa4cbaee785c7e3fa3a0d2e4969f\"}',NULL,'2026-11-08 11:29:52.595771'),(151,40,2,'APPROVE_EVENT','TRACE_EVENT','E-9270FE70A7C54835BA54','{\"comment\":\"烘烤记录审核通过\"}',NULL,'2026-11-08 11:29:54.664709'),(152,42,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-DD9FA2B846C7475CAAA1','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T19:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-DD9FA2B846C7475CAAA1\",\"eventType\":\"QUALITY_CHECK\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"加工企业质检室\",\"operatorUserId\":\"42\",\"prevEventId\":\"E-9270FE70A7C54835BA54\",\"prevHash\":\"f8385304c57d357077553c4e344d6834c458ffe043bd6b207c49682a32e78982\",\"processData\":{\"inspectionType\":\"微生物检测\",\"microbialResult\":\"PASS\",\"moisture\":\"45.2\",\"overallResult\":\"PASS\",\"remark\":\"菌落总数和大肠菌群均符合企业标准\",\"sampleNo\":\"PRO-QA-20261108-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"ROASTED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:29:54.694383'),(153,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-DD9FA2B846C7475CAAA1','{\"prevEventId\":\"E-9270FE70A7C54835BA54\",\"prevHash\":\"f8385304c57d357077553c4e344d6834c458ffe043bd6b207c49682a32e78982\"}',NULL,'2026-11-08 11:29:54.710946'),(154,40,2,'APPROVE_EVENT','TRACE_EVENT','E-DD9FA2B846C7475CAAA1','{\"comment\":\"加工质检审核通过\"}',NULL,'2026-11-08 11:29:56.766909'),(155,41,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-9B6CAFD4278D4C78B4A9','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T20:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-9B6CAFD4278D4C78B4A9\",\"eventType\":\"PACKAGE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"真空包装一车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-DD9FA2B846C7475CAAA1\",\"prevHash\":\"71504837fdd2ebfc0af3db9887cf418ac1c75e964b86990186e19e017955e7b5\",\"processData\":{\"expiryDate\":\"2027-05-08\",\"netWeight\":\"600\",\"packageMaterialBatchNo\":\"BZ-20261107-01\",\"packageQuantity\":\"100\",\"productCode\":\"CDJBY-600\",\"productionLineNo\":\"PACK-LINE-01\",\"qaResult\":\"PASS\",\"sealTemperature\":\"145\",\"spec\":\"600g/袋\",\"vacuumDegree\":\"-0.095MPa\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"PACKAGED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:29:56.794137'),(156,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-9B6CAFD4278D4C78B4A9','{\"prevEventId\":\"E-DD9FA2B846C7475CAAA1\",\"prevHash\":\"71504837fdd2ebfc0af3db9887cf418ac1c75e964b86990186e19e017955e7b5\"}',NULL,'2026-11-08 11:29:56.810709'),(157,40,2,'APPROVE_EVENT','TRACE_EVENT','E-9B6CAFD4278D4C78B4A9','{\"comment\":\"包装记录审核通过\"}',NULL,'2026-11-08 11:29:58.860830'),(158,43,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-CC3F984D18884CA792A5','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T20:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-CC3F984D18884CA792A5\",\"eventType\":\"WAREHOUSE_IN\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"成品冷库一号库\",\"operatorUserId\":\"43\",\"prevEventId\":\"E-9B6CAFD4278D4C78B4A9\",\"prevHash\":\"60f617eaf52994161925fee22c4ac99c50f39407885bcb75313b4825e17dadd5\",\"processData\":{\"binNo\":\"A-01-03\",\"coldChainStatus\":\"NORMAL\",\"quantity\":\"100\",\"temperature\":\"4\",\"warehouseId\":\"CZDY-WH-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"WAREHOUSED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:29:58.886094'),(159,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-CC3F984D18884CA792A5','{\"prevEventId\":\"E-9B6CAFD4278D4C78B4A9\",\"prevHash\":\"60f617eaf52994161925fee22c4ac99c50f39407885bcb75313b4825e17dadd5\"}',NULL,'2026-11-08 11:29:58.901968'),(160,40,2,'APPROVE_EVENT','TRACE_EVENT','E-CC3F984D18884CA792A5','{\"comment\":\"成品入库审核通过\"}',NULL,'2026-11-08 11:30:00.956929'),(161,41,2,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-713A4F66223F44978627','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T21:00\",\"carrierOrgId\":\"3\",\"discrepancyCode\":\"\",\"eventId\":\"E-713A4F66223F44978627\",\"eventType\":\"DISPATCH\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"成品冷库发货区\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-CC3F984D18884CA792A5\",\"prevHash\":\"fccb54474a2b52c5b89d9c0e7345e0683c16d3d2d40e6968e4a07002298089ee\",\"processData\":{\"destination\":\"常德老街特产店\",\"sealNo\":\"SEAL-PRO-20261108-001\",\"temperature\":\"4\",\"vehicleRef\":\"湘J-LOG-03\"},\"resultStatus\":\"DISPATCHED\",\"stage\":\"DISPATCHED\",\"targetOrgId\":\"4\"}',NULL,'2026-11-08 11:30:00.990207'),(162,40,2,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-713A4F66223F44978627','{\"prevEventId\":\"E-CC3F984D18884CA792A5\",\"prevHash\":\"fccb54474a2b52c5b89d9c0e7345e0683c16d3d2d40e6968e4a07002298089ee\"}',NULL,'2026-11-08 11:30:01.008265'),(163,40,2,'APPROVE_EVENT','TRACE_EVENT','E-713A4F66223F44978627','{\"comment\":\"加工发货审核通过\"}',NULL,'2026-11-08 11:30:03.066168'),(164,45,3,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-3887A5C4C50841D88FC3','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T21:20\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-3887A5C4C50841D88FC3\",\"eventType\":\"TRANSPORT\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"3\",\"locationCode\":\"沅水冷链物流运输节点\",\"operatorUserId\":\"45\",\"prevEventId\":\"E-713A4F66223F44978627\",\"prevHash\":\"600b915c3209a3e38f5a049d8baee12940223cc318683b0a9d774f3433d1d4a5\",\"processData\":{\"alarmCount\":\"0\",\"coldChainCompliant\":\"PASS\",\"fromPlace\":\"常德酱板鸭食品有限公司\",\"sealNo\":\"SEAL-PRO-20261108-001\",\"temperature\":\"4\",\"toPlace\":\"常德老街特产店\",\"vehicleRef\":\"湘J-LOG-03\"},\"resultStatus\":\"IN_TRANSIT\",\"stage\":\"IN_TRANSIT\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:30:03.095447'),(165,44,3,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-3887A5C4C50841D88FC3','{\"prevEventId\":\"E-713A4F66223F44978627\",\"prevHash\":\"600b915c3209a3e38f5a049d8baee12940223cc318683b0a9d774f3433d1d4a5\"}',NULL,'2026-11-08 11:30:03.113580'),(166,44,3,'APPROVE_EVENT','TRACE_EVENT','E-3887A5C4C50841D88FC3','{\"comment\":\"运输登记审核通过\"}',NULL,'2026-11-08 11:30:05.317764'),(167,46,3,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-363AEAAD7F9541F99216','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T22:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-363AEAAD7F9541F99216\",\"eventType\":\"DELIVER\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"3\",\"locationCode\":\"常德老街特产店收货区\",\"operatorUserId\":\"46\",\"prevEventId\":\"E-3887A5C4C50841D88FC3\",\"prevHash\":\"fb9c0758490be0fac17a885de3b6fd86f1eb799abf1e45f60ba86c0011777b67\",\"processData\":{\"deliveredAt\":\"2026-11-08T22:00:00\",\"discrepancyCode\":\"\",\"receiptResult\":\"正常\",\"temperature\":\"4\"},\"resultStatus\":\"DELIVERED\",\"stage\":\"DELIVERED\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:30:05.347086'),(168,44,3,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-363AEAAD7F9541F99216','{\"prevEventId\":\"E-3887A5C4C50841D88FC3\",\"prevHash\":\"fb9c0758490be0fac17a885de3b6fd86f1eb799abf1e45f60ba86c0011777b67\"}',NULL,'2026-11-08 11:30:05.362538'),(169,44,3,'APPROVE_EVENT','TRACE_EVENT','E-363AEAAD7F9541F99216','{\"comment\":\"交付记录审核通过\"}',NULL,'2026-11-08 11:30:07.422286'),(170,48,4,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-DF98933B176841D78CB6','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T22:10\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-DF98933B176841D78CB6\",\"eventType\":\"RECEIVE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"4\",\"locationCode\":\"常德老街特产店\",\"operatorUserId\":\"48\",\"prevEventId\":\"E-363AEAAD7F9541F99216\",\"prevHash\":\"7424ab5630614ec95141533a9f9b01f4465a8da1d554e14a9d059fcaa2522502\",\"processData\":{\"discrepancyCode\":\"\",\"packageIntact\":\"是\",\"quantityReceived\":\"100\",\"temperature\":\"4\"},\"resultStatus\":\"ON_SALE\",\"stage\":\"ON_SALE\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:30:07.450010'),(171,47,4,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-DF98933B176841D78CB6','{\"prevEventId\":\"E-363AEAAD7F9541F99216\",\"prevHash\":\"7424ab5630614ec95141533a9f9b01f4465a8da1d554e14a9d059fcaa2522502\"}',NULL,'2026-11-08 11:30:07.466495'),(172,47,4,'APPROVE_EVENT','TRACE_EVENT','E-DF98933B176841D78CB6','{\"comment\":\"门店收货审核通过\"}',NULL,'2026-11-08 11:30:09.643050'),(173,49,4,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-809B927CFA864B87B8BA','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T23:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-809B927CFA864B87B8BA\",\"eventType\":\"SALE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"4\",\"locationCode\":\"常德老街特产店\",\"operatorUserId\":\"49\",\"prevEventId\":\"E-DF98933B176841D78CB6\",\"prevHash\":\"def2a8e5e167cc7794b560dc4e043f9a94fe5d7e9b56667c136e802112474f23\",\"processData\":{\"quantitySold\":\"100\",\"remainingQuantity\":\"0\",\"saleOrderHash\":\"SALE-20261108-001\",\"salesChannel\":\"门店\",\"storageTemperature\":\"4\"},\"resultStatus\":\"SOLD\",\"stage\":\"SOLD\",\"targetOrgId\":\"\"}',NULL,'2026-11-08 11:30:09.670276'),(174,47,4,'REBASE_UNCOMMITTED_EVENT','TRACE_EVENT','E-809B927CFA864B87B8BA','{\"prevEventId\":\"E-DF98933B176841D78CB6\",\"prevHash\":\"def2a8e5e167cc7794b560dc4e043f9a94fe5d7e9b56667c136e802112474f23\"}',NULL,'2026-11-08 11:30:09.684427'),(175,47,4,'APPROVE_EVENT','TRACE_EVENT','E-809B927CFA864B87B8BA','{\"comment\":\"终端销售审核通过\"}',NULL,'2026-11-08 11:30:11.755244');
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
INSERT INTO `batch_party` VALUES ('B-39D9C2A4FB694E9B86EE',2,'RECEIVER','FULL','2026-11-08 11:29:41.925071'),('B-39D9C2A4FB694E9B86EE',3,'CARRIER','FULL','2026-11-08 11:29:41.925493'),('B-39D9C2A4FB694E9B86EE',8,'OWNER','FULL','2026-11-08 11:29:29.857968'),('B-3CC9C77146D240D18BEE',2,'OWNER','FULL','2026-11-08 11:29:44.183093'),('B-3CC9C77146D240D18BEE',3,'CARRIER','FULL','2026-11-08 11:30:03.058852'),('B-3CC9C77146D240D18BEE',4,'RECEIVER','FULL','2026-11-08 11:30:03.058537'),('B-C5BB618A6E6342F4A6D7',2,'OWNER','FULL','2026-11-08 11:17:47.546129'),('B-C5BB618A6E6342F4A6D7',3,'CARRIER','FULL','2026-11-08 11:18:06.444412'),('B-C5BB618A6E6342F4A6D7',4,'RECEIVER','FULL','2026-11-08 11:18:06.443962'),('B-D584BC5A5AA54C5291CF',2,'RECEIVER','FULL','2026-11-08 11:17:45.283525'),('B-D584BC5A5AA54C5291CF',3,'CARRIER','FULL','2026-11-08 11:17:45.284124'),('B-D584BC5A5AA54C5291CF',8,'OWNER','FULL','2026-11-08 11:17:32.978074');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_relation`
--

LOCK TABLES `batch_relation` WRITE;
/*!40000 ALTER TABLE `batch_relation` DISABLE KEYS */;
INSERT INTO `batch_relation` VALUES (3,'B-D584BC5A5AA54C5291CF','B-C5BB618A6E6342F4A6D7','MERGE',100.000,'2026-11-08 11:17:47.551494'),(4,'B-39D9C2A4FB694E9B86EE','B-3CC9C77146D240D18BEE','MERGE',100.000,'2026-11-08 11:29:44.188193');
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
INSERT INTO `custody_transfer` VALUES ('T-35964AA072ED4968A492','B-C5BB618A6E6342F4A6D7','E-477CBBEAF95849FBA5B8',2,4,3,'RECEIVED','2026-11-08 11:18:06.442616','2026-11-08 11:18:12.943918','','2026-11-08 11:18:06.443451'),('T-5C1F36B992F64C919EC8','B-3CC9C77146D240D18BEE','E-DF98933B176841D78CB6',2,4,3,'RECEIVED','2026-11-08 11:30:03.056336','2026-11-08 11:30:09.626183','','2026-11-08 11:30:03.058044'),('T-68E1B7278963494E824D','B-D584BC5A5AA54C5291CF','E-546B7DDF767E4FF5B1A4',8,2,3,'RECEIVED','2026-11-08 11:17:45.281084','2026-11-08 11:17:47.505558','','2026-11-08 11:17:45.283105'),('T-759BCCFA14574AC9AD1B','B-39D9C2A4FB694E9B86EE','E-356D2FB950DD439587CD',8,2,3,'RECEIVED','2026-11-08 11:29:41.923515','2026-11-08 11:29:44.143564','','2026-11-08 11:29:41.924518');
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
INSERT INTO `event_review` VALUES ('E-0D194EBB3E2F4CC9A142','PROCESSOR_OPERATOR','APPROVED',40,'2026-11-08 11:29:48.335271','屠宰记录审核通过','2026-11-08 11:29:46.266198'),('E-10DC4BF6F734497AAA47','PROCESSOR_OPERATOR','APPROVED',40,'2026-11-08 11:18:06.444929','加工发货审核通过','2026-11-08 11:18:04.376450'),('E-118BD66E78F04C9BA940','PROCESSOR_OPERATOR','APPROVED',40,'2026-11-08 11:29:50.436294','腌制记录审核通过','2026-11-08 11:29:48.372299'),('E-356D2FB950DD439587CD','PROCESSOR_OPERATOR','APPROVED',40,'2026-11-08 11:29:44.144866','加工企业收货审核通过','2026-11-08 11:29:41.957087'),('E-3623D186C3124F099421','SUPPLIER_QA','APPROVED',35,'2026-11-08 11:29:37.755412','供应商三类记录统一审核通过','2026-11-08 11:29:33.587944'),('E-363AEAAD7F9541F99216','LOGISTICS_DRIVER','APPROVED',44,'2026-11-08 11:30:07.407169','交付记录审核通过','2026-11-08 11:30:05.341792'),('E-3887A5C4C50841D88FC3','LOGISTICS_DISPATCHER','APPROVED',44,'2026-11-08 11:30:05.310116','运输登记审核通过','2026-11-08 11:30:03.090518'),('E-39FC6BBB9A914CE5A789','LOGISTICS_DRIVER','APPROVED',44,'2026-11-08 11:18:10.734785','交付记录审核通过','2026-11-08 11:18:08.670606'),('E-427F6062552748F1A6CE','PROCESSOR_OPERATOR','APPROVED',40,'2026-11-08 11:17:53.810357','腌制记录审核通过','2026-11-08 11:17:51.748782'),('E-477CBBEAF95849FBA5B8','RETAIL_RECEIVER','APPROVED',47,'2026-11-08 11:18:12.945680','门店收货审核通过','2026-11-08 11:18:10.764067'),('E-4BDDE4AB6BE7407AA87F','SUPPLIER_BREEDER','APPROVED',35,'2026-11-08 11:17:39.017605','供应商三类记录统一审核通过','2026-11-08 11:17:36.860011'),('E-4C041B7ADAB34EF1900E','SUPPLIER_BREEDER','APPROVED',35,'2026-11-08 11:29:35.687396','供应商三类记录统一审核通过','2026-11-08 11:29:33.542885'),('E-4CEDB67D14554BEDAEE8','PROCESSOR_OPERATOR','APPROVED',40,'2026-11-08 11:29:52.542583','酱卤记录审核通过','2026-11-08 11:29:50.468038'),('E-546B7DDF767E4FF5B1A4','PROCESSOR_OPERATOR','APPROVED',40,'2026-11-08 11:17:47.507758','加工企业收货审核通过','2026-11-08 11:17:45.316902'),('E-58D22977D67A4B98B1DF','LOGISTICS_DISPATCHER','APPROVED',44,'2026-11-08 11:18:08.641559','运输登记审核通过','2026-11-08 11:18:06.471614'),('E-5FA896BA43C4405FABDA','SUPPLIER_OPERATOR','APPROVED',35,'2026-11-08 11:17:43.172801','供应商三类记录统一审核通过','2026-11-08 11:17:36.932413'),('E-6FF2C27B73E649829771','PROCESSOR_QA','APPROVED',40,'2026-11-08 11:18:00.124680','加工质检审核通过','2026-11-08 11:17:58.062969'),('E-713A4F66223F44978627','PROCESSOR_OPERATOR','APPROVED',40,'2026-11-08 11:30:03.059143','加工发货审核通过','2026-11-08 11:30:00.984881'),('E-809B927CFA864B87B8BA','RETAIL_SALESPERSON','APPROVED',47,'2026-11-08 11:30:11.749577','终端销售审核通过','2026-11-08 11:30:09.665524'),('E-85743BE0BEAA46258CBF','PROCESSOR_WAREHOUSE','APPROVED',40,'2026-11-08 11:18:04.337778','成品入库审核通过','2026-11-08 11:18:02.263610'),('E-87D486CFF6DD4EC3AC0E','SUPPLIER_QA','APPROVED',35,'2026-11-08 11:17:41.096379','供应商三类记录统一审核通过','2026-11-08 11:17:36.903827'),('E-88A811F982A84030958F','PROCESSOR_OPERATOR','APPROVED',40,'2026-11-08 11:17:55.909943','酱卤记录审核通过','2026-11-08 11:17:53.844663'),('E-8B77E313EF184E908392','PROCESSOR_OPERATOR','APPROVED',40,'2026-11-08 11:18:02.225879','包装记录审核通过','2026-11-08 11:18:00.161527'),('E-9270FE70A7C54835BA54','PROCESSOR_OPERATOR','APPROVED',40,'2026-11-08 11:29:54.650025','烘烤记录审核通过','2026-11-08 11:29:52.572256'),('E-92B55180A9D24E40A7DB','PROCESSOR_OPERATOR','APPROVED',40,'2026-11-08 11:17:58.019307','烘烤记录审核通过','2026-11-08 11:17:55.949881'),('E-9B6CAFD4278D4C78B4A9','PROCESSOR_OPERATOR','APPROVED',40,'2026-11-08 11:29:58.853471','包装记录审核通过','2026-11-08 11:29:56.788723'),('E-BE6604CA9D6444A48854','SUPPLIER_OPERATOR','APPROVED',35,'2026-11-08 11:29:39.822607','供应商三类记录统一审核通过','2026-11-08 11:29:33.615451'),('E-C3B6BE45E07D4EA5BBF3','SUPPLIER_SHIPPER','APPROVED',35,'2026-11-08 11:17:45.284728','供应商发货审核通过','2026-11-08 11:17:43.207828'),('E-C5E8443572734B60B4ED','PROCESSOR_OPERATOR','APPROVED',40,'2026-11-08 11:17:51.701833','屠宰记录审核通过','2026-11-08 11:17:49.621339'),('E-CC3F984D18884CA792A5','PROCESSOR_WAREHOUSE','APPROVED',40,'2026-11-08 11:30:00.950628','成品入库审核通过','2026-11-08 11:29:58.881746'),('E-D8A20BF537FF4A2694D8','RETAIL_SALESPERSON','APPROVED',47,'2026-11-08 11:18:15.043468','终端销售审核通过','2026-11-08 11:18:12.973081'),('E-DD9FA2B846C7475CAAA1','PROCESSOR_QA','APPROVED',40,'2026-11-08 11:29:56.751385','加工质检审核通过','2026-11-08 11:29:54.689170'),('E-DF98933B176841D78CB6','RETAIL_RECEIVER','APPROVED',47,'2026-11-08 11:30:09.627493','门店收货审核通过','2026-11-08 11:30:07.444838'),('E-F08202E599F14EB9A64D','SUPPLIER_SHIPPER','APPROVED',35,'2026-11-08 11:29:41.925826','供应商发货审核通过','2026-11-08 11:29:39.855571');
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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (8,'admin','$2a$10$GqJ5gHG7KzXgvARyNFoTOOMeykWvypwVoA30CWsSyO6YQqWqcmb6.','平台管理员',6,1,'2026-11-01 10:00:58.167706'),(35,'13910000001','$2a$10$5BA7BkaNw9btw8Bvrd7zpOb/zohGvTsQxNBQKwMdAnMf9ocqyjexG','张三',8,1,'2026-11-08 11:14:07.404479'),(36,'13910000002','$2a$10$YgFiRRxI900EW5Mb7VShMekgLqgHEnJl7b8oLnABCwdQnOaHJBRVC','李四',8,1,'2026-11-08 11:14:07.483500'),(37,'13910000003','$2a$10$tzsbmdkyZTEflgdzZKRrbOOUj0tWEMgkdfnUY2l86zH9u0mX5xASO','王五',8,1,'2026-11-08 11:14:07.554766'),(38,'13910000004','$2a$10$9SKHG3YFm6cOIq0et1gop.X6siuAP1YrKuLfWpq2bEwbJ4a/Yy0LG','赵六',8,1,'2026-11-08 11:14:07.625527'),(39,'13910000005','$2a$10$Q8MdB.1y4sdMxYWVmo29huYc/k5wnM04KHY6LGN/YdSld8aW6lUbC','陈七',8,1,'2026-11-08 11:14:07.696313'),(40,'13920000001','$2a$10$q/BBrf.6Z2ZkY6MPJ4bXAuybF7DMcScAa6kJVN0KvzvNHfHQd5Pb2','刘洋',2,1,'2026-11-08 11:14:07.766614'),(41,'13920000002','$2a$10$uxLl576L43kDQN7js/mvqeEjFk7nal9oWtz4M4qtBeCmh08gB2fZe','周强',2,1,'2026-11-08 11:14:07.837420'),(42,'13920000003','$2a$10$Zb2wh6BecrRXQuq4zDUxcO/Y1bBnfDHSnRQuCPbloxIJbMz0.hYYy','吴敏',2,1,'2026-11-08 11:14:07.909076'),(43,'13920000004','$2a$10$wVre5qKST6l9QtdYkvGjBOsJD5q67jUhYQuLEupLkMDBAqLOq1l0O','郑伟',2,1,'2026-11-08 11:14:07.979886'),(44,'13930000001','$2a$10$8.rCSdNAhwdATgd.XNm/beQvRGsTN27UpdbnLHbClcG2KlUZTSby2','孙磊',3,1,'2026-11-08 11:14:08.050316'),(45,'13930000002','$2a$10$D5lQxpX1eUwH3hGs9pc2qOWBR8z3meLGkBYHNPxZYRtaxqWVT5h8C','何静',3,1,'2026-11-08 11:14:08.121185'),(46,'13930000003','$2a$10$lIdKkNJ.nZ1Db74QvGKJruKnftq6NWAN.knWgXKSyeRlJzELx5b9S','林涛',3,1,'2026-11-08 11:14:08.209279'),(47,'13940000001','$2a$10$i9qfvqjThpPxYKeQcz6Ex.B/3WxVnvBhISawOQFht3u0YewjOS.q.','徐丽',4,1,'2026-11-08 11:14:08.278780'),(48,'13940000002','$2a$10$SZFvjZcisUiFzoYgI6IXm.siAriqrLRk6yxGP6KhCBZnbvbB/RAsy','马超',4,1,'2026-11-08 11:14:08.350010'),(49,'13940000003','$2a$10$CQ/jbrxV4R3dcXN05iIX6uLU6yiyxFBaF/Yh8u5lVh2JvtKIOYkHy','朱琳',4,1,'2026-11-08 11:14:08.420689');
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
INSERT INTO `sys_user_role` VALUES (39,1),(41,2),(42,3),(8,7),(35,8),(40,8),(44,8),(47,8),(36,9),(37,10),(38,11),(43,12),(45,13),(46,14),(48,15),(49,16);
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
INSERT INTO `trace_batch` VALUES ('B-39D9C2A4FB694E9B86EE','YL-20261108112929-7C1F',NULL,'RAW_DUCK',8,2,'常德麻鸭','活鸭，约2.5kg/只',100.000,'只','RECEIVED','ACTIVE','2026-11-08',NULL,'E-356D2FB950DD439587CD','e4cb8aa3614a3dd1b35355db4ba65356e5b746ef113e79b592d814ba49f611c0','COMMITTED','603a8a6b10e8a9a4c3c6679fc85c20c21f2b1aefcd085fa211e4c98294b2e6bc',39,'2026-11-08 11:29:29.851502','2026-11-08 11:29:44.144439'),('B-3CC9C77146D240D18BEE','CP-20261108112944-D8F3','CDJBY-20261108112944-FC8033','FINISHED',2,4,'常德酱板鸭','600g/袋',100.000,'袋','SOLD','SOLD','2026-11-08','2027-05-08','E-809B927CFA864B87B8BA','38e960d7d69dd82298d304045eafa4d31dd65fae88e30524db7616a6e6cf6a27','COMMITTED','3e91292947ea5d1e1d952dcaa07a24b07dce6d927aa01f3e9884c0169947850f',41,'2026-11-08 11:29:44.177835','2026-11-08 11:30:11.749066'),('B-C5BB618A6E6342F4A6D7','CP-20261108111747-62EA','CDJBY-20261108111747-E6C62F','FINISHED',2,4,'常德酱板鸭','600g/袋',100.000,'袋','SOLD','SOLD','2026-11-08','2027-05-08','E-D8A20BF537FF4A2694D8','c343bb0fe3c442c81d3542d02f5a7e076cca4e4bd8ba386c9f433f409e552e4a','COMMITTED','da5a0136c550a036eec329d15ea6fcb44bf6be081c5f89a9479a0e659d1ca4e3',41,'2026-11-08 11:17:47.540595','2026-11-08 11:18:15.042833'),('B-D584BC5A5AA54C5291CF','YL-20261108111732-807D',NULL,'RAW_DUCK',8,2,'常德麻鸭','活鸭，约2.5kg/只',100.000,'只','RECEIVED','ACTIVE','2026-11-08',NULL,'E-546B7DDF767E4FF5B1A4','2c1b427413dd10de6c72ddeb50dfe5b6a8fc84450788e6b4d4ac25774c0ef4f0','COMMITTED','4322a7185782df14aa5a75bf900ded018fb5974729d9f8b290fbf64e56348a67',39,'2026-11-08 11:17:32.972489','2026-11-08 11:17:47.507071');
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
INSERT INTO `trace_event` VALUES ('E-0D194EBB3E2F4CC9A142','B-3CC9C77146D240D18BEE','SLAUGHTER','SLAUGHTERED','ACTIVE',2,41,'2026-11-08 10:30:00.000000','常德酱板鸭食品有限公司屠宰车间','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T10:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-0D194EBB3E2F4CC9A142\",\"eventType\":\"SLAUGHTER\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司屠宰车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"\",\"prevHash\":\"37e4d56ae84c6c474717a00e092a55be69d0e487867b035640806d516f66c81e\",\"processData\":{\"brineTemperature\":\"4\",\"carcassWeight\":\"180\",\"liveWeight\":\"250\",\"marinadeDurationMin\":\"240\",\"marinadeEndAt\":\"2026-11-08T15:00:00\",\"marinadeStartAt\":\"2026-11-08T11:00:00\",\"preSlaughterQuarantineResult\":\"PASS\",\"saltBatchNo\":\"SY-20261106-01\",\"slaughterhouseId\":\"CZDY-SL-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SLAUGHTERED\",\"targetOrgId\":\"\"}','5d5c04cd4b2784058446591ad990ec131ea3f7013ddc1e58269e0a82daa53442',NULL,NULL,'37e4d56ae84c6c474717a00e092a55be69d0e487867b035640806d516f66c81e','e9699f61-d8e6-483f-8328-afafc7e84a9b','COMMITTED','6a0feff2ab4af927823eb5217977cc95bd69c186a27d7d5f3ba925982776d08a',43,NULL,NULL,'2026-11-08 11:29:46.260316'),('E-10DC4BF6F734497AAA47','B-C5BB618A6E6342F4A6D7','DISPATCH','DISPATCHED','DISPATCHED',2,41,'2026-11-08 21:00:00.000000','成品冷库发货区','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T21:00\",\"carrierOrgId\":\"3\",\"discrepancyCode\":\"\",\"eventId\":\"E-10DC4BF6F734497AAA47\",\"eventType\":\"DISPATCH\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"成品冷库发货区\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-85743BE0BEAA46258CBF\",\"prevHash\":\"a6acdc3d7eac703cdf198a7981d84f162f83cdf8fe0bef2f183517d99815f0b7\",\"processData\":{\"destination\":\"常德老街特产店\",\"sealNo\":\"SEAL-PRO-20261108-001\",\"temperature\":\"4\",\"vehicleRef\":\"湘J-LOG-03\"},\"resultStatus\":\"DISPATCHED\",\"stage\":\"DISPATCHED\",\"targetOrgId\":\"4\"}','74265e795a8511e781b0e352734502abf3d2ed094542b945e0fd95a3dfff9f3c',NULL,'E-85743BE0BEAA46258CBF','a6acdc3d7eac703cdf198a7981d84f162f83cdf8fe0bef2f183517d99815f0b7','15b38bec-3572-44e7-8d43-39fd4d3d6f9c','COMMITTED','40c730c68bf75149330aeef10428918a18c8400b41b0bf87d464d6534bc8bfd1',31,NULL,NULL,'2026-11-08 11:18:04.369973'),('E-118BD66E78F04C9BA940','B-3CC9C77146D240D18BEE','MARINATE','MARINATED','ACTIVE',2,41,'2026-11-08 15:00:00.000000','一号腌制车间','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T15:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-118BD66E78F04C9BA940\",\"eventType\":\"MARINATE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"一号腌制车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-0D194EBB3E2F4CC9A142\",\"prevHash\":\"5d5c04cd4b2784058446591ad990ec131ea3f7013ddc1e58269e0a82daa53442\",\"processData\":{\"durationMin\":\"240\",\"endAt\":\"2026-11-08T15:00:00\",\"equipmentId\":\"YAN-01\",\"saltBatchNo\":\"SY-20261106-01\",\"sensorFileHash\":\"\",\"startAt\":\"2026-11-08T11:00:00\",\"temperature\":\"4\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"MARINATED\",\"targetOrgId\":\"\"}','ae4b5ddcd08048126d024f2c211e78d77528c097639c2ca98f991bf94190cf09',NULL,'E-0D194EBB3E2F4CC9A142','5d5c04cd4b2784058446591ad990ec131ea3f7013ddc1e58269e0a82daa53442','f273c50b-0478-4237-a9dc-9ccfa0b21186','COMMITTED','7930e85944e83db5c119a3f95966058284c6ee7fcd7d1c3538f39e3dacf149dc',44,NULL,NULL,'2026-11-08 11:29:48.366584'),('E-356D2FB950DD439587CD','B-39D9C2A4FB694E9B86EE','RECEIVE','RECEIVED','ACTIVE',2,41,'2026-11-08 10:00:00.000000','加工企业原料收货区','{\"batchId\":\"B-39D9C2A4FB694E9B86EE\",\"businessTime\":\"2026-11-08T10:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-356D2FB950DD439587CD\",\"eventType\":\"RECEIVE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"加工企业原料收货区\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-F08202E599F14EB9A64D\",\"prevHash\":\"2fc3438b08c01f108de381d0293317dde488dfd4b8db48544e6ea6d9aee093f3\",\"processData\":{\"discrepancyCode\":\"\",\"packageIntact\":\"是\",\"quantityReceived\":\"100\",\"temperature\":\"4\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"RECEIVED\",\"targetOrgId\":\"\"}','e4cb8aa3614a3dd1b35355db4ba65356e5b746ef113e79b592d814ba49f611c0',NULL,'E-F08202E599F14EB9A64D','2fc3438b08c01f108de381d0293317dde488dfd4b8db48544e6ea6d9aee093f3','ad8b9b6a-3194-40e0-9664-749d5d5cc17e','COMMITTED','603a8a6b10e8a9a4c3c6679fc85c20c21f2b1aefcd085fa211e4c98294b2e6bc',41,NULL,NULL,'2026-11-08 11:29:41.952003'),('E-3623D186C3124F099421','B-39D9C2A4FB694E9B86EE','QUALITY_CHECK','SOURCE','ACTIVE',8,37,'2026-11-08 08:30:00.000000','供应商内部质检室','{\"batchId\":\"B-39D9C2A4FB694E9B86EE\",\"businessTime\":\"2026-11-08T08:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-3623D186C3124F099421\",\"eventType\":\"QUALITY_CHECK\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"供应商内部质检室\",\"operatorUserId\":\"37\",\"prevEventId\":\"E-4C041B7ADAB34EF1900E\",\"prevHash\":\"d698102786d535e310b61d6d5b8713338380c151e98f22439925464799cd0fed\",\"processData\":{\"inspectionType\":\"工序抽检\",\"microbialResult\":\"PASS\",\"moisture\":\"68.5\",\"overallResult\":\"PASS\",\"remark\":\"感官正常，微生物指标符合要求\",\"sampleNo\":\"SUP-QC-20261108-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}','b74e3e8d374288f07552296b05ae2f059d0d249895abc769343d7907775f030b',NULL,'E-4C041B7ADAB34EF1900E','d698102786d535e310b61d6d5b8713338380c151e98f22439925464799cd0fed','c16cf62a-f1c9-40e9-b454-47c88202fe0d','COMMITTED','38aa87f5246594581f7e675ef121b452f61b77d6f7a25282d349a63d03858b6f',38,NULL,NULL,'2026-11-08 11:29:33.582302'),('E-363AEAAD7F9541F99216','B-3CC9C77146D240D18BEE','DELIVER','DELIVERED','DELIVERED',3,46,'2026-11-08 22:00:00.000000','常德老街特产店收货区','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T22:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-363AEAAD7F9541F99216\",\"eventType\":\"DELIVER\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"3\",\"locationCode\":\"常德老街特产店收货区\",\"operatorUserId\":\"46\",\"prevEventId\":\"E-3887A5C4C50841D88FC3\",\"prevHash\":\"fb9c0758490be0fac17a885de3b6fd86f1eb799abf1e45f60ba86c0011777b67\",\"processData\":{\"deliveredAt\":\"2026-11-08T22:00:00\",\"discrepancyCode\":\"\",\"receiptResult\":\"正常\",\"temperature\":\"4\"},\"resultStatus\":\"DELIVERED\",\"stage\":\"DELIVERED\",\"targetOrgId\":\"\"}','7424ab5630614ec95141533a9f9b01f4465a8da1d554e14a9d059fcaa2522502',NULL,'E-3887A5C4C50841D88FC3','fb9c0758490be0fac17a885de3b6fd86f1eb799abf1e45f60ba86c0011777b67','608741b4-6386-41cd-987b-673084427318','COMMITTED','ce75dbdb9b0a61dce6cb46859e50d4f266fb0b0d8566cddad98a439112eb94e5',52,NULL,NULL,'2026-11-08 11:30:05.334115'),('E-3887A5C4C50841D88FC3','B-3CC9C77146D240D18BEE','TRANSPORT','IN_TRANSIT','IN_TRANSIT',3,45,'2026-11-08 21:20:00.000000','沅水冷链物流运输节点','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T21:20\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-3887A5C4C50841D88FC3\",\"eventType\":\"TRANSPORT\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"3\",\"locationCode\":\"沅水冷链物流运输节点\",\"operatorUserId\":\"45\",\"prevEventId\":\"E-713A4F66223F44978627\",\"prevHash\":\"600b915c3209a3e38f5a049d8baee12940223cc318683b0a9d774f3433d1d4a5\",\"processData\":{\"alarmCount\":\"0\",\"coldChainCompliant\":\"PASS\",\"fromPlace\":\"常德酱板鸭食品有限公司\",\"sealNo\":\"SEAL-PRO-20261108-001\",\"temperature\":\"4\",\"toPlace\":\"常德老街特产店\",\"vehicleRef\":\"湘J-LOG-03\"},\"resultStatus\":\"IN_TRANSIT\",\"stage\":\"IN_TRANSIT\",\"targetOrgId\":\"\"}','fb9c0758490be0fac17a885de3b6fd86f1eb799abf1e45f60ba86c0011777b67',NULL,'E-713A4F66223F44978627','600b915c3209a3e38f5a049d8baee12940223cc318683b0a9d774f3433d1d4a5','088fb676-b50e-4fb8-b68c-c475c2c4641b','COMMITTED','83877c25b5e41fa7fad0d92ba1bcd9692a650ed6d777250f01f34b71ce1aacc5',51,NULL,NULL,'2026-11-08 11:30:03.085354'),('E-39FC6BBB9A914CE5A789','B-C5BB618A6E6342F4A6D7','DELIVER','DELIVERED','DELIVERED',3,46,'2026-11-08 22:00:00.000000','常德老街特产店收货区','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T22:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-39FC6BBB9A914CE5A789\",\"eventType\":\"DELIVER\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"3\",\"locationCode\":\"常德老街特产店收货区\",\"operatorUserId\":\"46\",\"prevEventId\":\"E-58D22977D67A4B98B1DF\",\"prevHash\":\"0aa44f5952c37edd56b345679c669a8c446dd7b90ea06cbb6f3e20cfe6ade93d\",\"processData\":{\"deliveredAt\":\"2026-11-08T22:00:00\",\"discrepancyCode\":\"\",\"receiptResult\":\"正常\",\"temperature\":\"4\"},\"resultStatus\":\"DELIVERED\",\"stage\":\"DELIVERED\",\"targetOrgId\":\"\"}','4c65cafe22f3df90720932bdcc4eff0d9b9d85de00bf4758e2f8e0112c36fcdd',NULL,'E-58D22977D67A4B98B1DF','0aa44f5952c37edd56b345679c669a8c446dd7b90ea06cbb6f3e20cfe6ade93d','bf814d91-7ae7-4b3a-805b-65fa683a700f','COMMITTED','6485808265349874ca99bd0c4dad562047266d9fb6b7c1074b2a1eac02dfeb6b',33,NULL,NULL,'2026-11-08 11:18:08.665320'),('E-427F6062552748F1A6CE','B-C5BB618A6E6342F4A6D7','MARINATE','MARINATED','ACTIVE',2,41,'2026-11-08 15:00:00.000000','一号腌制车间','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T15:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-427F6062552748F1A6CE\",\"eventType\":\"MARINATE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"一号腌制车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-C5E8443572734B60B4ED\",\"prevHash\":\"c3cde6e4f2e5181ef09245b804a2a49b8f9276c21200cc0ff1fa705b2e2df213\",\"processData\":{\"durationMin\":\"240\",\"endAt\":\"2026-11-08T15:00:00\",\"equipmentId\":\"YAN-01\",\"saltBatchNo\":\"SY-20261106-01\",\"sensorFileHash\":\"\",\"startAt\":\"2026-11-08T11:00:00\",\"temperature\":\"4\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"MARINATED\",\"targetOrgId\":\"\"}','d5a7f132c218f664865054831563dfde13cb10f34992b1a2565f79336243a85a',NULL,'E-C5E8443572734B60B4ED','c3cde6e4f2e5181ef09245b804a2a49b8f9276c21200cc0ff1fa705b2e2df213','95a4ee65-cf81-4894-adbf-123fa50ac8e3','COMMITTED','645fca56e55309147a27a969c0c35d8c8c0dd87e5609bff967f980ac75fcd116',25,NULL,NULL,'2026-11-08 11:17:51.743589'),('E-477CBBEAF95849FBA5B8','B-C5BB618A6E6342F4A6D7','RECEIVE','ON_SALE','ON_SALE',4,48,'2026-11-08 22:10:00.000000','常德老街特产店','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T22:10\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-477CBBEAF95849FBA5B8\",\"eventType\":\"RECEIVE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"4\",\"locationCode\":\"常德老街特产店\",\"operatorUserId\":\"48\",\"prevEventId\":\"E-39FC6BBB9A914CE5A789\",\"prevHash\":\"4c65cafe22f3df90720932bdcc4eff0d9b9d85de00bf4758e2f8e0112c36fcdd\",\"processData\":{\"discrepancyCode\":\"\",\"packageIntact\":\"是\",\"quantityReceived\":\"100\",\"temperature\":\"4\"},\"resultStatus\":\"ON_SALE\",\"stage\":\"ON_SALE\",\"targetOrgId\":\"\"}','57317132fea2b152dc258d17b0e105de0973c42c10857873b022d648f71de9ac',NULL,'E-39FC6BBB9A914CE5A789','4c65cafe22f3df90720932bdcc4eff0d9b9d85de00bf4758e2f8e0112c36fcdd','bf1fb4e3-b495-40db-94b2-bbe779fefba4','COMMITTED','4da676a6f6255e08a5960cac51d0072ac77eba2c59c74e22a5d91d925fa030b6',34,NULL,NULL,'2026-11-08 11:18:10.758488'),('E-4BDDE4AB6BE7407AA87F','B-D584BC5A5AA54C5291CF','BREEDING_RECORD','SOURCE','ACTIVE',8,36,'2026-11-08 08:00:00.000000','常德市鼎城区1号麻鸭养殖场','{\"batchId\":\"B-D584BC5A5AA54C5291CF\",\"businessTime\":\"2026-11-08T08:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-4BDDE4AB6BE7407AA87F\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"常德市鼎城区1号麻鸭养殖场\",\"operatorUserId\":\"36\",\"prevEventId\":\"\",\"prevHash\":\"16d973d7d5e8adec4bfc4288cfe22e90e10049f0adfd416c972ca07490cbf04a\",\"processData\":{\"breedingBatchNo\":\"YZ-20261108-01\",\"feedBatchNo\":\"SL-20261106-02\",\"healthStatus\":\"正常\",\"medicationRecord\":\"YY-20261101-03\",\"remark\":\"养殖周期120天，鸭群健康，休药期已结束\",\"stockQuantity\":\"100\",\"vaccineRecord\":\"YM-20261020-01\",\"withdrawalPeriodEnd\":\"2026-11-06\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}','487fefb18f2b416d4cf07712d906d7a40fb194b3a0402f377d11726b06e6c16d',NULL,NULL,'16d973d7d5e8adec4bfc4288cfe22e90e10049f0adfd416c972ca07490cbf04a','a1829559-ea57-40cf-9a50-bd85efd9ae31','COMMITTED','30e376e144136716a3dcf7010b637b7a224291d6460eebae4d4b6ba83ce27e45',18,NULL,NULL,'2026-11-08 11:17:36.854244'),('E-4C041B7ADAB34EF1900E','B-39D9C2A4FB694E9B86EE','BREEDING_RECORD','SOURCE','ACTIVE',8,36,'2026-11-08 08:00:00.000000','常德市鼎城区1号麻鸭养殖场','{\"batchId\":\"B-39D9C2A4FB694E9B86EE\",\"businessTime\":\"2026-11-08T08:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-4C041B7ADAB34EF1900E\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"常德市鼎城区1号麻鸭养殖场\",\"operatorUserId\":\"36\",\"prevEventId\":\"\",\"prevHash\":\"f7fd465092bdda40422f0c2ab9b3c19a90edf218627b27024b61fb4288eca4e1\",\"processData\":{\"breedingBatchNo\":\"YZ-20261108-01\",\"feedBatchNo\":\"SL-20261106-02\",\"healthStatus\":\"正常\",\"medicationRecord\":\"YY-20261101-03\",\"remark\":\"养殖周期120天，鸭群健康，休药期已结束\",\"stockQuantity\":\"100\",\"vaccineRecord\":\"YM-20261020-01\",\"withdrawalPeriodEnd\":\"2026-11-06\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}','d698102786d535e310b61d6d5b8713338380c151e98f22439925464799cd0fed',NULL,NULL,'f7fd465092bdda40422f0c2ab9b3c19a90edf218627b27024b61fb4288eca4e1','45245336-c7d8-4837-8744-e57bf59eec6f','COMMITTED','f2085fc15330162638866a7cdf6bf93d2fd1babb6846138e319fa29b3c70c887',37,NULL,NULL,'2026-11-08 11:29:33.536908'),('E-4CEDB67D14554BEDAEE8','B-3CC9C77146D240D18BEE','SAUCE','SAUCED','ACTIVE',2,41,'2026-11-08 16:50:00.000000','一号酱卤车间','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T16:50\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-4CEDB67D14554BEDAEE8\",\"eventType\":\"SAUCE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"一号酱卤车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-118BD66E78F04C9BA940\",\"prevHash\":\"ae4b5ddcd08048126d024f2c211e78d77528c097639c2ca98f991bf94190cf09\",\"processData\":{\"actualTemperature\":\"94.5\",\"ccpResult\":\"PASS\",\"durationMin\":\"90\",\"endAt\":\"2026-11-08T16:50:00\",\"equipmentId\":\"LU-02\",\"formulaVersion\":\"CDJBY-FORMULA-V3\",\"pH\":\"6.2\",\"pressureKPa\":\"101\",\"salinity\":\"3.5\",\"setTemperature\":\"95\",\"startAt\":\"2026-11-08T15:20:00\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SAUCED\",\"targetOrgId\":\"\"}','d6772c1b68fb48782199e4850ee1e9554146aa4cbaee785c7e3fa3a0d2e4969f',NULL,'E-118BD66E78F04C9BA940','ae4b5ddcd08048126d024f2c211e78d77528c097639c2ca98f991bf94190cf09','19dbe27b-c248-490c-bbc3-3db12de9b1f6','COMMITTED','62b8e59985f6aff7d23d127f6fcfd9a018c9924891dce2048d20416084e66da9',45,NULL,NULL,'2026-11-08 11:29:50.462253'),('E-546B7DDF767E4FF5B1A4','B-D584BC5A5AA54C5291CF','RECEIVE','RECEIVED','ACTIVE',2,41,'2026-11-08 10:00:00.000000','加工企业原料收货区','{\"batchId\":\"B-D584BC5A5AA54C5291CF\",\"businessTime\":\"2026-11-08T10:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-546B7DDF767E4FF5B1A4\",\"eventType\":\"RECEIVE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"加工企业原料收货区\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-C3B6BE45E07D4EA5BBF3\",\"prevHash\":\"7eb5d2270606a9b71571414cf6b99ad741b236b1e6c1a159f39939ac8edbf9db\",\"processData\":{\"discrepancyCode\":\"\",\"packageIntact\":\"是\",\"quantityReceived\":\"100\",\"temperature\":\"4\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"RECEIVED\",\"targetOrgId\":\"\"}','2c1b427413dd10de6c72ddeb50dfe5b6a8fc84450788e6b4d4ac25774c0ef4f0',NULL,'E-C3B6BE45E07D4EA5BBF3','7eb5d2270606a9b71571414cf6b99ad741b236b1e6c1a159f39939ac8edbf9db','50f3d751-05b9-47fe-ab0c-041b5a58678f','COMMITTED','4322a7185782df14aa5a75bf900ded018fb5974729d9f8b290fbf64e56348a67',22,NULL,NULL,'2026-11-08 11:17:45.311234'),('E-58D22977D67A4B98B1DF','B-C5BB618A6E6342F4A6D7','TRANSPORT','IN_TRANSIT','IN_TRANSIT',3,45,'2026-11-08 21:20:00.000000','沅水冷链物流运输节点','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T21:20\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-58D22977D67A4B98B1DF\",\"eventType\":\"TRANSPORT\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"3\",\"locationCode\":\"沅水冷链物流运输节点\",\"operatorUserId\":\"45\",\"prevEventId\":\"E-10DC4BF6F734497AAA47\",\"prevHash\":\"74265e795a8511e781b0e352734502abf3d2ed094542b945e0fd95a3dfff9f3c\",\"processData\":{\"alarmCount\":\"0\",\"coldChainCompliant\":\"PASS\",\"fromPlace\":\"常德酱板鸭食品有限公司\",\"sealNo\":\"SEAL-PRO-20261108-001\",\"temperature\":\"4\",\"toPlace\":\"常德老街特产店\",\"vehicleRef\":\"湘J-LOG-03\"},\"resultStatus\":\"IN_TRANSIT\",\"stage\":\"IN_TRANSIT\",\"targetOrgId\":\"\"}','0aa44f5952c37edd56b345679c669a8c446dd7b90ea06cbb6f3e20cfe6ade93d',NULL,'E-10DC4BF6F734497AAA47','74265e795a8511e781b0e352734502abf3d2ed094542b945e0fd95a3dfff9f3c','1d237413-613b-439a-8a28-939c32a0e275','COMMITTED','861eeffef273753abc5fafcca68fdd7e4811d98982a98797c3ba851db002d3d5',32,NULL,NULL,'2026-11-08 11:18:06.466349'),('E-5FA896BA43C4405FABDA','B-D584BC5A5AA54C5291CF','QUARANTINE','QUARANTINED','ACTIVE',8,39,'2026-11-08 09:00:00.000000','常德市动物检疫申报点','{\"batchId\":\"B-D584BC5A5AA54C5291CF\",\"businessTime\":\"2026-11-08T09:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-5FA896BA43C4405FABDA\",\"eventType\":\"QUARANTINE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"常德市动物检疫申报点\",\"operatorUserId\":\"39\",\"prevEventId\":\"E-87D486CFF6DD4EC3AC0E\",\"prevHash\":\"e03f6be24a41f52fb3906697114b84ec5f5485388d3bfabe05a316b5f3255036\",\"processData\":{\"issuerOrg\":\"常德市动物疫病预防控制中心\",\"quarantineCertNo\":\"JY-430700-20261108-001\",\"quarantineDate\":\"2026-11-08\",\"quarantineResult\":\"PASS\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"QUARANTINED\",\"targetOrgId\":\"\"}','1ca2f51943e450c2f96cfcec569aa21494dd5e128bc60bd7d96456143b6d15c5',NULL,'E-87D486CFF6DD4EC3AC0E','e03f6be24a41f52fb3906697114b84ec5f5485388d3bfabe05a316b5f3255036','17e6b01b-caaa-401e-90bc-242c98032866','COMMITTED','827eccd6418cc19ad0c37cbf588d56160bcde1fbd68cb4a4b43494d7fbd424cd',20,NULL,NULL,'2026-11-08 11:17:36.927270'),('E-6FF2C27B73E649829771','B-C5BB618A6E6342F4A6D7','QUALITY_CHECK','ROASTED','ACTIVE',2,42,'2026-11-08 19:00:00.000000','加工企业质检室','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T19:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-6FF2C27B73E649829771\",\"eventType\":\"QUALITY_CHECK\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"加工企业质检室\",\"operatorUserId\":\"42\",\"prevEventId\":\"E-92B55180A9D24E40A7DB\",\"prevHash\":\"185ca152c2c88507e16fd3a227f784716f30a07035690820a6a98925e7f0b4de\",\"processData\":{\"inspectionType\":\"微生物检测\",\"microbialResult\":\"PASS\",\"moisture\":\"45.2\",\"overallResult\":\"PASS\",\"remark\":\"菌落总数和大肠菌群均符合企业标准\",\"sampleNo\":\"PRO-QA-20261108-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"ROASTED\",\"targetOrgId\":\"\"}','9293d5f454cd3d6a98dfd97bf27357dd5ba367cc40eef111912308ed2b752b68',NULL,'E-92B55180A9D24E40A7DB','185ca152c2c88507e16fd3a227f784716f30a07035690820a6a98925e7f0b4de','a5cffa6b-14c9-4d43-b039-8d5c46f3a4bb','COMMITTED','bc3514053d3714d51e6662ef60f6e9e729af69f7a90f7c38583b6df07047d183',28,NULL,NULL,'2026-11-08 11:17:58.040628'),('E-713A4F66223F44978627','B-3CC9C77146D240D18BEE','DISPATCH','DISPATCHED','DISPATCHED',2,41,'2026-11-08 21:00:00.000000','成品冷库发货区','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T21:00\",\"carrierOrgId\":\"3\",\"discrepancyCode\":\"\",\"eventId\":\"E-713A4F66223F44978627\",\"eventType\":\"DISPATCH\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"成品冷库发货区\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-CC3F984D18884CA792A5\",\"prevHash\":\"fccb54474a2b52c5b89d9c0e7345e0683c16d3d2d40e6968e4a07002298089ee\",\"processData\":{\"destination\":\"常德老街特产店\",\"sealNo\":\"SEAL-PRO-20261108-001\",\"temperature\":\"4\",\"vehicleRef\":\"湘J-LOG-03\"},\"resultStatus\":\"DISPATCHED\",\"stage\":\"DISPATCHED\",\"targetOrgId\":\"4\"}','600b915c3209a3e38f5a049d8baee12940223cc318683b0a9d774f3433d1d4a5',NULL,'E-CC3F984D18884CA792A5','fccb54474a2b52c5b89d9c0e7345e0683c16d3d2d40e6968e4a07002298089ee','a558d3b5-8ba1-4453-98ae-37a6e4cff62b','COMMITTED','8ecca299bc7f9259f3c3b24b6efd0209829b086923b47d0a5d9394d283e6b3aa',50,NULL,NULL,'2026-11-08 11:30:00.976467'),('E-809B927CFA864B87B8BA','B-3CC9C77146D240D18BEE','SALE','SOLD','SOLD',4,49,'2026-11-08 23:00:00.000000','常德老街特产店','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T23:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-809B927CFA864B87B8BA\",\"eventType\":\"SALE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"4\",\"locationCode\":\"常德老街特产店\",\"operatorUserId\":\"49\",\"prevEventId\":\"E-DF98933B176841D78CB6\",\"prevHash\":\"def2a8e5e167cc7794b560dc4e043f9a94fe5d7e9b56667c136e802112474f23\",\"processData\":{\"quantitySold\":\"100\",\"remainingQuantity\":\"0\",\"saleOrderHash\":\"SALE-20261108-001\",\"salesChannel\":\"门店\",\"storageTemperature\":\"4\"},\"resultStatus\":\"SOLD\",\"stage\":\"SOLD\",\"targetOrgId\":\"\"}','38e960d7d69dd82298d304045eafa4d31dd65fae88e30524db7616a6e6cf6a27',NULL,'E-DF98933B176841D78CB6','def2a8e5e167cc7794b560dc4e043f9a94fe5d7e9b56667c136e802112474f23','41706837-6980-494d-873e-aece14ae5c0c','COMMITTED','3e91292947ea5d1e1d952dcaa07a24b07dce6d927aa01f3e9884c0169947850f',54,NULL,NULL,'2026-11-08 11:30:09.660308'),('E-85743BE0BEAA46258CBF','B-C5BB618A6E6342F4A6D7','WAREHOUSE_IN','WAREHOUSED','ACTIVE',2,43,'2026-11-08 20:30:00.000000','成品冷库一号库','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T20:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-85743BE0BEAA46258CBF\",\"eventType\":\"WAREHOUSE_IN\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"成品冷库一号库\",\"operatorUserId\":\"43\",\"prevEventId\":\"E-8B77E313EF184E908392\",\"prevHash\":\"7110999b5f25bf56ab5785d3991c575042c165a3825aa9dcb608d5b91950bcc9\",\"processData\":{\"binNo\":\"A-01-03\",\"coldChainStatus\":\"NORMAL\",\"quantity\":\"100\",\"temperature\":\"4\",\"warehouseId\":\"CZDY-WH-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"WAREHOUSED\",\"targetOrgId\":\"\"}','a6acdc3d7eac703cdf198a7981d84f162f83cdf8fe0bef2f183517d99815f0b7',NULL,'E-8B77E313EF184E908392','7110999b5f25bf56ab5785d3991c575042c165a3825aa9dcb608d5b91950bcc9','3ae4abc1-dd6f-4d47-b138-7d7ba8927686','COMMITTED','6e8d0eb6fee46e3d3e1253798d5ea2bc76786de005d293fee22cbab5fad19499',30,NULL,NULL,'2026-11-08 11:18:02.258466'),('E-87D486CFF6DD4EC3AC0E','B-D584BC5A5AA54C5291CF','QUALITY_CHECK','SOURCE','ACTIVE',8,37,'2026-11-08 08:30:00.000000','供应商内部质检室','{\"batchId\":\"B-D584BC5A5AA54C5291CF\",\"businessTime\":\"2026-11-08T08:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-87D486CFF6DD4EC3AC0E\",\"eventType\":\"QUALITY_CHECK\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"供应商内部质检室\",\"operatorUserId\":\"37\",\"prevEventId\":\"E-4BDDE4AB6BE7407AA87F\",\"prevHash\":\"487fefb18f2b416d4cf07712d906d7a40fb194b3a0402f377d11726b06e6c16d\",\"processData\":{\"inspectionType\":\"工序抽检\",\"microbialResult\":\"PASS\",\"moisture\":\"68.5\",\"overallResult\":\"PASS\",\"remark\":\"感官正常，微生物指标符合要求\",\"sampleNo\":\"SUP-QC-20261108-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}','e03f6be24a41f52fb3906697114b84ec5f5485388d3bfabe05a316b5f3255036',NULL,'E-4BDDE4AB6BE7407AA87F','487fefb18f2b416d4cf07712d906d7a40fb194b3a0402f377d11726b06e6c16d','80bf2a86-ef4d-476b-9044-b8a6e1797b50','COMMITTED','50929ccf0c581005cce8265ffe170ffc0f71009cab65177709f394a65daf6854',19,NULL,NULL,'2026-11-08 11:17:36.898055'),('E-88A811F982A84030958F','B-C5BB618A6E6342F4A6D7','SAUCE','SAUCED','ACTIVE',2,41,'2026-11-08 16:50:00.000000','一号酱卤车间','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T16:50\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-88A811F982A84030958F\",\"eventType\":\"SAUCE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"一号酱卤车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-427F6062552748F1A6CE\",\"prevHash\":\"d5a7f132c218f664865054831563dfde13cb10f34992b1a2565f79336243a85a\",\"processData\":{\"actualTemperature\":\"94.5\",\"ccpResult\":\"PASS\",\"durationMin\":\"90\",\"endAt\":\"2026-11-08T16:50:00\",\"equipmentId\":\"LU-02\",\"formulaVersion\":\"CDJBY-FORMULA-V3\",\"pH\":\"6.2\",\"pressureKPa\":\"101\",\"salinity\":\"3.5\",\"setTemperature\":\"95\",\"startAt\":\"2026-11-08T15:20:00\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SAUCED\",\"targetOrgId\":\"\"}','ebbaee41f1ae98769027a05b203e08bc6bbb0709a62299875b1a19afbca99af5',NULL,'E-427F6062552748F1A6CE','d5a7f132c218f664865054831563dfde13cb10f34992b1a2565f79336243a85a','bc3a1020-2e13-4200-aa3e-831cd8ca669b','COMMITTED','cf4d8d3f8494e4cb2ff62f58b44313fa0aa8c90d47f0e1fb6ea507a1476c3a80',26,NULL,NULL,'2026-11-08 11:17:53.839196'),('E-8B77E313EF184E908392','B-C5BB618A6E6342F4A6D7','PACKAGE','PACKAGED','ACTIVE',2,41,'2026-11-08 20:00:00.000000','真空包装一车间','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T20:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-8B77E313EF184E908392\",\"eventType\":\"PACKAGE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"真空包装一车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-6FF2C27B73E649829771\",\"prevHash\":\"9293d5f454cd3d6a98dfd97bf27357dd5ba367cc40eef111912308ed2b752b68\",\"processData\":{\"expiryDate\":\"2027-05-08\",\"netWeight\":\"600\",\"packageMaterialBatchNo\":\"BZ-20261107-01\",\"packageQuantity\":\"100\",\"productCode\":\"CDJBY-600\",\"productionLineNo\":\"PACK-LINE-01\",\"qaResult\":\"PASS\",\"sealTemperature\":\"145\",\"spec\":\"600g/袋\",\"vacuumDegree\":\"-0.095MPa\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"PACKAGED\",\"targetOrgId\":\"\"}','7110999b5f25bf56ab5785d3991c575042c165a3825aa9dcb608d5b91950bcc9',NULL,'E-6FF2C27B73E649829771','9293d5f454cd3d6a98dfd97bf27357dd5ba367cc40eef111912308ed2b752b68','ec00911b-3c9d-4def-a413-2d87ea21e5ed','COMMITTED','ce275347b6d4b3f4d07bf105508780ec28136e667a4d3ebb654c3977f0b12c67',29,NULL,NULL,'2026-11-08 11:18:00.156384'),('E-9270FE70A7C54835BA54','B-3CC9C77146D240D18BEE','ROAST','ROASTED','ACTIVE',2,41,'2026-11-08 18:30:00.000000','烘烤一车间','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T18:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-9270FE70A7C54835BA54\",\"eventType\":\"ROAST\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"烘烤一车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-4CEDB67D14554BEDAEE8\",\"prevHash\":\"d6772c1b68fb48782199e4850ee1e9554146aa4cbaee785c7e3fa3a0d2e4969f\",\"processData\":{\"ccpCompliant\":\"PASS\",\"coreTemperature\":\"78\",\"endAt\":\"2026-11-08T18:30:00\",\"equipmentId\":\"HK-01\",\"exceptionCode\":\"\",\"humidity\":\"35\",\"processType\":\"烘烤\",\"setTemperature\":\"180\",\"startAt\":\"2026-11-08T17:00:00\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"ROASTED\",\"targetOrgId\":\"\"}','f8385304c57d357077553c4e344d6834c458ffe043bd6b207c49682a32e78982',NULL,'E-4CEDB67D14554BEDAEE8','d6772c1b68fb48782199e4850ee1e9554146aa4cbaee785c7e3fa3a0d2e4969f','4eecff63-2b14-4d64-afa4-8f0cef5ceb24','COMMITTED','255cf75188f72526f8d934b24efce0fe5fb10ff29600eaa1283d3d86429afe0f',46,NULL,NULL,'2026-11-08 11:29:52.566608'),('E-92B55180A9D24E40A7DB','B-C5BB618A6E6342F4A6D7','ROAST','ROASTED','ACTIVE',2,41,'2026-11-08 18:30:00.000000','烘烤一车间','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T18:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-92B55180A9D24E40A7DB\",\"eventType\":\"ROAST\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"烘烤一车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-88A811F982A84030958F\",\"prevHash\":\"ebbaee41f1ae98769027a05b203e08bc6bbb0709a62299875b1a19afbca99af5\",\"processData\":{\"ccpCompliant\":\"PASS\",\"coreTemperature\":\"78\",\"endAt\":\"2026-11-08T18:30:00\",\"equipmentId\":\"HK-01\",\"exceptionCode\":\"\",\"humidity\":\"35\",\"processType\":\"烘烤\",\"setTemperature\":\"180\",\"startAt\":\"2026-11-08T17:00:00\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"ROASTED\",\"targetOrgId\":\"\"}','185ca152c2c88507e16fd3a227f784716f30a07035690820a6a98925e7f0b4de',NULL,'E-88A811F982A84030958F','ebbaee41f1ae98769027a05b203e08bc6bbb0709a62299875b1a19afbca99af5','d1f86506-13c6-40c3-bb66-c4a9ed575356','COMMITTED','780ceadd8fbf43f7723f5b6f0d1e3d0a81b9f74515007747ff50f149c5e488d1',27,NULL,NULL,'2026-11-08 11:17:55.943941'),('E-9B6CAFD4278D4C78B4A9','B-3CC9C77146D240D18BEE','PACKAGE','PACKAGED','ACTIVE',2,41,'2026-11-08 20:00:00.000000','真空包装一车间','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T20:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-9B6CAFD4278D4C78B4A9\",\"eventType\":\"PACKAGE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"真空包装一车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"E-DD9FA2B846C7475CAAA1\",\"prevHash\":\"71504837fdd2ebfc0af3db9887cf418ac1c75e964b86990186e19e017955e7b5\",\"processData\":{\"expiryDate\":\"2027-05-08\",\"netWeight\":\"600\",\"packageMaterialBatchNo\":\"BZ-20261107-01\",\"packageQuantity\":\"100\",\"productCode\":\"CDJBY-600\",\"productionLineNo\":\"PACK-LINE-01\",\"qaResult\":\"PASS\",\"sealTemperature\":\"145\",\"spec\":\"600g/袋\",\"vacuumDegree\":\"-0.095MPa\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"PACKAGED\",\"targetOrgId\":\"\"}','60f617eaf52994161925fee22c4ac99c50f39407885bcb75313b4825e17dadd5',NULL,'E-DD9FA2B846C7475CAAA1','71504837fdd2ebfc0af3db9887cf418ac1c75e964b86990186e19e017955e7b5','00b175cc-a065-4d25-b811-ad62d8c1fee3','COMMITTED','abd5e8df0ed9fe29b9946cc4de55a257272d7c7c0bae9ff5c3c60fddb3aa96d2',48,NULL,NULL,'2026-11-08 11:29:56.783639'),('E-BE6604CA9D6444A48854','B-39D9C2A4FB694E9B86EE','QUARANTINE','QUARANTINED','ACTIVE',8,39,'2026-11-08 09:00:00.000000','常德市动物检疫申报点','{\"batchId\":\"B-39D9C2A4FB694E9B86EE\",\"businessTime\":\"2026-11-08T09:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-BE6604CA9D6444A48854\",\"eventType\":\"QUARANTINE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"常德市动物检疫申报点\",\"operatorUserId\":\"39\",\"prevEventId\":\"E-3623D186C3124F099421\",\"prevHash\":\"b74e3e8d374288f07552296b05ae2f059d0d249895abc769343d7907775f030b\",\"processData\":{\"issuerOrg\":\"常德市动物疫病预防控制中心\",\"quarantineCertNo\":\"JY-430700-20261108-001\",\"quarantineDate\":\"2026-11-08\",\"quarantineResult\":\"PASS\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"QUARANTINED\",\"targetOrgId\":\"\"}','93cb95cec763bf781416b204a42861f556bf1183ed4398ede8d62d9019732f96',NULL,'E-3623D186C3124F099421','b74e3e8d374288f07552296b05ae2f059d0d249895abc769343d7907775f030b','20656f59-992a-4663-91df-9045a1bf37b0','COMMITTED','2c2be21a473c680ca3bce92c29a029c3d4b6b712ae88eefe310552b6d3fb9577',39,NULL,NULL,'2026-11-08 11:29:33.610055'),('E-C3B6BE45E07D4EA5BBF3','B-D584BC5A5AA54C5291CF','DISPATCH','DISPATCHED','DISPATCHED',8,38,'2026-11-08 09:30:00.000000','供应商发货区','{\"batchId\":\"B-D584BC5A5AA54C5291CF\",\"businessTime\":\"2026-11-08T09:30\",\"carrierOrgId\":\"3\",\"discrepancyCode\":\"\",\"eventId\":\"E-C3B6BE45E07D4EA5BBF3\",\"eventType\":\"DISPATCH\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"供应商发货区\",\"operatorUserId\":\"38\",\"prevEventId\":\"E-5FA896BA43C4405FABDA\",\"prevHash\":\"1ca2f51943e450c2f96cfcec569aa21494dd5e128bc60bd7d96456143b6d15c5\",\"processData\":{\"destination\":\"常德酱板鸭食品有限公司原料仓库\",\"sealNo\":\"SEAL-SUP-20261108-001\",\"temperature\":\"4\",\"vehicleRef\":\"湘JB1688\"},\"resultStatus\":\"DISPATCHED\",\"stage\":\"DISPATCHED\",\"targetOrgId\":\"2\"}','7eb5d2270606a9b71571414cf6b99ad741b236b1e6c1a159f39939ac8edbf9db',NULL,'E-5FA896BA43C4405FABDA','1ca2f51943e450c2f96cfcec569aa21494dd5e128bc60bd7d96456143b6d15c5','87749c27-a9f1-4855-a53b-10d695f820da','COMMITTED','94ffed69367a80929f9402a9c74a5bec1c3aaa918be9aa63738e1f7d7e749d44',21,NULL,NULL,'2026-11-08 11:17:43.202778'),('E-C5E8443572734B60B4ED','B-C5BB618A6E6342F4A6D7','SLAUGHTER','SLAUGHTERED','ACTIVE',2,41,'2026-11-08 10:30:00.000000','常德酱板鸭食品有限公司屠宰车间','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T10:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-C5E8443572734B60B4ED\",\"eventType\":\"SLAUGHTER\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司屠宰车间\",\"operatorUserId\":\"41\",\"prevEventId\":\"\",\"prevHash\":\"3b68b6a6e80f04d3cac6e8442c78099b8df5c305b856196ed3a54f695422ce6a\",\"processData\":{\"brineTemperature\":\"4\",\"carcassWeight\":\"180\",\"liveWeight\":\"250\",\"marinadeDurationMin\":\"240\",\"marinadeEndAt\":\"2026-11-08T15:00:00\",\"marinadeStartAt\":\"2026-11-08T11:00:00\",\"preSlaughterQuarantineResult\":\"PASS\",\"saltBatchNo\":\"SY-20261106-01\",\"slaughterhouseId\":\"CZDY-SL-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SLAUGHTERED\",\"targetOrgId\":\"\"}','c3cde6e4f2e5181ef09245b804a2a49b8f9276c21200cc0ff1fa705b2e2df213',NULL,NULL,'3b68b6a6e80f04d3cac6e8442c78099b8df5c305b856196ed3a54f695422ce6a','7a89aa40-bb8c-4ea3-94a6-30293342ba1b','COMMITTED','2facdb4e6ba74a74c49388de8ea9cb257dc8eceb5c88b0d9f8dc7fb9f5c90231',24,NULL,NULL,'2026-11-08 11:17:49.615788'),('E-CC3F984D18884CA792A5','B-3CC9C77146D240D18BEE','WAREHOUSE_IN','WAREHOUSED','ACTIVE',2,43,'2026-11-08 20:30:00.000000','成品冷库一号库','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T20:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-CC3F984D18884CA792A5\",\"eventType\":\"WAREHOUSE_IN\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"成品冷库一号库\",\"operatorUserId\":\"43\",\"prevEventId\":\"E-9B6CAFD4278D4C78B4A9\",\"prevHash\":\"60f617eaf52994161925fee22c4ac99c50f39407885bcb75313b4825e17dadd5\",\"processData\":{\"binNo\":\"A-01-03\",\"coldChainStatus\":\"NORMAL\",\"quantity\":\"100\",\"temperature\":\"4\",\"warehouseId\":\"CZDY-WH-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"WAREHOUSED\",\"targetOrgId\":\"\"}','fccb54474a2b52c5b89d9c0e7345e0683c16d3d2d40e6968e4a07002298089ee',NULL,'E-9B6CAFD4278D4C78B4A9','60f617eaf52994161925fee22c4ac99c50f39407885bcb75313b4825e17dadd5','ddd23ae6-3ede-470a-af11-8571f9b083d5','COMMITTED','c2220449d38d2b8cbe89c5cefa21ff8a40880a077dd8222b8f8944e2934c4012',49,NULL,NULL,'2026-11-08 11:29:58.876688'),('E-D8A20BF537FF4A2694D8','B-C5BB618A6E6342F4A6D7','SALE','SOLD','SOLD',4,49,'2026-11-08 23:00:00.000000','常德老街特产店','{\"batchId\":\"B-C5BB618A6E6342F4A6D7\",\"businessTime\":\"2026-11-08T23:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-D8A20BF537FF4A2694D8\",\"eventType\":\"SALE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"4\",\"locationCode\":\"常德老街特产店\",\"operatorUserId\":\"49\",\"prevEventId\":\"E-477CBBEAF95849FBA5B8\",\"prevHash\":\"57317132fea2b152dc258d17b0e105de0973c42c10857873b022d648f71de9ac\",\"processData\":{\"quantitySold\":\"100\",\"remainingQuantity\":\"0\",\"saleOrderHash\":\"SALE-20261108-001\",\"salesChannel\":\"门店\",\"storageTemperature\":\"4\"},\"resultStatus\":\"SOLD\",\"stage\":\"SOLD\",\"targetOrgId\":\"\"}','c343bb0fe3c442c81d3542d02f5a7e076cca4e4bd8ba386c9f433f409e552e4a',NULL,'E-477CBBEAF95849FBA5B8','57317132fea2b152dc258d17b0e105de0973c42c10857873b022d648f71de9ac','c8a43e7c-8b30-4cc8-8898-035f403c1eca','COMMITTED','da5a0136c550a036eec329d15ea6fcb44bf6be081c5f89a9479a0e659d1ca4e3',35,NULL,NULL,'2026-11-08 11:18:12.966601'),('E-DD9FA2B846C7475CAAA1','B-3CC9C77146D240D18BEE','QUALITY_CHECK','ROASTED','ACTIVE',2,42,'2026-11-08 19:00:00.000000','加工企业质检室','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T19:00\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-DD9FA2B846C7475CAAA1\",\"eventType\":\"QUALITY_CHECK\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"加工企业质检室\",\"operatorUserId\":\"42\",\"prevEventId\":\"E-9270FE70A7C54835BA54\",\"prevHash\":\"f8385304c57d357077553c4e344d6834c458ffe043bd6b207c49682a32e78982\",\"processData\":{\"inspectionType\":\"微生物检测\",\"microbialResult\":\"PASS\",\"moisture\":\"45.2\",\"overallResult\":\"PASS\",\"remark\":\"菌落总数和大肠菌群均符合企业标准\",\"sampleNo\":\"PRO-QA-20261108-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"ROASTED\",\"targetOrgId\":\"\"}','71504837fdd2ebfc0af3db9887cf418ac1c75e964b86990186e19e017955e7b5',NULL,'E-9270FE70A7C54835BA54','f8385304c57d357077553c4e344d6834c458ffe043bd6b207c49682a32e78982','fa2bb3b0-37fa-412c-a568-bdf3d75de158','COMMITTED','abc8550923ad68acbe6037a480b276b9b4f082f706b498112e1b23249cffb295',47,NULL,NULL,'2026-11-08 11:29:54.683939'),('E-DF98933B176841D78CB6','B-3CC9C77146D240D18BEE','RECEIVE','ON_SALE','ON_SALE',4,48,'2026-11-08 22:10:00.000000','常德老街特产店','{\"batchId\":\"B-3CC9C77146D240D18BEE\",\"businessTime\":\"2026-11-08T22:10\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-DF98933B176841D78CB6\",\"eventType\":\"RECEIVE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"4\",\"locationCode\":\"常德老街特产店\",\"operatorUserId\":\"48\",\"prevEventId\":\"E-363AEAAD7F9541F99216\",\"prevHash\":\"7424ab5630614ec95141533a9f9b01f4465a8da1d554e14a9d059fcaa2522502\",\"processData\":{\"discrepancyCode\":\"\",\"packageIntact\":\"是\",\"quantityReceived\":\"100\",\"temperature\":\"4\"},\"resultStatus\":\"ON_SALE\",\"stage\":\"ON_SALE\",\"targetOrgId\":\"\"}','def2a8e5e167cc7794b560dc4e043f9a94fe5d7e9b56667c136e802112474f23',NULL,'E-363AEAAD7F9541F99216','7424ab5630614ec95141533a9f9b01f4465a8da1d554e14a9d059fcaa2522502','f3b81572-d8ab-4033-87b3-642198f1ec0f','COMMITTED','30188412798dffadd1080bb1bc2251d8947c27c06606310ca36b3c44526b9062',53,NULL,NULL,'2026-11-08 11:30:07.439496'),('E-F08202E599F14EB9A64D','B-39D9C2A4FB694E9B86EE','DISPATCH','DISPATCHED','DISPATCHED',8,38,'2026-11-08 09:30:00.000000','供应商发货区','{\"batchId\":\"B-39D9C2A4FB694E9B86EE\",\"businessTime\":\"2026-11-08T09:30\",\"carrierOrgId\":\"3\",\"discrepancyCode\":\"\",\"eventId\":\"E-F08202E599F14EB9A64D\",\"eventType\":\"DISPATCH\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"供应商发货区\",\"operatorUserId\":\"38\",\"prevEventId\":\"E-BE6604CA9D6444A48854\",\"prevHash\":\"93cb95cec763bf781416b204a42861f556bf1183ed4398ede8d62d9019732f96\",\"processData\":{\"destination\":\"常德酱板鸭食品有限公司原料仓库\",\"sealNo\":\"SEAL-SUP-20261108-001\",\"temperature\":\"4\",\"vehicleRef\":\"湘JB1688\"},\"resultStatus\":\"DISPATCHED\",\"stage\":\"DISPATCHED\",\"targetOrgId\":\"2\"}','2fc3438b08c01f108de381d0293317dde488dfd4b8db48544e6ea6d9aee093f3',NULL,'E-BE6604CA9D6444A48854','93cb95cec763bf781416b204a42861f556bf1183ed4398ede8d62d9019732f96','ce9f6536-60b8-4fb1-9049-af96302ca718','COMMITTED','9721b4e9c6abbb479775c2d34096dafaca863fb3eed52d0313174546c114e039',40,NULL,NULL,'2026-11-08 11:29:39.850142');
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

-- Dump completed on 2026-11-08 11:34:41

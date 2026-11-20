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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
INSERT INTO `audit_log` VALUES (1,1,1,'CREATE_BATCH','TRACE_BATCH','B-B9E25EAC78A34A149FE3','{\"batchId\":\"B-B9E25EAC78A34A149FE3\",\"batchNo\":\"YL-20261101001859-BDC1\",\"batchType\":\"RAW_DUCK\",\"createdAt\":\"2026-11-01T00:18:59.084166200\",\"custodianOrgId\":\"1\",\"expiryDate\":\"\",\"lastEventId\":\"\",\"lastHash\":\"6aa68270bbd3747178c4a56ca0866a75815f0667d4b90bd0425bf79209dabf32\",\"ownerOrgId\":\"1\",\"parentBatchIds\":[],\"productName\":\"常德麻鸭\",\"productionDate\":\"2026-11-01\",\"quantity\":\"200\",\"spec\":\"整鸭\",\"stage\":\"SOURCE\",\"status\":\"ACTIVE\",\"traceCode\":\"\",\"unit\":\"kg\"}',NULL,'2026-11-01 00:19:01.214030'),(2,1,1,'QUARANTINE','TRACE_EVENT','E-05457F6A3E7C4FC392C3','{\"batchId\":\"B-B9E25EAC78A34A149FE3\",\"businessTime\":\"2026-11-01T00:20\",\"carrierOrgId\":\"\",\"eventId\":\"E-05457F6A3E7C4FC392C3\",\"eventType\":\"QUARANTINE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"1\",\"locationCode\":\"常德金鸭养殖基地\",\"operatorUserId\":\"1\",\"prevEventId\":\"\",\"prevHash\":\"6aa68270bbd3747178c4a56ca0866a75815f0667d4b90bd0425bf79209dabf32\",\"processData\":{\"issuerOrg\":\"常德动物卫生监督所\",\"quarantineCertNo\":\"QY-20261101-001\",\"quarantineDate\":\"2026-11-01\",\"quarantineResult\":\"PASS\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"QUARANTINED\",\"targetOrgId\":\"\"}',NULL,'2026-11-01 00:19:12.305143'),(3,1,1,'DISPATCH','TRACE_EVENT','E-E895546863A444E2A7CA','{\"batchId\":\"B-B9E25EAC78A34A149FE3\",\"businessTime\":\"2026-11-01T00:22\",\"carrierOrgId\":\"\",\"eventId\":\"E-E895546863A444E2A7CA\",\"eventType\":\"DISPATCH\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"1\",\"locationCode\":\"常德金鸭养殖基地\",\"operatorUserId\":\"1\",\"prevEventId\":\"E-05457F6A3E7C4FC392C3\",\"prevHash\":\"a1016dbbc9873378e66db03008852252f53d7e8bdd39692669290003ad9415b1\",\"processData\":{\"destination\":\"常德酱板鸭食品有限公司\",\"sealNo\":\"SEAL-001\",\"temperature\":\"12\",\"vehicleRef\":\"湘J-12345\"},\"resultStatus\":\"DISPATCHED\",\"stage\":\"DISPATCHED\",\"targetOrgId\":\"2\"}',NULL,'2026-11-01 00:19:20.060348'),(4,2,2,'RECEIVE','TRACE_EVENT','E-349415A2BB344EC1AFC3','{\"batchId\":\"B-B9E25EAC78A34A149FE3\",\"businessTime\":\"2026-11-01T00:25\",\"carrierOrgId\":\"\",\"eventId\":\"E-349415A2BB344EC1AFC3\",\"eventType\":\"RECEIVE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德加工一车间\",\"operatorUserId\":\"2\",\"prevEventId\":\"E-E895546863A444E2A7CA\",\"prevHash\":\"c490d661541add2c8d4b0431f25e2a8ce12a3d9ada37a2cd2f172e6f4213cdc3\",\"processData\":{\"discrepancyCode\":\"\",\"packageIntact\":\"是\",\"quantityReceived\":\"200\",\"temperature\":\"12\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"RECEIVED\",\"targetOrgId\":\"\"}',NULL,'2026-11-01 00:20:01.153487'),(5,2,2,'CREATE_BATCH','TRACE_BATCH','B-E564BA8B6A4A485FAB62','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"batchNo\":\"BC-20261101002032-4717\",\"batchType\":\"SEMI_FINISHED\",\"createdAt\":\"2026-11-01T00:20:32.085511200\",\"custodianOrgId\":\"2\",\"expiryDate\":\"2027-05-01\",\"lastEventId\":\"\",\"lastHash\":\"8c10742e781ee3d81fc62a3ef675f82b4ebb1d2d1e76a2f84b08b13b78ff0657\",\"ownerOrgId\":\"2\",\"parentBatchIds\":[\"B-B9E25EAC78A34A149FE3\"],\"productName\":\"酱板鸭加工批次\",\"productionDate\":\"2026-11-01\",\"quantity\":\"180\",\"spec\":\"待包装\",\"stage\":\"CREATED\",\"status\":\"ACTIVE\",\"traceCode\":\"\",\"unit\":\"kg\"}',NULL,'2026-11-01 00:20:34.141262'),(6,2,2,'SLAUGHTER','TRACE_EVENT','E-644235B0264342D58587','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T07:10\",\"carrierOrgId\":\"\",\"eventId\":\"E-644235B0264342D58587\",\"eventType\":\"SLAUGHTER\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司\",\"operatorUserId\":\"2\",\"prevEventId\":\"\",\"prevHash\":\"8c10742e781ee3d81fc62a3ef675f82b4ebb1d2d1e76a2f84b08b13b78ff0657\",\"processData\":{\"brineTemperature\":\"4\",\"carcassWeight\":\"165\",\"liveWeight\":\"200\",\"marinadeDurationMin\":\"360\",\"marinadeEndAt\":\"2026-11-01T07:00:00\",\"marinadeStartAt\":\"2026-11-01T01:00:00\",\"preSlaughterQuarantineResult\":\"PASS\",\"saltBatchNo\":\"SALT-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SLAUGHTERED\",\"targetOrgId\":\"\"}',NULL,'2026-11-01 00:20:36.235578'),(7,2,2,'MARINATE','TRACE_EVENT','E-7415ECD554CF47BFAAEB','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T07:15\",\"carrierOrgId\":\"\",\"eventId\":\"E-7415ECD554CF47BFAAEB\",\"eventType\":\"MARINATE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司\",\"operatorUserId\":\"2\",\"prevEventId\":\"E-644235B0264342D58587\",\"prevHash\":\"6406a6ea1f147710d8402a88b988b6feb85d5be12757c14e98d487468b51c617\",\"processData\":{\"durationMin\":\"360\",\"endAt\":\"2026-11-01T07:00:00\",\"equipmentId\":\"M-01\",\"saltBatchNo\":\"SALT-01\",\"startAt\":\"2026-11-01T01:00:00\",\"temperature\":\"4\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"MARINATED\",\"targetOrgId\":\"\"}',NULL,'2026-11-01 00:20:38.329365'),(8,2,2,'SAUCE','TRACE_EVENT','E-C08191BE171248E1BE8B','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T11:05\",\"carrierOrgId\":\"\",\"eventId\":\"E-C08191BE171248E1BE8B\",\"eventType\":\"SAUCE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司\",\"operatorUserId\":\"2\",\"prevEventId\":\"E-7415ECD554CF47BFAAEB\",\"prevHash\":\"61501e708a6e72cae060030a3f26c9bec23c075b1c1b4f85c5bdff5c1b5ab93f\",\"processData\":{\"actualTemperature\":\"91.5\",\"ccpResult\":\"PASS\",\"durationMin\":\"180\",\"endAt\":\"2026-11-01T11:00:00\",\"equipmentId\":\"C-01\",\"formulaVersion\":\"V1.0\",\"pH\":\"6.2\",\"pressureKPa\":\"101\",\"salinity\":\"3.5\",\"setTemperature\":\"92\",\"startAt\":\"2026-11-01T08:00:00\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SAUCED\",\"targetOrgId\":\"\"}',NULL,'2026-11-01 00:20:40.396897'),(9,2,2,'ROAST','TRACE_EVENT','E-73C279E4FE2D4CCBA465','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T13:25\",\"carrierOrgId\":\"\",\"eventId\":\"E-73C279E4FE2D4CCBA465\",\"eventType\":\"ROAST\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司\",\"operatorUserId\":\"2\",\"prevEventId\":\"E-C08191BE171248E1BE8B\",\"prevHash\":\"b0b6b0cffb3c85d7ca5eb6c5e5b103db228f62d1a3ee0a22d5aedfc082a7e5f0\",\"processData\":{\"ccpCompliant\":\"PASS\",\"coreTemperature\":\"78\",\"endAt\":\"2026-11-01T13:20:00\",\"equipmentId\":\"R-01\",\"exceptionCode\":\"\",\"humidity\":\"55\",\"processType\":\"烘烤\",\"setTemperature\":\"85\",\"startAt\":\"2026-11-01T11:20:00\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"ROASTED\",\"targetOrgId\":\"\"}',NULL,'2026-11-01 00:20:42.463928'),(10,2,2,'PACKAGE','TRACE_EVENT','E-7F681640B3974F879AA2','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T14:00\",\"carrierOrgId\":\"\",\"eventId\":\"E-7F681640B3974F879AA2\",\"eventType\":\"PACKAGE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司\",\"operatorUserId\":\"2\",\"prevEventId\":\"E-73C279E4FE2D4CCBA465\",\"prevHash\":\"45fbdff028173c796756b24495cf328635b540d796bdbd5da0b7d313391f8996\",\"processData\":{\"expiryDate\":\"2027-05-01\",\"netWeight\":\"300\",\"packageMaterialBatchNo\":\"PKG-01\",\"packageQuantity\":\"500\",\"productCode\":\"CDJBY-300\",\"productionLineNo\":\"L1\",\"qaResult\":\"PASS\",\"sealTemperature\":\"145\",\"spec\":\"300g/袋\",\"vacuumDegree\":\"-0.09MPa\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"PACKAGED\",\"targetOrgId\":\"\"}',NULL,'2026-11-01 00:20:44.535477'),(11,2,2,'WAREHOUSE_IN','TRACE_EVENT','E-B588DD8EC9FE445BA7DD','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T14:30\",\"carrierOrgId\":\"\",\"eventId\":\"E-B588DD8EC9FE445BA7DD\",\"eventType\":\"WAREHOUSE_IN\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司\",\"operatorUserId\":\"2\",\"prevEventId\":\"E-7F681640B3974F879AA2\",\"prevHash\":\"b765901bb45768fe7d31658cc150005a2fd672b605e59573347f296803ad181f\",\"processData\":{\"binNo\":\"A-01\",\"coldChainStatus\":\"NORMAL\",\"quantity\":\"150\",\"temperature\":\"4\",\"warehouseId\":\"WH-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"WAREHOUSED\",\"targetOrgId\":\"\"}',NULL,'2026-11-01 00:20:46.612833'),(12,2,2,'DISPATCH','TRACE_EVENT','E-15367AB11FBD43958C8F','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T15:00\",\"carrierOrgId\":\"3\",\"eventId\":\"E-15367AB11FBD43958C8F\",\"eventType\":\"DISPATCH\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司\",\"operatorUserId\":\"2\",\"prevEventId\":\"E-B588DD8EC9FE445BA7DD\",\"prevHash\":\"fe6f541ed88da62872e06765264c3f18e4da11ec5b54a3e43a8e55cd4add4c41\",\"processData\":{\"destination\":\"常德老街特产店\",\"sealNo\":\"SEAL-002\",\"temperature\":\"5\",\"vehicleRef\":\"湘J-LOG01\"},\"resultStatus\":\"DISPATCHED\",\"stage\":\"DISPATCHED\",\"targetOrgId\":\"4\"}',NULL,'2026-11-01 00:20:48.702190'),(13,4,3,'TRANSPORT','TRACE_EVENT','E-6A2075291FD7420FB673','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T15:20\",\"carrierOrgId\":\"\",\"eventId\":\"E-6A2075291FD7420FB673\",\"eventType\":\"TRANSPORT\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"3\",\"locationCode\":\"沅水冷链运输节点\",\"operatorUserId\":\"4\",\"prevEventId\":\"E-15367AB11FBD43958C8F\",\"prevHash\":\"e80a3775bf169fe2e29e53089f2038218017f790e78c0c70b37a6e256ac88ee9\",\"processData\":{\"alarmCount\":\"0\",\"coldChainCompliant\":\"PASS\",\"fromPlace\":\"常德加工园\",\"sealNo\":\"SEAL-002\",\"temperature\":\"4\",\"toPlace\":\"常德老街特产店\",\"vehicleRef\":\"湘J-LOG01\"},\"resultStatus\":\"IN_TRANSIT\",\"stage\":\"IN_TRANSIT\",\"targetOrgId\":\"\"}',NULL,'2026-11-01 00:20:56.875193'),(14,4,3,'DELIVER','TRACE_EVENT','E-986B72694D6445B69694','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T16:30\",\"carrierOrgId\":\"\",\"eventId\":\"E-986B72694D6445B69694\",\"eventType\":\"DELIVER\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"3\",\"locationCode\":\"沅水冷链运输节点\",\"operatorUserId\":\"4\",\"prevEventId\":\"E-6A2075291FD7420FB673\",\"prevHash\":\"1c75e1e3b4dc0369805ade738c8b12e45cda002d323b6a2e2c54a548fb17bb56\",\"processData\":{\"deliveredAt\":\"2026-11-01T16:30:00\",\"discrepancyCode\":\"\",\"receiptResult\":\"正常\",\"temperature\":\"4\"},\"resultStatus\":\"DELIVERED\",\"stage\":\"DELIVERED\",\"targetOrgId\":\"\"}',NULL,'2026-11-01 00:20:58.940977'),(15,5,4,'RECEIVE','TRACE_EVENT','E-F98ACF267CC74310B3B8','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T16:45\",\"carrierOrgId\":\"\",\"eventId\":\"E-F98ACF267CC74310B3B8\",\"eventType\":\"RECEIVE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"4\",\"locationCode\":\"常德老街特产店\",\"operatorUserId\":\"5\",\"prevEventId\":\"E-986B72694D6445B69694\",\"prevHash\":\"7baea2f550ffe7838315785a2e816fa14ee79734e003f80481000d06e86ed734\",\"processData\":{\"discrepancyCode\":\"\",\"packageIntact\":\"是\",\"quantityReceived\":\"150\",\"temperature\":\"5\"},\"resultStatus\":\"ON_SALE\",\"stage\":\"ON_SALE\",\"targetOrgId\":\"\"}',NULL,'2026-11-01 00:21:01.096723'),(16,5,4,'SALE','TRACE_EVENT','E-77B41695E4FD4454A46D','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T17:00\",\"carrierOrgId\":\"\",\"eventId\":\"E-77B41695E4FD4454A46D\",\"eventType\":\"SALE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"4\",\"locationCode\":\"沅水冷链运输节点\",\"operatorUserId\":\"5\",\"prevEventId\":\"E-F98ACF267CC74310B3B8\",\"prevHash\":\"b960871c2d081b53ca6c139a09f99a6d94d3fc92bf0ee87951918ae0ca931189\",\"processData\":{\"quantitySold\":\"20\",\"remainingQuantity\":\"130\",\"saleOrderHash\":\"ORDER-DEMO-001\",\"salesChannel\":\"门店\",\"storageTemperature\":\"5\"},\"resultStatus\":\"SOLD\",\"stage\":\"SOLD\",\"targetOrgId\":\"\"}',NULL,'2026-11-01 00:21:03.158856'),(17,6,5,'INSPECTION','TRACE_EVENT','E-87107801FBDE418E900B','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T17:30\",\"carrierOrgId\":\"\",\"eventId\":\"E-87107801FBDE418E900B\",\"eventType\":\"INSPECTION\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"5\",\"locationCode\":\"常德市市场监督管理局\",\"operatorUserId\":\"6\",\"prevEventId\":\"E-77B41695E4FD4454A46D\",\"prevHash\":\"1ff46f6a3156aebf61618d7ac01db5d50b514fdde67eaa6619a2287ba3807c1a\",\"processData\":{\"decision\":\"RELEASE\",\"indicators\":[{\"limit\":\"10000\",\"name\":\"菌落总数\",\"result\":\"PASS\",\"unit\":\"CFU/g\",\"value\":\"100\"}],\"inspectionType\":\"监督抽检\",\"overallResult\":\"PASS\",\"remark\":\"抽检合格\",\"reportNo\":\"REP-20261101-001\",\"sampleNo\":\"JC-20261101-001\"},\"resultStatus\":\"SOLD\",\"stage\":\"SOLD\",\"targetOrgId\":\"\"}',NULL,'2026-11-01 00:22:51.290436'),(18,11,8,'CREATE_BATCH','TRACE_BATCH','B-C40745116CEA46FF9D59','{\"batchId\":\"B-C40745116CEA46FF9D59\",\"batchNo\":\"YL-20261101103518-653E\",\"batchType\":\"RAW_DUCK\",\"createdAt\":\"2026-11-01T10:35:18.880490400\",\"custodianOrgId\":\"8\",\"expiryDate\":\"2026-11-01\",\"lastEventId\":\"\",\"lastHash\":\"daae7c524e108b19adda337ee3ca9fa13519347b6d86632207f714baeb1529f5\",\"ownerOrgId\":\"8\",\"parentBatchIds\":[],\"productName\":\"常德麻鸭\",\"productionDate\":\"2026-11-01\",\"quantity\":\"100\",\"spec\":\"散装\",\"stage\":\"SOURCE\",\"status\":\"ACTIVE\",\"traceCode\":\"\",\"unit\":\"只\"}',NULL,'2026-11-01 10:35:20.999047'),(24,18,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-32DCE59B351E42658243','{\"batchId\":\"B-C40745116CEA46FF9D59\",\"businessTime\":\"2026-11-01T03:29:26\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-32DCE59B351E42658243\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"一车间\",\"operatorUserId\":\"18\",\"prevEventId\":\"\",\"prevHash\":\"daae7c524e108b19adda337ee3ca9fa13519347b6d86632207f714baeb1529f5\",\"processData\":{\"breedingBatchNo\":\"123456\",\"feedBatchNo\":\"12345\",\"healthStatus\":\"正常\",\"medicationRecord\":\"87654\",\"remark\":\"好\",\"stockQuantity\":\"12\",\"vaccineRecord\":\"\",\"withdrawalPeriodEnd\":\"2026-11-24\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}',NULL,'2026-11-01 11:30:27.913399'),(25,11,8,'APPROVE_EVENT','TRACE_EVENT','E-32DCE59B351E42658243','{\"comment\":\"\"}',NULL,'2026-11-01 11:31:31.496781'),(28,17,8,'CREATE_BATCH','TRACE_BATCH','B-9CE1CE83D60C47769096','{\"batchId\":\"B-9CE1CE83D60C47769096\",\"batchNo\":\"YL-20261107101819-19DB\",\"batchType\":\"RAW_DUCK\",\"createdAt\":\"2026-11-07T10:18:19.109411700\",\"custodianOrgId\":\"8\",\"expiryDate\":\"\",\"lastEventId\":\"\",\"lastHash\":\"decefa0f8614cf4f923a303186ae31aba33f7327d1b5e651137fd93b5ea07968\",\"ownerOrgId\":\"8\",\"parentBatchIds\":[],\"productName\":\"旧链上链修复验证批次\",\"productionDate\":\"2026-11-07\",\"quantity\":\"50\",\"spec\":\"整鸭\",\"stage\":\"SOURCE\",\"status\":\"ACTIVE\",\"traceCode\":\"\",\"unit\":\"只\"}',NULL,'2026-11-07 10:18:21.250528'),(29,18,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-ECCE910F403147D3866A','{\"batchId\":\"B-9CE1CE83D60C47769096\",\"businessTime\":\"2026-11-07T10:20\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-ECCE910F403147D3866A\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"SUP-VERIFY\",\"operatorUserId\":\"18\",\"prevEventId\":\"\",\"prevHash\":\"decefa0f8614cf4f923a303186ae31aba33f7327d1b5e651137fd93b5ea07968\",\"processData\":{\"breedingBatchNo\":\"YZ-CHAIN-FIX-001\",\"feedBatchNo\":\"SL-CHAIN-FIX-001\",\"healthStatus\":\"正常\",\"medicationRecord\":\"YY-CHAIN-FIX\",\"remark\":\"上链修复验证\",\"stockQuantity\":\"50\",\"vaccineRecord\":\"YM-CHAIN-FIX\",\"withdrawalPeriodEnd\":\"2026-11-20\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}',NULL,'2026-11-07 10:18:45.022968'),(30,17,8,'APPROVE_EVENT','TRACE_EVENT','E-ECCE910F403147D3866A','{\"comment\":\"上链修复验证通过\"}',NULL,'2026-11-07 10:18:47.106646'),(31,17,8,'CREATE_BATCH','TRACE_BATCH','B-C43F968FBCB24D27A66E','{\"batchId\":\"B-C43F968FBCB24D27A66E\",\"batchNo\":\"YL-20261107122530-66D5\",\"batchType\":\"RAW_DUCK\",\"createdAt\":\"2026-11-07T12:25:30.619433500\",\"custodianOrgId\":\"8\",\"expiryDate\":\"\",\"lastEventId\":\"\",\"lastHash\":\"e0c33513939828679fb3e3521113665e1f53fa3c1a9dec11e2374e270cc983dd\",\"ownerOrgId\":\"8\",\"parentBatchIds\":[],\"productName\":\"常德麻鸭\",\"productionDate\":\"\",\"quantity\":\"100\",\"spec\":\"\",\"stage\":\"SOURCE\",\"status\":\"ACTIVE\",\"traceCode\":\"\",\"unit\":\"kg\"}',NULL,'2026-11-07 12:25:32.733539'),(32,18,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-0C00FAFDF1AE42BFA2CC','{\"batchId\":\"B-C43F968FBCB24D27A66E\",\"businessTime\":\"2026-11-07T15:10\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-0C00FAFDF1AE42BFA2CC\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"功能联调-养殖场\",\"operatorUserId\":\"18\",\"prevEventId\":\"\",\"prevHash\":\"e0c33513939828679fb3e3521113665e1f53fa3c1a9dec11e2374e270cc983dd\",\"processData\":{\"breedingBatchNo\":\"YZ-20261107-01\",\"feedBatchNo\":\"SL-20261107-01\",\"healthStatus\":\"正常\",\"medicationRecord\":\"YY-20261107-01\",\"remark\":\"审核流程联调记录\",\"stockQuantity\":\"100\",\"vaccineRecord\":\"YM-20261107-01\",\"withdrawalPeriodEnd\":\"2026-12-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}',NULL,'2026-11-07 15:01:03.148982'),(33,17,8,'APPROVE_EVENT','TRACE_EVENT','E-0C00FAFDF1AE42BFA2CC','{\"comment\":\"功能联调审核通过\"}',NULL,'2026-11-07 15:01:12.365154'),(34,18,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-75F57184CE924C71A67C','{\"batchId\":\"B-C43F968FBCB24D27A66E\",\"businessTime\":\"2026-11-07T07:02:08\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-75F57184CE924C71A67C\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"浏览器审核流程联调\",\"operatorUserId\":\"18\",\"prevEventId\":\"E-0C00FAFDF1AE42BFA2CC\",\"prevHash\":\"9b4759e80131039bd84b46f27d2ce4a3d3aa6159c6ef59c64aa9456682828412\",\"processData\":{\"breedingBatchNo\":\"YANGZHI-20261107070205\",\"feedBatchNo\":\"SILIAO-20261107070205\",\"healthStatus\":\"正常\",\"medicationRecord\":\"\",\"remark\":\"\",\"stockQuantity\":\"100\",\"vaccineRecord\":\"\",\"withdrawalPeriodEnd\":\"2026-12-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}',NULL,'2026-11-07 15:02:08.970704'),(35,17,8,'APPROVE_EVENT','TRACE_EVENT','E-75F57184CE924C71A67C','{\"comment\":\"浏览器审核流程联调通过\"}',NULL,'2026-11-07 15:02:43.491782'),(36,11,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-4FCB1286DEB34743AFED','{\"batchId\":\"B-C43F968FBCB24D27A66E\",\"businessTime\":\"2026-11-07T15:20\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-4FCB1286DEB34743AFED\",\"eventType\":\"QUARANTINE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"本人审核规则联调\",\"operatorUserId\":\"11\",\"prevEventId\":\"E-75F57184CE924C71A67C\",\"prevHash\":\"8d3772f53e1abdccd4b19e56521b9ef640e5ee51926c0c32a83898eff25068fb\",\"processData\":{\"issuerOrg\":\"常德市动物检疫中心\",\"quarantineCertNo\":\"JY-20261107-01\",\"quarantineDate\":\"2026-11-07\",\"quarantineResult\":\"PASS\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"QUARANTINED\",\"targetOrgId\":\"\"}',NULL,'2026-11-07 15:13:09.335213'),(37,17,8,'APPROVE_EVENT','TRACE_EVENT','E-4FCB1286DEB34743AFED','{\"comment\":\"其他管理员审核流程验证通过\"}',NULL,'2026-11-07 15:25:09.631637'),(38,18,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-A76CB06E3B6144459C53','{\"batchId\":\"B-C43F968FBCB24D27A66E\",\"businessTime\":\"2026-11-07T07:46:05\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-A76CB06E3B6144459C53\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"浏览器审核流程联调\",\"operatorUserId\":\"18\",\"prevEventId\":\"E-4FCB1286DEB34743AFED\",\"prevHash\":\"f8e3ed51c055d8cdf380d3682bed8744e0ef7ceb3610a7e23b6d87b19cb072f9\",\"processData\":{\"breedingBatchNo\":\"YANGZHI-20261107074603\",\"feedBatchNo\":\"SILIAO-20261107074603\",\"healthStatus\":\"正常\",\"medicationRecord\":\"\",\"remark\":\"\",\"stockQuantity\":\"100\",\"vaccineRecord\":\"\",\"withdrawalPeriodEnd\":\"2026-12-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"QUARANTINED\",\"targetOrgId\":\"\"}',NULL,'2026-11-07 15:46:06.201333'),(39,17,8,'APPROVE_EVENT','TRACE_EVENT','E-A76CB06E3B6144459C53','{\"comment\":\"浏览器审核流程联调通过\"}',NULL,'2026-11-07 15:46:10.775105'),(40,18,8,'SUBMIT_EVENT_REVIEW','TRACE_EVENT','E-D1E00FB0CDB94259AAA9','{\"batchId\":\"B-C43F968FBCB24D27A66E\",\"businessTime\":\"2026-11-07T07:48:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-D1E00FB0CDB94259AAA9\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"\",\"operatorUserId\":\"18\",\"prevEventId\":\"E-A76CB06E3B6144459C53\",\"prevHash\":\"eaba33b0efb1851ae0c9d9ddb3c68e6551a55613fa67ad2ee72ea02b9751a2d9\",\"processData\":{\"breedingBatchNo\":\"1\",\"feedBatchNo\":\"1\",\"healthStatus\":\"异常\",\"medicationRecord\":\"1\",\"remark\":\"\",\"stockQuantity\":\"1\",\"vaccineRecord\":\"1\",\"withdrawalPeriodEnd\":\"2026-11-07\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"QUARANTINED\",\"targetOrgId\":\"\"}',NULL,'2026-11-07 15:48:42.573966');
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
INSERT INTO `batch_party` VALUES ('B-9CE1CE83D60C47769096',8,'OWNER','FULL','2026-11-07 10:18:19.128430'),('B-AD74FD8A3AB74980A2A1',8,'OWNER','FULL','2026-11-07 10:12:08.465833'),('B-B9E25EAC78A34A149FE3',1,'OWNER','FULL','2026-11-01 00:18:59.104638'),('B-B9E25EAC78A34A149FE3',2,'RECEIVER','FULL','2026-11-01 00:19:18.011195'),('B-C40745116CEA46FF9D59',8,'OWNER','FULL','2026-11-01 10:35:18.895156'),('B-C43F968FBCB24D27A66E',8,'OWNER','FULL','2026-11-07 12:25:30.634972'),('B-E564BA8B6A4A485FAB62',2,'OWNER','FULL','2026-11-01 00:20:32.095913'),('B-E564BA8B6A4A485FAB62',3,'CARRIER','FULL','2026-11-01 00:20:46.646280'),('B-E564BA8B6A4A485FAB62',4,'RECEIVER','FULL','2026-11-01 00:20:46.641059'),('B-F16C3E9614F947B492BF',8,'OWNER','FULL','2026-11-07 10:14:07.655045');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_relation`
--

LOCK TABLES `batch_relation` WRITE;
/*!40000 ALTER TABLE `batch_relation` DISABLE KEYS */;
INSERT INTO `batch_relation` VALUES (1,'B-B9E25EAC78A34A149FE3','B-E564BA8B6A4A485FAB62','MERGE',180.000,'2026-11-01 00:20:32.101771');
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
INSERT INTO `consumer_user` VALUES (4,'15347361610','$2a$10$ncrCDX4ggh/zRc84w.hgwOS4aTGCVoWvmxe3UnAfX4WvCXNwK.OM6','用户1610','男','430700',1,1,'2026-11-07 10:07:27.311254','2026-11-01 10:55:42.804325','2026-11-07 10:07:27.311254'),(5,'18912345678','$2a$10$KGy6uDvoEJXQ/cg72Of9NeFgVtynfVtExh2CEWkRqHrglALK8W/WC','用户5678','不公开','430700',1,1,'2026-11-07 14:49:47.411491','2026-11-07 12:29:18.233225','2026-11-07 14:49:47.411491');
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
INSERT INTO `custody_transfer` VALUES ('T-B175BAD58D70463482B1','B-E564BA8B6A4A485FAB62','E-F98ACF267CC74310B3B8',2,4,3,'RECEIVED','2026-11-01 00:20:46.633353','2026-11-01 00:21:01.080651',NULL,'2026-11-01 00:20:46.635450'),('T-DC6B88043DA9498DA58C','B-B9E25EAC78A34A149FE3','E-349415A2BB344EC1AFC3',1,2,NULL,'RECEIVED','2026-11-01 00:19:18.004772','2026-11-01 00:20:01.144716',NULL,'2026-11-01 00:19:18.005902');
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
INSERT INTO `event_review` VALUES ('E-0C00FAFDF1AE42BFA2CC','SUPPLIER_BREEDER','APPROVED',17,'2026-11-07 15:01:12.358783','功能联调审核通过','2026-11-07 15:01:03.142948'),('E-32DCE59B351E42658243','SUPPLIER_BREEDER','APPROVED',11,'2026-11-01 11:31:31.490460','','2026-11-01 11:30:27.907475'),('E-4FCB1286DEB34743AFED','SUPPLIER_OPERATOR','APPROVED',17,'2026-11-07 15:25:09.622478','其他管理员审核流程验证通过','2026-11-07 15:13:09.329293'),('E-75F57184CE924C71A67C','SUPPLIER_BREEDER','APPROVED',17,'2026-11-07 15:02:43.484283','浏览器审核流程联调通过','2026-11-07 15:02:08.965074'),('E-A76CB06E3B6144459C53','SUPPLIER_BREEDER','APPROVED',17,'2026-11-07 15:46:10.767246','浏览器审核流程联调通过','2026-11-07 15:46:06.196337'),('E-D1E00FB0CDB94259AAA9','SUPPLIER_BREEDER','PENDING_REVIEW',NULL,NULL,NULL,'2026-11-07 15:48:42.567930'),('E-ECCE910F403147D3866A','SUPPLIER_BREEDER','APPROVED',17,'2026-11-07 10:18:47.088580','上链修复验证通过','2026-11-07 10:18:45.017325');
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
INSERT INTO `evidence` VALUES ('V-2707338E982B45C8BC35','B-E564BA8B6A4A485FAB62','E-BFAACBB0D5904EA0ACD6',6,'B-E564BA8B6A4A485FAB62/V-2707338E982B45C8BC35.md','README.md','application/octet-stream',4048,'c2a8b9a6ba8432b6245744b56be43fe155ef31bd5a58a193cbdb2aa65cfa683a','2026-11-01 08:36:45.208869'),('V-3FCE3F3555B54AB1B5B9','B-C40745116CEA46FF9D59',NULL,17,'B-C40745116CEA46FF9D59/V-3FCE3F3555B54AB1B5B9.png','图片1.png','image/png',99702,'86a12a7478e38d69ba8e31ef5f78bc38b64bfda091ca3ae3a11578c7de85c014','2026-11-07 10:11:45.846221'),('V-B3556EE6DD1245A4A275','B-C43F968FBCB24D27A66E',NULL,17,'B-C43F968FBCB24D27A66E/V-B3556EE6DD1245A4A275.png','图片1.png','image/png',99702,'86a12a7478e38d69ba8e31ef5f78bc38b64bfda091ca3ae3a11578c7de85c014','2026-11-07 12:26:26.276718');
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
INSERT INTO `inspection_record` VALUES ('I-0BF0590FE39343C788A8','B-E564BA8B6A4A485FAB62','E-87107801FBDE418E900B','监督抽检','JC-20261101-001','[{\"limit\":\"10000\",\"name\":\"菌落总数\",\"result\":\"PASS\",\"unit\":\"CFU/g\",\"value\":\"100\"}]','PASS','REP-20261101-001',NULL,5,'2026-11-01 17:30:00.000000','RELEASE','抽检合格','2026-11-01 00:22:51.273945');
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
INSERT INTO `organization` VALUES (1,'SUP001','常德金鸭养殖基地','SUPPLIER','430700','Org1MSP','ACTIVE','2026-11-01 00:14:27.710112'),(2,'PRO001','常德酱板鸭食品有限公司','PROCESSOR','430700','Org1MSP','ACTIVE','2026-11-01 00:14:27.710112'),(3,'LOG001','沅水冷链物流有限公司','LOGISTICS','430700','Org1MSP','ACTIVE','2026-11-01 00:14:27.710112'),(4,'RET001','常德老街特产店','RETAILER','430700','Org1MSP','ACTIVE','2026-11-01 00:14:27.710112'),(5,'REG001','常德市市场监督管理局','REGULATOR','430700','Org2MSP','ACTIVE','2026-11-01 00:14:27.710112'),(6,'PLATFORM001','溯源平台管理中心','ADMIN','430700','Org1MSP','ACTIVE','2026-11-01 00:14:27.710112'),(8,'SUP003','yuanyuanyuan供应商','SUPPLIER','430700','Org1MSP','ACTIVE','2026-11-01 10:22:17.035944');
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'legacy_supplier','$2a$10$Not078x8lQmStLyHfAW6x.uhwIy4rQfw/O5sOUX6VUFLwSFZRDGHa','历史审计账号-supplier',1,0,'2026-11-01 00:14:29.488742'),(2,'legacy_processor','$2a$10$qmO6jKMb2k1cZf6BcMBMVuKJRA.6/8WwYu5GUYSpU1QOQrvWbYn7u','历史审计账号-processor',2,0,'2026-11-01 00:14:29.559243'),(3,'legacy_quality','$2a$10$XkeRat2b.d4zl74w3sYppe0zQRSRe93dyxTfeyPCyr683ZS8ydx9m','历史审计账号-quality',2,0,'2026-11-01 00:14:29.630130'),(4,'legacy_logistics','$2a$10$jwDk/b0OdpZY0vgCwG4B9Oq7N/DNCiwAaIDtHxTZpG9iklw3WyTla','历史审计账号-logistics',3,0,'2026-11-01 00:14:29.700493'),(5,'legacy_retailer','$2a$10$OrzsYvsv1ea0yHrTqIAk7OINsLib6kHkTg4ieAerw8KJYtHi5mLsu','历史审计账号-retailer',4,0,'2026-11-01 00:14:29.771165'),(6,'legacy_regulator','$2a$10$S1pV0VtnZykWEu.im0aWLOo4I0qp.ZMBuDb3qjBu710BR5oS4E0Gm','历史审计账号-regulator',5,0,'2026-11-01 00:14:29.846472'),(7,'legacy_admin','$2a$10$9oz.5PoGUtPp1tGZlgy7pOcth0eSB3LuaN98VAhLYE6GM2zGEX0l6','历史审计账号-admin',6,0,'2026-11-01 00:14:29.925112'),(8,'admin','$2a$10$GqJ5gHG7KzXgvARyNFoTOOMeykWvypwVoA30CWsSyO6YQqWqcmb6.','平台管理员',6,1,'2026-11-01 10:00:58.167706'),(11,'15347361610','$2a$10$3LW1wVUbDReOZEeAWeJqheoS5pjnYl76.HUTeTVvzXan2lEyZktfi','袁文平',8,1,'2026-11-01 10:22:17.111204'),(15,'19958162153','$2a$10$M8wznaeEU5Q4nSv7yp/AWuR7ciqX9NVTOX/8mFSvx3ISjBbpXlyUO','yanyy',8,1,'2026-11-01 10:57:17.508632'),(17,'13910000001','$2a$10$haTSsWWxCRLgOLMMrqLj6ercXlJHlXFwjbfpOT9mcoUxCUEBtzKa6','张三',8,1,'2026-11-01 11:21:21.446747'),(18,'13910000002','$2a$10$0zAiVlpFSjre6naqLLIVqeJgWtpXZuhNqwI7V6NiPVU6HWZ0o9I6u','李四',8,1,'2026-11-01 11:21:21.540022'),(19,'13910000003','$2a$10$WdIm7U9k65vZi7uUBSGJe..gVx8Y98h1exZYk2A1uXblXBG7bLtBG','王五',8,1,'2026-11-01 11:21:21.613139'),(20,'13910000004','$2a$10$pEeh5UhYsAOnUycZodMWHO5FXacVysqsFHwNnEnPL/Z.NBRnd4VzC','赵六',8,1,'2026-11-01 11:21:21.688756'),(21,'13910000005','$2a$10$6AO3S9PR0rR.ghIX9ML7d.DDchpsLYxpXfM.CZGoRV21yrPQVOXbK','陈七',8,1,'2026-11-01 11:21:21.761510'),(22,'13920000001','$2a$10$4GxzE7Bxb4sCl2t15lxQyeuj66GuqWxTZRB269CvkDuzrvuPgpSsi','刘洋',2,1,'2026-11-01 11:21:21.837100'),(23,'13920000002','$2a$10$IFO4GOxlyMTIjfoU.T8zXe.62BOhSJMe5kRvun2vRIsuuTbAj0vHC','周强',2,1,'2026-11-01 11:21:21.912602'),(24,'13920000003','$2a$10$awFb4qbdOjrAlK6dpl2Yserf1R8OZ5MqI0c1ml.kQJLOUiWFnU6ey','吴敏',2,1,'2026-11-01 11:21:21.984776'),(25,'13920000004','$2a$10$Lr4MlrQHSwDwSIRdK.lpieEBM7XxTTTrwGakrFA7SrZ6eHZOfEmnG','郑伟',2,1,'2026-11-01 11:21:22.059789'),(26,'13930000001','$2a$10$ahPiHSXie0GnAmt69j1zle9hlT.UkfN3yTFN1/MWaI3wNJ.VeHDTa','孙磊',3,1,'2026-11-01 11:21:22.132350'),(27,'13930000002','$2a$10$5quS6KGNpkzmzJxVYiecXOaNrw4LhrFsLDR48pOPh9VyycvhIaA7e','何静',3,1,'2026-11-01 11:21:22.205894'),(28,'13930000003','$2a$10$v3IZe8eHBpW3q9MJW0HvkucgTV2InyivoJ1izx60IDmGrDG/txcby','林涛',3,1,'2026-11-01 11:21:22.277240'),(29,'13940000001','$2a$10$aHTomcHsoeWGqU4X0U55Beln.2at2SHIYznh6WiCFd235nwv6Wrdy','徐丽',4,1,'2026-11-01 11:21:22.351307'),(30,'13940000002','$2a$10$TlxzX93lJMny8V1rJyS1zu4KW/vfLLyj9dGjK.vff47WdSwJEBf4W','马超',4,1,'2026-11-01 11:21:22.424046'),(31,'13940000003','$2a$10$z5EBQAGizqY0RZ3/WK7NCuBw71qfzE6kcnFFcAsFhO6hFBKHEamJ2','朱琳',4,1,'2026-11-01 11:21:22.496112'),(32,'13950000001','$2a$10$HHj2qWNNxk91CJp18i39B.GDZAipg.hMlOxS7ayO0wvggMkzn1gcG','高峰',5,1,'2026-11-01 11:21:22.577613'),(33,'13950000002','$2a$10$al9UUPCNbAT5jwgxxBXLhOTz2InMoZBGvwmADMCbNTNt6vFLPED6q','罗敏',5,1,'2026-11-01 11:21:22.655479');
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
INSERT INTO `sys_user_role` VALUES (1,1),(11,1),(15,1),(17,1),(21,1),(2,2),(22,2),(23,2),(3,3),(24,3),(4,4),(26,4),(5,5),(29,5),(6,6),(32,6),(7,7),(8,7),(11,8),(17,8),(22,8),(26,8),(29,8),(32,8),(18,9),(19,10),(20,11),(25,12),(27,13),(28,14),(30,15),(31,16),(33,17);
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
INSERT INTO `trace_batch` VALUES ('B-9CE1CE83D60C47769096','YL-20261107101819-19DB',NULL,'RAW_DUCK',8,8,'旧链上链修复验证批次','整鸭',50.000,'只','SOURCE','ACTIVE','2026-11-07',NULL,'E-ECCE910F403147D3866A','f5d2a0e8b76681e624534ba8b6e78add700725f3632c3650b61817eb22221ed0','COMMITTED','718799323c9ec11a9b48ed0a089c2d77a3a9cefaaed67dd00d338c87013df1f0',17,'2026-11-07 10:18:19.122264','2026-11-07 10:18:47.087861'),('B-AD74FD8A3AB74980A2A1','YL-20261107101208-E5B5',NULL,'RAW_DUCK',8,8,'常德麻鸭','300',100.000,'只','SOURCE','ACTIVE','2026-11-07','2026-11-28',NULL,'3f759e7ec17d087b3cb8b61627f18d9e6296cd12f815dc2f0ead21331865d75d','FAILED',NULL,17,'2026-11-07 10:12:08.456415','2026-11-07 10:12:08.494856'),('B-B9E25EAC78A34A149FE3','YL-20261101001859-BDC1',NULL,'RAW_DUCK',1,2,'常德麻鸭','整鸭',200.000,'kg','RECEIVED','ACTIVE','2026-11-01',NULL,'E-349415A2BB344EC1AFC3','fccbafd62f87df5b2a1b7763fa86694d8935b83189548c0e96fed4d356ec18be','COMMITTED','931e92c7176f26a2843cb3de37d898c8933c043d47c981b92feab288812a9aea',1,'2026-11-01 00:18:59.098772','2026-11-01 00:20:01.146592'),('B-C40745116CEA46FF9D59','YL-20261101103518-653E',NULL,'RAW_DUCK',8,8,'常德麻鸭','散装',100.000,'只','SOURCE','ACTIVE','2026-11-01','2026-11-01','E-32DCE59B351E42658243','a7701c34b81eb6bdd429a03dd8128fb4a2e2a05f63191a34585ffbba42c71716','COMMITTED','000c513682570432cbdcbf36b3dec39ccdb5b201edfe883b31c26fb50b1cc84a',11,'2026-11-01 10:35:18.888731','2026-11-01 11:31:31.489962'),('B-C43F968FBCB24D27A66E','YL-20261107122530-66D5',NULL,'RAW_DUCK',8,8,'常德麻鸭','',100.000,'kg','QUARANTINED','ACTIVE',NULL,NULL,'E-A76CB06E3B6144459C53','eaba33b0efb1851ae0c9d9ddb3c68e6551a55613fa67ad2ee72ea02b9751a2d9','COMMITTED','c7b95596abbb6783b2bdf6b54a7c2917537b2a3e614e230f378505792315789d',17,'2026-11-07 12:25:30.626894','2026-11-07 15:46:10.766702'),('B-E564BA8B6A4A485FAB62','BC-20261101002032-4717','CDJBY-20261101002044-E8FAC5','FINISHED',2,4,'酱板鸭加工批次','待包装',180.000,'kg','SOLD','SOLD','2026-11-01','2027-05-01','E-87107801FBDE418E900B','dbae9f2bb77dca9b02ed9efdf3be4c6bc646e61053b672b1ae9633b481188078','COMMITTED','2ef2c6f4cff8797ce6ec7cb8ac04613b8ded759de1da99ee4afdc22061bf824a',2,'2026-11-01 00:20:32.088370','2026-11-01 00:22:51.271882'),('B-F16C3E9614F947B492BF','YL-20261107101407-9022',NULL,'RAW_DUCK',8,8,'常德麻鸭','',100.000,'kg','SOURCE','ACTIVE',NULL,NULL,NULL,'b70ca18619a23bfb8ffd5452c6372083a140381238867ae68f931d0e3d097045','FAILED',NULL,17,'2026-11-07 10:14:07.648535','2026-11-07 10:14:07.665094');
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
INSERT INTO `trace_event` VALUES ('E-05457F6A3E7C4FC392C3','B-B9E25EAC78A34A149FE3','QUARANTINE','QUARANTINED','ACTIVE',1,1,'2026-11-01 00:20:00.000000','常德金鸭养殖基地','{\"batchId\":\"B-B9E25EAC78A34A149FE3\",\"businessTime\":\"2026-11-01T00:20\",\"carrierOrgId\":\"\",\"eventId\":\"E-05457F6A3E7C4FC392C3\",\"eventType\":\"QUARANTINE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"1\",\"locationCode\":\"常德金鸭养殖基地\",\"operatorUserId\":\"1\",\"prevEventId\":\"\",\"prevHash\":\"6aa68270bbd3747178c4a56ca0866a75815f0667d4b90bd0425bf79209dabf32\",\"processData\":{\"issuerOrg\":\"常德动物卫生监督所\",\"quarantineCertNo\":\"QY-20261101-001\",\"quarantineDate\":\"2026-11-01\",\"quarantineResult\":\"PASS\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"QUARANTINED\",\"targetOrgId\":\"\"}','a1016dbbc9873378e66db03008852252f53d7e8bdd39692669290003ad9415b1',NULL,NULL,'6aa68270bbd3747178c4a56ca0866a75815f0667d4b90bd0425bf79209dabf32','e43c014a-8977-47f1-99a2-8d943be9a3de','COMMITTED','37af2b8f4d505565de0b08af6e22c90244870ea99fd78c27928f1871de0faaff',10,NULL,NULL,'2026-11-01 00:19:10.257348'),('E-0C00FAFDF1AE42BFA2CC','B-C43F968FBCB24D27A66E','BREEDING_RECORD','SOURCE','ACTIVE',8,18,'2026-11-07 15:10:00.000000','功能联调-养殖场','{\"batchId\":\"B-C43F968FBCB24D27A66E\",\"businessTime\":\"2026-11-07T15:10\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-0C00FAFDF1AE42BFA2CC\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"功能联调-养殖场\",\"operatorUserId\":\"18\",\"prevEventId\":\"\",\"prevHash\":\"e0c33513939828679fb3e3521113665e1f53fa3c1a9dec11e2374e270cc983dd\",\"processData\":{\"breedingBatchNo\":\"YZ-20261107-01\",\"feedBatchNo\":\"SL-20261107-01\",\"healthStatus\":\"正常\",\"medicationRecord\":\"YY-20261107-01\",\"remark\":\"审核流程联调记录\",\"stockQuantity\":\"100\",\"vaccineRecord\":\"YM-20261107-01\",\"withdrawalPeriodEnd\":\"2026-12-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}','9b4759e80131039bd84b46f27d2ce4a3d3aa6159c6ef59c64aa9456682828412',NULL,NULL,'e0c33513939828679fb3e3521113665e1f53fa3c1a9dec11e2374e270cc983dd','92f1a93f-9dd8-4904-92ff-00b2d55a0af6','COMMITTED','c41b9ec49ca24f511145b41ecde4eed45ab010601bcfb931f0e09bc19af41e41',9,NULL,NULL,'2026-11-07 15:01:03.136469'),('E-15367AB11FBD43958C8F','B-E564BA8B6A4A485FAB62','DISPATCH','DISPATCHED','DISPATCHED',2,2,'2026-11-01 15:00:00.000000','常德酱板鸭食品有限公司','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T15:00\",\"carrierOrgId\":\"3\",\"eventId\":\"E-15367AB11FBD43958C8F\",\"eventType\":\"DISPATCH\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司\",\"operatorUserId\":\"2\",\"prevEventId\":\"E-B588DD8EC9FE445BA7DD\",\"prevHash\":\"fe6f541ed88da62872e06765264c3f18e4da11ec5b54a3e43a8e55cd4add4c41\",\"processData\":{\"destination\":\"常德老街特产店\",\"sealNo\":\"SEAL-002\",\"temperature\":\"5\",\"vehicleRef\":\"湘J-LOG01\"},\"resultStatus\":\"DISPATCHED\",\"stage\":\"DISPATCHED\",\"targetOrgId\":\"4\"}','e80a3775bf169fe2e29e53089f2038218017f790e78c0c70b37a6e256ac88ee9',NULL,'E-B588DD8EC9FE445BA7DD','fe6f541ed88da62872e06765264c3f18e4da11ec5b54a3e43a8e55cd4add4c41','1cee80bd-4649-4f75-a98f-b4143d17d6df','COMMITTED','8682a681899aa48b7bc0848a6d239d98ec32fac7049585da038815a9f5f2f269',20,NULL,NULL,'2026-11-01 00:20:46.652556'),('E-32DCE59B351E42658243','B-C40745116CEA46FF9D59','BREEDING_RECORD','SOURCE','ACTIVE',8,18,'2026-11-01 03:29:26.000000','一车间','{\"batchId\":\"B-C40745116CEA46FF9D59\",\"businessTime\":\"2026-11-01T03:29:26\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-32DCE59B351E42658243\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"一车间\",\"operatorUserId\":\"18\",\"prevEventId\":\"\",\"prevHash\":\"daae7c524e108b19adda337ee3ca9fa13519347b6d86632207f714baeb1529f5\",\"processData\":{\"breedingBatchNo\":\"123456\",\"feedBatchNo\":\"12345\",\"healthStatus\":\"正常\",\"medicationRecord\":\"87654\",\"remark\":\"好\",\"stockQuantity\":\"12\",\"vaccineRecord\":\"\",\"withdrawalPeriodEnd\":\"2026-11-24\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}','a7701c34b81eb6bdd429a03dd8128fb4a2e2a05f63191a34585ffbba42c71716',NULL,NULL,'daae7c524e108b19adda337ee3ca9fa13519347b6d86632207f714baeb1529f5','1c45e50c-6208-4e8e-b82a-72648c73f60c','COMMITTED','000c513682570432cbdcbf36b3dec39ccdb5b201edfe883b31c26fb50b1cc84a',27,NULL,NULL,'2026-11-01 11:30:27.888471'),('E-349415A2BB344EC1AFC3','B-B9E25EAC78A34A149FE3','RECEIVE','RECEIVED','ACTIVE',2,2,'2026-11-01 00:25:00.000000','常德加工一车间','{\"batchId\":\"B-B9E25EAC78A34A149FE3\",\"businessTime\":\"2026-11-01T00:25\",\"carrierOrgId\":\"\",\"eventId\":\"E-349415A2BB344EC1AFC3\",\"eventType\":\"RECEIVE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德加工一车间\",\"operatorUserId\":\"2\",\"prevEventId\":\"E-E895546863A444E2A7CA\",\"prevHash\":\"c490d661541add2c8d4b0431f25e2a8ce12a3d9ada37a2cd2f172e6f4213cdc3\",\"processData\":{\"discrepancyCode\":\"\",\"packageIntact\":\"是\",\"quantityReceived\":\"200\",\"temperature\":\"12\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"RECEIVED\",\"targetOrgId\":\"\"}','fccbafd62f87df5b2a1b7763fa86694d8935b83189548c0e96fed4d356ec18be',NULL,'E-E895546863A444E2A7CA','c490d661541add2c8d4b0431f25e2a8ce12a3d9ada37a2cd2f172e6f4213cdc3','d10cbef8-4f97-4982-8d5b-7b5cecf56fb3','COMMITTED','931e92c7176f26a2843cb3de37d898c8933c043d47c981b92feab288812a9aea',12,NULL,NULL,'2026-11-01 00:19:57.207602'),('E-4FCB1286DEB34743AFED','B-C43F968FBCB24D27A66E','QUARANTINE','QUARANTINED','ACTIVE',8,11,'2026-11-07 15:20:00.000000','本人审核规则联调','{\"batchId\":\"B-C43F968FBCB24D27A66E\",\"businessTime\":\"2026-11-07T15:20\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-4FCB1286DEB34743AFED\",\"eventType\":\"QUARANTINE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"本人审核规则联调\",\"operatorUserId\":\"11\",\"prevEventId\":\"E-75F57184CE924C71A67C\",\"prevHash\":\"8d3772f53e1abdccd4b19e56521b9ef640e5ee51926c0c32a83898eff25068fb\",\"processData\":{\"issuerOrg\":\"常德市动物检疫中心\",\"quarantineCertNo\":\"JY-20261107-01\",\"quarantineDate\":\"2026-11-07\",\"quarantineResult\":\"PASS\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"QUARANTINED\",\"targetOrgId\":\"\"}','f8e3ed51c055d8cdf380d3682bed8744e0ef7ceb3610a7e23b6d87b19cb072f9',NULL,'E-75F57184CE924C71A67C','8d3772f53e1abdccd4b19e56521b9ef640e5ee51926c0c32a83898eff25068fb','1a6af7ee-784d-4143-838c-8a61917ec9a2','COMMITTED','cc90a37ee8d6242dfef8ee1be8ef9f4a54c81556e12ebbd8c0b0ec12be43bbfb',11,NULL,NULL,'2026-11-07 15:13:09.321328'),('E-644235B0264342D58587','B-E564BA8B6A4A485FAB62','SLAUGHTER','SLAUGHTERED','ACTIVE',2,2,'2026-11-01 07:10:00.000000','常德酱板鸭食品有限公司','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T07:10\",\"carrierOrgId\":\"\",\"eventId\":\"E-644235B0264342D58587\",\"eventType\":\"SLAUGHTER\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司\",\"operatorUserId\":\"2\",\"prevEventId\":\"\",\"prevHash\":\"8c10742e781ee3d81fc62a3ef675f82b4ebb1d2d1e76a2f84b08b13b78ff0657\",\"processData\":{\"brineTemperature\":\"4\",\"carcassWeight\":\"165\",\"liveWeight\":\"200\",\"marinadeDurationMin\":\"360\",\"marinadeEndAt\":\"2026-11-01T07:00:00\",\"marinadeStartAt\":\"2026-11-01T01:00:00\",\"preSlaughterQuarantineResult\":\"PASS\",\"saltBatchNo\":\"SALT-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SLAUGHTERED\",\"targetOrgId\":\"\"}','6406a6ea1f147710d8402a88b988b6feb85d5be12757c14e98d487468b51c617',NULL,NULL,'8c10742e781ee3d81fc62a3ef675f82b4ebb1d2d1e76a2f84b08b13b78ff0657','dba0952a-6a8e-4569-b072-3077217bdbe7','COMMITTED','4062102be3ed7e2ba12f447baeac599b4f415d665b672b69402042e6ee592861',14,NULL,NULL,'2026-11-01 00:20:34.185261'),('E-6A2075291FD7420FB673','B-E564BA8B6A4A485FAB62','TRANSPORT','IN_TRANSIT','IN_TRANSIT',3,4,'2026-11-01 15:20:00.000000','沅水冷链运输节点','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T15:20\",\"carrierOrgId\":\"\",\"eventId\":\"E-6A2075291FD7420FB673\",\"eventType\":\"TRANSPORT\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"3\",\"locationCode\":\"沅水冷链运输节点\",\"operatorUserId\":\"4\",\"prevEventId\":\"E-15367AB11FBD43958C8F\",\"prevHash\":\"e80a3775bf169fe2e29e53089f2038218017f790e78c0c70b37a6e256ac88ee9\",\"processData\":{\"alarmCount\":\"0\",\"coldChainCompliant\":\"PASS\",\"fromPlace\":\"常德加工园\",\"sealNo\":\"SEAL-002\",\"temperature\":\"4\",\"toPlace\":\"常德老街特产店\",\"vehicleRef\":\"湘J-LOG01\"},\"resultStatus\":\"IN_TRANSIT\",\"stage\":\"IN_TRANSIT\",\"targetOrgId\":\"\"}','1c75e1e3b4dc0369805ade738c8b12e45cda002d323b6a2e2c54a548fb17bb56',NULL,'E-15367AB11FBD43958C8F','e80a3775bf169fe2e29e53089f2038218017f790e78c0c70b37a6e256ac88ee9','fb0323a9-5396-4097-8ab4-2fe5f29a8ed2','COMMITTED','496ccf0135f6611d1c384cc2c1ee7eb8c9cfa7e8c6ab2650a2386efcc67e99a3',21,NULL,NULL,'2026-11-01 00:20:54.830301'),('E-73C279E4FE2D4CCBA465','B-E564BA8B6A4A485FAB62','ROAST','ROASTED','ACTIVE',2,2,'2026-11-01 13:25:00.000000','常德酱板鸭食品有限公司','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T13:25\",\"carrierOrgId\":\"\",\"eventId\":\"E-73C279E4FE2D4CCBA465\",\"eventType\":\"ROAST\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司\",\"operatorUserId\":\"2\",\"prevEventId\":\"E-C08191BE171248E1BE8B\",\"prevHash\":\"b0b6b0cffb3c85d7ca5eb6c5e5b103db228f62d1a3ee0a22d5aedfc082a7e5f0\",\"processData\":{\"ccpCompliant\":\"PASS\",\"coreTemperature\":\"78\",\"endAt\":\"2026-11-01T13:20:00\",\"equipmentId\":\"R-01\",\"exceptionCode\":\"\",\"humidity\":\"55\",\"processType\":\"烘烤\",\"setTemperature\":\"85\",\"startAt\":\"2026-11-01T11:20:00\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"ROASTED\",\"targetOrgId\":\"\"}','45fbdff028173c796756b24495cf328635b540d796bdbd5da0b7d313391f8996',NULL,'E-C08191BE171248E1BE8B','b0b6b0cffb3c85d7ca5eb6c5e5b103db228f62d1a3ee0a22d5aedfc082a7e5f0','7287574c-c500-4d41-a01c-48645a0d9fe5','COMMITTED','94f088fc4004f95e728c2eeab7eb81679218f2ad4cf37bee9962ae18f207dd7b',17,NULL,NULL,'2026-11-01 00:20:40.419608'),('E-7415ECD554CF47BFAAEB','B-E564BA8B6A4A485FAB62','MARINATE','MARINATED','ACTIVE',2,2,'2026-11-01 07:15:00.000000','常德酱板鸭食品有限公司','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T07:15\",\"carrierOrgId\":\"\",\"eventId\":\"E-7415ECD554CF47BFAAEB\",\"eventType\":\"MARINATE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司\",\"operatorUserId\":\"2\",\"prevEventId\":\"E-644235B0264342D58587\",\"prevHash\":\"6406a6ea1f147710d8402a88b988b6feb85d5be12757c14e98d487468b51c617\",\"processData\":{\"durationMin\":\"360\",\"endAt\":\"2026-11-01T07:00:00\",\"equipmentId\":\"M-01\",\"saltBatchNo\":\"SALT-01\",\"startAt\":\"2026-11-01T01:00:00\",\"temperature\":\"4\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"MARINATED\",\"targetOrgId\":\"\"}','61501e708a6e72cae060030a3f26c9bec23c075b1c1b4f85c5bdff5c1b5ab93f',NULL,'E-644235B0264342D58587','6406a6ea1f147710d8402a88b988b6feb85d5be12757c14e98d487468b51c617','cf6cc235-3f95-4686-a5d3-fef0f221e275','COMMITTED','92a1b4eb1c5ced9caca4682207799be52f2704e1dd7acfce7bf05768867f4735',15,NULL,NULL,'2026-11-01 00:20:36.267760'),('E-75F57184CE924C71A67C','B-C43F968FBCB24D27A66E','BREEDING_RECORD','SOURCE','ACTIVE',8,18,'2026-11-07 07:02:08.000000','浏览器审核流程联调','{\"batchId\":\"B-C43F968FBCB24D27A66E\",\"businessTime\":\"2026-11-07T07:02:08\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-75F57184CE924C71A67C\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"浏览器审核流程联调\",\"operatorUserId\":\"18\",\"prevEventId\":\"E-0C00FAFDF1AE42BFA2CC\",\"prevHash\":\"9b4759e80131039bd84b46f27d2ce4a3d3aa6159c6ef59c64aa9456682828412\",\"processData\":{\"breedingBatchNo\":\"YANGZHI-20261107070205\",\"feedBatchNo\":\"SILIAO-20261107070205\",\"healthStatus\":\"正常\",\"medicationRecord\":\"\",\"remark\":\"\",\"stockQuantity\":\"100\",\"vaccineRecord\":\"\",\"withdrawalPeriodEnd\":\"2026-12-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}','8d3772f53e1abdccd4b19e56521b9ef640e5ee51926c0c32a83898eff25068fb',NULL,'E-0C00FAFDF1AE42BFA2CC','9b4759e80131039bd84b46f27d2ce4a3d3aa6159c6ef59c64aa9456682828412','d421ac2c-e82f-4435-8892-9b61b1e1f804','COMMITTED','58511356738c782aa861e30c0df1ab800e71d0e1022b92c31afc0ae4e2529768',10,NULL,NULL,'2026-11-07 15:02:08.959562'),('E-77B41695E4FD4454A46D','B-E564BA8B6A4A485FAB62','SALE','SOLD','SOLD',4,5,'2026-11-01 17:00:00.000000','沅水冷链运输节点','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T17:00\",\"carrierOrgId\":\"\",\"eventId\":\"E-77B41695E4FD4454A46D\",\"eventType\":\"SALE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"4\",\"locationCode\":\"沅水冷链运输节点\",\"operatorUserId\":\"5\",\"prevEventId\":\"E-F98ACF267CC74310B3B8\",\"prevHash\":\"b960871c2d081b53ca6c139a09f99a6d94d3fc92bf0ee87951918ae0ca931189\",\"processData\":{\"quantitySold\":\"20\",\"remainingQuantity\":\"130\",\"saleOrderHash\":\"ORDER-DEMO-001\",\"salesChannel\":\"门店\",\"storageTemperature\":\"5\"},\"resultStatus\":\"SOLD\",\"stage\":\"SOLD\",\"targetOrgId\":\"\"}','1ff46f6a3156aebf61618d7ac01db5d50b514fdde67eaa6619a2287ba3807c1a',NULL,'E-F98ACF267CC74310B3B8','b960871c2d081b53ca6c139a09f99a6d94d3fc92bf0ee87951918ae0ca931189','dc2a6555-be65-4504-a5db-743673e6bfe3','COMMITTED','f5c65f407115a0114ed0231be5a816af9b62aab2e4a28d0c797db4d2b8d2e10e',24,NULL,NULL,'2026-11-01 00:21:01.117911'),('E-7F681640B3974F879AA2','B-E564BA8B6A4A485FAB62','PACKAGE','PACKAGED','ACTIVE',2,2,'2026-11-01 14:00:00.000000','常德酱板鸭食品有限公司','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T14:00\",\"carrierOrgId\":\"\",\"eventId\":\"E-7F681640B3974F879AA2\",\"eventType\":\"PACKAGE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司\",\"operatorUserId\":\"2\",\"prevEventId\":\"E-73C279E4FE2D4CCBA465\",\"prevHash\":\"45fbdff028173c796756b24495cf328635b540d796bdbd5da0b7d313391f8996\",\"processData\":{\"expiryDate\":\"2027-05-01\",\"netWeight\":\"300\",\"packageMaterialBatchNo\":\"PKG-01\",\"packageQuantity\":\"500\",\"productCode\":\"CDJBY-300\",\"productionLineNo\":\"L1\",\"qaResult\":\"PASS\",\"sealTemperature\":\"145\",\"spec\":\"300g/袋\",\"vacuumDegree\":\"-0.09MPa\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"PACKAGED\",\"targetOrgId\":\"\"}','b765901bb45768fe7d31658cc150005a2fd672b605e59573347f296803ad181f',NULL,'E-73C279E4FE2D4CCBA465','45fbdff028173c796756b24495cf328635b540d796bdbd5da0b7d313391f8996','50ff6cfc-f0e7-4b32-a39c-bf6a2503071c','COMMITTED','0b1c5898cb518109dc9fd92716e021262c0110cd3cb26a041b0549f510dd40e4',18,NULL,NULL,'2026-11-01 00:20:42.486313'),('E-87107801FBDE418E900B','B-E564BA8B6A4A485FAB62','INSPECTION','SOLD','SOLD',5,6,'2026-11-01 17:30:00.000000','常德市市场监督管理局','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T17:30\",\"carrierOrgId\":\"\",\"eventId\":\"E-87107801FBDE418E900B\",\"eventType\":\"INSPECTION\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"5\",\"locationCode\":\"常德市市场监督管理局\",\"operatorUserId\":\"6\",\"prevEventId\":\"E-77B41695E4FD4454A46D\",\"prevHash\":\"1ff46f6a3156aebf61618d7ac01db5d50b514fdde67eaa6619a2287ba3807c1a\",\"processData\":{\"decision\":\"RELEASE\",\"indicators\":[{\"limit\":\"10000\",\"name\":\"菌落总数\",\"result\":\"PASS\",\"unit\":\"CFU/g\",\"value\":\"100\"}],\"inspectionType\":\"监督抽检\",\"overallResult\":\"PASS\",\"remark\":\"抽检合格\",\"reportNo\":\"REP-20261101-001\",\"sampleNo\":\"JC-20261101-001\"},\"resultStatus\":\"SOLD\",\"stage\":\"SOLD\",\"targetOrgId\":\"\"}','dbae9f2bb77dca9b02ed9efdf3be4c6bc646e61053b672b1ae9633b481188078',NULL,'E-77B41695E4FD4454A46D','1ff46f6a3156aebf61618d7ac01db5d50b514fdde67eaa6619a2287ba3807c1a','ef2e79e3-a9e4-4c5d-902f-a7cec84adf1e','COMMITTED','2ef2c6f4cff8797ce6ec7cb8ac04613b8ded759de1da99ee4afdc22061bf824a',25,NULL,NULL,'2026-11-01 00:22:47.483568'),('E-986B72694D6445B69694','B-E564BA8B6A4A485FAB62','DELIVER','DELIVERED','DELIVERED',3,4,'2026-11-01 16:30:00.000000','沅水冷链运输节点','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T16:30\",\"carrierOrgId\":\"\",\"eventId\":\"E-986B72694D6445B69694\",\"eventType\":\"DELIVER\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"3\",\"locationCode\":\"沅水冷链运输节点\",\"operatorUserId\":\"4\",\"prevEventId\":\"E-6A2075291FD7420FB673\",\"prevHash\":\"1c75e1e3b4dc0369805ade738c8b12e45cda002d323b6a2e2c54a548fb17bb56\",\"processData\":{\"deliveredAt\":\"2026-11-01T16:30:00\",\"discrepancyCode\":\"\",\"receiptResult\":\"正常\",\"temperature\":\"4\"},\"resultStatus\":\"DELIVERED\",\"stage\":\"DELIVERED\",\"targetOrgId\":\"\"}','7baea2f550ffe7838315785a2e816fa14ee79734e003f80481000d06e86ed734',NULL,'E-6A2075291FD7420FB673','1c75e1e3b4dc0369805ade738c8b12e45cda002d323b6a2e2c54a548fb17bb56','b78b54e7-ea8b-46ca-9d3d-c9a50e744085','COMMITTED','46ada76b251c73cd600c83d064cd3f36a16d3896761636a4269d5713fa22e48d',22,NULL,NULL,'2026-11-01 00:20:56.900350'),('E-A76CB06E3B6144459C53','B-C43F968FBCB24D27A66E','BREEDING_RECORD','QUARANTINED','ACTIVE',8,18,'2026-11-07 07:46:05.000000','浏览器审核流程联调','{\"batchId\":\"B-C43F968FBCB24D27A66E\",\"businessTime\":\"2026-11-07T07:46:05\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-A76CB06E3B6144459C53\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"浏览器审核流程联调\",\"operatorUserId\":\"18\",\"prevEventId\":\"E-4FCB1286DEB34743AFED\",\"prevHash\":\"f8e3ed51c055d8cdf380d3682bed8744e0ef7ceb3610a7e23b6d87b19cb072f9\",\"processData\":{\"breedingBatchNo\":\"YANGZHI-20261107074603\",\"feedBatchNo\":\"SILIAO-20261107074603\",\"healthStatus\":\"正常\",\"medicationRecord\":\"\",\"remark\":\"\",\"stockQuantity\":\"100\",\"vaccineRecord\":\"\",\"withdrawalPeriodEnd\":\"2026-12-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"QUARANTINED\",\"targetOrgId\":\"\"}','eaba33b0efb1851ae0c9d9ddb3c68e6551a55613fa67ad2ee72ea02b9751a2d9',NULL,'E-4FCB1286DEB34743AFED','f8e3ed51c055d8cdf380d3682bed8744e0ef7ceb3610a7e23b6d87b19cb072f9','50e8e046-fd8d-4210-b07e-fda626f651af','COMMITTED','c7b95596abbb6783b2bdf6b54a7c2917537b2a3e614e230f378505792315789d',12,NULL,NULL,'2026-11-07 15:46:06.190099'),('E-B588DD8EC9FE445BA7DD','B-E564BA8B6A4A485FAB62','WAREHOUSE_IN','WAREHOUSED','ACTIVE',2,2,'2026-11-01 14:30:00.000000','常德酱板鸭食品有限公司','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T14:30\",\"carrierOrgId\":\"\",\"eventId\":\"E-B588DD8EC9FE445BA7DD\",\"eventType\":\"WAREHOUSE_IN\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司\",\"operatorUserId\":\"2\",\"prevEventId\":\"E-7F681640B3974F879AA2\",\"prevHash\":\"b765901bb45768fe7d31658cc150005a2fd672b605e59573347f296803ad181f\",\"processData\":{\"binNo\":\"A-01\",\"coldChainStatus\":\"NORMAL\",\"quantity\":\"150\",\"temperature\":\"4\",\"warehouseId\":\"WH-01\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"WAREHOUSED\",\"targetOrgId\":\"\"}','fe6f541ed88da62872e06765264c3f18e4da11ec5b54a3e43a8e55cd4add4c41',NULL,'E-7F681640B3974F879AA2','b765901bb45768fe7d31658cc150005a2fd672b605e59573347f296803ad181f','a31c6e19-f481-43aa-8d07-713794192580','COMMITTED','a9f1b2e9ef2e118f549c7cb303fba374781191844532f91612c3cacff7e94a88',19,NULL,NULL,'2026-11-01 00:20:44.558088'),('E-BFAACBB0D5904EA0ACD6','B-E564BA8B6A4A485FAB62','INSPECTION','SOLD','SOLD',5,6,'2026-11-01 18:00:00.000000','常德市市场监督管理局','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T18:00\",\"carrierOrgId\":\"\",\"eventId\":\"E-BFAACBB0D5904EA0ACD6\",\"eventType\":\"INSPECTION\",\"evidenceRoot\":\"ee7cbc47ce5b5e02151f46172f85718304ad636606045b9bd8314e377d5ffb44\",\"issuerOrgId\":\"5\",\"locationCode\":\"常德市市场监督管理局\",\"operatorUserId\":\"6\",\"prevEventId\":\"E-87107801FBDE418E900B\",\"prevHash\":\"dbae9f2bb77dca9b02ed9efdf3be4c6bc646e61053b672b1ae9633b481188078\",\"processData\":{\"decision\":\"RELEASE\",\"indicators\":[{\"limit\":\"30\",\"name\":\"亚硝酸盐\",\"result\":\"PASS\",\"unit\":\"mg/kg\",\"value\":\"2\"}],\"inspectionType\":\"监督复核\",\"overallResult\":\"PASS\",\"reportNo\":\"REP-20261101-002\",\"sampleNo\":\"JC-20261101-002\"},\"resultStatus\":\"SOLD\",\"stage\":\"SOLD\",\"targetOrgId\":\"\"}','f6f2eb9f1d1302f5531274440b5337f06e450a1cf76577b68803c75cce7a5f35','ee7cbc47ce5b5e02151f46172f85718304ad636606045b9bd8314e377d5ffb44','E-87107801FBDE418E900B','dbae9f2bb77dca9b02ed9efdf3be4c6bc646e61053b672b1ae9633b481188078','aa602201-7a1c-4f44-911e-1d288fc4a3fc','FAILED',NULL,NULL,'区块链提交失败：getConfigBlock for channel tracechannel failed with peer peer0.org2.example.com.  Status FAILURE, details: Channel Channel{id: 18, name: tracechannel} Sending proposal with transaction: 0bc7586df0a670da758c0964e81122630935b6f57e08438434b20dc2fbb26668 to Peer{ id: 16, name: peer0.org2.example.com, channelName: tracechannel, url: grpcs://192.168.116.144:9051} failed because of: gRPC failure=Status{code=UNAVAILABLE, description=io exception, cause=io.grpc.netty.shaded.io.netty.channel.Abstr',NULL,'2026-11-01 08:36:45.332252'),('E-C08191BE171248E1BE8B','B-E564BA8B6A4A485FAB62','SAUCE','SAUCED','ACTIVE',2,2,'2026-11-01 11:05:00.000000','常德酱板鸭食品有限公司','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T11:05\",\"carrierOrgId\":\"\",\"eventId\":\"E-C08191BE171248E1BE8B\",\"eventType\":\"SAUCE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"2\",\"locationCode\":\"常德酱板鸭食品有限公司\",\"operatorUserId\":\"2\",\"prevEventId\":\"E-7415ECD554CF47BFAAEB\",\"prevHash\":\"61501e708a6e72cae060030a3f26c9bec23c075b1c1b4f85c5bdff5c1b5ab93f\",\"processData\":{\"actualTemperature\":\"91.5\",\"ccpResult\":\"PASS\",\"durationMin\":\"180\",\"endAt\":\"2026-11-01T11:00:00\",\"equipmentId\":\"C-01\",\"formulaVersion\":\"V1.0\",\"pH\":\"6.2\",\"pressureKPa\":\"101\",\"salinity\":\"3.5\",\"setTemperature\":\"92\",\"startAt\":\"2026-11-01T08:00:00\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SAUCED\",\"targetOrgId\":\"\"}','b0b6b0cffb3c85d7ca5eb6c5e5b103db228f62d1a3ee0a22d5aedfc082a7e5f0',NULL,'E-7415ECD554CF47BFAAEB','61501e708a6e72cae060030a3f26c9bec23c075b1c1b4f85c5bdff5c1b5ab93f','82314b9c-f50a-4428-a36a-70b50af6cff0','COMMITTED','c22fef0cd8daa0b9cb3d7bdc5d80cc6726b8fbae7ac473aeef2aabc188e3986c',16,NULL,NULL,'2026-11-01 00:20:38.352220'),('E-D1E00FB0CDB94259AAA9','B-C43F968FBCB24D27A66E','BREEDING_RECORD','QUARANTINED','ACTIVE',8,18,'2026-11-07 07:48:30.000000','','{\"batchId\":\"B-C43F968FBCB24D27A66E\",\"businessTime\":\"2026-11-07T07:48:30\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-D1E00FB0CDB94259AAA9\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"\",\"operatorUserId\":\"18\",\"prevEventId\":\"E-A76CB06E3B6144459C53\",\"prevHash\":\"eaba33b0efb1851ae0c9d9ddb3c68e6551a55613fa67ad2ee72ea02b9751a2d9\",\"processData\":{\"breedingBatchNo\":\"1\",\"feedBatchNo\":\"1\",\"healthStatus\":\"异常\",\"medicationRecord\":\"1\",\"remark\":\"\",\"stockQuantity\":\"1\",\"vaccineRecord\":\"1\",\"withdrawalPeriodEnd\":\"2026-11-07\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"QUARANTINED\",\"targetOrgId\":\"\"}','22f64cdddaeba44c3ef1cbe9846be7904e8a405864e480f2f9e01ae46a0498a3',NULL,'E-A76CB06E3B6144459C53','eaba33b0efb1851ae0c9d9ddb3c68e6551a55613fa67ad2ee72ea02b9751a2d9','64704d03-2483-4f45-a6ec-5adc024af5d3','PENDING_REVIEW',NULL,NULL,NULL,NULL,'2026-11-07 15:48:42.552196'),('E-E895546863A444E2A7CA','B-B9E25EAC78A34A149FE3','DISPATCH','DISPATCHED','DISPATCHED',1,1,'2026-11-01 00:22:00.000000','常德金鸭养殖基地','{\"batchId\":\"B-B9E25EAC78A34A149FE3\",\"businessTime\":\"2026-11-01T00:22\",\"carrierOrgId\":\"\",\"eventId\":\"E-E895546863A444E2A7CA\",\"eventType\":\"DISPATCH\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"1\",\"locationCode\":\"常德金鸭养殖基地\",\"operatorUserId\":\"1\",\"prevEventId\":\"E-05457F6A3E7C4FC392C3\",\"prevHash\":\"a1016dbbc9873378e66db03008852252f53d7e8bdd39692669290003ad9415b1\",\"processData\":{\"destination\":\"常德酱板鸭食品有限公司\",\"sealNo\":\"SEAL-001\",\"temperature\":\"12\",\"vehicleRef\":\"湘J-12345\"},\"resultStatus\":\"DISPATCHED\",\"stage\":\"DISPATCHED\",\"targetOrgId\":\"2\"}','c490d661541add2c8d4b0431f25e2a8ce12a3d9ada37a2cd2f172e6f4213cdc3',NULL,'E-05457F6A3E7C4FC392C3','a1016dbbc9873378e66db03008852252f53d7e8bdd39692669290003ad9415b1','412e7d11-09a5-44b4-bc20-9fa0756b0506','COMMITTED','27c30a2c0b100820c04246ae9150c63de0ea7ed17cd7e5b31ef01ae3dabed801',11,NULL,NULL,'2026-11-01 00:19:18.019217'),('E-ECCE910F403147D3866A','B-9CE1CE83D60C47769096','BREEDING_RECORD','SOURCE','ACTIVE',8,18,'2026-11-07 10:20:00.000000','SUP-VERIFY','{\"batchId\":\"B-9CE1CE83D60C47769096\",\"businessTime\":\"2026-11-07T10:20\",\"carrierOrgId\":\"\",\"discrepancyCode\":\"\",\"eventId\":\"E-ECCE910F403147D3866A\",\"eventType\":\"BREEDING_RECORD\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"8\",\"locationCode\":\"SUP-VERIFY\",\"operatorUserId\":\"18\",\"prevEventId\":\"\",\"prevHash\":\"decefa0f8614cf4f923a303186ae31aba33f7327d1b5e651137fd93b5ea07968\",\"processData\":{\"breedingBatchNo\":\"YZ-CHAIN-FIX-001\",\"feedBatchNo\":\"SL-CHAIN-FIX-001\",\"healthStatus\":\"正常\",\"medicationRecord\":\"YY-CHAIN-FIX\",\"remark\":\"上链修复验证\",\"stockQuantity\":\"50\",\"vaccineRecord\":\"YM-CHAIN-FIX\",\"withdrawalPeriodEnd\":\"2026-11-20\"},\"resultStatus\":\"ACTIVE\",\"stage\":\"SOURCE\",\"targetOrgId\":\"\"}','f5d2a0e8b76681e624534ba8b6e78add700725f3632c3650b61817eb22221ed0',NULL,NULL,'decefa0f8614cf4f923a303186ae31aba33f7327d1b5e651137fd93b5ea07968','25f54eec-3e53-4c02-ae4d-83d38f247c70','COMMITTED','718799323c9ec11a9b48ed0a089c2d77a3a9cefaaed67dd00d338c87013df1f0',7,NULL,NULL,'2026-11-07 10:18:45.011129'),('E-F98ACF267CC74310B3B8','B-E564BA8B6A4A485FAB62','RECEIVE','ON_SALE','ON_SALE',4,5,'2026-11-01 16:45:00.000000','常德老街特产店','{\"batchId\":\"B-E564BA8B6A4A485FAB62\",\"businessTime\":\"2026-11-01T16:45\",\"carrierOrgId\":\"\",\"eventId\":\"E-F98ACF267CC74310B3B8\",\"eventType\":\"RECEIVE\",\"evidenceRoot\":\"\",\"issuerOrgId\":\"4\",\"locationCode\":\"常德老街特产店\",\"operatorUserId\":\"5\",\"prevEventId\":\"E-986B72694D6445B69694\",\"prevHash\":\"7baea2f550ffe7838315785a2e816fa14ee79734e003f80481000d06e86ed734\",\"processData\":{\"discrepancyCode\":\"\",\"packageIntact\":\"是\",\"quantityReceived\":\"150\",\"temperature\":\"5\"},\"resultStatus\":\"ON_SALE\",\"stage\":\"ON_SALE\",\"targetOrgId\":\"\"}','b960871c2d081b53ca6c139a09f99a6d94d3fc92bf0ee87951918ae0ca931189',NULL,'E-986B72694D6445B69694','7baea2f550ffe7838315785a2e816fa14ee79734e003f80481000d06e86ed734','9d7ddbc5-9bca-410f-aa0e-8b097766b457','COMMITTED','68b4533a4353441330771c2cb78344f2e9ae04a2cb0ef62ddd4bdaded612a572',23,NULL,NULL,'2026-11-01 00:20:59.040963');
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

-- Dump completed on 2026-11-07 15:50:32

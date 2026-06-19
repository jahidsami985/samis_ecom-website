-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: sami_ecom_website_db
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add email otp',7,'add_emailotp'),(26,'Can change email otp',7,'change_emailotp'),(27,'Can delete email otp',7,'delete_emailotp'),(28,'Can view email otp',7,'view_emailotp'),(29,'Can add customer',8,'add_customer'),(30,'Can change customer',8,'change_customer'),(31,'Can delete customer',8,'delete_customer'),(32,'Can view customer',8,'view_customer'),(33,'Can add menu list',9,'add_menulist'),(34,'Can change menu list',9,'change_menulist'),(35,'Can delete menu list',9,'delete_menulist'),(36,'Can view menu list',9,'view_menulist'),(37,'Can add order',10,'add_order'),(38,'Can change order',10,'change_order'),(39,'Can delete order',10,'delete_order'),(40,'Can view order',10,'view_order'),(41,'Can add online payment request',11,'add_onlinepaymentrequest'),(42,'Can change online payment request',11,'change_onlinepaymentrequest'),(43,'Can delete online payment request',11,'delete_onlinepaymentrequest'),(44,'Can view online payment request',11,'view_onlinepaymentrequest'),(45,'Can add order payment',12,'add_orderpayment'),(46,'Can change order payment',12,'change_orderpayment'),(47,'Can delete order payment',12,'delete_orderpayment'),(48,'Can view order payment',12,'view_orderpayment'),(49,'Can add product',13,'add_product'),(50,'Can change product',13,'change_product'),(51,'Can delete product',13,'delete_product'),(52,'Can view product',13,'view_product'),(53,'Can add order detail',14,'add_orderdetail'),(54,'Can change order detail',14,'change_orderdetail'),(55,'Can delete order detail',14,'delete_orderdetail'),(56,'Can view order detail',14,'view_orderdetail'),(57,'Can add order cart',15,'add_ordercart'),(58,'Can change order cart',15,'change_ordercart'),(59,'Can delete order cart',15,'delete_ordercart'),(60,'Can view order cart',15,'view_ordercart'),(61,'Can add product main category',16,'add_productmaincategory'),(62,'Can change product main category',16,'change_productmaincategory'),(63,'Can delete product main category',16,'delete_productmaincategory'),(64,'Can view product main category',16,'view_productmaincategory'),(65,'Can add product sub category',17,'add_productsubcategory'),(66,'Can change product sub category',17,'change_productsubcategory'),(67,'Can delete product sub category',17,'delete_productsubcategory'),(68,'Can view product sub category',17,'view_productsubcategory'),(69,'Can add user permission',18,'add_userpermission'),(70,'Can change user permission',18,'change_userpermission'),(71,'Can delete user permission',18,'delete_userpermission'),(72,'Can view user permission',18,'view_userpermission');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$720000$HchMpWlsW3py2LW7XH9zfz$m0EfMmVFLKlN8PuXRRTcHV0iezrL7Qui6RM6ri3nAcw=','2026-06-19 04:11:01.192048',1,'admin','','','admin@example.com',1,1,'2026-06-13 20:11:46.470936');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backend_customer`
--

DROP TABLE IF EXISTS `backend_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backend_customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `phone` varchar(15) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `backend_customer_user_id_ce4154f6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backend_customer`
--

LOCK TABLES `backend_customer` WRITE;
/*!40000 ALTER TABLE `backend_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `backend_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backend_emailotp`
--

DROP TABLE IF EXISTS `backend_emailotp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backend_emailotp` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `code` varchar(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backend_emailotp`
--

LOCK TABLES `backend_emailotp` WRITE;
/*!40000 ALTER TABLE `backend_emailotp` DISABLE KEYS */;
/*!40000 ALTER TABLE `backend_emailotp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2026-06-19 04:11:53.076515','2','ph',1,'[{\"added\": {}}]',16,1),(2,'2026-06-19 04:12:12.652271','2','ph',3,'',16,1),(3,'2026-06-19 04:15:43.346949','3','T-shirt',1,'[{\"added\": {}}]',16,1),(4,'2026-06-19 04:18:28.919771','4','Phone',1,'[{\"added\": {}}]',16,1),(5,'2026-06-19 04:20:03.484048','1','iphone 15 max',1,'[{\"added\": {}}]',13,1),(6,'2026-06-19 04:21:41.580648','2','iphone 12',1,'[{\"added\": {}}]',13,1),(7,'2026-06-19 04:22:46.266994','3','iphone7',1,'[{\"added\": {}}]',13,1),(8,'2026-06-19 04:24:17.767315','3','iphone7',2,'[{\"changed\": {\"fields\": [\"Product image\"]}}]',13,1),(9,'2026-06-19 04:26:55.228329','4','Hatil sofa',1,'[{\"added\": {}}]',13,1),(10,'2026-06-19 04:28:00.685446','5','Sofa',1,'[{\"added\": {}}]',13,1),(11,'2026-06-19 04:28:55.096855','5','Sofa',2,'[{\"changed\": {\"fields\": [\"Product image\"]}}]',13,1),(12,'2026-06-19 04:49:57.016493','6','Soft-colorsful-Tshirt',1,'[{\"added\": {}}]',13,1),(13,'2026-06-19 04:51:12.104725','7','Orange-tshirt',1,'[{\"added\": {}}]',13,1),(14,'2026-06-19 04:52:13.011371','8','Gray-tshirt',1,'[{\"added\": {}}]',13,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(8,'backend','customer'),(7,'backend','emailotp'),(9,'backend','menulist'),(11,'backend','onlinepaymentrequest'),(10,'backend','order'),(15,'backend','ordercart'),(14,'backend','orderdetail'),(12,'backend','orderpayment'),(13,'backend','product'),(16,'backend','productmaincategory'),(17,'backend','productsubcategory'),(18,'backend','userpermission'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-06-13 20:11:25.253770'),(2,'auth','0001_initial','2026-06-13 20:11:26.389732'),(3,'admin','0001_initial','2026-06-13 20:11:26.580639'),(4,'admin','0002_logentry_remove_auto_add','2026-06-13 20:11:26.588461'),(5,'admin','0003_logentry_add_action_flag_choices','2026-06-13 20:11:26.597220'),(6,'contenttypes','0002_remove_content_type_name','2026-06-13 20:11:26.732653'),(7,'auth','0002_alter_permission_name_max_length','2026-06-13 20:11:26.818204'),(8,'auth','0003_alter_user_email_max_length','2026-06-13 20:11:26.841142'),(9,'auth','0004_alter_user_username_opts','2026-06-13 20:11:26.849645'),(10,'auth','0005_alter_user_last_login_null','2026-06-13 20:11:26.919386'),(11,'auth','0006_require_contenttypes_0002','2026-06-13 20:11:26.923181'),(12,'auth','0007_alter_validators_add_error_messages','2026-06-13 20:11:26.931744'),(13,'auth','0008_alter_user_username_max_length','2026-06-13 20:11:27.013841'),(14,'auth','0009_alter_user_last_name_max_length','2026-06-13 20:11:27.106531'),(15,'auth','0010_alter_group_name_max_length','2026-06-13 20:11:27.128883'),(16,'auth','0011_update_proxy_permissions','2026-06-13 20:11:27.138765'),(17,'auth','0012_alter_user_first_name_max_length','2026-06-13 20:11:27.221629'),(18,'backend','0001_initial','2026-06-13 20:11:29.849155'),(19,'sessions','0001_initial','2026-06-13 20:11:29.896225');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('ikr3pci22x9g9bpmcv9upxmabcq9h0bl','.eJxVjDsOwjAQBe_iGll2vP5R0nMGa-3d4ABypDipEHeHSCmgfTPzXiLhtta0dV7SROIstDj9bhnLg9sO6I7tNssyt3WZstwVedAurzPx83K4fwcVe_3WEWEAKgC-eDbKeoAQRgreITmno-ecA2nnnRmjMmhNyczRhghxUIXF-wPN0jdq:1waQZJ:EWa94eFXD6Wq4IYVNRDpd8n-4vff7lCdp9srzNzXIFo','2026-07-03 04:11:01.208838');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_list`
--

DROP TABLE IF EXISTS `menu_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_list` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `module_name` varchar(100) NOT NULL,
  `menu_name` varchar(100) NOT NULL,
  `menu_url` varchar(250) NOT NULL,
  `menu_icon` varchar(250) DEFAULT NULL,
  `parent_id` int NOT NULL,
  `is_main_menu` tinyint(1) NOT NULL,
  `is_sub_menu` tinyint(1) NOT NULL,
  `is_sub_child_menu` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `created_by_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menu_name` (`menu_name`),
  UNIQUE KEY `menu_url` (`menu_url`),
  KEY `menu_list_created_by_id_37c8f718_fk_auth_user_id` (`created_by_id`),
  KEY `menu_list_module_name_b77fdeda` (`module_name`),
  CONSTRAINT `menu_list_created_by_id_37c8f718_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_list`
--

LOCK TABLES `menu_list` WRITE;
/*!40000 ALTER TABLE `menu_list` DISABLE KEYS */;
INSERT INTO `menu_list` VALUES (1,'Ecommerce','Ecom Dashboard','/backend/dashboard/','fa fa-users icon',0,1,0,0,'2025-05-07 15:01:14.353000','2025-05-07 15:01:14.353000','2025-05-07 15:01:14.353000',1,0,1),(2,'Setting','Setting Dashboard','/backend/setting-dashboard/','fa fa-users icon',0,1,0,0,'2025-05-07 15:01:14.353000','2025-05-07 15:01:14.353000','2025-05-07 15:01:14.353000',1,0,1),(3,'Setting','Products Main Category','/backend/product-main-category-list/','fa fa-users icon',2,0,1,0,'2025-05-07 15:01:14.353000','2025-05-07 15:01:14.353000','2025-05-07 15:01:14.353000',1,0,1),(4,'Setting','Product List','/backend/product-list/','fa fa-users icon',2,0,1,0,'2025-05-07 15:01:14.353000','2025-05-07 15:01:14.353000','2025-05-07 15:01:14.353000',1,0,1),(5,'Setting','Brand List','/backend/brand-list/','fa fa-users icon',2,0,1,0,'2025-05-07 15:01:14.353000','2025-05-07 15:01:14.353000','2025-05-07 15:01:14.353000',1,0,1),(6,'Setting','Category List','/backend/category-list/','fa fa-users icon',2,0,1,0,'2025-05-07 15:01:14.353000','2025-05-07 15:01:14.353000','2025-05-07 15:01:14.353000',1,0,1);
/*!40000 ALTER TABLE `menu_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `online_payment_request`
--

DROP TABLE IF EXISTS `online_payment_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `online_payment_request` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(100) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_status` varchar(15) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `created_by_id` int NOT NULL,
  `order_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `online_payment_request_created_by_id_037bf7d6_fk_auth_user_id` (`created_by_id`),
  KEY `online_payment_request_order_id_b82b2d74_fk_orders_id` (`order_id`),
  CONSTRAINT `online_payment_request_created_by_id_037bf7d6_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `online_payment_request_order_id_b82b2d74_fk_orders_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `online_payment_request`
--

LOCK TABLES `online_payment_request` WRITE;
/*!40000 ALTER TABLE `online_payment_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `online_payment_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_cart`
--

DROP TABLE IF EXISTS `order_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_cart` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `is_order` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `customer_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_cart_customer_id_6237d072_fk_backend_customer_id` (`customer_id`),
  KEY `order_cart_product_id_f972b785_fk_products_id` (`product_id`),
  CONSTRAINT `order_cart_customer_id_6237d072_fk_backend_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `backend_customer` (`id`),
  CONSTRAINT `order_cart_product_id_f972b785_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `order_cart_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_cart`
--

LOCK TABLES `order_cart` WRITE;
/*!40000 ALTER TABLE `order_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `unit_price` decimal(10,2) NOT NULL,
  `is_discount` tinyint(1) NOT NULL,
  `discount_price` decimal(10,2) NOT NULL,
  `quantity` int unsigned NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_details_order_id_9401d97b_fk_orders_id` (`order_id`),
  KEY `order_details_product_id_a3b1bac1_fk_products_id` (`product_id`),
  CONSTRAINT `order_details_order_id_9401d97b_fk_orders_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_details_product_id_a3b1bac1_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `order_details_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_payments`
--

DROP TABLE IF EXISTS `order_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_payments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `payment_method` varchar(50) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `transaction_id` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `order_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_payments_order_id_e4609447_fk_orders_id` (`order_id`),
  CONSTRAINT `order_payments_order_id_e4609447_fk_orders_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_payments`
--

LOCK TABLES `order_payments` WRITE;
/*!40000 ALTER TABLE `order_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_number` varchar(100) DEFAULT NULL,
  `billing_address` varchar(255) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `order_amount` decimal(20,2) NOT NULL,
  `shipping_charge` decimal(20,2) NOT NULL,
  `discount` decimal(20,2) NOT NULL,
  `coupon_discount` decimal(20,2) NOT NULL,
  `vat_amount` decimal(20,2) NOT NULL,
  `tax_amount` decimal(20,2) NOT NULL,
  `paid_amount` decimal(20,2) NOT NULL,
  `due_amount` decimal(20,2) NOT NULL,
  `grand_total` decimal(20,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `customer_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_customer_id_b7016332_fk_backend_customer_id` (`customer_id`),
  CONSTRAINT `orders_customer_id_b7016332_fk_backend_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `backend_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `main_cat_name` varchar(100) NOT NULL,
  `cat_slug` varchar(150) NOT NULL,
  `cat_image` varchar(100) DEFAULT NULL,
  `description` longtext,
  `cat_ordering` int DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_by_id` int NOT NULL,
  `updated_by_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `main_cat_name` (`main_cat_name`),
  UNIQUE KEY `cat_slug` (`cat_slug`),
  KEY `product_category_created_by_id_f48672df_fk_auth_user_id` (`created_by_id`),
  KEY `product_category_updated_by_id_ba9db67e_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `product_category_created_by_id_f48672df_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `product_category_updated_by_id_ba9db67e_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES (1,'Furniture','furniture','','Default product category',1,'2025-05-07 15:01:14.353000',NULL,1,1,NULL),(3,'T-shirt','t-shirt','','Upgrade your everyday essentials with this modern drop-shoulder T-shirt, designed for comfort, structure, and effortless style',6,'2026-06-19 04:15:43.305762','2026-06-19 18:00:00.000000',1,1,NULL),(4,'Phone','phone','ecommerce/category_images/iPhone-15-Pro-15-pro-max-Black-Titanium-price-in-Bangladesh-M_dVixzFQ.webp','',3,'2026-06-19 04:18:28.913624','2026-06-18 18:00:00.000000',1,1,NULL);
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_sub_category`
--

DROP TABLE IF EXISTS `product_sub_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_sub_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sub_cat_name` varchar(100) NOT NULL,
  `sub_cat_slug` varchar(150) NOT NULL,
  `sub_cat_image` varchar(100) DEFAULT NULL,
  `sub_cat_ordering` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_by_id` int NOT NULL,
  `main_category_id` bigint NOT NULL,
  `updated_by_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sub_cat_name` (`sub_cat_name`),
  UNIQUE KEY `sub_cat_slug` (`sub_cat_slug`),
  KEY `product_sub_category_created_by_id_10d4902a_fk_auth_user_id` (`created_by_id`),
  KEY `product_sub_category_main_category_id_94360a6d_fk_product_c` (`main_category_id`),
  KEY `product_sub_category_updated_by_id_cdee20ff_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `product_sub_category_created_by_id_10d4902a_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `product_sub_category_main_category_id_94360a6d_fk_product_c` FOREIGN KEY (`main_category_id`) REFERENCES `product_category` (`id`),
  CONSTRAINT `product_sub_category_updated_by_id_cdee20ff_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_sub_category`
--

LOCK TABLES `product_sub_category` WRITE;
/*!40000 ALTER TABLE `product_sub_category` DISABLE KEYS */;
INSERT INTO `product_sub_category` VALUES (1,'General','general','',1,'2025-05-07 15:01:14.353000',NULL,1,1,1,NULL);
/*!40000 ALTER TABLE `product_sub_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) NOT NULL,
  `product_slug` varchar(150) NOT NULL,
  `product_image` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int unsigned NOT NULL,
  `is_featured` tinyint(1) NOT NULL,
  `total_views` int unsigned NOT NULL,
  `discount_percentage` int unsigned DEFAULT NULL,
  `discount_price` decimal(10,2) DEFAULT NULL,
  `description` longtext,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_by_id` int NOT NULL,
  `updated_by_id` int DEFAULT NULL,
  `main_category_id` bigint NOT NULL,
  `sub_category_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_name` (`product_name`),
  UNIQUE KEY `product_slug` (`product_slug`),
  KEY `products_main_category_id_fa561a99_fk_product_category_id` (`main_category_id`),
  KEY `products_sub_category_id_f08b7711_fk_product_sub_category_id` (`sub_category_id`),
  KEY `products_created_by_id_924ff91a_fk_auth_user_id` (`created_by_id`),
  KEY `products_updated_by_id_65dc5679_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `products_created_by_id_924ff91a_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `products_main_category_id_fa561a99_fk_product_category_id` FOREIGN KEY (`main_category_id`) REFERENCES `product_category` (`id`),
  CONSTRAINT `products_sub_category_id_f08b7711_fk_product_sub_category_id` FOREIGN KEY (`sub_category_id`) REFERENCES `product_sub_category` (`id`),
  CONSTRAINT `products_updated_by_id_65dc5679_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `products_chk_1` CHECK ((`stock` >= 0)),
  CONSTRAINT `products_chk_2` CHECK ((`total_views` >= 0)),
  CONSTRAINT `products_chk_3` CHECK ((`discount_percentage` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'iphone 15 max','iphone-15-max','ecommerce/product_images/iPhone-15-Pro-15-pro-max-Black-Titanium-price-in-Bangladesh-MC_xGJOt1q.webp',146000.00,20,1,0,0,NULL,'Titanium design. Game-changing performance. The Apple iPhone 15 Pro Max redefines what a premium smartphone can do. Forged in Aerospace-grade Titanium, it is remarkably light yet incredibly strong. Powered by the revolutionary A17 Pro chip, this device brings console-level gaming right to your palm. Equipped with a professional 48MP main camera and an exclusive 5x optical zoom, it is the ultimate tool for visual creators, multitaskers, and power users alike','2026-06-19 04:20:03.472531',NULL,1,1,NULL,4,NULL),(2,'iphone 12','iphone-12','ecommerce/product_images/iPhone_12_family_AWxUssP.webp',120000.00,20,1,0,0,NULL,'The iPhone 12 Pro elevates your mobile experience with premium surgical-grade stainless steel construction and a matte glass back. Engineered for power users, it boosts multitasking with 6GB of RAM and introduces a triple-camera system paired with cutting-edge depth-sensing technology.','2026-06-19 04:21:41.573717',NULL,1,1,NULL,4,NULL),(3,'iphone7','iphone7','ecommerce/product_images/eng_pm_Apple-iPhone-7-A1778-2GB-32GB-Black-Pre-owned-iOS-77658__n9wwLBo.jpg',80000.00,30,1,0,0,NULL,'. Reliable everyday performance. The iPhone 7 remains a highly capable, budget-friendly entry point into the Apple ecosystem. Featuring a sleek, lightweight aluminum unibody design, it delivers smooth performance for everyday essentials like messaging, social media, and calling. With its sharp Retina HD display and solid 12MP camera with optical stabilization, it serves as an excellent, highly affordable choice for a first phone, a reliable backup device, or a durable option for kids','2026-06-19 04:22:46.262438',NULL,1,1,1,4,NULL),(4,'Hatil sofa','hatil-sofa','ecommerce/product_images/HATIL_Sofa_Set_Veteran-336_7E7daNE.webp',200000.00,30,0,0,0,NULL,'The HATIL Denver-331 fabric sofa brings a sophisticated, modern aesthetic to any contemporary living room. Crafted using kiln-dried imported Beech wood and engineered components, it provides deep, supportive cushioning upholstered in dry-cleanable, premium fabric. Its ergonomic contours make it perfect for long hours of lounging or hosting guests in style','2026-06-19 04:26:55.223095',NULL,1,1,NULL,1,NULL),(5,'Sofa','sofa','ecommerce/product_images/fg-1776928937_DmAXhyb.webp',90000.00,50,0,0,0,NULL,'Maximize your floor layout with the HATIL Simsbury-285 L-shaped modular sofa. Engineered specifically for corners or spacious open-plan living zones, this multi-seater arrangement provides generous seating capacity without crowding your room. Its minimalist wooden lines seamlessly blend Japanese \"Kaizen\" craftsmanship with Scandinavian functionality.','2026-06-19 04:28:00.679329',NULL,1,1,1,1,NULL),(6,'Soft-colorsful-Tshirt','soft-colorsful-tshirt','ecommerce/product_images/HLB1ZjLZRAzoK1RjSZFlq6yi4VXac.avif',700.00,30,1,0,0,NULL,'Crafted from ultra-soft, breathable combed cotton, this premium crewneck t-shirt is designed for maximum comfort and durability. It features a modern, tailored fit that sits perfectly on the shoulders without feeling restrictive. Whether worn as a standalone casual piece or layered under a jacket, it remains a reliable wardrobe staple that holds its shape wash after wash.','2026-06-19 04:49:56.971730',NULL,1,1,NULL,3,NULL),(7,'Orange-tshirt','orange-tshirt','ecommerce/product_images/Artboard_7_31_OdjBQhn.webp',800.00,40,0,0,0,NULL,'Elevate your everyday look with this classic polo t-shirt. Combining the comfort of a casual tee with the structured elegance of a collar, it transitions effortlessly from office meetings to weekend hangouts. The piqué knit weave provides excellent ventilation, keeping you cool and dry even during hot, humid afternoons.','2026-06-19 04:51:12.095940',NULL,1,1,NULL,3,NULL),(8,'Gray-tshirt','gray-tshirt','ecommerce/product_images/0901013_oversized-plain-t-shirt-silver-ash_xifzoOR.webp',700.00,50,0,0,0,NULL,'Embrace modern urban fashion with this oversized graphic t-shirt. Featuring a relaxed drop-shoulder silhouette and a heavyweight fabric build, it offers a distinct, high-fashion drape. The chest features a high-density, screen-printed graphic that serves as a bold statement piece for any streetwear enthusiast.','2026-06-19 04:52:13.002687',NULL,1,1,NULL,3,NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_permission`
--

DROP TABLE IF EXISTS `user_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_permission` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `can_view` tinyint(1) NOT NULL,
  `can_add` tinyint(1) NOT NULL,
  `can_update` tinyint(1) NOT NULL,
  `can_delete` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `created_by_id` int NOT NULL,
  `deleted_by_id` int DEFAULT NULL,
  `menu_id` bigint NOT NULL,
  `updated_by_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_permission_created_by_id_41746c1a_fk_auth_user_id` (`created_by_id`),
  KEY `user_permission_deleted_by_id_b8a40ecc_fk_auth_user_id` (`deleted_by_id`),
  KEY `user_permission_menu_id_b02bb39b_fk_menu_list_id` (`menu_id`),
  KEY `user_permission_updated_by_id_445bbdd4_fk_auth_user_id` (`updated_by_id`),
  KEY `user_permission_user_id_094cc8c7_fk_auth_user_id` (`user_id`),
  CONSTRAINT `user_permission_created_by_id_41746c1a_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `user_permission_deleted_by_id_b8a40ecc_fk_auth_user_id` FOREIGN KEY (`deleted_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `user_permission_menu_id_b02bb39b_fk_menu_list_id` FOREIGN KEY (`menu_id`) REFERENCES `menu_list` (`id`),
  CONSTRAINT `user_permission_updated_by_id_445bbdd4_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `user_permission_user_id_094cc8c7_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permission`
--

LOCK TABLES `user_permission` WRITE;
/*!40000 ALTER TABLE `user_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'sami_ecom_website_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-18 23:04:18

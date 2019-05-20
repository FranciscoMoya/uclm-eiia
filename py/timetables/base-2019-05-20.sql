-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: timetable
-- ------------------------------------------------------
-- Server version	5.7.25-1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `academic_area`
--

DROP TABLE IF EXISTS `academic_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_area` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `academic_area_abbreviation` varchar(40) DEFAULT NULL,
  `long_title` varchar(100) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_academic_area` (`session_id`,`academic_area_abbreviation`),
  KEY `idx_academic_area_abbv` (`academic_area_abbreviation`,`session_id`),
  CONSTRAINT `fk_academic_area_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_area`
--

LOCK TABLES `academic_area` WRITE;
/*!40000 ALTER TABLE `academic_area` DISABLE KEYS */;
/*!40000 ALTER TABLE `academic_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academic_classification`
--

DROP TABLE IF EXISTS `academic_classification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_classification` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `code` varchar(40) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_academic_clasf_code` (`code`,`session_id`),
  KEY `fk_acad_class_session` (`session_id`),
  CONSTRAINT `fk_acad_class_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_classification`
--

LOCK TABLES `academic_classification` WRITE;
/*!40000 ALTER TABLE `academic_classification` DISABLE KEYS */;
/*!40000 ALTER TABLE `academic_classification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `advisor`
--

DROP TABLE IF EXISTS `advisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `advisor` (
  `uniqueid` decimal(20,0) NOT NULL,
  `external_uid` varchar(40) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `acad_title` varchar(50) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `session_id` decimal(20,0) NOT NULL,
  `role_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_advisor_session` (`session_id`),
  KEY `fk_advisor_role` (`role_id`),
  KEY `idx_advisor` (`external_uid`,`role_id`),
  CONSTRAINT `fk_advisor_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_advisor_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advisor`
--

LOCK TABLES `advisor` WRITE;
/*!40000 ALTER TABLE `advisor` DISABLE KEYS */;
/*!40000 ALTER TABLE `advisor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_config`
--

DROP TABLE IF EXISTS `application_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_config` (
  `name` varchar(255) NOT NULL,
  `value` varchar(4000) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_config`
--

LOCK TABLES `application_config` WRITE;
/*!40000 ALTER TABLE `application_config` DISABLE KEYS */;
INSERT INTO `application_config` VALUES ('tmtbl.db.version','219','Timetabling database version (please do not change -- this key is used by automatic database update)');
/*!40000 ALTER TABLE `application_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assigned_instructors`
--

DROP TABLE IF EXISTS `assigned_instructors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assigned_instructors` (
  `assignment_id` decimal(20,0) NOT NULL,
  `instructor_id` decimal(20,0) NOT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  PRIMARY KEY (`assignment_id`,`instructor_id`),
  KEY `idx_assigned_instructors` (`assignment_id`),
  KEY `fk_assigned_instrs_instructor` (`instructor_id`),
  CONSTRAINT `fk_assigned_instrs_assignment` FOREIGN KEY (`assignment_id`) REFERENCES `assignment` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_assigned_instrs_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `departmental_instructor` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assigned_instructors`
--

LOCK TABLES `assigned_instructors` WRITE;
/*!40000 ALTER TABLE `assigned_instructors` DISABLE KEYS */;
/*!40000 ALTER TABLE `assigned_instructors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assigned_rooms`
--

DROP TABLE IF EXISTS `assigned_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assigned_rooms` (
  `assignment_id` decimal(20,0) NOT NULL,
  `room_id` decimal(20,0) NOT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  PRIMARY KEY (`assignment_id`,`room_id`),
  KEY `idx_assigned_rooms` (`assignment_id`),
  CONSTRAINT `fk_assigned_rooms_assignment` FOREIGN KEY (`assignment_id`) REFERENCES `assignment` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assigned_rooms`
--

LOCK TABLES `assigned_rooms` WRITE;
/*!40000 ALTER TABLE `assigned_rooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `assigned_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignment`
--

DROP TABLE IF EXISTS `assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignment` (
  `uniqueid` decimal(20,0) NOT NULL,
  `days` bigint(10) DEFAULT NULL,
  `slot` bigint(10) DEFAULT NULL,
  `time_pattern_id` decimal(20,0) DEFAULT NULL,
  `solution_id` decimal(20,0) DEFAULT NULL,
  `class_id` decimal(20,0) DEFAULT NULL,
  `class_name` varchar(100) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `date_pattern_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_assignment_class` (`class_id`),
  KEY `idx_assignment_solution_index` (`solution_id`),
  KEY `idx_assignment_time_pattern` (`time_pattern_id`),
  KEY `fk_assignment_date_pattern` (`date_pattern_id`),
  CONSTRAINT `fk_assignment_class` FOREIGN KEY (`class_id`) REFERENCES `class_` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_assignment_date_pattern` FOREIGN KEY (`date_pattern_id`) REFERENCES `date_pattern` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_assignment_solution` FOREIGN KEY (`solution_id`) REFERENCES `solution` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_assignment_time_pattern` FOREIGN KEY (`time_pattern_id`) REFERENCES `time_pattern` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment`
--

LOCK TABLES `assignment` WRITE;
/*!40000 ALTER TABLE `assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachment_type`
--

DROP TABLE IF EXISTS `attachment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachment_type` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) NOT NULL,
  `abbreviation` varchar(20) NOT NULL,
  `label` varchar(60) NOT NULL,
  `visibility` bigint(10) NOT NULL,
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachment_type`
--

LOCK TABLES `attachment_type` WRITE;
/*!40000 ALTER TABLE `attachment_type` DISABLE KEYS */;
INSERT INTO `attachment_type` VALUES (1769418,'OTHER','Other','Not Specified',6),(1769419,'PICTURE','Picture','Room Picture',15);
/*!40000 ALTER TABLE `attachment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute`
--

DROP TABLE IF EXISTS `attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attribute` (
  `uniqueid` decimal(20,0) NOT NULL,
  `code` varchar(20) NOT NULL,
  `name` varchar(60) NOT NULL,
  `type_id` decimal(20,0) NOT NULL,
  `parent_id` decimal(20,0) DEFAULT NULL,
  `session_id` decimal(20,0) NOT NULL,
  `department_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_attribute_type` (`type_id`),
  KEY `fk_attribute_session` (`session_id`),
  KEY `fk_attribute_department` (`department_id`),
  KEY `fk_attribute_parent` (`parent_id`),
  CONSTRAINT `fk_attribute_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_attribute_parent` FOREIGN KEY (`parent_id`) REFERENCES `attribute` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_attribute_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_attribute_type` FOREIGN KEY (`type_id`) REFERENCES `attribute_type` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute`
--

LOCK TABLES `attribute` WRITE;
/*!40000 ALTER TABLE `attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_pref`
--

DROP TABLE IF EXISTS `attribute_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attribute_pref` (
  `uniqueid` decimal(20,0) NOT NULL,
  `owner_id` decimal(20,0) NOT NULL,
  `pref_level_id` decimal(20,0) NOT NULL,
  `attribute_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_attribute_pref_pref` (`pref_level_id`),
  KEY `fk_attribute_pref_attribute` (`attribute_id`),
  CONSTRAINT `fk_attribute_pref_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `attribute` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_attribute_pref_pref` FOREIGN KEY (`pref_level_id`) REFERENCES `preference_level` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_pref`
--

LOCK TABLES `attribute_pref` WRITE;
/*!40000 ALTER TABLE `attribute_pref` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_type`
--

DROP TABLE IF EXISTS `attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attribute_type` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) NOT NULL,
  `label` varchar(60) NOT NULL,
  `conjunctive` int(1) NOT NULL,
  `required` int(1) NOT NULL,
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_type`
--

LOCK TABLES `attribute_type` WRITE;
/*!40000 ALTER TABLE `attribute_type` DISABLE KEYS */;
INSERT INTO `attribute_type` VALUES (1834952,'Performance','Performance Level',0,1),(1834953,'Skill','Skill',1,1),(1834954,'Qualification','Qualification',0,1),(1834955,'Cerfification','Cerfification',0,1);
/*!40000 ALTER TABLE `attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `building` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `abbreviation` varchar(20) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `coordinate_x` double DEFAULT NULL,
  `coordinate_y` double DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_building` (`session_id`,`abbreviation`),
  CONSTRAINT `fk_building_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `building`
--

LOCK TABLES `building` WRITE;
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
/*!40000 ALTER TABLE `building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `building_pref`
--

DROP TABLE IF EXISTS `building_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `building_pref` (
  `uniqueid` decimal(20,0) NOT NULL,
  `owner_id` decimal(20,0) DEFAULT NULL,
  `pref_level_id` decimal(20,0) DEFAULT NULL,
  `bldg_id` decimal(20,0) DEFAULT NULL,
  `distance_from` int(5) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_building_pref_bldg` (`bldg_id`),
  KEY `idx_building_pref_level` (`pref_level_id`),
  KEY `idx_building_pref_owner` (`owner_id`),
  CONSTRAINT `fk_building_pref_bldg` FOREIGN KEY (`bldg_id`) REFERENCES `building` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_building_pref_level` FOREIGN KEY (`pref_level_id`) REFERENCES `preference_level` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `building_pref`
--

LOCK TABLES `building_pref` WRITE;
/*!40000 ALTER TABLE `building_pref` DISABLE KEYS */;
/*!40000 ALTER TABLE `building_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `change_log`
--

DROP TABLE IF EXISTS `change_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change_log` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `manager_id` decimal(20,0) DEFAULT NULL,
  `time_stamp` datetime DEFAULT NULL,
  `obj_type` varchar(255) DEFAULT NULL,
  `obj_uid` decimal(20,0) DEFAULT NULL,
  `obj_title` varchar(255) DEFAULT NULL,
  `subj_area_id` decimal(20,0) DEFAULT NULL,
  `department_id` decimal(20,0) DEFAULT NULL,
  `source` varchar(50) DEFAULT NULL,
  `operation` varchar(50) DEFAULT NULL,
  `detail` longblob,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_change_log_department` (`department_id`),
  KEY `idx_change_log_object` (`obj_type`,`obj_uid`),
  KEY `idx_change_log_sessionmgr` (`session_id`,`manager_id`),
  KEY `idx_change_log_subjarea` (`subj_area_id`),
  KEY `fk_change_log_manager` (`manager_id`),
  CONSTRAINT `fk_change_log_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_change_log_manager` FOREIGN KEY (`manager_id`) REFERENCES `timetable_manager` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_change_log_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_change_log_subjarea` FOREIGN KEY (`subj_area_id`) REFERENCES `subject_area` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `change_log`
--

LOCK TABLES `change_log` WRITE;
/*!40000 ALTER TABLE `change_log` DISABLE KEYS */;
INSERT INTO `change_log` VALUES (2064384,239259,470,'2019-05-20 06:45:01','org.unitime.timetable.model.Session',239259,'Primer semestre 2019 (EIIA)',NULL,NULL,'SESSION_EDIT','UPDATE',NULL),(2228224,239259,470,'2019-05-20 06:52:31','org.unitime.timetable.model.TimetableManager',470,'Admin, Default',NULL,NULL,'MANAGER_EDIT','UPDATE',NULL),(2228225,239259,470,'2019-05-20 06:53:15','org.unitime.timetable.model.TimetableManager',470,'Admin, Default',NULL,NULL,'MANAGER_EDIT','UPDATE',NULL),(2228226,239259,470,'2019-05-20 06:55:23','org.unitime.timetable.model.Department',2260992,'EIIA - Planificación docente',NULL,2260992,'DEPARTMENT_EDIT','CREATE',NULL),(2228227,239259,470,'2019-05-20 06:55:49','org.unitime.timetable.model.TimetableManager',470,'Admin, Default',NULL,NULL,'MANAGER_EDIT','UPDATE',NULL),(2228228,239259,470,'2019-05-20 06:56:01','org.unitime.timetable.model.TimetableManager',470,'Admin, Default',NULL,NULL,'MANAGER_EDIT','UPDATE',NULL),(2228229,239259,470,'2019-05-20 06:56:18','org.unitime.timetable.model.TimetableManager',470,'Moya, Francisco',NULL,NULL,'MANAGER_EDIT','UPDATE',NULL);
/*!40000 ALTER TABLE `change_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_`
--

DROP TABLE IF EXISTS `class_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_` (
  `uniqueid` decimal(20,0) NOT NULL,
  `subpart_id` decimal(20,0) DEFAULT NULL,
  `expected_capacity` int(4) DEFAULT NULL,
  `nbr_rooms` int(4) DEFAULT NULL,
  `parent_class_id` decimal(20,0) DEFAULT NULL,
  `owner_id` decimal(20,0) DEFAULT NULL,
  `room_capacity` int(4) DEFAULT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  `date_pattern_id` decimal(20,0) DEFAULT NULL,
  `managing_dept` decimal(20,0) DEFAULT NULL,
  `display_instructor` int(1) DEFAULT NULL,
  `sched_print_note` varchar(2000) DEFAULT NULL,
  `class_suffix` varchar(40) DEFAULT NULL,
  `display_in_sched_book` int(1) DEFAULT '1',
  `max_expected_capacity` int(4) DEFAULT NULL,
  `room_ratio` double DEFAULT NULL,
  `section_number` int(5) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `uid_rolled_fwd_from` decimal(20,0) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `enrollment` int(4) DEFAULT NULL,
  `cancelled` int(1) DEFAULT '0',
  `snapshot_limit` bigint(10) DEFAULT NULL,
  `snapshot_limit_date` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_class_datepatt` (`date_pattern_id`),
  KEY `idx_class_managing_dept` (`managing_dept`),
  KEY `idx_class_parent` (`parent_class_id`),
  KEY `idx_class_subpart_id` (`subpart_id`),
  CONSTRAINT `fk_class_datepatt` FOREIGN KEY (`date_pattern_id`) REFERENCES `date_pattern` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_class_parent` FOREIGN KEY (`parent_class_id`) REFERENCES `class_` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_class_scheduling_subpart` FOREIGN KEY (`subpart_id`) REFERENCES `scheduling_subpart` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_`
--

LOCK TABLES `class_` WRITE;
/*!40000 ALTER TABLE `class_` DISABLE KEYS */;
/*!40000 ALTER TABLE `class_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_instructor`
--

DROP TABLE IF EXISTS `class_instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_instructor` (
  `uniqueid` decimal(20,0) NOT NULL,
  `class_id` decimal(20,0) DEFAULT NULL,
  `instructor_id` decimal(20,0) DEFAULT NULL,
  `percent_share` int(3) DEFAULT NULL,
  `is_lead` int(1) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `responsibility_id` decimal(20,0) DEFAULT NULL,
  `request_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_class_instructor_class` (`class_id`),
  KEY `idx_class_instructor_instr` (`instructor_id`),
  KEY `fk_instr_responsibility` (`responsibility_id`),
  KEY `fk_instr_request` (`request_id`),
  CONSTRAINT `fk_class_instructor_class` FOREIGN KEY (`class_id`) REFERENCES `class_` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_class_instructor_instr` FOREIGN KEY (`instructor_id`) REFERENCES `departmental_instructor` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_instr_request` FOREIGN KEY (`request_id`) REFERENCES `teaching_request` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_instr_responsibility` FOREIGN KEY (`responsibility_id`) REFERENCES `teaching_responsibility` (`uniqueid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_instructor`
--

LOCK TABLES `class_instructor` WRITE;
/*!40000 ALTER TABLE `class_instructor` DISABLE KEYS */;
/*!40000 ALTER TABLE `class_instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_waitlist`
--

DROP TABLE IF EXISTS `class_waitlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_waitlist` (
  `uniqueid` decimal(20,0) NOT NULL,
  `student_id` decimal(20,0) DEFAULT NULL,
  `course_request_id` decimal(20,0) DEFAULT NULL,
  `class_id` decimal(20,0) DEFAULT NULL,
  `type` bigint(10) DEFAULT '0',
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_class_waitlist_class` (`class_id`),
  KEY `idx_class_waitlist_req` (`course_request_id`),
  KEY `idx_class_waitlist_student` (`student_id`),
  CONSTRAINT `fk_class_waitlist_class` FOREIGN KEY (`class_id`) REFERENCES `class_` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_class_waitlist_request` FOREIGN KEY (`course_request_id`) REFERENCES `course_request` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_class_waitlist_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_waitlist`
--

LOCK TABLES `class_waitlist` WRITE;
/*!40000 ALTER TABLE `class_waitlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `class_waitlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cluster_discovery`
--

DROP TABLE IF EXISTS `cluster_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cluster_discovery` (
  `own_address` varchar(200) NOT NULL,
  `cluster_name` varchar(200) NOT NULL,
  `ping_data` longblob,
  `time_stamp` datetime DEFAULT NULL,
  PRIMARY KEY (`own_address`,`cluster_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cluster_discovery`
--

LOCK TABLES `cluster_discovery` WRITE;
/*!40000 ALTER TABLE `cluster_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `cluster_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `constraint_info`
--

DROP TABLE IF EXISTS `constraint_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `constraint_info` (
  `assignment_id` decimal(20,0) NOT NULL,
  `solver_info_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`solver_info_id`,`assignment_id`),
  KEY `idx_constraint_info` (`assignment_id`),
  CONSTRAINT `fk_constraint_info_assignment` FOREIGN KEY (`assignment_id`) REFERENCES `assignment` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_constraint_info_solver` FOREIGN KEY (`solver_info_id`) REFERENCES `solver_info` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `constraint_info`
--

LOCK TABLES `constraint_info` WRITE;
/*!40000 ALTER TABLE `constraint_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `constraint_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_catalog`
--

DROP TABLE IF EXISTS `course_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_catalog` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `subject` varchar(10) DEFAULT NULL,
  `course_nbr` varchar(10) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `perm_id` varchar(20) DEFAULT NULL,
  `approval_type` varchar(20) DEFAULT NULL,
  `designator_req` int(1) DEFAULT NULL,
  `prev_subject` varchar(10) DEFAULT NULL,
  `prev_crs_nbr` varchar(10) DEFAULT NULL,
  `credit_type` varchar(20) DEFAULT NULL,
  `credit_unit_type` varchar(20) DEFAULT NULL,
  `credit_format` varchar(20) DEFAULT NULL,
  `fixed_min_credit` double DEFAULT NULL,
  `max_credit` double DEFAULT NULL,
  `frac_credit_allowed` int(1) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_course_catalog` (`session_id`,`subject`,`course_nbr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_catalog`
--

LOCK TABLES `course_catalog` WRITE;
/*!40000 ALTER TABLE `course_catalog` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_catalog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_credit_type`
--

DROP TABLE IF EXISTS `course_credit_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_credit_type` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) DEFAULT NULL,
  `label` varchar(60) DEFAULT NULL,
  `abbreviation` varchar(10) DEFAULT NULL,
  `legacy_crse_master_code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_course_credit_type_ref` (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_credit_type`
--

LOCK TABLES `course_credit_type` WRITE;
/*!40000 ALTER TABLE `course_credit_type` DISABLE KEYS */;
INSERT INTO `course_credit_type` VALUES (238,'collegiate','Collegiate Credit',NULL,' '),(239,'continuingEdUnits','Continuing Education Units','CEU','Q'),(240,'equivalent','Equivalent Credit','EQV','E'),(241,'mastersCredit','Masters Credit','MS','M'),(242,'phdThesisCredit','Phd Thesis Credit','PhD','T');
/*!40000 ALTER TABLE `course_credit_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_credit_unit_config`
--

DROP TABLE IF EXISTS `course_credit_unit_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_credit_unit_config` (
  `uniqueid` decimal(20,0) NOT NULL,
  `credit_format` varchar(20) DEFAULT NULL,
  `owner_id` decimal(20,0) DEFAULT NULL,
  `credit_type` decimal(20,0) DEFAULT NULL,
  `credit_unit_type` decimal(20,0) DEFAULT NULL,
  `defines_credit_at_course_level` int(1) DEFAULT NULL,
  `fixed_units` double DEFAULT NULL,
  `min_units` double DEFAULT NULL,
  `max_units` double DEFAULT NULL,
  `fractional_incr_allowed` int(1) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `course_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_crs_crdt_unit_cfg_crd_type` (`credit_type`),
  KEY `idx_crs_crdt_unit_cfg_owner` (`owner_id`),
  KEY `fk_crs_crdt_unit_cfg_crs_own` (`course_id`),
  CONSTRAINT `fk_crs_crdt_unit_cfg_crdt_type` FOREIGN KEY (`credit_type`) REFERENCES `course_credit_type` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_crs_crdt_unit_cfg_crs_own` FOREIGN KEY (`course_id`) REFERENCES `course_offering` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_crs_crdt_unit_cfg_owner` FOREIGN KEY (`owner_id`) REFERENCES `scheduling_subpart` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_credit_unit_config`
--

LOCK TABLES `course_credit_unit_config` WRITE;
/*!40000 ALTER TABLE `course_credit_unit_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_credit_unit_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_credit_unit_type`
--

DROP TABLE IF EXISTS `course_credit_unit_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_credit_unit_type` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) DEFAULT NULL,
  `label` varchar(60) DEFAULT NULL,
  `abbreviation` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_crs_crdt_unit_type_ref` (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_credit_unit_type`
--

LOCK TABLES `course_credit_unit_type` WRITE;
/*!40000 ALTER TABLE `course_credit_unit_type` DISABLE KEYS */;
INSERT INTO `course_credit_unit_type` VALUES (248,'semesterHours','Semester Hours',NULL);
/*!40000 ALTER TABLE `course_credit_unit_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_demand`
--

DROP TABLE IF EXISTS `course_demand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_demand` (
  `uniqueid` decimal(20,0) NOT NULL,
  `student_id` decimal(20,0) DEFAULT NULL,
  `priority` bigint(10) DEFAULT NULL,
  `waitlist` int(1) DEFAULT NULL,
  `is_alternative` int(1) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `free_time_id` decimal(20,0) DEFAULT NULL,
  `changed_by` varchar(40) DEFAULT NULL,
  `critical` int(1) DEFAULT '0',
  PRIMARY KEY (`uniqueid`),
  KEY `idx_course_demand_free_time` (`free_time_id`),
  KEY `idx_course_demand_student` (`student_id`),
  CONSTRAINT `fk_course_demand_free_time` FOREIGN KEY (`free_time_id`) REFERENCES `free_time` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_course_demand_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_demand`
--

LOCK TABLES `course_demand` WRITE;
/*!40000 ALTER TABLE `course_demand` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_demand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_offering`
--

DROP TABLE IF EXISTS `course_offering`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_offering` (
  `uniqueid` decimal(20,0) NOT NULL,
  `course_nbr` varchar(40) DEFAULT NULL,
  `is_control` int(1) DEFAULT NULL,
  `perm_id` varchar(20) DEFAULT NULL,
  `proj_demand` bigint(10) DEFAULT NULL,
  `instr_offr_id` decimal(20,0) DEFAULT NULL,
  `subject_area_id` decimal(20,0) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `schedule_book_note` varchar(1000) DEFAULT NULL,
  `demand_offering_id` decimal(20,0) DEFAULT NULL,
  `demand_offering_type` decimal(20,0) DEFAULT NULL,
  `nbr_expected_stdents` bigint(10) DEFAULT '0',
  `external_uid` varchar(40) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `uid_rolled_fwd_from` decimal(20,0) DEFAULT NULL,
  `lastlike_demand` bigint(10) DEFAULT '0',
  `enrollment` bigint(10) DEFAULT NULL,
  `reservation` bigint(10) DEFAULT NULL,
  `course_type_id` decimal(20,0) DEFAULT NULL,
  `consent_type` decimal(20,0) DEFAULT NULL,
  `alternative_offering_id` decimal(20,0) DEFAULT NULL,
  `snapshot_proj_demand` bigint(19) DEFAULT NULL,
  `snapshot_prj_dmd_date` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_course_offering_subj_crs` (`course_nbr`,`subject_area_id`),
  KEY `idx_course_offering_control` (`is_control`),
  KEY `idx_course_offering_demd_offr` (`demand_offering_id`),
  KEY `idx_course_offering_instr_offr` (`instr_offr_id`),
  KEY `fk_course_offering_subj_area` (`subject_area_id`),
  KEY `fk_course_offering_type` (`course_type_id`),
  KEY `fk_course_consent_type` (`consent_type`),
  CONSTRAINT `fk_course_consent_type` FOREIGN KEY (`consent_type`) REFERENCES `offr_consent_type` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_course_offering_demand_offr` FOREIGN KEY (`demand_offering_id`) REFERENCES `course_offering` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_course_offering_instr_offr` FOREIGN KEY (`instr_offr_id`) REFERENCES `instructional_offering` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_course_offering_subj_area` FOREIGN KEY (`subject_area_id`) REFERENCES `subject_area` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_course_offering_type` FOREIGN KEY (`course_type_id`) REFERENCES `course_type` (`uniqueid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_offering`
--

LOCK TABLES `course_offering` WRITE;
/*!40000 ALTER TABLE `course_offering` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_offering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_pref`
--

DROP TABLE IF EXISTS `course_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_pref` (
  `uniqueid` decimal(20,0) NOT NULL,
  `owner_id` decimal(20,0) NOT NULL,
  `pref_level_id` decimal(20,0) NOT NULL,
  `course_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_course_pref_pref` (`pref_level_id`),
  KEY `fk_course_pref_course` (`course_id`),
  CONSTRAINT `fk_course_pref_course` FOREIGN KEY (`course_id`) REFERENCES `course_offering` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_course_pref_pref` FOREIGN KEY (`pref_level_id`) REFERENCES `preference_level` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_pref`
--

LOCK TABLES `course_pref` WRITE;
/*!40000 ALTER TABLE `course_pref` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_request`
--

DROP TABLE IF EXISTS `course_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_request` (
  `uniqueid` decimal(20,0) NOT NULL,
  `course_demand_id` decimal(20,0) DEFAULT NULL,
  `course_offering_id` decimal(20,0) DEFAULT NULL,
  `ord` bigint(10) DEFAULT NULL,
  `allow_overlap` int(1) DEFAULT NULL,
  `credit` bigint(10) DEFAULT '0',
  `req_status` bigint(10) DEFAULT NULL,
  `req_extid` varchar(40) DEFAULT NULL,
  `req_ts` datetime DEFAULT NULL,
  `req_intent` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_course_request_demand` (`course_demand_id`),
  KEY `idx_course_request_offering` (`course_offering_id`),
  KEY `idx_course_req_extid` (`req_extid`),
  CONSTRAINT `fk_course_request_demand` FOREIGN KEY (`course_demand_id`) REFERENCES `course_demand` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_course_request_offering` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_request`
--

LOCK TABLES `course_request` WRITE;
/*!40000 ALTER TABLE `course_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_request_option`
--

DROP TABLE IF EXISTS `course_request_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_request_option` (
  `uniqueid` decimal(20,0) NOT NULL,
  `course_request_id` decimal(20,0) DEFAULT NULL,
  `option_type` bigint(10) DEFAULT NULL,
  `value` longblob,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_course_request_option_req` (`course_request_id`),
  CONSTRAINT `fk_course_request_options_req` FOREIGN KEY (`course_request_id`) REFERENCES `course_request` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_request_option`
--

LOCK TABLES `course_request_option` WRITE;
/*!40000 ALTER TABLE `course_request_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_request_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_subpart_credit`
--

DROP TABLE IF EXISTS `course_subpart_credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_subpart_credit` (
  `uniqueid` decimal(20,0) NOT NULL,
  `course_catalog_id` decimal(20,0) DEFAULT NULL,
  `subpart_id` varchar(10) DEFAULT NULL,
  `credit_type` varchar(20) DEFAULT NULL,
  `credit_unit_type` varchar(20) DEFAULT NULL,
  `credit_format` varchar(20) DEFAULT NULL,
  `fixed_min_credit` double DEFAULT NULL,
  `max_credit` double DEFAULT NULL,
  `frac_credit_allowed` int(1) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_subpart_cred_crs` (`course_catalog_id`),
  CONSTRAINT `fk_subpart_cred_crs` FOREIGN KEY (`course_catalog_id`) REFERENCES `course_catalog` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_subpart_credit`
--

LOCK TABLES `course_subpart_credit` WRITE;
/*!40000 ALTER TABLE `course_subpart_credit` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_subpart_credit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_type`
--

DROP TABLE IF EXISTS `course_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_type` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_type`
--

LOCK TABLES `course_type` WRITE;
/*!40000 ALTER TABLE `course_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crse_credit_format`
--

DROP TABLE IF EXISTS `crse_credit_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crse_credit_format` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) DEFAULT NULL,
  `label` varchar(60) DEFAULT NULL,
  `abbreviation` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_crse_credit_format_ref` (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crse_credit_format`
--

LOCK TABLES `crse_credit_format` WRITE;
/*!40000 ALTER TABLE `crse_credit_format` DISABLE KEYS */;
INSERT INTO `crse_credit_format` VALUES (243,'arrangeHours','Arrange Hours','AH'),(244,'fixedUnit','Fixed Unit',NULL),(245,'variableMinMax','Variable Min/Max',NULL),(246,'variableRange','Variable Range',NULL);
/*!40000 ALTER TABLE `crse_credit_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curriculum`
--

DROP TABLE IF EXISTS `curriculum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curriculum` (
  `uniqueid` decimal(20,0) NOT NULL,
  `abbv` varchar(40) NOT NULL,
  `name` varchar(100) NOT NULL,
  `acad_area_id` decimal(20,0) DEFAULT NULL,
  `dept_id` decimal(20,0) NOT NULL,
  `multiple_majors` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `pk_curricula` (`uniqueid`),
  KEY `fk_curriculum_acad_area` (`acad_area_id`),
  KEY `fk_curriculum_dept` (`dept_id`),
  CONSTRAINT `fk_curriculum_acad_area` FOREIGN KEY (`acad_area_id`) REFERENCES `academic_area` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_curriculum_dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculum`
--

LOCK TABLES `curriculum` WRITE;
/*!40000 ALTER TABLE `curriculum` DISABLE KEYS */;
/*!40000 ALTER TABLE `curriculum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curriculum_clasf`
--

DROP TABLE IF EXISTS `curriculum_clasf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curriculum_clasf` (
  `uniqueid` decimal(20,0) NOT NULL,
  `curriculum_id` decimal(20,0) NOT NULL,
  `name` varchar(20) NOT NULL,
  `acad_clasf_id` decimal(20,0) DEFAULT NULL,
  `nr_students` bigint(10) NOT NULL,
  `ord` bigint(10) NOT NULL,
  `students` longtext,
  `snapshot_nr_students` bigint(10) DEFAULT NULL,
  `snapshot_nr_stu_date` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `pk_curricula_clasf` (`uniqueid`),
  KEY `fk_curriculum_clasf_acad_clasf` (`acad_clasf_id`),
  KEY `fk_curriculum_clasf_curriculum` (`curriculum_id`),
  CONSTRAINT `fk_curriculum_clasf_acad_clasf` FOREIGN KEY (`acad_clasf_id`) REFERENCES `academic_classification` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_curriculum_clasf_curriculum` FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculum_clasf`
--

LOCK TABLES `curriculum_clasf` WRITE;
/*!40000 ALTER TABLE `curriculum_clasf` DISABLE KEYS */;
/*!40000 ALTER TABLE `curriculum_clasf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curriculum_course`
--

DROP TABLE IF EXISTS `curriculum_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curriculum_course` (
  `uniqueid` decimal(20,0) NOT NULL,
  `course_id` decimal(20,0) NOT NULL,
  `cur_clasf_id` decimal(20,0) NOT NULL,
  `pr_share` double NOT NULL,
  `ord` bigint(10) NOT NULL,
  `snapshot_pr_share` float DEFAULT NULL,
  `snapshot_pr_shr_date` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `pk_curricula_course` (`uniqueid`),
  KEY `fk_curriculum_course_clasf` (`cur_clasf_id`),
  KEY `fk_curriculum_course_course` (`course_id`),
  CONSTRAINT `fk_curriculum_course_clasf` FOREIGN KEY (`cur_clasf_id`) REFERENCES `curriculum_clasf` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_curriculum_course_course` FOREIGN KEY (`course_id`) REFERENCES `course_offering` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculum_course`
--

LOCK TABLES `curriculum_course` WRITE;
/*!40000 ALTER TABLE `curriculum_course` DISABLE KEYS */;
/*!40000 ALTER TABLE `curriculum_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curriculum_course_group`
--

DROP TABLE IF EXISTS `curriculum_course_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curriculum_course_group` (
  `group_id` decimal(20,0) NOT NULL,
  `cur_course_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`group_id`,`cur_course_id`),
  KEY `fk_cur_course_group_course` (`cur_course_id`),
  CONSTRAINT `fk_cur_course_group_course` FOREIGN KEY (`cur_course_id`) REFERENCES `curriculum_course` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_cur_course_group_group` FOREIGN KEY (`group_id`) REFERENCES `curriculum_group` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculum_course_group`
--

LOCK TABLES `curriculum_course_group` WRITE;
/*!40000 ALTER TABLE `curriculum_course_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `curriculum_course_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curriculum_group`
--

DROP TABLE IF EXISTS `curriculum_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curriculum_group` (
  `uniqueid` decimal(20,0) NOT NULL,
  `name` varchar(20) NOT NULL,
  `color` varchar(20) DEFAULT NULL,
  `type` bigint(10) NOT NULL,
  `curriculum_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_curriculum_group_curriculum` (`curriculum_id`),
  CONSTRAINT `fk_curriculum_group_curriculum` FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculum_group`
--

LOCK TABLES `curriculum_group` WRITE;
/*!40000 ALTER TABLE `curriculum_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `curriculum_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curriculum_major`
--

DROP TABLE IF EXISTS `curriculum_major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curriculum_major` (
  `curriculum_id` decimal(20,0) NOT NULL,
  `major_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`curriculum_id`,`major_id`),
  KEY `fk_curriculum_major_major` (`major_id`),
  CONSTRAINT `fk_curriculum_major_curriculum` FOREIGN KEY (`curriculum_id`) REFERENCES `curriculum` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_curriculum_major_major` FOREIGN KEY (`major_id`) REFERENCES `pos_major` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculum_major`
--

LOCK TABLES `curriculum_major` WRITE;
/*!40000 ALTER TABLE `curriculum_major` DISABLE KEYS */;
/*!40000 ALTER TABLE `curriculum_major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curriculum_rule`
--

DROP TABLE IF EXISTS `curriculum_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curriculum_rule` (
  `uniqueid` decimal(20,0) NOT NULL,
  `acad_area_id` decimal(20,0) NOT NULL,
  `major_id` decimal(20,0) DEFAULT NULL,
  `acad_clasf_id` decimal(20,0) NOT NULL,
  `projection` double NOT NULL,
  `snapshot_proj` float DEFAULT NULL,
  `snapshot_proj_date` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_cur_rule_areadept` (`acad_area_id`,`acad_clasf_id`),
  KEY `fk_cur_rule_acad_clasf` (`acad_clasf_id`),
  KEY `fk_cur_rule_major` (`major_id`),
  CONSTRAINT `fk_cur_rule_acad_area` FOREIGN KEY (`acad_area_id`) REFERENCES `academic_area` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_cur_rule_acad_clasf` FOREIGN KEY (`acad_clasf_id`) REFERENCES `academic_classification` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_cur_rule_major` FOREIGN KEY (`major_id`) REFERENCES `pos_major` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculum_rule`
--

LOCK TABLES `curriculum_rule` WRITE;
/*!40000 ALTER TABLE `curriculum_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `curriculum_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `date_mapping`
--

DROP TABLE IF EXISTS `date_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_mapping` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) NOT NULL,
  `class_date` bigint(10) NOT NULL,
  `event_date` bigint(10) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_event_date_session` (`session_id`),
  CONSTRAINT `fk_event_date_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date_mapping`
--

LOCK TABLES `date_mapping` WRITE;
/*!40000 ALTER TABLE `date_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `date_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `date_pattern`
--

DROP TABLE IF EXISTS `date_pattern`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_pattern` (
  `uniqueid` decimal(20,0) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `pattern` varchar(366) DEFAULT NULL,
  `offset` bigint(10) DEFAULT NULL,
  `type` bigint(10) DEFAULT NULL,
  `visible` int(1) DEFAULT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `nr_weeks` float DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_date_pattern_session` (`session_id`),
  CONSTRAINT `fk_date_pattern_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date_pattern`
--

LOCK TABLES `date_pattern` WRITE;
/*!40000 ALTER TABLE `date_pattern` DISABLE KEYS */;
/*!40000 ALTER TABLE `date_pattern` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `date_pattern_dept`
--

DROP TABLE IF EXISTS `date_pattern_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_pattern_dept` (
  `dept_id` decimal(20,0) NOT NULL,
  `pattern_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`dept_id`,`pattern_id`),
  KEY `fk_date_pattern_dept_date` (`pattern_id`),
  CONSTRAINT `fk_date_pattern_dept_date` FOREIGN KEY (`pattern_id`) REFERENCES `date_pattern` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_date_pattern_dept_dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date_pattern_dept`
--

LOCK TABLES `date_pattern_dept` WRITE;
/*!40000 ALTER TABLE `date_pattern_dept` DISABLE KEYS */;
/*!40000 ALTER TABLE `date_pattern_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `date_pattern_parent`
--

DROP TABLE IF EXISTS `date_pattern_parent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_pattern_parent` (
  `date_pattern_id` decimal(20,0) NOT NULL,
  `parent_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`date_pattern_id`,`parent_id`),
  KEY `fk_date_patt_parent_parent` (`parent_id`),
  CONSTRAINT `fk_date_patt_parent_date_patt` FOREIGN KEY (`date_pattern_id`) REFERENCES `date_pattern` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_date_patt_parent_parent` FOREIGN KEY (`parent_id`) REFERENCES `date_pattern` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date_pattern_parent`
--

LOCK TABLES `date_pattern_parent` WRITE;
/*!40000 ALTER TABLE `date_pattern_parent` DISABLE KEYS */;
/*!40000 ALTER TABLE `date_pattern_parent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `date_pattern_pref`
--

DROP TABLE IF EXISTS `date_pattern_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_pattern_pref` (
  `uniqueid` decimal(20,0) NOT NULL,
  `owner_id` decimal(20,0) NOT NULL,
  `pref_level_id` decimal(20,0) NOT NULL,
  `date_pattern_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_datepatt_pref_pref_level` (`pref_level_id`),
  KEY `fk_datepatt_pref_date_pat` (`date_pattern_id`),
  CONSTRAINT `fk_datepatt_pref_date_pat` FOREIGN KEY (`date_pattern_id`) REFERENCES `date_pattern` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_datepatt_pref_pref_level` FOREIGN KEY (`pref_level_id`) REFERENCES `preference_level` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date_pattern_pref`
--

LOCK TABLES `date_pattern_pref` WRITE;
/*!40000 ALTER TABLE `date_pattern_pref` DISABLE KEYS */;
/*!40000 ALTER TABLE `date_pattern_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `demand_offr_type`
--

DROP TABLE IF EXISTS `demand_offr_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demand_offr_type` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) DEFAULT NULL,
  `label` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_demand_offr_type_label` (`label`),
  UNIQUE KEY `uk_demand_offr_type_ref` (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `demand_offr_type`
--

LOCK TABLES `demand_offr_type` WRITE;
/*!40000 ALTER TABLE `demand_offr_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `demand_offr_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `abbreviation` varchar(20) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `dept_code` varchar(50) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `rs_color` varchar(6) DEFAULT NULL,
  `external_manager` int(1) DEFAULT NULL,
  `external_mgr_label` varchar(30) DEFAULT NULL,
  `external_mgr_abbv` varchar(10) DEFAULT NULL,
  `solver_group_id` decimal(20,0) DEFAULT NULL,
  `status_type` decimal(20,0) DEFAULT NULL,
  `dist_priority` bigint(10) DEFAULT '0',
  `allow_req_time` int(1) DEFAULT '0',
  `allow_req_room` int(1) DEFAULT '0',
  `last_modified_time` datetime DEFAULT NULL,
  `allow_req_dist` int(1) DEFAULT '0',
  `allow_events` int(1) DEFAULT '0',
  `instructor_pref` int(1) DEFAULT '1',
  `allow_student_schd` int(1) DEFAULT '1',
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_department_dept_code` (`session_id`,`dept_code`),
  KEY `idx_department_solver_grp` (`solver_group_id`),
  KEY `idx_department_status_type` (`status_type`),
  CONSTRAINT `fk_department_solver_group` FOREIGN KEY (`solver_group_id`) REFERENCES `solver_group` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_department_status_type` FOREIGN KEY (`status_type`) REFERENCES `dept_status_type` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (2260992,239259,'Ac','Planificación docente','EIIA','',NULL,0,'','',NULL,NULL,0,0,0,NULL,0,0,1,1);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departmental_instructor`
--

DROP TABLE IF EXISTS `departmental_instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departmental_instructor` (
  `uniqueid` decimal(20,0) NOT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `career_acct` varchar(20) DEFAULT NULL,
  `lname` varchar(100) DEFAULT NULL,
  `fname` varchar(100) DEFAULT NULL,
  `mname` varchar(100) DEFAULT NULL,
  `pos_code_type` decimal(20,0) DEFAULT NULL,
  `note` varchar(2048) DEFAULT NULL,
  `department_uniqueid` decimal(20,0) DEFAULT NULL,
  `ignore_too_far` int(1) DEFAULT '0',
  `last_modified_time` datetime DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `role_id` decimal(20,0) DEFAULT NULL,
  `acad_title` varchar(50) DEFAULT NULL,
  `teaching_pref_id` decimal(20,0) DEFAULT NULL,
  `max_load` float DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_dept_instr_dept` (`department_uniqueid`),
  KEY `idx_dept_instr_position_type` (`pos_code_type`),
  KEY `fk_instructor_role` (`role_id`),
  KEY `fk_dept_instr_teach_pref` (`teaching_pref_id`),
  CONSTRAINT `fk_dept_instr_dept` FOREIGN KEY (`department_uniqueid`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_dept_instr_pos_code_type` FOREIGN KEY (`pos_code_type`) REFERENCES `position_type` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_dept_instr_teach_pref` FOREIGN KEY (`teaching_pref_id`) REFERENCES `preference_level` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_instructor_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departmental_instructor`
--

LOCK TABLES `departmental_instructor` WRITE;
/*!40000 ALTER TABLE `departmental_instructor` DISABLE KEYS */;
/*!40000 ALTER TABLE `departmental_instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept_status_type`
--

DROP TABLE IF EXISTS `dept_status_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dept_status_type` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) DEFAULT NULL,
  `label` varchar(60) DEFAULT NULL,
  `status` bigint(10) DEFAULT NULL,
  `apply` bigint(10) DEFAULT NULL,
  `ord` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept_status_type`
--

LOCK TABLES `dept_status_type` WRITE;
/*!40000 ALTER TABLE `dept_status_type` DISABLE KEYS */;
INSERT INTO `dept_status_type` VALUES (265,'initial','Initial Data Load',1048576,1,0),(266,'input','Input Data Entry',2623161,1,1),(267,'timetabling','Timetabling',2625465,1,2),(268,'publish','Timetable Published',2683401,1,4),(269,'finished','Session Finished',524809,1,5),(270,'dept_input','External Mgr. Input Data Entry',135,2,6),(271,'dept_timetabling','External Mgr. Timetabling',423,2,7),(272,'dept_publish','External Mgr. Timetable Published',1,2,9),(325,'dept_readonly','Department Read Only',9,2,10),(326,'dept_edit','Department Allow Edit',441,2,11),(385,'dept_readonly_ni','External Mgr. Timetabling (No Instructor Assignments)',391,2,8),(414,'exams','Examination Timetabling',2625033,1,3),(1736651,'exam_disabled','Examination Disabled',0,4,12),(1736652,'exam_edit','Examination Data Entry',1536,4,13),(1736653,'exam_timetabling','Examination Timetabling',3584,4,14),(1736654,'exam_publish','Examination Published',12800,4,15);
/*!40000 ALTER TABLE `dept_status_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept_to_tt_mgr`
--

DROP TABLE IF EXISTS `dept_to_tt_mgr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dept_to_tt_mgr` (
  `timetable_mgr_id` decimal(20,0) NOT NULL,
  `department_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`timetable_mgr_id`,`department_id`),
  KEY `fk_dept_to_tt_mgr_dept` (`department_id`),
  CONSTRAINT `fk_dept_to_tt_mgr_dept` FOREIGN KEY (`department_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_dept_to_tt_mgr_mgr` FOREIGN KEY (`timetable_mgr_id`) REFERENCES `timetable_manager` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept_to_tt_mgr`
--

LOCK TABLES `dept_to_tt_mgr` WRITE;
/*!40000 ALTER TABLE `dept_to_tt_mgr` DISABLE KEYS */;
/*!40000 ALTER TABLE `dept_to_tt_mgr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `designator`
--

DROP TABLE IF EXISTS `designator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `designator` (
  `uniqueid` decimal(20,0) NOT NULL,
  `subject_area_id` decimal(20,0) DEFAULT NULL,
  `instructor_id` decimal(20,0) DEFAULT NULL,
  `code` varchar(3) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_designator_code` (`subject_area_id`,`instructor_id`,`code`),
  KEY `fk_designator_instructor` (`instructor_id`),
  CONSTRAINT `fk_designator_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `departmental_instructor` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_designator_subj_area` FOREIGN KEY (`subject_area_id`) REFERENCES `subject_area` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `designator`
--

LOCK TABLES `designator` WRITE;
/*!40000 ALTER TABLE `designator` DISABLE KEYS */;
/*!40000 ALTER TABLE `designator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disabled_override`
--

DROP TABLE IF EXISTS `disabled_override`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disabled_override` (
  `course_id` decimal(20,0) NOT NULL,
  `type_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`course_id`,`type_id`),
  KEY `fk_disb_override_type` (`type_id`),
  CONSTRAINT `fk_disb_override_course` FOREIGN KEY (`course_id`) REFERENCES `course_offering` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_disb_override_type` FOREIGN KEY (`type_id`) REFERENCES `override_type` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disabled_override`
--

LOCK TABLES `disabled_override` WRITE;
/*!40000 ALTER TABLE `disabled_override` DISABLE KEYS */;
/*!40000 ALTER TABLE `disabled_override` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dist_type_dept`
--

DROP TABLE IF EXISTS `dist_type_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dist_type_dept` (
  `dist_type_id` decimal(19,0) NOT NULL,
  `dept_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`dist_type_id`,`dept_id`),
  KEY `fk_dist_type_dept_dept` (`dept_id`),
  CONSTRAINT `fk_dist_type_dept_dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_dist_type_dept_type` FOREIGN KEY (`dist_type_id`) REFERENCES `distribution_type` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dist_type_dept`
--

LOCK TABLES `dist_type_dept` WRITE;
/*!40000 ALTER TABLE `dist_type_dept` DISABLE KEYS */;
/*!40000 ALTER TABLE `dist_type_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distribution_object`
--

DROP TABLE IF EXISTS `distribution_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distribution_object` (
  `uniqueid` decimal(20,0) NOT NULL,
  `dist_pref_id` decimal(20,0) DEFAULT NULL,
  `sequence_number` int(3) DEFAULT NULL,
  `pref_group_id` decimal(20,0) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_distribution_object_pg` (`pref_group_id`),
  KEY `idx_distribution_object_pref` (`dist_pref_id`),
  CONSTRAINT `fk_distribution_object_pref` FOREIGN KEY (`dist_pref_id`) REFERENCES `distribution_pref` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distribution_object`
--

LOCK TABLES `distribution_object` WRITE;
/*!40000 ALTER TABLE `distribution_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `distribution_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distribution_pref`
--

DROP TABLE IF EXISTS `distribution_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distribution_pref` (
  `uniqueid` decimal(20,0) NOT NULL,
  `owner_id` decimal(20,0) DEFAULT NULL,
  `pref_level_id` decimal(20,0) DEFAULT NULL,
  `dist_type_id` decimal(20,0) DEFAULT NULL,
  `dist_grouping` bigint(10) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `uid_rolled_fwd_from` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_distribution_pref_level` (`pref_level_id`),
  KEY `idx_distribution_pref_owner` (`owner_id`),
  KEY `idx_distribution_pref_type` (`dist_type_id`),
  CONSTRAINT `fk_distribution_pref_dist_type` FOREIGN KEY (`dist_type_id`) REFERENCES `distribution_type` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_distribution_pref_level` FOREIGN KEY (`pref_level_id`) REFERENCES `preference_level` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distribution_pref`
--

LOCK TABLES `distribution_pref` WRITE;
/*!40000 ALTER TABLE `distribution_pref` DISABLE KEYS */;
/*!40000 ALTER TABLE `distribution_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distribution_type`
--

DROP TABLE IF EXISTS `distribution_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distribution_type` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) DEFAULT NULL,
  `label` varchar(60) DEFAULT NULL,
  `sequencing_required` varchar(1) DEFAULT '0',
  `req_id` int(6) DEFAULT NULL,
  `allowed_pref` varchar(10) DEFAULT NULL,
  `description` varchar(2048) DEFAULT NULL,
  `abbreviation` varchar(20) DEFAULT NULL,
  `instructor_pref` int(1) DEFAULT '0',
  `exam_pref` int(1) DEFAULT '0',
  `visible` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_distribution_type_req_id` (`req_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distribution_type`
--

LOCK TABLES `distribution_type` WRITE;
/*!40000 ALTER TABLE `distribution_type` DISABLE KEYS */;
INSERT INTO `distribution_type` VALUES (61,'BTB','Back-To-Back & Same Room','0',1,'P43210R','Classes must be offered in adjacent time segments and must be placed in the same room. Given classes must also be taught on the same days.<BR>When prohibited or (strongly) discouraged: classes cannot be back-to-back. There must be at least half-hour between these classes, and they must be taught on the same days and in the same room.','BTB Same Room',1,0,1),(62,'BTB_TIME','Back-To-Back','0',2,'P43210R','Classes must be offered in adjacent time segments but may be placed in different rooms. Given classes must also be taught on the same days.<BR>When prohibited or (strongly) discouraged: no pair of classes can be taught back-to-back. They may not overlap in time, but must be taught on the same days. This means that there must be at least half-hour between these classes. ','BTB',1,0,1),(63,'SAME_TIME','Same Time','0',3,'P43210R','Given classes must be taught at the same time of day (independent of the actual day the classes meet). For the classes of the same length, this is the same constraint as <i>same start</i>. For classes of different length, the shorter one cannot start before, nor end after, the longer one.<BR>When prohibited or (strongly) discouraged: one class may not meet on any day at a time of day that overlaps with that of the other. For example, one class can not meet M 7:30 while the other meets F 7:30. Note the difference here from the <i>different time</i> constraint that only prohibits the actual class meetings from overlapping.','Same Time',0,0,1),(64,'SAME_DAYS','Same Days','0',4,'P43210R','Given classes must be taught on the same days. In case of classes of different time patterns, a class with fewer meetings must meet on a subset of the days used by the class with more meetings. For example, if one class pattern is 3x50, all others given in the constraint can only be taught on Monday, Wednesday, or Friday. For a 2x100 class MW, MF, WF is allowed but TTh is prohibited.<BR>When prohibited or (strongly) discouraged: any pair of classes classes cannot be taught on the same days (cannot overlap in days). For instance, if one class is MFW, the second has to be TTh.','Same Days',1,0,1),(65,'NHB(1)','1 Hour Between','0',5,'P43210R','Given classes must have exactly 1 hour in between the end of one and the beginning of another. As with the <i>back-to-back time</i> constraint, given classes must be taught on the same days.<BR>When prohibited or (strongly) discouraged: classes can not have 1 hour in between. They may not overlap in time but must be taught on the same days.','1h Btw',0,0,1),(66,'NHB(2)','2 Hours Between','0',6,'P43210R','Given classes must have exactly 2 hours in between the end of one and the beginning of another. As with the <i>back-to-back time</i> constraint, given classes must be taught on the same days.<BR>When prohibited or (strongly) discouraged: classes can not have 2 hours in between. They may not overlap in time but must be taught on the same days.','2h Btw',0,0,1),(67,'NHB(3)','3 Hours Between','0',7,'P43210R','Given classes must have exactly 3 hours in between the end of one and the beginning of another. As with the <i>back-to-back time</i> constraint, given classes must be taught on the same days.<BR>When prohibited or (strongly) discouraged: classes can not have 3 hours in between. They may not overlap in time but must be taught on the same days.','3h Btw',0,0,1),(68,'NHB(4)','4 Hours Between','0',8,'P43210R','Given classes must have exactly 4 hours in between the end of one and the beginning of another. As with the <i>back-to-back time</i> constraint, given classes must be taught on the same days.<BR>When prohibited or (strongly) discouraged: classes can not have 4 hours in between. They may not overlap in time but must be taught on the same days.','4h Btw',0,0,1),(69,'NHB(5)','5 Hours Between','0',9,'P43210R','Given classes must have exactly 5 hours in between the end of one and the beginning of another. As with the <i>back-to-back time</i> constraint, given classes must be taught on the same days.<BR>When prohibited or (strongly) discouraged: classes can not have 5 hours in between. They may not overlap in time but must be taught on the same days.','5h Btw',0,0,1),(70,'NHB(6)','6 Hours Between','0',10,'P43210R','Given classes must have exactly 6 hours in between the end of one and the beginning of another. As with the <i>back-to-back time</i> constraint, given classes must be taught on the same days.<BR>When prohibited or (strongly) discouraged: classes can not have 6 hours in between. They may not overlap in time but must be taught on the same days.','6h Btw',0,0,1),(71,'NHB(7)','7 Hours Between','0',11,'P43210R','Given classes must have exactly 7 hours in between the end of one and the beginning of another. As with the <i>back-to-back time</i> constraint, given classes must be taught on the same days.<BR>When prohibited or (strongly) discouraged: classes can not have 7 hours in between. They may not overlap in time but must be taught on the same days.','7h Btw',0,0,1),(72,'NHB(8)','8 Hours Between','0',12,'P43210R','Given classes must have exactly 8 hours in between the end of one and the beginning of another. As with the <i>back-to-back time</i> constraint, given classes must be taught on the same days.<BR>When prohibited or (strongly) discouraged: classes can not have 8 hours in between. They may not overlap in time but must be taught on the same days.','8h Btw',0,0,1),(73,'DIFF_TIME','Different Time','0',13,'P43210R','Given classes cannot overlap in time. They may be taught at the same time of day if they are on different days. For instance, MF 7:30 is compatible with TTh 7:30.<BR>When prohibited or (strongly) discouraged: every pair of classes in the constraint must overlap in time.','Diff Time',0,0,1),(74,'NHB(1.5)','90 Minutes Between','0',14,'P43210R','Given classes must have exactly 90 minutes in between the end of one and the beginning of another. As with the <i>back-to-back time</i> constraint, given classes must be taught on the same days.<BR>When prohibited or (strongly) discouraged: classes can not have 90 minutes in between. They may not overlap in time but must be taught on the same days.','90min Btw',0,0,1),(75,'NHB(4.5)','4.5 Hours Between','0',15,'P43210R','Given classes must have exactly 4.5 hours in between the end of one and the beginning of another. As with the <i>back-to-back time</i> constraint, given classes must be taught on the same days.<BR>When prohibited or (strongly) discouraged: classes can not have 4.5 hours in between. They may not overlap in time but must be taught on the same days.','4.5h Btw',0,0,1),(101,'SAME_ROOM','Same Room','0',17,'P43210R','Given classes must be taught in the same room.<BR>When prohibited or (strongly) discouraged: any pair of classes in the constraint cannot be taught in the same room.','Same Room',1,0,1),(102,'NHB_GTE(1)','At Least 1 Hour Between','0',18,'P43210R','Given classes have to have 1 hour or more in between.<BR>When prohibited or (strongly) discouraged: given classes have to have less than 1 hour in between.','>=1h Btw',1,0,1),(103,'SAME_START','Same Start Time','0',16,'P43210R','Given classes must start during the same half-hour period of a day (independent of the actual day the classes meet). For instance, MW 7:30 is compatible with TTh 7:30 but not with MWF 8:00.<BR>When prohibited or (strongly) discouraged: any pair of classes in the given constraint cannot start during the same half-hour period of any day of the week.','Same Start',0,0,1),(104,'NHB_LT(6)','Less Than 6 Hours Between','0',19,'P43210R','Given classes must have less than 6 hours from end of first class to the beginning of the next.  Given classes must also be taught on the same days.<BR>When prohibited or (strongly) discouraged: given classes must have 6 or more hours between. This constraint does not carry over from classes taught at the end of one day to the beginning of the next.','<6h Btw',1,0,1),(161,'SAME_STUDENTS','Same Students','0',20,'210R','Given classes are treated as they are attended by the same students, i.e., they cannot overlap in time and if they are back-to-back the assigned rooms cannot be too far (student limit is used).','Same Students',0,0,1),(162,'SAME_INSTR','Same Instructor','0',21,'210R','Given classes are treated as they are taught by the same instructor, i.e., they cannot overlap in time and if they are back-to-back the assigned rooms cannot be too far (instructor limit is used).<BR>If the constraint is required and the classes are back-to-back, discouraged and strongly discouraged distances between assigned rooms are also considered.','Same Instr',0,0,1),(163,'CAN_SHARE_ROOM','Can Share Room','0',22,'2R','Given classes can share the room (use the room in the same time) if the room is big enough.','Share Room',0,0,1),(164,'SPREAD','Spread In Time','0',23,'2R','Given classes have to be spread in time (overlapping of the classes in time needs to be minimized).','Time Spread',0,0,1),(165,'PRECEDENCE','Precedence','1',24,'P43210R','Given classes have to be taught in the given order (the first meeting of the first class has to end before the first meeting of the second class etc.)<BR>When prohibited or (strongly) discouraged: classes have to be taught in the order reverse to the given one','Precede',0,0,1),(185,'MIN_ROOM_USE','Minimize Number Of Rooms Used','0',25,'P43210R','Minimize number of rooms used by the given set of classes.','Min Rooms',1,0,1),(205,'BTB_DAY','Back-To-Back Day','0',26,'P43210R','Classes must be offered on adjacent days and may be placed in different rooms.<BR>When prohibited or (strongly) discouraged: classes can not be taught on adjacent days. They also can not be taught on the same days. This means that there must be at least one day between these classes.','BTB Day',0,0,1),(206,'MIN_GRUSE(10x1h)','Minimize Use Of 1h Groups','0',27,'P43210R','Minimize number of groups of time that are used by the given classes. The time is spread into the following 10 groups of one hour: 7:30a-8:30a, 8:30a-9:30a, 9:30a-10:30a, ... 4:30p-5:30p.','Min 1h Groups',0,0,1),(207,'MIN_GRUSE(5x2h)','Minimize Use Of 2h Groups','0',28,'P43210R','Minimize number of groups of time that are used by the given classes. The time is spread into the following 5 groups of two hours: 7:30a-9:30a, 9:30a-11:30a, 11:30a-1:30p, 1:30p-3:30p, 3:30p-5:30p.','Min 2h Groups',0,0,1),(208,'MIN_GRUSE(3x3h)','Minimize Use Of 3h Groups','0',29,'P43210R','Minimize number of groups of time that are used by the given classes. The time is spread into the following 3 groups: 7:30a-10:30a, 10:30a-2:30p, 2:30p-5:30p.','Min 3h Groups',0,0,1),(209,'MIN_GRUSE(2x5h)','Minimize Use Of 5h Groups','0',30,'P43210R','Minimize number of groups of time that are used by the given classes. The time is spread into the following 2 groups: 7:30a-12:30a, 12:30a-5:30p.','Min 5h Groups',0,0,1),(305,'NDB_GT_1','More Than 1 Day Between','0',32,'P43210R','Given classes must have two or more days in between.<br>When prohibited or (strongly) discouraged: given classes must be offered on adjacent days or with at most one day in between.','>1d Btw',0,0,1),(345,'CH_NOTOVERLAP','Children Cannot Overlap','0',33,'210R','If parent classes do not overlap in time, children classes can not overlap in time as well.<br>Note: This constraint only needs to be put on the parent classes. Preferred configurations are Required All Classes or Pairwise (Strongly) Preferred.','Ch No Ovlap',0,0,1),(365,'FOLLOWING_DAY','Next Day','1',34,'P43210R','The second class has to be placed on the following day of the first class (if the first class is on Friday, second class have to be on Monday).<br> When prohibited or (strongly) discouraged: The second class has to be placed on the previous day of the first class (if the first class is on Monday, second class have to be on Friday).<br> Note: This constraint works only between pairs of classes.','Next Day',0,0,1),(366,'EVERY_OTHER_DAY','Two Days After','1',35,'P43210R','The second class has to be placed two days after the first class (Monday &rarr; Wednesday, Tuesday &rarr; Thurday, Wednesday &rarr; Friday, Thursday &rarr; Monday, Friday &rarr; Tuesday).<br> When prohibited or (strongly) discouraged: The second class has to be placed two days before the first class (Monday &rarr; Thursday, Tuesday &rarr; Friday, Wednesday &rarr; Monday, Thursday &rarr; Tuesday, Friday &rarr; Wednesday).<br> Note: This constraint works only between pairs of classes.','2d After',0,0,1),(367,'MEET_WITH','Meet Together','0',31,'2R','Given classes are meeting together (same as if the given classes require constraints Can Share Room, Same Room, Same Time and Same Days all together).','Meet Together',0,0,1),(405,'EX_SAME_PER','Same Period','0',36,'P43210R','Exams are to be placed at the same period. <BR>When prohibited or (strongly) discouraged: exams are to be placed at different periods.','Same Per',0,1,1),(406,'EX_SAME_ROOM','Same Room','0',37,'P43210R','Exams are to be placed at the same room(s). <BR>When prohibited or (strongly) discouraged: exams are to be placed at different rooms.','Same Room',0,1,1),(407,'EX_PRECEDENCE','Precedence','1',38,'P43210R','Exams are to be placed in the given order. <BR>When prohibited or (strongly) discouraged: exams are to be placed in the order reverse to the given one.','Precede',0,1,1),(1179612,'MAX_HRS_DAY(6)','At Most 6 Hours A Day','0',39,'210R','Classes are to be placed in a way that there is no more than six hours in any day.','At Most 6 Hrs',1,0,1),(1179613,'MAX_HRS_DAY(7)','At Most 7 Hours A Day','0',40,'210R','Classes are to be placed in a way that there is no more than seven hours in any day.','At Most 7 Hrs',1,0,1),(1179614,'MAX_HRS_DAY(8)','At Most 8 Hours A Day','0',41,'210R','Classes are to be placed in a way that there is no more than eight hours in any day.','At Most 8 Hrs',1,0,1),(1277913,'LINKED_SECTIONS','Linked Classes','0',42,'R','Classes (of different courses) are to be attended by the same students. For instance, if class A1 (of a course A) and class B1 (of a course B) are linked, a student requesting both courses must attend A1 if and only if he also attends B1. This is a student sectioning constraint that is interpreted as Same Students constraint during course timetabling.','Linked',0,0,1),(1376214,'MAX_HRS_DAY(5)','At Most 5 Hours A Day','0',43,'210R','Classes are to be placed in a way that there is no more than five hours in any day.','At Most 5 Hrs',1,0,1),(1376215,'BTB_PRECEDENCE','Back-To-Back Precedence','0',44,'P43210R','Given classes have to be taught in the given order, on the same days, and in adjacent time segments.<br>When prohibited or (strongly) discouraged: Given classes have to be taught in the given order, on the same days, but cannot be back-to-back.','BTB Precede',0,0,1),(1376216,'SAME_D_T','Same Days-Time','0',45,'P43210R','Given classes must be taught at the same time of day and on the same days.<br>This constraint combines Same Days and Same Time distribution preferences.<br>When prohibited or (strongly) discouraged: Any pair of classes classes cannot be taught on the same days during the same time.','Same Days-Time',0,0,1),(1376217,'SAME_D_R_T','Same Days-Room-Time','0',46,'P43210R','Given classes must be taught at the same time of day, on the same days and in the same room.<br>Note that this constraint is the same as Meet Together constraint, except it does not allow for room sharing. In other words, it is only useful when these classes are taught during non-overlapping date patterns.<br>When prohibited or (strongly) discouraged: Any pair of classes classes cannot be taught on the same days during the same time in the same room.','Same Days-Room-Time',0,0,1),(1376218,'SAME_WEEKS','Same Weeks','0',47,'P43210R','Given classes must be taught during the same weeks (i.e., must have the same date pattern).<br>When prohibited or (strongly) discouraged: any two classes must have non overlapping date patterns.','Same Weeks',0,0,1),(1474515,'EX_SHARE_ROOM','Can Share Room','0',48,'2R','Given examinations can share a room (use the same room during the same period) if the room is big enough.  If examinations of different seating type are sharing a room, the more restrictive seating type is used to check the room size.','Share Room',0,1,1),(1572816,'NO_CONFLICT','Ignore Student Conflicts','0',49,'2R','All student conflicts between the given classes are to be ignored.','No Conflicts',0,0,1);
/*!40000 ALTER TABLE `distribution_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `duration_type`
--

DROP TABLE IF EXISTS `duration_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `duration_type` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) NOT NULL,
  `abbreviation` varchar(20) NOT NULL,
  `label` varchar(60) NOT NULL,
  `implementation` varchar(255) NOT NULL,
  `parameter` varchar(200) DEFAULT NULL,
  `visible` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duration_type`
--

LOCK TABLES `duration_type` WRITE;
/*!40000 ALTER TABLE `duration_type` DISABLE KEYS */;
INSERT INTO `duration_type` VALUES (1703884,'MIN_PER_WEEK','Mins','Minutes per Week','org.unitime.timetable.util.duration.MinutesPerWeek',NULL,1),(1703885,'WEEKLY_MIN','Wk Mins','Average Weekly Minutes','org.unitime.timetable.util.duration.WeeklyMinutes',NULL,1),(1703886,'SEMESTER_MIN','Sem Mins','Semester Minutes','org.unitime.timetable.util.duration.SemesterMinutes',NULL,1),(1703887,'SEMESTER_HRS','Sem Hrs','Semester Hours','org.unitime.timetable.util.duration.SemesterHours','50',1),(1703888,'MEETING_MIN','Mtg Mins','Meeting Minutes','org.unitime.timetable.util.duration.MeetingMinutes','0.95,1.10',1),(1703889,'MEETING_HRS','Mtg Hrs','Meeting Hours','org.unitime.timetable.util.duration.MeetingHours','50,0.95,1.10',1);
/*!40000 ALTER TABLE `duration_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `uniqueid` decimal(20,0) NOT NULL,
  `event_name` varchar(100) DEFAULT NULL,
  `min_capacity` bigint(10) DEFAULT NULL,
  `max_capacity` bigint(10) DEFAULT NULL,
  `sponsoring_org` decimal(20,0) DEFAULT NULL,
  `main_contact_id` decimal(20,0) DEFAULT NULL,
  `class_id` decimal(20,0) DEFAULT NULL,
  `exam_id` decimal(20,0) DEFAULT NULL,
  `event_type` bigint(10) DEFAULT NULL,
  `req_attd` int(1) DEFAULT NULL,
  `email` varchar(1000) DEFAULT NULL,
  `sponsor_org_id` decimal(20,0) DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_event_class` (`class_id`),
  KEY `idx_event_exam` (`exam_id`),
  KEY `fk_event_main_contact` (`main_contact_id`),
  KEY `fk_event_sponsor_org` (`sponsor_org_id`),
  CONSTRAINT `fk_event_class` FOREIGN KEY (`class_id`) REFERENCES `class_` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_event_exam` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_event_main_contact` FOREIGN KEY (`main_contact_id`) REFERENCES `event_contact` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_event_sponsor_org` FOREIGN KEY (`sponsor_org_id`) REFERENCES `sponsoring_organization` (`uniqueid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_contact`
--

DROP TABLE IF EXISTS `event_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_contact` (
  `uniqueid` decimal(20,0) NOT NULL,
  `external_id` varchar(40) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `middlename` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `acad_title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_contact`
--

LOCK TABLES `event_contact` WRITE;
/*!40000 ALTER TABLE `event_contact` DISABLE KEYS */;
INSERT INTO `event_contact` VALUES (2129920,'1','demo@unitime.org',NULL,'Deafult',NULL,'Admin',NULL);
/*!40000 ALTER TABLE `event_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_join_event_contact`
--

DROP TABLE IF EXISTS `event_join_event_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_join_event_contact` (
  `event_id` decimal(20,0) NOT NULL,
  `event_contact_id` decimal(20,0) NOT NULL,
  KEY `fk_event_contact_join` (`event_contact_id`),
  KEY `fk_event_id_join` (`event_id`),
  CONSTRAINT `fk_event_contact_join` FOREIGN KEY (`event_contact_id`) REFERENCES `event_contact` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_event_id_join` FOREIGN KEY (`event_id`) REFERENCES `event` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_join_event_contact`
--

LOCK TABLES `event_join_event_contact` WRITE;
/*!40000 ALTER TABLE `event_join_event_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_join_event_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_note`
--

DROP TABLE IF EXISTS `event_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_note` (
  `uniqueid` decimal(20,0) NOT NULL,
  `event_id` decimal(20,0) NOT NULL,
  `text_note` varchar(2000) DEFAULT NULL,
  `time_stamp` datetime DEFAULT NULL,
  `note_type` bigint(10) NOT NULL DEFAULT '0',
  `uname` varchar(100) DEFAULT NULL,
  `meetings` longtext,
  `attached_file` longblob,
  `attached_name` varchar(260) DEFAULT NULL,
  `attached_content` varchar(260) DEFAULT NULL,
  `user_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_event_note_event` (`event_id`),
  CONSTRAINT `fk_event_note_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_note`
--

LOCK TABLES `event_note` WRITE;
/*!40000 ALTER TABLE `event_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_note_meeting`
--

DROP TABLE IF EXISTS `event_note_meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_note_meeting` (
  `note_id` decimal(20,0) NOT NULL,
  `meeting_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`note_id`,`meeting_id`),
  KEY `fk_event_note_mtg` (`meeting_id`),
  CONSTRAINT `fk_event_note_mtg` FOREIGN KEY (`meeting_id`) REFERENCES `meeting` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_event_note_note` FOREIGN KEY (`note_id`) REFERENCES `event_note` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_note_meeting`
--

LOCK TABLES `event_note_meeting` WRITE;
/*!40000 ALTER TABLE `event_note_meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_note_meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_service_provider`
--

DROP TABLE IF EXISTS `event_service_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_service_provider` (
  `event_id` decimal(20,0) NOT NULL,
  `provider_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`event_id`,`provider_id`),
  KEY `fk_evt_service_provider` (`provider_id`),
  CONSTRAINT `fk_evt_service_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_evt_service_provider` FOREIGN KEY (`provider_id`) REFERENCES `service_provider` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_service_provider`
--

LOCK TABLES `event_service_provider` WRITE;
/*!40000 ALTER TABLE `event_service_provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_service_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exact_time_mins`
--

DROP TABLE IF EXISTS `exact_time_mins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exact_time_mins` (
  `uniqueid` decimal(20,0) NOT NULL,
  `mins_min` int(4) DEFAULT NULL,
  `mins_max` int(4) DEFAULT NULL,
  `nr_slots` int(4) DEFAULT NULL,
  `break_time` int(4) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_exact_time_mins` (`mins_min`,`mins_max`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exact_time_mins`
--

LOCK TABLES `exact_time_mins` WRITE;
/*!40000 ALTER TABLE `exact_time_mins` DISABLE KEYS */;
INSERT INTO `exact_time_mins` VALUES (214405,0,0,0,0),(214406,1,5,1,0),(214407,6,10,2,0),(214408,11,15,4,0),(214409,16,20,5,0),(214410,21,25,6,0),(214411,26,30,7,0),(214412,31,35,8,15),(214413,36,40,10,15),(214414,41,45,11,15),(214415,46,50,12,10),(214416,51,55,13,15),(214417,56,60,14,10),(214418,61,65,16,15),(214419,66,70,17,15),(214420,71,75,18,15),(214421,76,80,19,15),(214422,81,85,20,15),(214423,86,90,21,15),(214424,91,95,23,15),(214425,96,100,24,10),(214426,101,105,25,15),(214427,106,110,26,15),(214428,111,115,28,15),(214429,116,120,29,15),(214430,121,125,30,15),(214431,126,130,31,15),(214432,131,135,32,15),(214433,136,140,34,15),(214434,141,145,35,15),(214435,146,150,36,10),(214436,151,155,37,15),(214437,156,160,38,15),(214438,161,165,40,15),(214439,166,170,41,15),(214440,171,175,42,15),(214441,176,180,43,15),(214442,181,185,44,15),(214443,186,190,46,15),(214444,191,195,47,15),(214445,196,200,48,10),(214446,201,205,49,15),(214447,206,210,50,15),(214448,211,215,52,15),(214449,216,220,53,15),(214450,221,225,54,15),(214451,226,230,55,15),(214452,231,235,56,15),(214453,236,240,58,15),(214454,241,245,59,15),(214455,246,250,60,10),(214456,251,255,61,15),(214457,256,260,62,15),(214458,261,265,64,15),(214459,266,270,65,15),(214460,271,275,66,15),(214461,276,280,67,15),(214462,281,285,68,15),(214463,286,290,70,15),(214464,291,295,71,15),(214465,296,300,72,10),(214466,301,305,73,15),(214467,306,310,74,15),(214468,311,315,76,15),(214469,316,320,77,15),(214470,321,325,78,15),(214471,326,330,79,15),(214472,331,335,80,15),(214473,336,340,82,15),(214474,341,345,83,15),(214475,346,350,84,10),(214476,351,355,85,15),(214477,356,360,86,15),(214478,361,365,88,15),(214479,366,370,89,15),(214480,371,375,90,15),(214481,376,380,91,5),(214482,381,385,92,15),(214483,386,390,94,15),(214484,391,395,95,15),(214485,396,400,96,10),(214486,401,405,97,15),(214487,406,410,98,15),(214488,411,415,100,15),(214489,416,420,101,15),(214490,421,425,102,15),(214491,426,430,103,15),(214492,431,435,104,15),(214493,436,440,106,15),(214494,441,445,107,15),(214495,446,450,108,10),(214496,451,455,109,15),(214497,456,460,110,15),(214498,461,465,112,15),(214499,466,470,113,15),(214500,471,475,114,15),(214501,476,480,115,15),(214502,481,485,116,15),(214503,486,490,118,15),(214504,491,495,119,15),(214505,496,500,120,10),(214506,501,505,121,15),(214507,506,510,122,15),(214508,511,515,124,15),(214509,516,520,125,15),(214510,521,525,126,15),(214511,526,530,127,15),(214512,531,535,128,15),(214513,536,540,130,15),(214514,541,545,131,15),(214515,546,550,132,10),(214516,551,555,133,15),(214517,556,560,134,15),(214518,561,565,136,15),(214519,566,570,137,15),(214520,571,575,138,15),(214521,576,580,139,15),(214522,581,585,140,15),(214523,586,590,142,15),(214524,591,595,143,15),(214525,596,600,144,10),(214526,601,605,145,15),(214527,606,610,146,15),(214528,611,615,148,15),(214529,616,620,149,15),(214530,621,625,150,15),(214531,626,630,151,15),(214532,631,635,152,15),(214533,636,640,154,15),(214534,641,645,155,15),(214535,646,650,156,10),(214536,651,655,157,15),(214537,656,660,158,15),(214538,661,665,160,15),(214539,666,670,161,15),(214540,671,675,162,15),(214541,676,680,163,15),(214542,681,685,164,15),(214543,686,690,166,15),(214544,691,695,167,15),(214545,696,700,168,10),(214546,701,705,169,15),(214547,706,710,170,15),(214548,711,715,172,15),(214549,716,720,173,15);
/*!40000 ALTER TABLE `exact_time_mins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam`
--

DROP TABLE IF EXISTS `exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `length` bigint(10) NOT NULL,
  `max_nbr_rooms` bigint(10) NOT NULL DEFAULT '1',
  `seating_type` bigint(10) NOT NULL,
  `assigned_period` decimal(20,0) DEFAULT NULL,
  `assigned_pref` varchar(100) DEFAULT NULL,
  `avg_period` bigint(10) DEFAULT NULL,
  `uid_rolled_fwd_from` decimal(20,0) DEFAULT NULL,
  `exam_size` bigint(10) DEFAULT NULL,
  `print_offset` bigint(10) DEFAULT NULL,
  `exam_type_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_exam_period` (`assigned_period`),
  KEY `fk_exam_session` (`session_id`),
  KEY `fk_exam_type` (`exam_type_id`),
  CONSTRAINT `fk_exam_period` FOREIGN KEY (`assigned_period`) REFERENCES `exam_period` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_exam_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_exam_type` FOREIGN KEY (`exam_type_id`) REFERENCES `exam_type` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam`
--

LOCK TABLES `exam` WRITE;
/*!40000 ALTER TABLE `exam` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_instructor`
--

DROP TABLE IF EXISTS `exam_instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_instructor` (
  `exam_id` decimal(20,0) NOT NULL,
  `instructor_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`exam_id`,`instructor_id`),
  KEY `fk_exam_instructor_instructor` (`instructor_id`),
  CONSTRAINT `fk_exam_instructor_exam` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_exam_instructor_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `departmental_instructor` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_instructor`
--

LOCK TABLES `exam_instructor` WRITE;
/*!40000 ALTER TABLE `exam_instructor` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_location_pref`
--

DROP TABLE IF EXISTS `exam_location_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_location_pref` (
  `uniqueid` decimal(20,0) NOT NULL,
  `location_id` decimal(20,0) NOT NULL,
  `pref_level_id` decimal(20,0) NOT NULL,
  `period_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_exam_location_pref` (`location_id`),
  KEY `fk_exam_location_pref_period` (`period_id`),
  KEY `fk_exam_location_pref_pref` (`pref_level_id`),
  CONSTRAINT `fk_exam_location_pref_period` FOREIGN KEY (`period_id`) REFERENCES `exam_period` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_exam_location_pref_pref` FOREIGN KEY (`pref_level_id`) REFERENCES `preference_level` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_location_pref`
--

LOCK TABLES `exam_location_pref` WRITE;
/*!40000 ALTER TABLE `exam_location_pref` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_location_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_managers`
--

DROP TABLE IF EXISTS `exam_managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_managers` (
  `session_id` decimal(20,0) NOT NULL,
  `type_id` decimal(20,0) NOT NULL,
  `manager_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`session_id`,`type_id`,`manager_id`),
  KEY `fk_xmanagers_manager` (`manager_id`),
  CONSTRAINT `fk_xmanagers_manager` FOREIGN KEY (`manager_id`) REFERENCES `timetable_manager` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_xmanagers_status` FOREIGN KEY (`session_id`, `type_id`) REFERENCES `exam_status` (`session_id`, `type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_managers`
--

LOCK TABLES `exam_managers` WRITE;
/*!40000 ALTER TABLE `exam_managers` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_owner`
--

DROP TABLE IF EXISTS `exam_owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_owner` (
  `uniqueid` decimal(20,0) NOT NULL,
  `exam_id` decimal(20,0) NOT NULL,
  `owner_id` decimal(20,0) NOT NULL,
  `owner_type` bigint(10) NOT NULL,
  `course_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_exam_owner_course` (`course_id`),
  KEY `idx_exam_owner_exam` (`exam_id`),
  KEY `idx_exam_owner_owner` (`owner_id`,`owner_type`),
  CONSTRAINT `fk_exam_owner_course` FOREIGN KEY (`course_id`) REFERENCES `course_offering` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_exam_owner_exam` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_owner`
--

LOCK TABLES `exam_owner` WRITE;
/*!40000 ALTER TABLE `exam_owner` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_period`
--

DROP TABLE IF EXISTS `exam_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_period` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) NOT NULL,
  `date_ofs` bigint(10) NOT NULL,
  `start_slot` bigint(10) NOT NULL,
  `length` bigint(10) NOT NULL,
  `pref_level_id` decimal(20,0) NOT NULL,
  `event_start_offset` bigint(10) NOT NULL DEFAULT '0',
  `event_stop_offset` bigint(10) NOT NULL DEFAULT '0',
  `exam_type_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_exam_period_pref` (`pref_level_id`),
  KEY `fk_exam_period_session` (`session_id`),
  KEY `fk_exam_period_type` (`exam_type_id`),
  CONSTRAINT `fk_exam_period_pref` FOREIGN KEY (`pref_level_id`) REFERENCES `preference_level` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_exam_period_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_exam_period_type` FOREIGN KEY (`exam_type_id`) REFERENCES `exam_type` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_period`
--

LOCK TABLES `exam_period` WRITE;
/*!40000 ALTER TABLE `exam_period` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_period` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_period_pref`
--

DROP TABLE IF EXISTS `exam_period_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_period_pref` (
  `uniqueid` decimal(20,0) NOT NULL,
  `owner_id` decimal(20,0) NOT NULL,
  `pref_level_id` decimal(20,0) NOT NULL,
  `period_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_exam_period_pref_period` (`period_id`),
  KEY `fk_exam_period_pref_pref` (`pref_level_id`),
  CONSTRAINT `fk_exam_period_pref_period` FOREIGN KEY (`period_id`) REFERENCES `exam_period` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_exam_period_pref_pref` FOREIGN KEY (`pref_level_id`) REFERENCES `preference_level` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_period_pref`
--

LOCK TABLES `exam_period_pref` WRITE;
/*!40000 ALTER TABLE `exam_period_pref` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_period_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_room_assignment`
--

DROP TABLE IF EXISTS `exam_room_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_room_assignment` (
  `exam_id` decimal(20,0) NOT NULL,
  `location_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`exam_id`,`location_id`),
  CONSTRAINT `fk_exam_room_exam` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_room_assignment`
--

LOCK TABLES `exam_room_assignment` WRITE;
/*!40000 ALTER TABLE `exam_room_assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_room_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_status`
--

DROP TABLE IF EXISTS `exam_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_status` (
  `session_id` decimal(20,0) NOT NULL,
  `type_id` decimal(20,0) NOT NULL,
  `status_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`session_id`,`type_id`),
  KEY `fk_xstatus_type` (`type_id`),
  KEY `fk_xstatus_status` (`status_id`),
  CONSTRAINT `fk_xstatus_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_xstatus_status` FOREIGN KEY (`status_id`) REFERENCES `dept_status_type` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_xstatus_type` FOREIGN KEY (`type_id`) REFERENCES `exam_type` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_status`
--

LOCK TABLES `exam_status` WRITE;
/*!40000 ALTER TABLE `exam_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_type`
--

DROP TABLE IF EXISTS `exam_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_type` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) NOT NULL,
  `label` varchar(60) NOT NULL,
  `xtype` bigint(10) NOT NULL,
  `events` int(1) DEFAULT '1',
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_type`
--

LOCK TABLES `exam_type` WRITE;
/*!40000 ALTER TABLE `exam_type` DISABLE KEYS */;
INSERT INTO `exam_type` VALUES (1540049,'final','Final',0,1),(1540050,'midterm','Midterm',1,0);
/*!40000 ALTER TABLE `exam_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_dept_status`
--

DROP TABLE IF EXISTS `ext_dept_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ext_dept_status` (
  `ext_dept_id` decimal(20,0) NOT NULL,
  `department_id` decimal(20,0) NOT NULL,
  `status_type` decimal(20,0) NOT NULL,
  PRIMARY KEY (`ext_dept_id`,`department_id`),
  KEY `fk_dept_status_dep` (`department_id`),
  KEY `fk_dept_status_type` (`status_type`),
  CONSTRAINT `fk_dept_status_dep` FOREIGN KEY (`department_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_dept_status_ext` FOREIGN KEY (`ext_dept_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_dept_status_type` FOREIGN KEY (`status_type`) REFERENCES `dept_status_type` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_dept_status`
--

LOCK TABLES `ext_dept_status` WRITE;
/*!40000 ALTER TABLE `ext_dept_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_dept_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_building`
--

DROP TABLE IF EXISTS `external_building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_building` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `abbreviation` varchar(20) DEFAULT NULL,
  `coordinate_x` double DEFAULT NULL,
  `coordinate_y` double DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_external_building` (`session_id`,`abbreviation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_building`
--

LOCK TABLES `external_building` WRITE;
/*!40000 ALTER TABLE `external_building` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_room`
--

DROP TABLE IF EXISTS `external_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_room` (
  `uniqueid` decimal(20,0) NOT NULL,
  `external_bldg_id` decimal(20,0) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `room_number` varchar(40) DEFAULT NULL,
  `coordinate_x` double DEFAULT NULL,
  `coordinate_y` double DEFAULT NULL,
  `capacity` bigint(10) DEFAULT NULL,
  `classification` varchar(20) DEFAULT NULL,
  `instructional` int(1) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `exam_capacity` bigint(10) DEFAULT NULL,
  `room_type` decimal(20,0) DEFAULT NULL,
  `area` double DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_external_room` (`external_bldg_id`,`room_number`),
  KEY `fk_external_room_type` (`room_type`),
  CONSTRAINT `fk_ext_room_building` FOREIGN KEY (`external_bldg_id`) REFERENCES `external_building` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_external_room_type` FOREIGN KEY (`room_type`) REFERENCES `room_type` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_room`
--

LOCK TABLES `external_room` WRITE;
/*!40000 ALTER TABLE `external_room` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_room_department`
--

DROP TABLE IF EXISTS `external_room_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_room_department` (
  `uniqueid` decimal(20,0) NOT NULL,
  `external_room_id` decimal(20,0) DEFAULT NULL,
  `department_code` varchar(50) DEFAULT NULL,
  `percent` bigint(10) DEFAULT NULL,
  `assignment_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_ext_dept_room` (`external_room_id`),
  CONSTRAINT `fk_ext_dept_room` FOREIGN KEY (`external_room_id`) REFERENCES `external_room` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_room_department`
--

LOCK TABLES `external_room_department` WRITE;
/*!40000 ALTER TABLE `external_room_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_room_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_room_feature`
--

DROP TABLE IF EXISTS `external_room_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `external_room_feature` (
  `uniqueid` decimal(20,0) NOT NULL,
  `external_room_id` decimal(20,0) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `value` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_ext_ftr_room` (`external_room_id`),
  CONSTRAINT `fk_ext_ftr_room` FOREIGN KEY (`external_room_id`) REFERENCES `external_room` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_room_feature`
--

LOCK TABLES `external_room_feature` WRITE;
/*!40000 ALTER TABLE `external_room_feature` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_room_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature_type`
--

DROP TABLE IF EXISTS `feature_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feature_type` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) NOT NULL,
  `label` varchar(60) NOT NULL,
  `events` int(1) NOT NULL,
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature_type`
--

LOCK TABLES `feature_type` WRITE;
/*!40000 ALTER TABLE `feature_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `feature_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `free_time`
--

DROP TABLE IF EXISTS `free_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `free_time` (
  `uniqueid` decimal(20,0) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `day_code` bigint(10) DEFAULT NULL,
  `start_slot` bigint(10) DEFAULT NULL,
  `length` bigint(10) DEFAULT NULL,
  `category` bigint(10) DEFAULT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_free_time_session` (`session_id`),
  CONSTRAINT `fk_free_time_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `free_time`
--

LOCK TABLES `free_time` WRITE;
/*!40000 ALTER TABLE `free_time` DISABLE KEYS */;
/*!40000 ALTER TABLE `free_time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hashed_queries`
--

DROP TABLE IF EXISTS `hashed_queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hashed_queries` (
  `query_hash` varchar(48) NOT NULL,
  `query_text` varchar(2048) NOT NULL,
  `ts_create` datetime NOT NULL,
  `nbr_use` decimal(20,0) NOT NULL DEFAULT '0',
  `ts_use` datetime NOT NULL,
  PRIMARY KEY (`query_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hashed_queries`
--

LOCK TABLES `hashed_queries` WRITE;
/*!40000 ALTER TABLE `hashed_queries` DISABLE KEYS */;
/*!40000 ALTER TABLE `hashed_queries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hibernate_unique_key`
--

DROP TABLE IF EXISTS `hibernate_unique_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hibernate_unique_key` (
  `next_hi` decimal(20,0) DEFAULT '32'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hibernate_unique_key`
--

LOCK TABLES `hibernate_unique_key` WRITE;
/*!40000 ALTER TABLE `hibernate_unique_key` DISABLE KEYS */;
INSERT INTO `hibernate_unique_key` VALUES (70);
/*!40000 ALTER TABLE `hibernate_unique_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `uniqueid` decimal(20,0) NOT NULL,
  `subclass` varchar(10) DEFAULT NULL,
  `old_value` varchar(20) DEFAULT NULL,
  `new_value` varchar(20) DEFAULT NULL,
  `old_number` varchar(20) DEFAULT NULL,
  `new_number` varchar(20) DEFAULT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_history_session` (`session_id`),
  CONSTRAINT `fk_history_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hql_parameter`
--

DROP TABLE IF EXISTS `hql_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hql_parameter` (
  `hql_id` decimal(20,0) NOT NULL,
  `name` varchar(128) NOT NULL,
  `label` varchar(256) DEFAULT NULL,
  `type` varchar(2048) NOT NULL,
  `default_value` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`hql_id`,`name`),
  CONSTRAINT `fk_hql_parameter` FOREIGN KEY (`hql_id`) REFERENCES `saved_hql` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hql_parameter`
--

LOCK TABLES `hql_parameter` WRITE;
/*!40000 ALTER TABLE `hql_parameter` DISABLE KEYS */;
/*!40000 ALTER TABLE `hql_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instr_offering_config`
--

DROP TABLE IF EXISTS `instr_offering_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instr_offering_config` (
  `uniqueid` decimal(20,0) NOT NULL,
  `config_limit` bigint(10) DEFAULT NULL,
  `instr_offr_id` decimal(20,0) DEFAULT NULL,
  `unlimited_enrollment` int(1) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `uid_rolled_fwd_from` decimal(20,0) DEFAULT NULL,
  `duration_type_id` decimal(20,0) DEFAULT NULL,
  `instr_method_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_instr_offr_cfg_name` (`uniqueid`,`name`),
  KEY `idx_instr_offr_cfg_instr_offr` (`instr_offr_id`),
  KEY `fk_ioconfig_durtype` (`duration_type_id`),
  KEY `fk_ioconfig_instr_method` (`instr_method_id`),
  CONSTRAINT `fk_instr_offr_cfg_instr_offr` FOREIGN KEY (`instr_offr_id`) REFERENCES `instructional_offering` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_ioconfig_durtype` FOREIGN KEY (`duration_type_id`) REFERENCES `duration_type` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_ioconfig_instr_method` FOREIGN KEY (`instr_method_id`) REFERENCES `instructional_method` (`uniqueid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instr_offering_config`
--

LOCK TABLES `instr_offering_config` WRITE;
/*!40000 ALTER TABLE `instr_offering_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `instr_offering_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructional_method`
--

DROP TABLE IF EXISTS `instructional_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructional_method` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) NOT NULL,
  `label` varchar(60) NOT NULL,
  `visible` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructional_method`
--

LOCK TABLES `instructional_method` WRITE;
/*!40000 ALTER TABLE `instructional_method` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructional_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructional_offering`
--

DROP TABLE IF EXISTS `instructional_offering`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructional_offering` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `instr_offering_perm_id` bigint(10) DEFAULT NULL,
  `not_offered` int(1) DEFAULT NULL,
  `limit` int(4) DEFAULT NULL,
  `designator_required` int(1) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `uid_rolled_fwd_from` decimal(20,0) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `req_reservation` int(1) NOT NULL DEFAULT '0',
  `wk_enroll` bigint(10) DEFAULT NULL,
  `wk_change` bigint(10) DEFAULT NULL,
  `wk_drop` bigint(10) DEFAULT NULL,
  `notes` varchar(2000) DEFAULT NULL,
  `snapshot_limit` bigint(10) DEFAULT NULL,
  `snapshot_limit_date` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructional_offering`
--

LOCK TABLES `instructional_offering` WRITE;
/*!40000 ALTER TABLE `instructional_offering` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructional_offering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor_attributes`
--

DROP TABLE IF EXISTS `instructor_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructor_attributes` (
  `attribute_id` decimal(20,0) NOT NULL,
  `instructor_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`attribute_id`,`instructor_id`),
  KEY `fk_instrattributes_instructor` (`instructor_id`),
  CONSTRAINT `fk_instrattributes_attribute` FOREIGN KEY (`attribute_id`) REFERENCES `attribute` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_instrattributes_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `departmental_instructor` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor_attributes`
--

LOCK TABLES `instructor_attributes` WRITE;
/*!40000 ALTER TABLE `instructor_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructor_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor_pref`
--

DROP TABLE IF EXISTS `instructor_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructor_pref` (
  `uniqueid` decimal(20,0) NOT NULL,
  `owner_id` decimal(20,0) NOT NULL,
  `pref_level_id` decimal(20,0) NOT NULL,
  `instructor_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_instructor_pref_pref` (`pref_level_id`),
  KEY `fk_instructor_pref_instructor` (`instructor_id`),
  CONSTRAINT `fk_instructor_pref_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `departmental_instructor` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_instructor_pref_pref` FOREIGN KEY (`pref_level_id`) REFERENCES `preference_level` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor_pref`
--

LOCK TABLES `instructor_pref` WRITE;
/*!40000 ALTER TABLE `instructor_pref` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructor_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itype_desc`
--

DROP TABLE IF EXISTS `itype_desc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itype_desc` (
  `itype` int(2) NOT NULL,
  `abbv` varchar(7) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `sis_ref` varchar(20) DEFAULT NULL,
  `basic` int(1) DEFAULT NULL,
  `parent` int(2) DEFAULT NULL,
  `organized` int(1) DEFAULT NULL,
  PRIMARY KEY (`itype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itype_desc`
--

LOCK TABLES `itype_desc` WRITE;
/*!40000 ALTER TABLE `itype_desc` DISABLE KEYS */;
INSERT INTO `itype_desc` VALUES (10,'Lec  ','Lecture','lec',1,NULL,1),(11,'Lec 1','Lecture 1','lec',0,10,1),(12,'Lec 2','Lecture 2','lec',0,10,1),(13,'Lec 3','Lecture 3','lec',0,10,1),(14,'Lec 4','Lecture 4','lec',0,10,1),(15,'Lec 5','Lecture 5','lec',0,10,1),(16,'Lec 6','Lecture 6','lec',0,10,1),(17,'Lec 7','Lecture 7','lec',0,10,1),(18,'Lec 8','Lecture 8','lec',0,10,1),(19,'Lec 9','Lecture 9','lec',0,10,1),(20,'Rec  ','Recitation','rec',1,NULL,1),(21,'Rec 1','Recitation 1','rec',0,20,1),(22,'Rec 2','Recitation 2','rec',0,20,1),(23,'Rec 3','Recitation 3','rec',0,20,1),(24,'Rec 4','Recitation 4','rec',0,20,1),(25,'Prsn ','Presentation','prsn',1,NULL,1),(26,'Prsn1','Presentation 1','prsn',0,25,1),(27,'Prsn2','Presentation 2','prsn',0,25,1),(28,'Prsn3','Presentation 3 ','prsn',0,25,1),(29,'Prsn4','Presentation 4','prsn',0,25,1),(30,'Lab  ','Laboratory','lab',1,NULL,1),(31,'Lab 1','Laboratory 1','lab',0,30,1),(32,'Lab 2','Laboratory 2','lab',0,30,1),(33,'Lab 3','Laboratory 3','lab',0,30,1),(34,'Lab 4','Laboratory 4','lab',0,30,1),(35,'LabP ','Laboratory Preparation','labP',1,NULL,1),(36,'LabP1','Laboratory Preparation 1','labP',0,35,1),(37,'LabP2','Laboratory Preparation 2','labP',0,35,1),(38,'LabP3','Laboratory Preparation 3','labP',0,35,1),(39,'LabP4','Laboratory Preparation 4','labP',0,35,1),(40,'Stdo ','Studio','stdo',1,NULL,1),(41,'Stdo1','Studio 1','stdo',0,40,1),(42,'Stdo2','Studio 2','stdo',0,40,1),(43,'Stdo3','Studio 3','stdo',0,40,1),(44,'Stdo4','Studio 4','stdo',0,40,1),(45,'Dist ','Distance Learning','dist',1,NULL,0),(46,'Dist1','Distance Learning 1','dist',0,45,0),(47,'Dist2','Distance Learning 2','dist',0,45,0),(48,'Dist3','Distance Learning 3','dist',0,45,0),(49,'Dist4','Distance Learning 4','dist',0,45,0),(50,'Clin ','Clinic','clin',1,NULL,0),(51,'Clin1','Clinic 1','clin',0,50,0),(52,'Clin2','Clinic 2','clin',0,50,0),(53,'Clin3','Clinic 3','clin',0,50,0),(54,'Clin4','Clinic 4','clin',0,50,0),(55,'Clin5','Clinic 5','clin',0,50,0),(56,'Clin6','Clinic 6','clin',0,50,0),(57,'Clin7','Clinic 7','clin',0,50,0),(58,'Clin8','Clinic 8','clin',0,50,0),(59,'Clin9','Clinic 9','clin',0,50,0),(60,'Expr ','Experiential','expr',1,NULL,0),(61,'Expr1','Experiential 1','expr',0,60,0),(62,'Expr2','Experiential 2','expr',0,60,0),(63,'Expr3','Experiential 3','expr',0,60,0),(64,'Expr4','Experiential 4','expr',0,60,0),(65,'Expr5','Experiential 5','expr',0,60,0),(66,'Expr6','Experiential 6','expr',0,60,0),(67,'Expr7','Experiential 7','expr',0,60,0),(68,'Expr8','Experiential 8','expr',0,60,0),(69,'Expr9','Experiential 9','expr',0,60,0),(70,'Res  ','Research','res',1,NULL,0),(71,'Res 1','Research 1','res',0,70,0),(72,'Res 2','Research 2','res',0,70,0),(73,'Res 3','Research 3','res',0,70,0),(74,'Res 4','Research 4','res',0,70,0),(75,'Res 5','Research 5','res',0,70,0),(76,'Res 6','Research 6','res',0,70,0),(77,'Res 7','Research 7','res',0,70,0),(78,'Res 8','Research 8','res',0,70,0),(79,'Res 9','Research 9','res',0,70,0),(80,'Ind  ','Individual Study','ind',1,NULL,0),(81,'Ind 1','Individual Study 1','ind',0,80,0),(82,'Ind 2','Individual Study 2','ind',0,80,0),(83,'Ind 3','Individual Study 3','ind',0,80,0),(84,'Ind 4','Individual Study 4','ind',0,80,0),(85,'Ind 5','Individual Study 5','ind',0,80,0),(86,'Ind 6','Individual Study 6','ind',0,80,0),(87,'Ind 7','Individual Study 7','ind',0,80,0),(88,'Ind 8','Individual Study 8','ind',0,80,0),(89,'Ind 9','Individual Study 9','ind',0,80,0),(90,'Pso  ','Practice Study Observation','pso',1,NULL,0),(91,'Pso 1','Practice Study Observation 1','pso',0,90,0),(92,'Pso 2','Practice Study Observation 2','pso',0,90,0),(93,'Pso 3','Practice Study Observation 3','pso',0,90,0),(94,'Pso 4','Practice Study Observation 4','pso',0,90,0),(95,'Pso 5','Practice Study Observation 5','pso',0,90,0),(96,'Pso 6','Practice Study Observation 6','pso',0,90,0),(97,'Pso 7','Practice Study Observation 7','pso',0,90,0),(98,'Pso 8','Practice Study Observation 8','pso',0,90,0),(99,'Pso 9','Practice Study Observation 9','pso',0,90,0);
/*!40000 ALTER TABLE `itype_desc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jenrl`
--

DROP TABLE IF EXISTS `jenrl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jenrl` (
  `uniqueid` decimal(20,0) NOT NULL,
  `jenrl` double DEFAULT NULL,
  `solution_id` decimal(20,0) DEFAULT NULL,
  `class1_id` decimal(20,0) DEFAULT NULL,
  `class2_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_jenrl` (`solution_id`),
  KEY `idx_jenrl_class1` (`class1_id`),
  KEY `idx_jenrl_class2` (`class2_id`),
  CONSTRAINT `fk_jenrl_class1` FOREIGN KEY (`class1_id`) REFERENCES `class_` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_jenrl_class2` FOREIGN KEY (`class2_id`) REFERENCES `class_` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_jenrl_solution` FOREIGN KEY (`solution_id`) REFERENCES `solution` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jenrl`
--

LOCK TABLES `jenrl` WRITE;
/*!40000 ALTER TABLE `jenrl` DISABLE KEYS */;
/*!40000 ALTER TABLE `jenrl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lastlike_course_demand`
--

DROP TABLE IF EXISTS `lastlike_course_demand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lastlike_course_demand` (
  `uniqueid` decimal(20,0) NOT NULL,
  `student_id` decimal(20,0) DEFAULT NULL,
  `subject_area_id` decimal(20,0) DEFAULT NULL,
  `course_nbr` varchar(10) DEFAULT NULL,
  `priority` bigint(10) DEFAULT '0',
  `course_perm_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_ll_course_demand_course` (`subject_area_id`,`course_nbr`),
  KEY `idx_ll_course_demand_permid` (`course_perm_id`),
  KEY `idx_ll_course_demand_student` (`student_id`),
  CONSTRAINT `fk_ll_course_demand_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_ll_course_demand_subjarea` FOREIGN KEY (`subject_area_id`) REFERENCES `subject_area` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lastlike_course_demand`
--

LOCK TABLES `lastlike_course_demand` WRITE;
/*!40000 ALTER TABLE `lastlike_course_demand` DISABLE KEYS */;
/*!40000 ALTER TABLE `lastlike_course_demand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_picture`
--

DROP TABLE IF EXISTS `location_picture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_picture` (
  `uniqueid` decimal(20,0) NOT NULL,
  `location_id` decimal(20,0) NOT NULL,
  `data_file` longblob NOT NULL,
  `file_name` varchar(260) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `content_type` varchar(260) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `time_stamp` datetime NOT NULL,
  `type_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_location_picture` (`location_id`),
  KEY `fk_location_picture_type` (`type_id`),
  CONSTRAINT `fk_location_picture` FOREIGN KEY (`location_id`) REFERENCES `non_university_location` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_location_picture_type` FOREIGN KEY (`type_id`) REFERENCES `attachment_type` (`uniqueid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_picture`
--

LOCK TABLES `location_picture` WRITE;
/*!40000 ALTER TABLE `location_picture` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_picture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_service_provider`
--

DROP TABLE IF EXISTS `location_service_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_service_provider` (
  `location_id` decimal(20,0) NOT NULL,
  `provider_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`location_id`,`provider_id`),
  KEY `fk_location_service_provider` (`provider_id`),
  CONSTRAINT `fk_location_service_loc` FOREIGN KEY (`location_id`) REFERENCES `non_university_location` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_location_service_provider` FOREIGN KEY (`provider_id`) REFERENCES `service_provider` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_service_provider`
--

LOCK TABLES `location_service_provider` WRITE;
/*!40000 ALTER TABLE `location_service_provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_service_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager_settings`
--

DROP TABLE IF EXISTS `manager_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manager_settings` (
  `uniqueid` decimal(20,0) NOT NULL,
  `key_id` decimal(20,0) DEFAULT NULL,
  `value` varchar(100) DEFAULT NULL,
  `user_uniqueid` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_manager_settings_key` (`key_id`),
  KEY `idx_manager_settings_manager` (`user_uniqueid`),
  CONSTRAINT `fk_manager_settings_key` FOREIGN KEY (`key_id`) REFERENCES `settings` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_manager_settings_user` FOREIGN KEY (`user_uniqueid`) REFERENCES `timetable_manager` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager_settings`
--

LOCK TABLES `manager_settings` WRITE;
/*!40000 ALTER TABLE `manager_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `manager_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting`
--

DROP TABLE IF EXISTS `meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meeting` (
  `uniqueid` decimal(20,0) NOT NULL,
  `event_id` decimal(20,0) NOT NULL,
  `meeting_date` date NOT NULL,
  `start_period` bigint(10) NOT NULL,
  `start_offset` bigint(10) DEFAULT NULL,
  `stop_period` bigint(10) NOT NULL,
  `stop_offset` bigint(10) DEFAULT NULL,
  `location_perm_id` decimal(20,0) DEFAULT NULL,
  `class_can_override` int(1) NOT NULL,
  `approval_date` date DEFAULT NULL,
  `approval_status` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uniqueid`),
  KEY `fk_meeting_event` (`event_id`),
  KEY `idx_meeting_overlap` (`meeting_date`,`start_period`,`stop_period`,`location_perm_id`,`approval_status`),
  CONSTRAINT `fk_meeting_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meeting`
--

LOCK TABLES `meeting` WRITE;
/*!40000 ALTER TABLE `meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting_contact`
--

DROP TABLE IF EXISTS `meeting_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meeting_contact` (
  `meeting_id` decimal(20,0) NOT NULL,
  `contact_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`meeting_id`,`contact_id`),
  KEY `fk_meeting_contact_cont` (`contact_id`),
  CONSTRAINT `fk_meeting_contact_cont` FOREIGN KEY (`contact_id`) REFERENCES `event_contact` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_meeting_contact_mtg` FOREIGN KEY (`meeting_id`) REFERENCES `meeting` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meeting_contact`
--

LOCK TABLES `meeting_contact` WRITE;
/*!40000 ALTER TABLE `meeting_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeting_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_log`
--

DROP TABLE IF EXISTS `message_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_log` (
  `uniqueid` decimal(20,0) NOT NULL,
  `time_stamp` datetime NOT NULL,
  `log_level` decimal(10,0) NOT NULL,
  `message` longtext,
  `logger` varchar(255) NOT NULL,
  `thread` varchar(100) DEFAULT NULL,
  `ndc` longtext,
  `exception` longtext,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_message_log` (`time_stamp`,`log_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_log`
--

LOCK TABLES `message_log` WRITE;
/*!40000 ALTER TABLE `message_log` DISABLE KEYS */;
INSERT INTO `message_log` VALUES (2031616,'2019-05-20 06:43:19',30000,'  Resource messages_en_US.properties Not Found.','PropertyMessageResources','http-nio-80-exec-2','uid:1 role:Sysadmin sid:239259',NULL),(2031617,'2019-05-20 06:43:19',30000,'  Resource messages_en.properties Not Found.','PropertyMessageResources','http-nio-80-exec-2','uid:1 role:Sysadmin sid:239259',NULL),(2195456,'2019-05-20 06:50:56',30000,'  Resource messages_en_US.properties Not Found.','PropertyMessageResources','http-nio-80-exec-6','uid:1 role:Sysadmin sid:239259',NULL),(2195457,'2019-05-20 06:50:56',30000,'  Resource messages_en.properties Not Found.','PropertyMessageResources','http-nio-80-exec-6','uid:1 role:Sysadmin sid:239259',NULL);
/*!40000 ALTER TABLE `message_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `non_university_location`
--

DROP TABLE IF EXISTS `non_university_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `non_university_location` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `capacity` bigint(10) DEFAULT NULL,
  `coordinate_x` double DEFAULT NULL,
  `coordinate_y` double DEFAULT NULL,
  `ignore_too_far` int(1) DEFAULT NULL,
  `manager_ids` varchar(3000) DEFAULT NULL,
  `pattern` varchar(2048) DEFAULT NULL,
  `ignore_room_check` int(1) DEFAULT '0',
  `display_name` varchar(100) DEFAULT NULL,
  `exam_capacity` bigint(10) DEFAULT '0',
  `permanent_id` decimal(20,0) NOT NULL,
  `room_type` decimal(20,0) DEFAULT NULL,
  `event_dept_id` decimal(20,0) DEFAULT NULL,
  `area` double DEFAULT NULL,
  `break_time` bigint(10) DEFAULT NULL,
  `event_status` bigint(10) DEFAULT NULL,
  `note` varchar(2048) DEFAULT NULL,
  `availability` varchar(2048) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `share_note` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_location_permid` (`permanent_id`,`session_id`),
  KEY `idx_non_univ_loc_session` (`session_id`),
  KEY `fk_location_type` (`room_type`),
  KEY `fk_loc_event_dept` (`event_dept_id`),
  CONSTRAINT `fk_loc_event_dept` FOREIGN KEY (`event_dept_id`) REFERENCES `department` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_location_type` FOREIGN KEY (`room_type`) REFERENCES `room_type` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_non_univ_loc_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `non_university_location`
--

LOCK TABLES `non_university_location` WRITE;
/*!40000 ALTER TABLE `non_university_location` DISABLE KEYS */;
/*!40000 ALTER TABLE `non_university_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offering_coordinator`
--

DROP TABLE IF EXISTS `offering_coordinator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offering_coordinator` (
  `offering_id` decimal(20,0) NOT NULL,
  `instructor_id` decimal(20,0) NOT NULL,
  `responsibility_id` decimal(20,0) DEFAULT NULL,
  `request_id` decimal(20,0) DEFAULT NULL,
  `uniqueid` decimal(20,0) NOT NULL,
  `percent_share` int(3) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_offering_coord_instructor` (`instructor_id`),
  KEY `fk_coord_responsibility` (`responsibility_id`),
  KEY `fk_coord_request` (`request_id`),
  KEY `fk_offering_coord_offering` (`offering_id`),
  CONSTRAINT `fk_coord_request` FOREIGN KEY (`request_id`) REFERENCES `teaching_request` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_coord_responsibility` FOREIGN KEY (`responsibility_id`) REFERENCES `teaching_responsibility` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_offering_coord_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `departmental_instructor` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_offering_coord_offering` FOREIGN KEY (`offering_id`) REFERENCES `instructional_offering` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offering_coordinator`
--

LOCK TABLES `offering_coordinator` WRITE;
/*!40000 ALTER TABLE `offering_coordinator` DISABLE KEYS */;
/*!40000 ALTER TABLE `offering_coordinator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offr_consent_type`
--

DROP TABLE IF EXISTS `offr_consent_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offr_consent_type` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) DEFAULT NULL,
  `label` varchar(60) DEFAULT NULL,
  `abbv` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_offr_consent_type_label` (`label`),
  UNIQUE KEY `uk_offr_consent_type_ref` (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offr_consent_type`
--

LOCK TABLES `offr_consent_type` WRITE;
/*!40000 ALTER TABLE `offr_consent_type` DISABLE KEYS */;
INSERT INTO `offr_consent_type` VALUES (225,'IN','Consent of Instructor','Instructor'),(226,'DP','Consent of Department','Department');
/*!40000 ALTER TABLE `offr_consent_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offr_group`
--

DROP TABLE IF EXISTS `offr_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offr_group` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `department_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_offr_group_dept` (`department_id`),
  KEY `idx_offr_group_session` (`session_id`),
  CONSTRAINT `fk_offr_group_dept` FOREIGN KEY (`department_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_offr_group_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offr_group`
--

LOCK TABLES `offr_group` WRITE;
/*!40000 ALTER TABLE `offr_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `offr_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offr_group_offering`
--

DROP TABLE IF EXISTS `offr_group_offering`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offr_group_offering` (
  `offr_group_id` decimal(20,0) NOT NULL,
  `instr_offering_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`offr_group_id`,`instr_offering_id`),
  KEY `fk_offr_group_instr_offr` (`instr_offering_id`),
  CONSTRAINT `fk_offr_group_instr_offr` FOREIGN KEY (`instr_offering_id`) REFERENCES `instructional_offering` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_offr_group_offr_offr_grp` FOREIGN KEY (`offr_group_id`) REFERENCES `offr_group` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offr_group_offering`
--

LOCK TABLES `offr_group_offering` WRITE;
/*!40000 ALTER TABLE `offr_group_offering` DISABLE KEYS */;
/*!40000 ALTER TABLE `offr_group_offering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `override_type`
--

DROP TABLE IF EXISTS `override_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `override_type` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `override_type`
--

LOCK TABLES `override_type` WRITE;
/*!40000 ALTER TABLE `override_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `override_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pit_class`
--

DROP TABLE IF EXISTS `pit_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pit_class` (
  `uniqueid` decimal(20,0) NOT NULL,
  `class_id` decimal(20,0) DEFAULT NULL,
  `pit_subpart_id` decimal(20,0) NOT NULL,
  `pit_parent_id` decimal(20,0) DEFAULT NULL,
  `class_limit` int(10) DEFAULT NULL,
  `nbr_rooms` int(4) DEFAULT NULL,
  `date_pattern_id` decimal(20,0) DEFAULT NULL,
  `time_pattern_id` decimal(20,0) DEFAULT NULL,
  `managing_dept` decimal(20,0) DEFAULT NULL,
  `class_suffix` varchar(40) DEFAULT NULL,
  `enabled_for_stu_sched` int(1) DEFAULT '1',
  `section_number` int(5) DEFAULT NULL,
  `uid_rolled_fwd_from` decimal(20,0) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pit_c_to_pit_ss` (`pit_subpart_id`),
  KEY `fk_pit_c_to_c` (`class_id`),
  KEY `fk_pit_c_to_parent_pit_c` (`pit_parent_id`),
  KEY `fk_pit_c_to_dp` (`date_pattern_id`),
  KEY `fk_pit_c_to_tp` (`time_pattern_id`),
  KEY `fk_pit_c_to_d` (`managing_dept`),
  CONSTRAINT `fk_pit_c_to_c` FOREIGN KEY (`class_id`) REFERENCES `class_` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_pit_c_to_d` FOREIGN KEY (`managing_dept`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_c_to_dp` FOREIGN KEY (`date_pattern_id`) REFERENCES `date_pattern` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_c_to_parent_pit_c` FOREIGN KEY (`pit_parent_id`) REFERENCES `pit_class` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_c_to_pit_ss` FOREIGN KEY (`pit_subpart_id`) REFERENCES `pit_sched_subpart` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_c_to_tp` FOREIGN KEY (`time_pattern_id`) REFERENCES `time_pattern` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pit_class`
--

LOCK TABLES `pit_class` WRITE;
/*!40000 ALTER TABLE `pit_class` DISABLE KEYS */;
/*!40000 ALTER TABLE `pit_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pit_class_event`
--

DROP TABLE IF EXISTS `pit_class_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pit_class_event` (
  `uniqueid` decimal(20,0) NOT NULL,
  `pit_class_id` decimal(20,0) NOT NULL,
  `event_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pit_ce_to_pit_c` (`pit_class_id`),
  CONSTRAINT `fk_pit_ce_to_pit_c` FOREIGN KEY (`pit_class_id`) REFERENCES `pit_class` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pit_class_event`
--

LOCK TABLES `pit_class_event` WRITE;
/*!40000 ALTER TABLE `pit_class_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `pit_class_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pit_class_instructor`
--

DROP TABLE IF EXISTS `pit_class_instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pit_class_instructor` (
  `uniqueid` decimal(20,0) NOT NULL,
  `pit_class_id` decimal(20,0) NOT NULL,
  `pit_dept_instr_id` decimal(20,0) NOT NULL,
  `percent_share` int(3) DEFAULT NULL,
  `normalized_pct_share` int(3) DEFAULT NULL,
  `responsibility_id` decimal(20,0) DEFAULT NULL,
  `is_lead` int(1) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pit_ci_to_pit_di` (`pit_dept_instr_id`),
  KEY `fk_pit_ci_to_pit_c` (`pit_class_id`),
  KEY `fk_pit_ci_to_tr` (`responsibility_id`),
  CONSTRAINT `fk_pit_ci_to_pit_c` FOREIGN KEY (`pit_class_id`) REFERENCES `pit_class` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_ci_to_pit_di` FOREIGN KEY (`pit_dept_instr_id`) REFERENCES `pit_dept_instructor` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_ci_to_tr` FOREIGN KEY (`responsibility_id`) REFERENCES `teaching_responsibility` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pit_class_instructor`
--

LOCK TABLES `pit_class_instructor` WRITE;
/*!40000 ALTER TABLE `pit_class_instructor` DISABLE KEYS */;
/*!40000 ALTER TABLE `pit_class_instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pit_class_meeting`
--

DROP TABLE IF EXISTS `pit_class_meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pit_class_meeting` (
  `uniqueid` decimal(20,0) NOT NULL,
  `pit_class_event_id` decimal(20,0) NOT NULL,
  `meeting_date` date NOT NULL,
  `start_period` bigint(10) NOT NULL,
  `start_offset` bigint(10) DEFAULT NULL,
  `stop_period` bigint(10) NOT NULL,
  `stop_offset` bigint(10) DEFAULT NULL,
  `location_perm_id` decimal(20,0) DEFAULT NULL,
  `time_pattern_min_per_mtg` bigint(10) DEFAULT NULL,
  `calculated_min_per_mtg` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pit_cm_to_pit_ce` (`pit_class_event_id`),
  CONSTRAINT `fk_pit_cm_to_pit_ce` FOREIGN KEY (`pit_class_event_id`) REFERENCES `pit_class_event` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pit_class_meeting`
--

LOCK TABLES `pit_class_meeting` WRITE;
/*!40000 ALTER TABLE `pit_class_meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `pit_class_meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pit_class_mtg_util_period`
--

DROP TABLE IF EXISTS `pit_class_mtg_util_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pit_class_mtg_util_period` (
  `uniqueid` decimal(20,0) NOT NULL,
  `pit_class_meeting_id` decimal(20,0) NOT NULL,
  `time_slot` bigint(10) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pit_cmup_to_pit_cm` (`pit_class_meeting_id`),
  CONSTRAINT `fk_pit_cmup_to_pit_cm` FOREIGN KEY (`pit_class_meeting_id`) REFERENCES `pit_class_meeting` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pit_class_mtg_util_period`
--

LOCK TABLES `pit_class_mtg_util_period` WRITE;
/*!40000 ALTER TABLE `pit_class_mtg_util_period` DISABLE KEYS */;
/*!40000 ALTER TABLE `pit_class_mtg_util_period` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pit_course_offering`
--

DROP TABLE IF EXISTS `pit_course_offering`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pit_course_offering` (
  `uniqueid` decimal(20,0) NOT NULL,
  `course_offering_id` decimal(20,0) DEFAULT NULL,
  `subject_area_id` decimal(20,0) DEFAULT NULL,
  `pit_instr_offr_id` decimal(20,0) NOT NULL,
  `course_nbr` varchar(40) DEFAULT NULL,
  `is_control` int(1) DEFAULT NULL,
  `perm_id` varchar(20) DEFAULT NULL,
  `proj_demand` bigint(10) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `nbr_expected_stdents` bigint(10) DEFAULT '0',
  `external_uid` varchar(40) DEFAULT NULL,
  `uid_rolled_fwd_from` decimal(20,0) DEFAULT NULL,
  `lastlike_demand` bigint(10) DEFAULT '0',
  `course_type_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pit_co_to_pit_io` (`pit_instr_offr_id`),
  KEY `fk_pit_co_to_sa` (`subject_area_id`),
  KEY `fk_pit_co_to_co` (`course_offering_id`),
  KEY `fk_pit_co_to_ct` (`course_type_id`),
  CONSTRAINT `fk_pit_co_to_co` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_pit_co_to_ct` FOREIGN KEY (`course_type_id`) REFERENCES `course_type` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_pit_co_to_pit_io` FOREIGN KEY (`pit_instr_offr_id`) REFERENCES `pit_instr_offering` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_co_to_sa` FOREIGN KEY (`subject_area_id`) REFERENCES `subject_area` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pit_course_offering`
--

LOCK TABLES `pit_course_offering` WRITE;
/*!40000 ALTER TABLE `pit_course_offering` DISABLE KEYS */;
/*!40000 ALTER TABLE `pit_course_offering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pit_dept_instructor`
--

DROP TABLE IF EXISTS `pit_dept_instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pit_dept_instructor` (
  `uniqueid` decimal(20,0) NOT NULL,
  `point_in_time_data_id` decimal(20,0) NOT NULL,
  `dept_instructor_id` decimal(20,0) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `career_acct` varchar(20) DEFAULT NULL,
  `lname` varchar(100) DEFAULT NULL,
  `fname` varchar(100) DEFAULT NULL,
  `mname` varchar(100) DEFAULT NULL,
  `pos_code_type` decimal(20,0) DEFAULT NULL,
  `department_id` decimal(20,0) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pit_di_to_pitd` (`point_in_time_data_id`),
  KEY `fk_pit_di_to_di` (`dept_instructor_id`),
  KEY `fk_pit_di_to_d` (`department_id`),
  KEY `fk_pit_di_to_pt` (`pos_code_type`),
  CONSTRAINT `fk_pit_di_to_d` FOREIGN KEY (`department_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_di_to_di` FOREIGN KEY (`dept_instructor_id`) REFERENCES `departmental_instructor` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_pit_di_to_pitd` FOREIGN KEY (`point_in_time_data_id`) REFERENCES `point_in_time_data` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_di_to_pt` FOREIGN KEY (`pos_code_type`) REFERENCES `position_type` (`uniqueid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pit_dept_instructor`
--

LOCK TABLES `pit_dept_instructor` WRITE;
/*!40000 ALTER TABLE `pit_dept_instructor` DISABLE KEYS */;
/*!40000 ALTER TABLE `pit_dept_instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pit_instr_offer_config`
--

DROP TABLE IF EXISTS `pit_instr_offer_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pit_instr_offer_config` (
  `uniqueid` decimal(20,0) NOT NULL,
  `instr_offering_config_id` decimal(20,0) DEFAULT NULL,
  `pit_instr_offr_id` decimal(20,0) NOT NULL,
  `unlimited_enrollment` int(1) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `uid_rolled_fwd_from` decimal(20,0) DEFAULT NULL,
  `duration_type_id` decimal(20,0) DEFAULT NULL,
  `instr_method_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pit_ioc_to_pit_io` (`pit_instr_offr_id`),
  KEY `fk_pit_ioc_to_ioc` (`instr_offering_config_id`),
  KEY `fk_pit_ioc_to_dt` (`duration_type_id`),
  KEY `fk_pit_ioc_to_im` (`instr_method_id`),
  CONSTRAINT `fk_pit_ioc_to_dt` FOREIGN KEY (`duration_type_id`) REFERENCES `duration_type` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_pit_ioc_to_im` FOREIGN KEY (`instr_method_id`) REFERENCES `instructional_method` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_pit_ioc_to_ioc` FOREIGN KEY (`instr_offering_config_id`) REFERENCES `instr_offering_config` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_pit_ioc_to_pit_io` FOREIGN KEY (`pit_instr_offr_id`) REFERENCES `pit_instr_offering` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pit_instr_offer_config`
--

LOCK TABLES `pit_instr_offer_config` WRITE;
/*!40000 ALTER TABLE `pit_instr_offer_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `pit_instr_offer_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pit_instr_offering`
--

DROP TABLE IF EXISTS `pit_instr_offering`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pit_instr_offering` (
  `uniqueid` decimal(20,0) NOT NULL,
  `point_in_time_data_id` decimal(20,0) NOT NULL,
  `instr_offering_id` decimal(20,0) DEFAULT NULL,
  `instr_offering_perm_id` bigint(10) DEFAULT NULL,
  `demand` int(4) DEFAULT NULL,
  `offr_limit` int(10) DEFAULT NULL,
  `uid_rolled_fwd_from` decimal(20,0) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pit_io_to_pitd` (`point_in_time_data_id`),
  KEY `fk_pit_io_to_io` (`instr_offering_id`),
  CONSTRAINT `fk_pit_io_to_io` FOREIGN KEY (`instr_offering_id`) REFERENCES `instructional_offering` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_pit_io_to_pitd` FOREIGN KEY (`point_in_time_data_id`) REFERENCES `point_in_time_data` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pit_instr_offering`
--

LOCK TABLES `pit_instr_offering` WRITE;
/*!40000 ALTER TABLE `pit_instr_offering` DISABLE KEYS */;
/*!40000 ALTER TABLE `pit_instr_offering` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pit_offering_coord`
--

DROP TABLE IF EXISTS `pit_offering_coord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pit_offering_coord` (
  `uniqueid` decimal(20,0) NOT NULL,
  `pit_offering_id` decimal(20,0) NOT NULL,
  `pit_dept_instr_id` decimal(20,0) NOT NULL,
  `responsibility_id` decimal(20,0) DEFAULT NULL,
  `percent_share` int(3) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pit_ofr_coord_pit_offr` (`pit_offering_id`),
  KEY `fk_pit_ofr_coord_pit_dept_inst` (`pit_dept_instr_id`),
  KEY `fk_pit_coord_resp` (`responsibility_id`),
  CONSTRAINT `fk_pit_coord_resp` FOREIGN KEY (`responsibility_id`) REFERENCES `teaching_responsibility` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_pit_ofr_coord_pit_dept_inst` FOREIGN KEY (`pit_dept_instr_id`) REFERENCES `pit_dept_instructor` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_ofr_coord_pit_offr` FOREIGN KEY (`pit_offering_id`) REFERENCES `pit_instr_offering` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pit_offering_coord`
--

LOCK TABLES `pit_offering_coord` WRITE;
/*!40000 ALTER TABLE `pit_offering_coord` DISABLE KEYS */;
/*!40000 ALTER TABLE `pit_offering_coord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pit_sched_subpart`
--

DROP TABLE IF EXISTS `pit_sched_subpart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pit_sched_subpart` (
  `uniqueid` decimal(20,0) NOT NULL,
  `scheduling_subpart_id` decimal(20,0) DEFAULT NULL,
  `pit_parent_id` decimal(20,0) DEFAULT NULL,
  `pit_config_id` decimal(20,0) NOT NULL,
  `min_per_wk` int(4) DEFAULT NULL,
  `itype` int(2) DEFAULT NULL,
  `subpart_suffix` varchar(5) DEFAULT NULL,
  `credit_type` decimal(20,0) DEFAULT NULL,
  `credit_unit_type` decimal(20,0) DEFAULT NULL,
  `credit` double DEFAULT NULL,
  `student_allow_overlap` int(1) DEFAULT '0',
  `uid_rolled_fwd_from` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pit_ss_to_pit_ioc` (`pit_config_id`),
  KEY `fk_pit_ss_to_ss` (`scheduling_subpart_id`),
  KEY `fk_pit_ss_to_parent_pit_ss` (`pit_parent_id`),
  KEY `fk_pit_ss_to_itype` (`itype`),
  CONSTRAINT `fk_pit_ss_to_itype` FOREIGN KEY (`itype`) REFERENCES `itype_desc` (`itype`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_ss_to_parent_pit_ss` FOREIGN KEY (`pit_parent_id`) REFERENCES `pit_sched_subpart` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_ss_to_pit_ioc` FOREIGN KEY (`pit_config_id`) REFERENCES `pit_instr_offer_config` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_ss_to_ss` FOREIGN KEY (`scheduling_subpart_id`) REFERENCES `scheduling_subpart` (`uniqueid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pit_sched_subpart`
--

LOCK TABLES `pit_sched_subpart` WRITE;
/*!40000 ALTER TABLE `pit_sched_subpart` DISABLE KEYS */;
/*!40000 ALTER TABLE `pit_sched_subpart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pit_stu_aa_major_clasf`
--

DROP TABLE IF EXISTS `pit_stu_aa_major_clasf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pit_stu_aa_major_clasf` (
  `uniqueid` decimal(20,0) NOT NULL,
  `pit_student_id` decimal(20,0) NOT NULL,
  `acad_clasf_id` decimal(20,0) NOT NULL,
  `acad_area_id` decimal(20,0) NOT NULL,
  `major_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pit_stuamc_to_pit_stu` (`pit_student_id`),
  KEY `fk_pit_stuamc_to_ac` (`acad_clasf_id`),
  KEY `fk_pit_stuamc_to_aa` (`acad_area_id`),
  KEY `fk_pit_stuamc_to_pm` (`major_id`),
  CONSTRAINT `fk_pit_stuamc_to_aa` FOREIGN KEY (`acad_area_id`) REFERENCES `academic_area` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_stuamc_to_ac` FOREIGN KEY (`acad_clasf_id`) REFERENCES `academic_classification` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_stuamc_to_pit_stu` FOREIGN KEY (`pit_student_id`) REFERENCES `pit_student` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_stuamc_to_pm` FOREIGN KEY (`major_id`) REFERENCES `pos_major` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pit_stu_aa_major_clasf`
--

LOCK TABLES `pit_stu_aa_major_clasf` WRITE;
/*!40000 ALTER TABLE `pit_stu_aa_major_clasf` DISABLE KEYS */;
/*!40000 ALTER TABLE `pit_stu_aa_major_clasf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pit_stu_aa_minor_clasf`
--

DROP TABLE IF EXISTS `pit_stu_aa_minor_clasf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pit_stu_aa_minor_clasf` (
  `uniqueid` decimal(20,0) NOT NULL,
  `pit_student_id` decimal(20,0) NOT NULL,
  `acad_clasf_id` decimal(20,0) NOT NULL,
  `acad_area_id` decimal(20,0) NOT NULL,
  `minor_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pit_stuamnc_to_pit_stu` (`pit_student_id`),
  KEY `fk_pit_stuamnc_to_ac` (`acad_clasf_id`),
  KEY `fk_pit_stuamnc_to_aa` (`acad_area_id`),
  KEY `fk_pit_stuamnc_to_pmn` (`minor_id`),
  CONSTRAINT `fk_pit_stuamnc_to_aa` FOREIGN KEY (`acad_area_id`) REFERENCES `academic_area` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_stuamnc_to_ac` FOREIGN KEY (`acad_clasf_id`) REFERENCES `academic_classification` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_stuamnc_to_pit_stu` FOREIGN KEY (`pit_student_id`) REFERENCES `pit_student` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_stuamnc_to_pmn` FOREIGN KEY (`minor_id`) REFERENCES `pos_minor` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pit_stu_aa_minor_clasf`
--

LOCK TABLES `pit_stu_aa_minor_clasf` WRITE;
/*!40000 ALTER TABLE `pit_stu_aa_minor_clasf` DISABLE KEYS */;
/*!40000 ALTER TABLE `pit_stu_aa_minor_clasf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pit_student`
--

DROP TABLE IF EXISTS `pit_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pit_student` (
  `uniqueid` decimal(20,0) NOT NULL,
  `point_in_time_data_id` decimal(20,0) NOT NULL,
  `student_id` decimal(20,0) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pit_stu_to_pitd` (`point_in_time_data_id`),
  KEY `fk_pit_stu_to_stu` (`student_id`),
  CONSTRAINT `fk_pit_stu_to_pitd` FOREIGN KEY (`point_in_time_data_id`) REFERENCES `point_in_time_data` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_stu_to_stu` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pit_student`
--

LOCK TABLES `pit_student` WRITE;
/*!40000 ALTER TABLE `pit_student` DISABLE KEYS */;
/*!40000 ALTER TABLE `pit_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pit_student_class_enrl`
--

DROP TABLE IF EXISTS `pit_student_class_enrl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pit_student_class_enrl` (
  `uniqueid` decimal(20,0) NOT NULL,
  `pit_student_id` decimal(20,0) NOT NULL,
  `pit_class_id` decimal(20,0) NOT NULL,
  `pit_course_offering_id` decimal(20,0) NOT NULL,
  `timestamp` date DEFAULT NULL,
  `changed_by` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pit_sce_to_pit_stu` (`pit_student_id`),
  KEY `fk_pit_sce_to_pit_c` (`pit_class_id`),
  KEY `fk_pit_sce_to_pit_co` (`pit_course_offering_id`),
  CONSTRAINT `fk_pit_sce_to_pit_c` FOREIGN KEY (`pit_class_id`) REFERENCES `pit_class` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_sce_to_pit_co` FOREIGN KEY (`pit_course_offering_id`) REFERENCES `pit_course_offering` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pit_sce_to_pit_stu` FOREIGN KEY (`pit_student_id`) REFERENCES `pit_student` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pit_student_class_enrl`
--

LOCK TABLES `pit_student_class_enrl` WRITE;
/*!40000 ALTER TABLE `pit_student_class_enrl` DISABLE KEYS */;
/*!40000 ALTER TABLE `pit_student_class_enrl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `point_in_time_data`
--

DROP TABLE IF EXISTS `point_in_time_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `point_in_time_data` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) NOT NULL,
  `timestamp` date NOT NULL,
  `name` varchar(100) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `saved_successfully` int(1) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pitd_to_s` (`session_id`),
  CONSTRAINT `fk_pitd_to_s` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `point_in_time_data`
--

LOCK TABLES `point_in_time_data` WRITE;
/*!40000 ALTER TABLE `point_in_time_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `point_in_time_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pos_acad_area_major`
--

DROP TABLE IF EXISTS `pos_acad_area_major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pos_acad_area_major` (
  `academic_area_id` decimal(20,0) NOT NULL,
  `major_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`academic_area_id`,`major_id`),
  KEY `fk_pos_acad_area_major_major` (`major_id`),
  CONSTRAINT `fk_pos_acad_area_major_area` FOREIGN KEY (`academic_area_id`) REFERENCES `academic_area` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pos_acad_area_major_major` FOREIGN KEY (`major_id`) REFERENCES `pos_major` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pos_acad_area_major`
--

LOCK TABLES `pos_acad_area_major` WRITE;
/*!40000 ALTER TABLE `pos_acad_area_major` DISABLE KEYS */;
/*!40000 ALTER TABLE `pos_acad_area_major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pos_acad_area_minor`
--

DROP TABLE IF EXISTS `pos_acad_area_minor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pos_acad_area_minor` (
  `academic_area_id` decimal(20,0) NOT NULL,
  `minor_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`academic_area_id`,`minor_id`),
  KEY `fk_pos_acad_area_minor_minor` (`minor_id`),
  CONSTRAINT `fk_pos_acad_area_minor_area` FOREIGN KEY (`academic_area_id`) REFERENCES `academic_area` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_pos_acad_area_minor_minor` FOREIGN KEY (`minor_id`) REFERENCES `pos_minor` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pos_acad_area_minor`
--

LOCK TABLES `pos_acad_area_minor` WRITE;
/*!40000 ALTER TABLE `pos_acad_area_minor` DISABLE KEYS */;
/*!40000 ALTER TABLE `pos_acad_area_minor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pos_major`
--

DROP TABLE IF EXISTS `pos_major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pos_major` (
  `uniqueid` decimal(20,0) NOT NULL,
  `code` varchar(40) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `external_uid` varchar(20) DEFAULT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_pos_major_code` (`code`,`session_id`),
  KEY `fk_pos_major_session` (`session_id`),
  CONSTRAINT `fk_pos_major_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pos_major`
--

LOCK TABLES `pos_major` WRITE;
/*!40000 ALTER TABLE `pos_major` DISABLE KEYS */;
/*!40000 ALTER TABLE `pos_major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pos_minor`
--

DROP TABLE IF EXISTS `pos_minor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pos_minor` (
  `uniqueid` decimal(20,0) NOT NULL,
  `code` varchar(40) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_pos_minor_session` (`session_id`),
  CONSTRAINT `fk_pos_minor_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pos_minor`
--

LOCK TABLES `pos_minor` WRITE;
/*!40000 ALTER TABLE `pos_minor` DISABLE KEYS */;
/*!40000 ALTER TABLE `pos_minor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `position_type`
--

DROP TABLE IF EXISTS `position_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `position_type` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) DEFAULT NULL,
  `label` varchar(60) DEFAULT NULL,
  `sort_order` int(4) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_position_type_label` (`label`),
  UNIQUE KEY `uk_position_type_ref` (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `position_type`
--

LOCK TABLES `position_type` WRITE;
/*!40000 ALTER TABLE `position_type` DISABLE KEYS */;
INSERT INTO `position_type` VALUES (1,'PROF','Professor',100),(2,'ASSOC_PROF','Associate Professor',200),(3,'ASST_PROF','Assistant Professor',300),(4,'INSTRUCTOR','Instructor',800),(5,'CLIN_PROF','Clinical / Professional',500),(6,'CONT_LEC','Continuing Lecturer',600),(7,'LTD_LEC','Limited-Term Lecturer',700),(8,'VISIT_FAC','Visiting Faculty',400),(9,'POST_DOC','Post Doctoral',1500),(10,'ADJUNCT_FAC','Adjunct Faculty',1000),(11,'GRAD_TEACH_ASST','Graduate Teaching Assistant',1200),(12,'GRAD_LEC','Graduate Lecturer',1100),(13,'CLERICAL_STAFF','Clerical Staff',1600),(14,'SERVICE_STAFF','Service Staff',1700),(15,'FELLOWSHIP','Fellowship',1800),(16,'EMERITUS','Emeritus Faculty',900),(17,'OTHER','Other',2000),(18,'ADMIN_STAFF','Administrative/Professional Staff',1300),(19,'UNDRGRD_TEACH_ASST','Undergrad Teaching Assistant',1400);
/*!40000 ALTER TABLE `position_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preference_level`
--

DROP TABLE IF EXISTS `preference_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preference_level` (
  `pref_id` int(2) DEFAULT NULL,
  `pref_prolog` varchar(2) DEFAULT NULL,
  `pref_name` varchar(20) DEFAULT NULL,
  `uniqueid` decimal(20,0) NOT NULL,
  `pref_abbv` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_preference_level_pref_id` (`pref_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preference_level`
--

LOCK TABLES `preference_level` WRITE;
/*!40000 ALTER TABLE `preference_level` DISABLE KEYS */;
INSERT INTO `preference_level` VALUES (1,'R','Required',1,'Req'),(2,'-2','Strongly Preferred',2,'StrPref'),(3,'-1','Preferred',3,'Pref'),(4,'0','Neutral',4,''),(5,'1','Discouraged',5,'Disc'),(6,'2','Strongly Discouraged',6,'StrDisc'),(7,'P','Prohibited',7,'Proh'),(8,'N','Not Available',8,'N/A');
/*!40000 ALTER TABLE `preference_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `query_log`
--

DROP TABLE IF EXISTS `query_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `query_log` (
  `uniqueid` decimal(20,0) NOT NULL,
  `time_stamp` datetime NOT NULL,
  `time_spent` decimal(20,0) NOT NULL,
  `uri` varchar(255) NOT NULL,
  `type` decimal(10,0) NOT NULL,
  `session_id` varchar(32) DEFAULT NULL,
  `userid` varchar(40) DEFAULT NULL,
  `query` longtext,
  `exception` longtext,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_query_log` (`time_stamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `query_log`
--

LOCK TABLES `query_log` WRITE;
/*!40000 ALTER TABLE `query_log` DISABLE KEYS */;
INSERT INTO `query_log` VALUES (1998848,'2019-05-20 06:40:00',1342,'selectPrimaryRole.do',0,'9955F2904EE9074D6932743091B5833D','1','{}',NULL),(1998849,'2019-05-20 06:39:59',1,'RPC:IsSessionBusyRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{}',NULL),(1998850,'2019-05-20 06:39:59',1,'RPC:IsSessionBusyRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{}',NULL),(1998851,'2019-05-20 06:40:00',1,'RPC:PageNameRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{\"name\":\"University Timetabling Application\"}',NULL),(1998852,'2019-05-20 06:40:00',0,'RPC:VersionInfoRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{}',NULL),(1998853,'2019-05-20 06:40:00',2,'RPC:UserInfoRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{}',NULL),(1998854,'2019-05-20 06:40:00',15,'RPC:SessionInfoRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{}',NULL),(1998855,'2019-05-20 06:40:00',155,'RPC:MenuRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{}',NULL),(1998856,'2019-05-20 06:40:11',0,'RPC:PageNameRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{\"name\":\"Curricula\"}',NULL),(1998857,'2019-05-20 06:40:11',10,'RPC:CurriculumFilterRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{\"command\":\"LOAD\",\"text\":\"\",\"options\":{\"user\":[\"1\"]},\"sessionId\":239259}',NULL),(1998858,'2019-05-20 06:40:11',3,'RPC:CurriculumFilterRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{\"command\":\"LOAD\",\"text\":\"\",\"options\":{\"department\":[\"Managed\"],\"user\":[\"1\"]},\"sessionId\":239259}',NULL),(1998859,'2019-05-20 06:40:11',9,'RPC:CurriculumFilterRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{\"command\":\"LOAD\",\"text\":\"\",\"options\":{\"department\":[\"Managed\"],\"user\":[\"1\"]},\"sessionId\":239259}',NULL),(1998860,'2019-05-20 06:40:11',2,'RPC:SessionInfoRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{}',NULL),(1998861,'2019-05-20 06:40:11',0,'RPC:VersionInfoRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{}',NULL),(1998862,'2019-05-20 06:40:11',0,'RPC:UserInfoRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{}',NULL),(1998863,'2019-05-20 06:40:11',48,'RPC:MenuRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{}',NULL),(1998864,'2019-05-20 06:40:20',0,'RPC:PageNameRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{\"name\":\"Curricula\"}',NULL),(1998865,'2019-05-20 06:40:21',1,'RPC:CurriculumFilterRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{\"command\":\"LOAD\",\"text\":\"\",\"options\":{\"user\":[\"1\"]},\"sessionId\":239259}',NULL),(1998866,'2019-05-20 06:40:21',1,'RPC:CurriculumFilterRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{\"command\":\"LOAD\",\"text\":\"\",\"options\":{\"department\":[\"Managed\"],\"user\":[\"1\"]},\"sessionId\":239259}',NULL),(1998867,'2019-05-20 06:40:21',2,'RPC:CurriculumFilterRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{\"command\":\"LOAD\",\"text\":\"\",\"options\":{\"department\":[\"Managed\"],\"user\":[\"1\"]},\"sessionId\":239259}',NULL),(1998868,'2019-05-20 06:40:21',1,'RPC:SessionInfoRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{}',NULL),(1998869,'2019-05-20 06:40:21',0,'RPC:VersionInfoRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{}',NULL),(1998870,'2019-05-20 06:40:21',2,'RPC:UserInfoRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{}',NULL),(1998871,'2019-05-20 06:40:21',29,'RPC:MenuRpcRequest',3,'9955F2904EE9074D6932743091B5833D','1','{}',NULL),(1998872,'2019-05-20 06:40:32',0,'RPC:VersionInfoRpcRequest',3,'2AAE6C053EE11B3FB23AB4C51ECF295B','','{}',NULL),(1998873,'2019-05-20 06:40:32',31,'RPC:MenuRpcRequest',3,'2AAE6C053EE11B3FB23AB4C51ECF295B','','{}',NULL),(1998874,'2019-05-20 06:40:11',54,'curricula.gwt: CurriculaService#canAddCurriculum',1,'9955F2904EE9074D6932743091B5833D','1','[]',NULL),(1998875,'2019-05-20 06:40:11',27,'curricula.gwt: CurriculaService#isAdmin',1,'9955F2904EE9074D6932743091B5833D','1','[]',NULL),(1998876,'2019-05-20 06:40:11',3,'curricula.gwt: CurriculaService#lastCurriculaFilter',1,'9955F2904EE9074D6932743091B5833D','1','[]',NULL),(1998877,'2019-05-20 06:40:11',30,'curricula.gwt: CurriculaService#loadAcademicAreas',1,'9955F2904EE9074D6932743091B5833D','1','[]',NULL),(1998878,'2019-05-20 06:40:11',32,'curricula.gwt: CurriculaService#loadDepartments',1,'9955F2904EE9074D6932743091B5833D','1','[]',NULL),(1998879,'2019-05-20 06:40:11',36,'curricula.gwt: CurriculaService#loadAcademicClassifications',1,'9955F2904EE9074D6932743091B5833D','1','[]',NULL),(1998880,'2019-05-20 06:40:14',22,'curricula.gwt: CurriculaService#findCurricula',1,'9955F2904EE9074D6932743091B5833D','1','[{\"command\":\"ENUMERATE\",\"text\":\"\",\"options\":{\"department\":[\"Managed\"]}}]',NULL),(1998881,'2019-05-20 06:40:20',1,'curricula.gwt: CurriculaService#canAddCurriculum',1,'9955F2904EE9074D6932743091B5833D','1','[]',NULL),(1998882,'2019-05-20 06:40:20',1,'curricula.gwt: CurriculaService#isAdmin',1,'9955F2904EE9074D6932743091B5833D','1','[]',NULL),(1998883,'2019-05-20 06:40:21',2,'curricula.gwt: CurriculaService#lastCurriculaFilter',1,'9955F2904EE9074D6932743091B5833D','1','[]',NULL),(1998884,'2019-05-20 06:40:21',2,'curricula.gwt: CurriculaService#loadAcademicAreas',1,'9955F2904EE9074D6932743091B5833D','1','[]',NULL),(1998885,'2019-05-20 06:40:21',3,'curricula.gwt: CurriculaService#loadDepartments',1,'9955F2904EE9074D6932743091B5833D','1','[]',NULL),(1998886,'2019-05-20 06:40:21',2,'curricula.gwt: CurriculaService#loadAcademicClassifications',1,'9955F2904EE9074D6932743091B5833D','1','[]',NULL),(1998887,'2019-05-20 06:40:32',41,'login.do',0,'2AAE6C053EE11B3FB23AB4C51ECF295B','','{}',NULL),(1998888,'2019-05-20 06:43:14',0,'RPC:PageNameRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{\"name\":\"University Timetabling Application\"}',NULL),(1998889,'2019-05-20 06:43:14',17,'RPC:MenuRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998890,'2019-05-20 06:43:14',1,'RPC:SessionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998891,'2019-05-20 06:43:14',1,'RPC:UserInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998892,'2019-05-20 06:43:14',0,'RPC:VersionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998893,'2019-05-20 06:43:19',0,'RPC:PageNameRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{\"name\":\"Academic Sessions\"}',NULL),(1998894,'2019-05-20 06:43:19',12,'RPC:MenuRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998895,'2019-05-20 06:43:19',1,'RPC:SessionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998896,'2019-05-20 06:43:19',1,'RPC:UserInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998897,'2019-05-20 06:43:19',0,'RPC:VersionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998898,'2019-05-20 06:43:22',0,'RPC:PageNameRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{\"name\":\"Edit Academic Session\"}',NULL),(1998899,'2019-05-20 06:43:22',11,'RPC:MenuRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998900,'2019-05-20 06:43:22',1,'RPC:SessionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998901,'2019-05-20 06:43:22',1,'RPC:UserInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998902,'2019-05-20 06:43:22',0,'RPC:VersionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998903,'2019-05-20 06:43:33',0,'RPC:PageNameRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{\"name\":\"Edit Academic Session\"}',NULL),(1998904,'2019-05-20 06:43:33',9,'RPC:MenuRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998905,'2019-05-20 06:43:33',1,'RPC:SessionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998906,'2019-05-20 06:43:33',1,'RPC:UserInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998907,'2019-05-20 06:43:33',0,'RPC:VersionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998908,'2019-05-20 06:43:49',0,'RPC:PageNameRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{\"name\":\"Edit Academic Session\"}',NULL),(1998909,'2019-05-20 06:43:50',14,'RPC:MenuRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998910,'2019-05-20 06:43:50',0,'RPC:UserInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998911,'2019-05-20 06:43:50',1,'RPC:SessionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998912,'2019-05-20 06:43:50',0,'RPC:VersionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998913,'2019-05-20 06:43:14',8,'selectPrimaryRole.do',0,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998914,'2019-05-20 06:43:19',140,'sessionList.do',0,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998915,'2019-05-20 06:43:22',178,'sessionEdit.do',0,'F6425B121216582512FEF4B160E80AD1','1','{\"doit\":\"editSession\",\"sessionId\":\"239259\"}',NULL),(1998916,'2019-05-20 06:43:32',155,'sessionEdit.do',0,'F6425B121216582512FEF4B160E80AD1','1','{\"sessionStart\":\"09/06/2010\",\"cal_val_2010_10_11\":\"0\",\"cal_val_2010_10_10\":\"0\",\"cal_val_2010_10_13\":\"0\",\"cal_val_2010_10_12\":\"0\",\"cal_val_2010_10_19\":\"0\",\"cal_val_2010_10_18\":\"0\",\"examStart\":\"12/06/2010\",\"academicYear\":\"2019\",\"cal_val_2010_10_15\":\"0\",\"cal_val_2010_10_14\":\"0\",\"cal_val_2010_10_17\":\"0\",\"cal_val_2010_10_16\":\"0\",\"cal_val_2010_10_22\":\"0\",\"cal_val_2010_10_21\":\"0\",\"cal_val_2010_10_24\":\"0\",\"cal_val_2010_10_23\":\"0\",\"cal_val_2010_10_20\":\"0\",\"cal_val_2010_10_29\":\"0\",\"cal_val_2010_10_26\":\"0\",\"cal_val_2010_10_25\":\"0\",\"cal_val_2010_10_28\":\"0\",\"cal_val_2010_10_27\":\"0\",\"academicInitiative\":\"EIIA\",\"status\":\"input\",\"cal_val_2010_9_4\":\"0\",\"cal_val_2010_9_3\":\"0\",\"cal_val_2010_9_2\":\"0\",\"cal_val_2010_9_1\":\"0\",\"cal_val_2010_9_8\":\"0\",\"cal_val_2010_9_7\":\"0\",\"cal_val_2010_9_6\":\"0\",\"cal_val_2010_9_5\":\"0\",\"cal_val_2010_8_19\":\"0\",\"cal_val_2010_8_18\":\"0\",\"cal_val_2010_8_17\":\"0\",\"durationType\":\"1703884\",\"cal_select\":\"0\",\"cal_val_2010_8_23\":\"0\",\"cal_val_2010_8_22\":\"0\",\"cal_val_2010_8_21\":\"0\",\"cal_val_2010_8_20\":\"0\",\"cal_val_2010_8_27\":\"0\",\"cal_val_2010_8_26\":\"0\",\"cal_val_2010_8_25\":\"0\",\"cal_val_2010_8_24\":\"0\",\"sessionEnd\":\"12/12/2010\",\"refresh\":\"1\",\"sessionId\":\"239259\",\"cal_val_2010_8_12\":\"0\",\"cal_val_2010_8_11\":\"0\",\"eventEnd\":\"12/31/2010\",\"cal_val_2010_8_10\":\"0\",\"wkEnroll\":\"1\",\"cal_val_2010_8_16\":\"0\",\"cal_val_2010_8_15\":\"0\",\"cal_val_2010_8_14\":\"0\",\"cal_val_2010_8_13\":\"0\",\"cal_val_2010_8_5\":\"0\",\"cal_val_2010_11_3\":\"0\",\"cal_val_2010_8_4\":\"0\",\"cal_val_2010_11_2\":\"0\",\"cal_val_2010_8_3\":\"0\",\"cal_val_2010_11_1\":\"0\",\"sectStatus\":\"-1\",\"cal_val_2010_8_2\":\"0\",\"cal_val_2010_8_9\":\"0\",\"cal_val_2010_8_8\":\"0\",\"cal_val_2010_8_7\":\"0\",\"wkChange\":\"1\",\"cal_val_2010_8_6\":\"0\",\"cal_val_2010_11_24\":\"0\",\"cal_val_2010_11_25\":\"0\",\"cal_val_2010_11_9\":\"0\",\"cal_val_2010_11_22\":\"0\",\"cal_val_2010_11_8\":\"0\",\"cal_val_2010_11_23\":\"0\",\"cal_val_2010_8_1\":\"0\",\"cal_val_2010_11_7\":\"0\",\"cal_val_2010_11_20\":\"0\",\"cal_val_2010_11_6\":\"0\",\"cal_val_2010_11_21\":\"0\",\"cal_val_2010_11_5\":\"0\",\"cal_val_2010_11_4\":\"0\",\"cal_val_2010_9_13\":\"0\",\"cal_val_2010_9_12\":\"0\",\"cal_val_2010_9_11\":\"0\",\"cal_val_2010_9_10\":\"0\",\"cal_val_2010_9_17\":\"0\",\"cal_val_2010_11_28\":\"0\",\"cal_val_2010_9_16\":\"0\",\"cal_val_2010_11_29\":\"0\",\"cal_val_2010_9_15\":\"0\",\"cal_val_2010_11_26\":\"0\",\"cal_val_2010_9_14\":\"0\",\"cal_val_2010_11_27\":\"0\",\"instructionalMethod\":\"-1\",\"cal_val_2010_8_29\":\"0\",\"cal_val_2010_8_28\":\"0\",\"cal_val_2010_11_31\":\"0\",\"cal_val_2010_11_30\":\"0\",\"cal_val_2010_9_9\":\"0\",\"cal_val_2010_8_30\":\"0\",\"cal_val_2010_10_4\":\"0\",\"cal_val_2010_10_3\":\"0\",\"cal_val_2010_10_2\":\"0\",\"cal_val_2010_10_1\":\"0\",\"cal_val_2010_9_29\":\"0\",\"cal_val_2010_10_9\":\"0\",\"cal_val_2010_10_8\":\"0\",\"cal_val_2010_10_7\":\"0\",\"cal_val_2010_10_6\":\"0\",\"cal_val_2010_10_5\":\"0\",\"cal_val_2010_10_30\":\"0\",\"classesEnd\":\"12/05/2010\",\"doit\":\"Update\",\"cal_val_2010_9_31\":\"0\",\"cal_val_2010_9_30\":\"0\",\"defaultDatePatternId\":\"\",\"academicTerm\":\"Primer semestre\",\"cal_val_2010_11_13\":\"0\",\"cal_val_2010_11_14\":\"0\",\"eventStart\":\"09/01/2010\",\"cal_val_2010_9_19\":\"0\",\"cal_val_2010_11_11\":\"0\",\"cal_val_2010_9_18\":\"0\",\"cal_val_2010_11_12\":\"0\",\"cal_val_2010_11_10\":\"0\",\"cal_val_2010_9_24\":\"0\",\"cal_val_2010_9_23\":\"0\",\"cal_val_2010_9_22\":\"0\",\"cal_val_2010_11_19\":\"0\",\"cal_val_2010_9_21\":\"0\",\"cal_val_2010_9_28\":\"0\",\"cal_val_2010_11_17\":\"0\",\"cal_val_2010_9_27\":\"0\",\"cal_val_2010_11_18\":\"0\",\"cal_val_2010_9_26\":\"0\",\"cal_val_2010_11_15\":\"0\",\"wkDrop\":\"1\",\"cal_val_2010_9_25\":\"0\",\"cal_val_2010_11_16\":\"0\",\"cal_val_2010_9_20\":\"0\"}',NULL),(1998917,'2019-05-20 06:43:49',89,'sessionEdit.do',0,'F6425B121216582512FEF4B160E80AD1','1','{\"sessionStart\":\"09/06/2010\",\"cal_val_2010_10_11\":\"0\",\"cal_val_2010_10_10\":\"0\",\"cal_val_2010_10_13\":\"0\",\"cal_val_2010_10_12\":\"0\",\"cal_val_2010_10_19\":\"0\",\"cal_val_2010_10_18\":\"0\",\"examStart\":\"12/06/2010\",\"academicYear\":\"2019\",\"cal_val_2010_10_15\":\"0\",\"cal_val_2010_10_14\":\"0\",\"cal_val_2010_10_17\":\"0\",\"cal_val_2010_10_16\":\"0\",\"cal_val_2010_10_22\":\"0\",\"cal_val_2010_10_21\":\"0\",\"cal_val_2010_10_24\":\"0\",\"cal_val_2010_10_23\":\"0\",\"cal_val_2010_10_20\":\"0\",\"cal_val_2010_10_29\":\"0\",\"cal_val_2010_10_26\":\"0\",\"cal_val_2010_10_25\":\"0\",\"cal_val_2010_10_28\":\"0\",\"cal_val_2010_10_27\":\"0\",\"academicInitiative\":\"EIIA\",\"status\":\"input\",\"cal_val_2010_9_4\":\"0\",\"cal_val_2010_9_3\":\"0\",\"cal_val_2010_9_2\":\"0\",\"cal_val_2010_9_1\":\"0\",\"cal_val_2010_9_8\":\"0\",\"cal_val_2010_9_7\":\"0\",\"cal_val_2010_9_6\":\"0\",\"cal_val_2010_9_5\":\"0\",\"cal_val_2010_8_19\":\"0\",\"cal_val_2010_8_18\":\"0\",\"cal_val_2010_8_17\":\"0\",\"durationType\":\"1703884\",\"cal_select\":\"0\",\"cal_val_2010_8_23\":\"0\",\"cal_val_2010_8_22\":\"0\",\"cal_val_2010_8_21\":\"0\",\"cal_val_2010_8_20\":\"0\",\"cal_val_2010_8_27\":\"0\",\"cal_val_2010_8_26\":\"0\",\"cal_val_2010_8_25\":\"0\",\"cal_val_2010_8_24\":\"0\",\"sessionEnd\":\"12/12/2010\",\"refresh\":\"1\",\"sessionId\":\"239259\",\"cal_val_2010_8_12\":\"0\",\"cal_val_2010_8_11\":\"0\",\"eventEnd\":\"01/24/2020\",\"cal_val_2010_8_10\":\"0\",\"wkEnroll\":\"1\",\"cal_val_2010_8_16\":\"0\",\"cal_val_2010_8_15\":\"0\",\"cal_val_2010_8_14\":\"0\",\"cal_val_2010_8_13\":\"0\",\"cal_val_2010_8_5\":\"0\",\"cal_val_2010_11_3\":\"0\",\"cal_val_2010_8_4\":\"0\",\"cal_val_2010_11_2\":\"0\",\"cal_val_2010_8_3\":\"0\",\"cal_val_2010_11_1\":\"0\",\"sectStatus\":\"-1\",\"cal_val_2010_8_2\":\"0\",\"cal_val_2010_8_9\":\"0\",\"cal_val_2010_8_8\":\"0\",\"cal_val_2010_8_7\":\"0\",\"wkChange\":\"1\",\"cal_val_2010_8_6\":\"0\",\"cal_val_2010_11_24\":\"0\",\"cal_val_2010_11_25\":\"0\",\"cal_val_2010_11_9\":\"0\",\"cal_val_2010_11_22\":\"0\",\"cal_val_2010_11_8\":\"0\",\"cal_val_2010_11_23\":\"0\",\"cal_val_2010_8_1\":\"0\",\"cal_val_2010_11_7\":\"0\",\"cal_val_2010_11_20\":\"0\",\"cal_val_2010_11_6\":\"0\",\"cal_val_2010_11_21\":\"0\",\"cal_val_2010_11_5\":\"0\",\"cal_val_2010_11_4\":\"0\",\"cal_val_2010_9_13\":\"0\",\"cal_val_2010_9_12\":\"0\",\"cal_val_2010_9_11\":\"0\",\"cal_val_2010_9_10\":\"0\",\"cal_val_2010_9_17\":\"0\",\"cal_val_2010_11_28\":\"0\",\"cal_val_2010_9_16\":\"0\",\"cal_val_2010_11_29\":\"0\",\"cal_val_2010_9_15\":\"0\",\"cal_val_2010_11_26\":\"0\",\"cal_val_2010_9_14\":\"0\",\"cal_val_2010_11_27\":\"0\",\"instructionalMethod\":\"-1\",\"cal_val_2010_8_29\":\"0\",\"cal_val_2010_8_28\":\"0\",\"cal_val_2010_11_31\":\"0\",\"cal_val_2010_11_30\":\"0\",\"cal_val_2010_9_9\":\"0\",\"cal_val_2010_8_30\":\"0\",\"cal_val_2010_10_4\":\"0\",\"cal_val_2010_10_3\":\"0\",\"cal_val_2010_10_2\":\"0\",\"cal_val_2010_10_1\":\"0\",\"cal_val_2010_9_29\":\"0\",\"cal_val_2010_10_9\":\"0\",\"cal_val_2010_10_8\":\"0\",\"cal_val_2010_10_7\":\"0\",\"cal_val_2010_10_6\":\"0\",\"cal_val_2010_10_5\":\"0\",\"cal_val_2010_10_30\":\"0\",\"classesEnd\":\"12/05/2010\",\"doit\":\"Update\",\"cal_val_2010_9_31\":\"0\",\"cal_val_2010_9_30\":\"0\",\"defaultDatePatternId\":\"\",\"academicTerm\":\"Primer semestre\",\"cal_val_2010_11_13\":\"0\",\"cal_val_2010_11_14\":\"0\",\"eventStart\":\"09/01/2010\",\"cal_val_2010_9_19\":\"0\",\"cal_val_2010_11_11\":\"0\",\"cal_val_2010_9_18\":\"0\",\"cal_val_2010_11_12\":\"0\",\"cal_val_2010_11_10\":\"0\",\"cal_val_2010_9_24\":\"0\",\"cal_val_2010_9_23\":\"0\",\"cal_val_2010_9_22\":\"0\",\"cal_val_2010_11_19\":\"0\",\"cal_val_2010_9_21\":\"0\",\"cal_val_2010_9_28\":\"0\",\"cal_val_2010_11_17\":\"0\",\"cal_val_2010_9_27\":\"0\",\"cal_val_2010_11_18\":\"0\",\"cal_val_2010_9_26\":\"0\",\"cal_val_2010_11_15\":\"0\",\"wkDrop\":\"1\",\"cal_val_2010_9_25\":\"0\",\"cal_val_2010_11_16\":\"0\",\"cal_val_2010_9_20\":\"0\"}',NULL),(1998918,'2019-05-20 06:44:01',69,'sessionEdit.do',0,'F6425B121216582512FEF4B160E80AD1','1','{\"sessionStart\":\"09/06/2010\",\"cal_val_2010_10_11\":\"0\",\"cal_val_2010_10_10\":\"0\",\"cal_val_2010_10_13\":\"0\",\"cal_val_2010_10_12\":\"0\",\"cal_val_2010_10_19\":\"0\",\"cal_val_2010_10_18\":\"0\",\"examStart\":\"12/06/2010\",\"academicYear\":\"2019\",\"cal_val_2010_10_15\":\"0\",\"cal_val_2010_10_14\":\"0\",\"cal_val_2010_10_17\":\"0\",\"cal_val_2010_10_16\":\"0\",\"cal_val_2010_10_22\":\"0\",\"cal_val_2010_10_21\":\"0\",\"cal_val_2010_10_24\":\"0\",\"cal_val_2010_10_23\":\"0\",\"cal_val_2010_10_20\":\"0\",\"cal_val_2010_10_29\":\"0\",\"cal_val_2010_10_26\":\"0\",\"cal_val_2010_10_25\":\"0\",\"cal_val_2010_10_28\":\"0\",\"cal_val_2010_10_27\":\"0\",\"academicInitiative\":\"EIIA\",\"status\":\"input\",\"cal_val_2010_9_4\":\"0\",\"cal_val_2010_9_3\":\"0\",\"cal_val_2010_9_2\":\"0\",\"cal_val_2010_9_1\":\"0\",\"cal_val_2010_9_8\":\"0\",\"cal_val_2010_9_7\":\"0\",\"cal_val_2010_9_6\":\"0\",\"cal_val_2010_9_5\":\"0\",\"cal_val_2010_8_19\":\"0\",\"cal_val_2010_8_18\":\"0\",\"cal_val_2010_8_17\":\"0\",\"durationType\":\"1703884\",\"cal_select\":\"0\",\"cal_val_2010_8_23\":\"0\",\"cal_val_2010_8_22\":\"0\",\"cal_val_2010_8_21\":\"0\",\"cal_val_2010_8_20\":\"0\",\"cal_val_2010_8_27\":\"0\",\"cal_val_2010_8_26\":\"0\",\"cal_val_2010_8_25\":\"0\",\"cal_val_2010_8_24\":\"0\",\"sessionEnd\":\"12/12/2010\",\"refresh\":\"1\",\"sessionId\":\"239259\",\"cal_val_2010_8_12\":\"0\",\"cal_val_2010_8_11\":\"0\",\"eventEnd\":\"01/24/2020\",\"cal_val_2010_8_10\":\"0\",\"wkEnroll\":\"1\",\"cal_val_2010_8_16\":\"0\",\"cal_val_2010_8_15\":\"0\",\"cal_val_2010_8_14\":\"0\",\"cal_val_2010_8_13\":\"0\",\"cal_val_2010_8_5\":\"0\",\"cal_val_2010_11_3\":\"0\",\"cal_val_2010_8_4\":\"0\",\"cal_val_2010_11_2\":\"0\",\"cal_val_2010_8_3\":\"0\",\"cal_val_2010_11_1\":\"0\",\"sectStatus\":\"-1\",\"cal_val_2010_8_2\":\"0\",\"cal_val_2010_8_9\":\"0\",\"cal_val_2010_8_8\":\"0\",\"cal_val_2010_8_7\":\"0\",\"wkChange\":\"1\",\"cal_val_2010_8_6\":\"0\",\"cal_val_2010_11_24\":\"0\",\"cal_val_2010_11_25\":\"0\",\"cal_val_2010_11_9\":\"0\",\"cal_val_2010_11_22\":\"0\",\"cal_val_2010_11_8\":\"0\",\"cal_val_2010_11_23\":\"0\",\"cal_val_2010_8_1\":\"0\",\"cal_val_2010_11_7\":\"0\",\"cal_val_2010_11_20\":\"0\",\"cal_val_2010_11_6\":\"0\",\"cal_val_2010_11_21\":\"0\",\"cal_val_2010_11_5\":\"0\",\"cal_val_2010_11_4\":\"0\",\"cal_val_2010_9_13\":\"0\",\"cal_val_2010_9_12\":\"0\",\"cal_val_2010_9_11\":\"0\",\"cal_val_2010_9_10\":\"0\",\"cal_val_2010_9_17\":\"0\",\"cal_val_2010_11_28\":\"0\",\"cal_val_2010_9_16\":\"0\",\"cal_val_2010_11_29\":\"0\",\"cal_val_2010_9_15\":\"0\",\"cal_val_2010_11_26\":\"0\",\"cal_val_2010_9_14\":\"0\",\"cal_val_2010_11_27\":\"0\",\"instructionalMethod\":\"-1\",\"cal_val_2010_8_29\":\"0\",\"cal_val_2010_8_28\":\"0\",\"cal_val_2010_11_31\":\"0\",\"cal_val_2010_11_30\":\"0\",\"cal_val_2010_9_9\":\"0\",\"cal_val_2010_8_30\":\"0\",\"cal_val_2010_10_4\":\"0\",\"cal_val_2010_10_3\":\"0\",\"cal_val_2010_10_2\":\"0\",\"cal_val_2010_10_1\":\"0\",\"cal_val_2010_9_29\":\"0\",\"cal_val_2010_10_9\":\"0\",\"cal_val_2010_10_8\":\"0\",\"cal_val_2010_10_7\":\"0\",\"cal_val_2010_10_6\":\"0\",\"cal_val_2010_10_5\":\"0\",\"cal_val_2010_10_30\":\"0\",\"classesEnd\":\"12/05/2010\",\"doit\":\"Update\",\"cal_val_2010_9_31\":\"0\",\"cal_val_2010_9_30\":\"0\",\"defaultDatePatternId\":\"\",\"academicTerm\":\"Primer semestre\",\"cal_val_2010_11_13\":\"0\",\"cal_val_2010_11_14\":\"0\",\"eventStart\":\"09/09/2019\",\"cal_val_2010_9_19\":\"0\",\"cal_val_2010_11_11\":\"0\",\"cal_val_2010_9_18\":\"0\",\"cal_val_2010_11_12\":\"0\",\"cal_val_2010_11_10\":\"0\",\"cal_val_2010_9_24\":\"0\",\"cal_val_2010_9_23\":\"0\",\"cal_val_2010_9_22\":\"0\",\"cal_val_2010_11_19\":\"0\",\"cal_val_2010_9_21\":\"0\",\"cal_val_2010_9_28\":\"0\",\"cal_val_2010_11_17\":\"0\",\"cal_val_2010_9_27\":\"0\",\"cal_val_2010_11_18\":\"0\",\"cal_val_2010_9_26\":\"0\",\"cal_val_2010_11_15\":\"0\",\"wkDrop\":\"1\",\"cal_val_2010_9_25\":\"0\",\"cal_val_2010_11_16\":\"0\",\"cal_val_2010_9_20\":\"0\"}',NULL),(1998919,'2019-05-20 06:44:01',0,'RPC:PageNameRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{\"name\":\"Edit Academic Session\"}',NULL),(1998920,'2019-05-20 06:44:01',6,'RPC:MenuRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998921,'2019-05-20 06:44:01',1,'RPC:SessionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998922,'2019-05-20 06:44:01',1,'RPC:UserInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998923,'2019-05-20 06:44:01',0,'RPC:VersionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998924,'2019-05-20 06:44:17',0,'RPC:PageNameRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{\"name\":\"Edit Academic Session\"}',NULL),(1998925,'2019-05-20 06:44:17',9,'RPC:MenuRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998926,'2019-05-20 06:44:17',1,'RPC:SessionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998927,'2019-05-20 06:44:17',0,'RPC:UserInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998928,'2019-05-20 06:44:17',0,'RPC:VersionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998929,'2019-05-20 06:44:34',0,'RPC:PageNameRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{\"name\":\"Edit Academic Session\"}',NULL),(1998930,'2019-05-20 06:44:34',9,'RPC:MenuRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998931,'2019-05-20 06:44:34',0,'RPC:SessionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998932,'2019-05-20 06:44:34',1,'RPC:UserInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998933,'2019-05-20 06:44:34',0,'RPC:VersionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998934,'2019-05-20 06:44:45',0,'RPC:PageNameRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{\"name\":\"Edit Academic Session\"}',NULL),(1998935,'2019-05-20 06:44:45',8,'RPC:MenuRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998936,'2019-05-20 06:44:45',1,'RPC:SessionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998937,'2019-05-20 06:44:45',1,'RPC:UserInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998938,'2019-05-20 06:44:45',0,'RPC:VersionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998939,'2019-05-20 06:44:56',0,'RPC:PageNameRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{\"name\":\"Edit Academic Session\"}',NULL),(1998940,'2019-05-20 06:44:56',8,'RPC:MenuRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998941,'2019-05-20 06:44:56',1,'RPC:SessionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998942,'2019-05-20 06:44:56',1,'RPC:UserInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998943,'2019-05-20 06:44:56',1,'RPC:VersionInfoRpcRequest',3,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1998944,'2019-05-20 06:44:17',61,'sessionEdit.do',0,'F6425B121216582512FEF4B160E80AD1','1','{\"sessionStart\":\"09/06/2010\",\"cal_val_2010_10_11\":\"0\",\"cal_val_2010_10_10\":\"0\",\"cal_val_2010_10_13\":\"0\",\"cal_val_2010_10_12\":\"0\",\"cal_val_2010_10_19\":\"0\",\"cal_val_2010_10_18\":\"0\",\"examStart\":\"12/06/2010\",\"academicYear\":\"2019\",\"cal_val_2010_10_15\":\"0\",\"cal_val_2010_10_14\":\"0\",\"cal_val_2010_10_17\":\"0\",\"cal_val_2010_10_16\":\"0\",\"cal_val_2010_10_22\":\"0\",\"cal_val_2010_10_21\":\"0\",\"cal_val_2010_10_24\":\"0\",\"cal_val_2010_10_23\":\"0\",\"cal_val_2010_10_20\":\"0\",\"cal_val_2010_10_29\":\"0\",\"cal_val_2010_10_26\":\"0\",\"cal_val_2010_10_25\":\"0\",\"cal_val_2010_10_28\":\"0\",\"cal_val_2010_10_27\":\"0\",\"academicInitiative\":\"EIIA\",\"status\":\"input\",\"cal_val_2010_9_4\":\"0\",\"cal_val_2010_9_3\":\"0\",\"cal_val_2010_9_2\":\"0\",\"cal_val_2010_9_1\":\"0\",\"cal_val_2010_9_8\":\"0\",\"cal_val_2010_9_7\":\"0\",\"cal_val_2010_9_6\":\"0\",\"cal_val_2010_9_5\":\"0\",\"cal_val_2010_8_19\":\"0\",\"cal_val_2010_8_18\":\"0\",\"cal_val_2010_8_17\":\"0\",\"durationType\":\"1703884\",\"cal_select\":\"0\",\"cal_val_2010_8_23\":\"0\",\"cal_val_2010_8_22\":\"0\",\"cal_val_2010_8_21\":\"0\",\"cal_val_2010_8_20\":\"0\",\"cal_val_2010_8_27\":\"0\",\"cal_val_2010_8_26\":\"0\",\"cal_val_2010_8_25\":\"0\",\"cal_val_2010_8_24\":\"0\",\"sessionEnd\":\"01/24/2020\",\"refresh\":\"1\",\"sessionId\":\"239259\",\"cal_val_2010_8_12\":\"0\",\"cal_val_2010_8_11\":\"0\",\"eventEnd\":\"01/24/2020\",\"cal_val_2010_8_10\":\"0\",\"wkEnroll\":\"1\",\"cal_val_2010_8_16\":\"0\",\"cal_val_2010_8_15\":\"0\",\"cal_val_2010_8_14\":\"0\",\"cal_val_2010_8_13\":\"0\",\"cal_val_2010_8_5\":\"0\",\"cal_val_2010_11_3\":\"0\",\"cal_val_2010_8_4\":\"0\",\"cal_val_2010_11_2\":\"0\",\"cal_val_2010_8_3\":\"0\",\"cal_val_2010_11_1\":\"0\",\"sectStatus\":\"-1\",\"cal_val_2010_8_2\":\"0\",\"cal_val_2010_8_9\":\"0\",\"cal_val_2010_8_8\":\"0\",\"cal_val_2010_8_7\":\"0\",\"wkChange\":\"1\",\"cal_val_2010_8_6\":\"0\",\"cal_val_2010_11_24\":\"0\",\"cal_val_2010_11_25\":\"0\",\"cal_val_2010_11_9\":\"0\",\"cal_val_2010_11_22\":\"0\",\"cal_val_2010_11_8\":\"0\",\"cal_val_2010_11_23\":\"0\",\"cal_val_2010_8_1\":\"0\",\"cal_val_2010_11_7\":\"0\",\"cal_val_2010_11_20\":\"0\",\"cal_val_2010_11_6\":\"0\",\"cal_val_2010_11_21\":\"0\",\"cal_val_2010_11_5\":\"0\",\"cal_val_2010_11_4\":\"0\",\"cal_val_2010_9_13\":\"0\",\"cal_val_2010_9_12\":\"0\",\"cal_val_2010_9_11\":\"0\",\"cal_val_2010_9_10\":\"0\",\"cal_val_2010_9_17\":\"0\",\"cal_val_2010_11_28\":\"0\",\"cal_val_2010_9_16\":\"0\",\"cal_val_2010_11_29\":\"0\",\"cal_val_2010_9_15\":\"0\",\"cal_val_2010_11_26\":\"0\",\"cal_val_2010_9_14\":\"0\",\"cal_val_2010_11_27\":\"0\",\"instructionalMethod\":\"-1\",\"cal_val_2010_8_29\":\"0\",\"cal_val_2010_8_28\":\"0\",\"cal_val_2010_11_31\":\"0\",\"cal_val_2010_11_30\":\"0\",\"cal_val_2010_9_9\":\"0\",\"cal_val_2010_8_30\":\"0\",\"cal_val_2010_10_4\":\"0\",\"cal_val_2010_10_3\":\"0\",\"cal_val_2010_10_2\":\"0\",\"cal_val_2010_10_1\":\"0\",\"cal_val_2010_9_29\":\"0\",\"cal_val_2010_10_9\":\"0\",\"cal_val_2010_10_8\":\"0\",\"cal_val_2010_10_7\":\"0\",\"cal_val_2010_10_6\":\"0\",\"cal_val_2010_10_5\":\"0\",\"cal_val_2010_10_30\":\"0\",\"classesEnd\":\"12/05/2010\",\"doit\":\"Update\",\"cal_val_2010_9_31\":\"0\",\"cal_val_2010_9_30\":\"0\",\"defaultDatePatternId\":\"\",\"academicTerm\":\"Primer semestre\",\"cal_val_2010_11_13\":\"0\",\"cal_val_2010_11_14\":\"0\",\"eventStart\":\"09/09/2019\",\"cal_val_2010_9_19\":\"0\",\"cal_val_2010_11_11\":\"0\",\"cal_val_2010_9_18\":\"0\",\"cal_val_2010_11_12\":\"0\",\"cal_val_2010_11_10\":\"0\",\"cal_val_2010_9_24\":\"0\",\"cal_val_2010_9_23\":\"0\",\"cal_val_2010_9_22\":\"0\",\"cal_val_2010_11_19\":\"0\",\"cal_val_2010_9_21\":\"0\",\"cal_val_2010_9_28\":\"0\",\"cal_val_2010_11_17\":\"0\",\"cal_val_2010_9_27\":\"0\",\"cal_val_2010_11_18\":\"0\",\"cal_val_2010_9_26\":\"0\",\"cal_val_2010_11_15\":\"0\",\"wkDrop\":\"1\",\"cal_val_2010_9_25\":\"0\",\"cal_val_2010_11_16\":\"0\",\"cal_val_2010_9_20\":\"0\"}',NULL),(1998945,'2019-05-20 06:44:33',82,'sessionEdit.do',0,'F6425B121216582512FEF4B160E80AD1','1','{\"sessionStart\":\"09/06/2010\",\"cal_val_2010_10_11\":\"0\",\"cal_val_2010_10_10\":\"0\",\"cal_val_2010_10_13\":\"0\",\"cal_val_2010_10_12\":\"0\",\"cal_val_2010_10_19\":\"0\",\"cal_val_2010_10_18\":\"0\",\"examStart\":\"01/08/2020\",\"academicYear\":\"2019\",\"cal_val_2010_10_15\":\"0\",\"cal_val_2010_10_14\":\"0\",\"cal_val_2010_10_17\":\"0\",\"cal_val_2010_10_16\":\"0\",\"cal_val_2010_10_22\":\"0\",\"cal_val_2010_10_21\":\"0\",\"cal_val_2010_10_24\":\"0\",\"cal_val_2010_10_23\":\"0\",\"cal_val_2010_10_20\":\"0\",\"cal_val_2010_10_29\":\"0\",\"cal_val_2010_10_26\":\"0\",\"cal_val_2010_10_25\":\"0\",\"cal_val_2010_10_28\":\"0\",\"cal_val_2010_10_27\":\"0\",\"academicInitiative\":\"EIIA\",\"status\":\"input\",\"cal_val_2010_9_4\":\"0\",\"cal_val_2010_9_3\":\"0\",\"cal_val_2010_9_2\":\"0\",\"cal_val_2010_9_1\":\"0\",\"cal_val_2010_9_8\":\"0\",\"cal_val_2010_9_7\":\"0\",\"cal_val_2010_9_6\":\"0\",\"cal_val_2010_9_5\":\"0\",\"cal_val_2010_8_19\":\"0\",\"cal_val_2010_8_18\":\"0\",\"cal_val_2010_8_17\":\"0\",\"durationType\":\"1703884\",\"cal_select\":\"0\",\"cal_val_2010_8_23\":\"0\",\"cal_val_2010_8_22\":\"0\",\"cal_val_2010_8_21\":\"0\",\"cal_val_2010_8_20\":\"0\",\"cal_val_2010_8_27\":\"0\",\"cal_val_2010_8_26\":\"0\",\"cal_val_2010_8_25\":\"0\",\"cal_val_2010_8_24\":\"0\",\"sessionEnd\":\"01/24/2020\",\"refresh\":\"1\",\"sessionId\":\"239259\",\"cal_val_2010_8_12\":\"0\",\"cal_val_2010_8_11\":\"0\",\"eventEnd\":\"01/24/2020\",\"cal_val_2010_8_10\":\"0\",\"wkEnroll\":\"1\",\"cal_val_2010_8_16\":\"0\",\"cal_val_2010_8_15\":\"0\",\"cal_val_2010_8_14\":\"0\",\"cal_val_2010_8_13\":\"0\",\"cal_val_2010_8_5\":\"0\",\"cal_val_2010_11_3\":\"0\",\"cal_val_2010_8_4\":\"0\",\"cal_val_2010_11_2\":\"0\",\"cal_val_2010_8_3\":\"0\",\"cal_val_2010_11_1\":\"0\",\"sectStatus\":\"-1\",\"cal_val_2010_8_2\":\"0\",\"cal_val_2010_8_9\":\"0\",\"cal_val_2010_8_8\":\"0\",\"cal_val_2010_8_7\":\"0\",\"wkChange\":\"1\",\"cal_val_2010_8_6\":\"0\",\"cal_val_2010_11_24\":\"0\",\"cal_val_2010_11_25\":\"0\",\"cal_val_2010_11_9\":\"0\",\"cal_val_2010_11_22\":\"0\",\"cal_val_2010_11_8\":\"0\",\"cal_val_2010_11_23\":\"0\",\"cal_val_2010_8_1\":\"0\",\"cal_val_2010_11_7\":\"0\",\"cal_val_2010_11_20\":\"0\",\"cal_val_2010_11_6\":\"0\",\"cal_val_2010_11_21\":\"0\",\"cal_val_2010_11_5\":\"0\",\"cal_val_2010_11_4\":\"0\",\"cal_val_2010_9_13\":\"0\",\"cal_val_2010_9_12\":\"0\",\"cal_val_2010_9_11\":\"0\",\"cal_val_2010_9_10\":\"0\",\"cal_val_2010_9_17\":\"0\",\"cal_val_2010_11_28\":\"0\",\"cal_val_2010_9_16\":\"0\",\"cal_val_2010_11_29\":\"0\",\"cal_val_2010_9_15\":\"0\",\"cal_val_2010_11_26\":\"0\",\"cal_val_2010_9_14\":\"0\",\"cal_val_2010_11_27\":\"0\",\"instructionalMethod\":\"-1\",\"cal_val_2010_8_29\":\"0\",\"cal_val_2010_8_28\":\"0\",\"cal_val_2010_11_31\":\"0\",\"cal_val_2010_11_30\":\"0\",\"cal_val_2010_9_9\":\"0\",\"cal_val_2010_8_30\":\"0\",\"cal_val_2010_10_4\":\"0\",\"cal_val_2010_10_3\":\"0\",\"cal_val_2010_10_2\":\"0\",\"cal_val_2010_10_1\":\"0\",\"cal_val_2010_9_29\":\"0\",\"cal_val_2010_10_9\":\"0\",\"cal_val_2010_10_8\":\"0\",\"cal_val_2010_10_7\":\"0\",\"cal_val_2010_10_6\":\"0\",\"cal_val_2010_10_5\":\"0\",\"cal_val_2010_10_30\":\"0\",\"classesEnd\":\"12/05/2010\",\"doit\":\"Update\",\"cal_val_2010_9_31\":\"0\",\"cal_val_2010_9_30\":\"0\",\"defaultDatePatternId\":\"\",\"academicTerm\":\"Primer semestre\",\"cal_val_2010_11_13\":\"0\",\"cal_val_2010_11_14\":\"0\",\"eventStart\":\"09/09/2019\",\"cal_val_2010_9_19\":\"0\",\"cal_val_2010_11_11\":\"0\",\"cal_val_2010_9_18\":\"0\",\"cal_val_2010_11_12\":\"0\",\"cal_val_2010_11_10\":\"0\",\"cal_val_2010_9_24\":\"0\",\"cal_val_2010_9_23\":\"0\",\"cal_val_2010_9_22\":\"0\",\"cal_val_2010_11_19\":\"0\",\"cal_val_2010_9_21\":\"0\",\"cal_val_2010_9_28\":\"0\",\"cal_val_2010_11_17\":\"0\",\"cal_val_2010_9_27\":\"0\",\"cal_val_2010_11_18\":\"0\",\"cal_val_2010_9_26\":\"0\",\"cal_val_2010_11_15\":\"0\",\"wkDrop\":\"1\",\"cal_val_2010_9_25\":\"0\",\"cal_val_2010_11_16\":\"0\",\"cal_val_2010_9_20\":\"0\"}',NULL),(1998946,'2019-05-20 06:44:44',64,'sessionEdit.do',0,'F6425B121216582512FEF4B160E80AD1','1','{\"sessionStart\":\"09/06/2010\",\"cal_val_2010_10_11\":\"0\",\"cal_val_2010_10_10\":\"0\",\"cal_val_2010_10_13\":\"0\",\"cal_val_2010_10_12\":\"0\",\"cal_val_2010_10_19\":\"0\",\"cal_val_2010_10_18\":\"0\",\"examStart\":\"01/08/2020\",\"academicYear\":\"2019\",\"cal_val_2010_10_15\":\"0\",\"cal_val_2010_10_14\":\"0\",\"cal_val_2010_10_17\":\"0\",\"cal_val_2010_10_16\":\"0\",\"cal_val_2010_10_22\":\"0\",\"cal_val_2010_10_21\":\"0\",\"cal_val_2010_10_24\":\"0\",\"cal_val_2010_10_23\":\"0\",\"cal_val_2010_10_20\":\"0\",\"cal_val_2010_10_29\":\"0\",\"cal_val_2010_10_26\":\"0\",\"cal_val_2010_10_25\":\"0\",\"cal_val_2010_10_28\":\"0\",\"cal_val_2010_10_27\":\"0\",\"academicInitiative\":\"EIIA\",\"status\":\"input\",\"cal_val_2010_9_4\":\"0\",\"cal_val_2010_9_3\":\"0\",\"cal_val_2010_9_2\":\"0\",\"cal_val_2010_9_1\":\"0\",\"cal_val_2010_9_8\":\"0\",\"cal_val_2010_9_7\":\"0\",\"cal_val_2010_9_6\":\"0\",\"cal_val_2010_9_5\":\"0\",\"cal_val_2010_8_19\":\"0\",\"cal_val_2010_8_18\":\"0\",\"cal_val_2010_8_17\":\"0\",\"durationType\":\"1703884\",\"cal_select\":\"0\",\"cal_val_2010_8_23\":\"0\",\"cal_val_2010_8_22\":\"0\",\"cal_val_2010_8_21\":\"0\",\"cal_val_2010_8_20\":\"0\",\"cal_val_2010_8_27\":\"0\",\"cal_val_2010_8_26\":\"0\",\"cal_val_2010_8_25\":\"0\",\"cal_val_2010_8_24\":\"0\",\"sessionEnd\":\"01/24/2020\",\"refresh\":\"1\",\"sessionId\":\"239259\",\"cal_val_2010_8_12\":\"0\",\"cal_val_2010_8_11\":\"0\",\"eventEnd\":\"01/24/2020\",\"cal_val_2010_8_10\":\"0\",\"wkEnroll\":\"1\",\"cal_val_2010_8_16\":\"0\",\"cal_val_2010_8_15\":\"0\",\"cal_val_2010_8_14\":\"0\",\"cal_val_2010_8_13\":\"0\",\"cal_val_2010_8_5\":\"0\",\"cal_val_2010_11_3\":\"0\",\"cal_val_2010_8_4\":\"0\",\"cal_val_2010_11_2\":\"0\",\"cal_val_2010_8_3\":\"0\",\"cal_val_2010_11_1\":\"0\",\"sectStatus\":\"-1\",\"cal_val_2010_8_2\":\"0\",\"cal_val_2010_8_9\":\"0\",\"cal_val_2010_8_8\":\"0\",\"cal_val_2010_8_7\":\"0\",\"wkChange\":\"1\",\"cal_val_2010_8_6\":\"0\",\"cal_val_2010_11_24\":\"0\",\"cal_val_2010_11_25\":\"0\",\"cal_val_2010_11_9\":\"0\",\"cal_val_2010_11_22\":\"0\",\"cal_val_2010_11_8\":\"0\",\"cal_val_2010_11_23\":\"0\",\"cal_val_2010_8_1\":\"0\",\"cal_val_2010_11_7\":\"0\",\"cal_val_2010_11_20\":\"0\",\"cal_val_2010_11_6\":\"0\",\"cal_val_2010_11_21\":\"0\",\"cal_val_2010_11_5\":\"0\",\"cal_val_2010_11_4\":\"0\",\"cal_val_2010_9_13\":\"0\",\"cal_val_2010_9_12\":\"0\",\"cal_val_2010_9_11\":\"0\",\"cal_val_2010_9_10\":\"0\",\"cal_val_2010_9_17\":\"0\",\"cal_val_2010_11_28\":\"0\",\"cal_val_2010_9_16\":\"0\",\"cal_val_2010_11_29\":\"0\",\"cal_val_2010_9_15\":\"0\",\"cal_val_2010_11_26\":\"0\",\"cal_val_2010_9_14\":\"0\",\"cal_val_2010_11_27\":\"0\",\"instructionalMethod\":\"-1\",\"cal_val_2010_8_29\":\"0\",\"cal_val_2010_8_28\":\"0\",\"cal_val_2010_11_31\":\"0\",\"cal_val_2010_11_30\":\"0\",\"cal_val_2010_9_9\":\"0\",\"cal_val_2010_8_30\":\"0\",\"cal_val_2010_10_4\":\"0\",\"cal_val_2010_10_3\":\"0\",\"cal_val_2010_10_2\":\"0\",\"cal_val_2010_10_1\":\"0\",\"cal_val_2010_9_29\":\"0\",\"cal_val_2010_10_9\":\"0\",\"cal_val_2010_10_8\":\"0\",\"cal_val_2010_10_7\":\"0\",\"cal_val_2010_10_6\":\"0\",\"cal_val_2010_10_5\":\"0\",\"cal_val_2010_10_30\":\"0\",\"classesEnd\":\"12/20/2019\",\"doit\":\"Update\",\"cal_val_2010_9_31\":\"0\",\"cal_val_2010_9_30\":\"0\",\"defaultDatePatternId\":\"\",\"academicTerm\":\"Primer semestre\",\"cal_val_2010_11_13\":\"0\",\"cal_val_2010_11_14\":\"0\",\"eventStart\":\"09/09/2019\",\"cal_val_2010_9_19\":\"0\",\"cal_val_2010_11_11\":\"0\",\"cal_val_2010_9_18\":\"0\",\"cal_val_2010_11_12\":\"0\",\"cal_val_2010_11_10\":\"0\",\"cal_val_2010_9_24\":\"0\",\"cal_val_2010_9_23\":\"0\",\"cal_val_2010_9_22\":\"0\",\"cal_val_2010_11_19\":\"0\",\"cal_val_2010_9_21\":\"0\",\"cal_val_2010_9_28\":\"0\",\"cal_val_2010_11_17\":\"0\",\"cal_val_2010_9_27\":\"0\",\"cal_val_2010_11_18\":\"0\",\"cal_val_2010_9_26\":\"0\",\"cal_val_2010_11_15\":\"0\",\"wkDrop\":\"1\",\"cal_val_2010_9_25\":\"0\",\"cal_val_2010_11_16\":\"0\",\"cal_val_2010_9_20\":\"0\"}',NULL),(1998947,'2019-05-20 06:44:56',56,'sessionEdit.do',0,'F6425B121216582512FEF4B160E80AD1','1','{\"sessionStart\":\"09/09/2019\",\"cal_val_2010_10_11\":\"0\",\"cal_val_2010_10_10\":\"0\",\"cal_val_2010_10_13\":\"0\",\"cal_val_2010_10_12\":\"0\",\"cal_val_2010_10_19\":\"0\",\"cal_val_2010_10_18\":\"0\",\"examStart\":\"01/08/2020\",\"academicYear\":\"2019\",\"cal_val_2010_10_15\":\"0\",\"cal_val_2010_10_14\":\"0\",\"cal_val_2010_10_17\":\"0\",\"cal_val_2010_10_16\":\"0\",\"cal_val_2010_10_22\":\"0\",\"cal_val_2010_10_21\":\"0\",\"cal_val_2010_10_24\":\"0\",\"cal_val_2010_10_23\":\"0\",\"cal_val_2010_10_20\":\"0\",\"cal_val_2010_10_29\":\"0\",\"cal_val_2010_10_26\":\"0\",\"cal_val_2010_10_25\":\"0\",\"cal_val_2010_10_28\":\"0\",\"cal_val_2010_10_27\":\"0\",\"academicInitiative\":\"EIIA\",\"status\":\"input\",\"cal_val_2010_9_4\":\"0\",\"cal_val_2010_9_3\":\"0\",\"cal_val_2010_9_2\":\"0\",\"cal_val_2010_9_1\":\"0\",\"cal_val_2010_9_8\":\"0\",\"cal_val_2010_9_7\":\"0\",\"cal_val_2010_9_6\":\"0\",\"cal_val_2010_9_5\":\"0\",\"cal_val_2010_8_19\":\"0\",\"cal_val_2010_8_18\":\"0\",\"cal_val_2010_8_17\":\"0\",\"durationType\":\"1703884\",\"cal_select\":\"0\",\"cal_val_2010_8_23\":\"0\",\"cal_val_2010_8_22\":\"0\",\"cal_val_2010_8_21\":\"0\",\"cal_val_2010_8_20\":\"0\",\"cal_val_2010_8_27\":\"0\",\"cal_val_2010_8_26\":\"0\",\"cal_val_2010_8_25\":\"0\",\"cal_val_2010_8_24\":\"0\",\"sessionEnd\":\"01/24/2020\",\"refresh\":\"1\",\"sessionId\":\"239259\",\"cal_val_2010_8_12\":\"0\",\"cal_val_2010_8_11\":\"0\",\"eventEnd\":\"01/24/2020\",\"cal_val_2010_8_10\":\"0\",\"wkEnroll\":\"1\",\"cal_val_2010_8_16\":\"0\",\"cal_val_2010_8_15\":\"0\",\"cal_val_2010_8_14\":\"0\",\"cal_val_2010_8_13\":\"0\",\"cal_val_2010_8_5\":\"0\",\"cal_val_2010_11_3\":\"0\",\"cal_val_2010_8_4\":\"0\",\"cal_val_2010_11_2\":\"0\",\"cal_val_2010_8_3\":\"0\",\"cal_val_2010_11_1\":\"0\",\"sectStatus\":\"-1\",\"cal_val_2010_8_2\":\"0\",\"cal_val_2010_8_9\":\"0\",\"cal_val_2010_8_8\":\"0\",\"cal_val_2010_8_7\":\"0\",\"wkChange\":\"1\",\"cal_val_2010_8_6\":\"0\",\"cal_val_2010_11_24\":\"0\",\"cal_val_2010_11_25\":\"0\",\"cal_val_2010_11_9\":\"0\",\"cal_val_2010_11_22\":\"0\",\"cal_val_2010_11_8\":\"0\",\"cal_val_2010_11_23\":\"0\",\"cal_val_2010_8_1\":\"0\",\"cal_val_2010_11_7\":\"0\",\"cal_val_2010_11_20\":\"0\",\"cal_val_2010_11_6\":\"0\",\"cal_val_2010_11_21\":\"0\",\"cal_val_2010_11_5\":\"0\",\"cal_val_2010_11_4\":\"0\",\"cal_val_2010_9_13\":\"0\",\"cal_val_2010_9_12\":\"0\",\"cal_val_2010_9_11\":\"0\",\"cal_val_2010_9_10\":\"0\",\"cal_val_2010_9_17\":\"0\",\"cal_val_2010_11_28\":\"0\",\"cal_val_2010_9_16\":\"0\",\"cal_val_2010_11_29\":\"0\",\"cal_val_2010_9_15\":\"0\",\"cal_val_2010_11_26\":\"0\",\"cal_val_2010_9_14\":\"0\",\"cal_val_2010_11_27\":\"0\",\"instructionalMethod\":\"-1\",\"cal_val_2010_8_29\":\"0\",\"cal_val_2010_8_28\":\"0\",\"cal_val_2010_11_31\":\"0\",\"cal_val_2010_11_30\":\"0\",\"cal_val_2010_9_9\":\"0\",\"cal_val_2010_8_30\":\"0\",\"cal_val_2010_10_4\":\"0\",\"cal_val_2010_10_3\":\"0\",\"cal_val_2010_10_2\":\"0\",\"cal_val_2010_10_1\":\"0\",\"cal_val_2010_9_29\":\"0\",\"cal_val_2010_10_9\":\"0\",\"cal_val_2010_10_8\":\"0\",\"cal_val_2010_10_7\":\"0\",\"cal_val_2010_10_6\":\"0\",\"cal_val_2010_10_5\":\"0\",\"cal_val_2010_10_30\":\"0\",\"classesEnd\":\"12/20/2019\",\"doit\":\"Update\",\"cal_val_2010_9_31\":\"0\",\"cal_val_2010_9_30\":\"0\",\"defaultDatePatternId\":\"\",\"academicTerm\":\"Primer semestre\",\"cal_val_2010_11_13\":\"0\",\"cal_val_2010_11_14\":\"0\",\"eventStart\":\"09/09/2019\",\"cal_val_2010_9_19\":\"0\",\"cal_val_2010_11_11\":\"0\",\"cal_val_2010_9_18\":\"0\",\"cal_val_2010_11_12\":\"0\",\"cal_val_2010_11_10\":\"0\",\"cal_val_2010_9_24\":\"0\",\"cal_val_2010_9_23\":\"0\",\"cal_val_2010_9_22\":\"0\",\"cal_val_2010_11_19\":\"0\",\"cal_val_2010_9_21\":\"0\",\"cal_val_2010_9_28\":\"0\",\"cal_val_2010_11_17\":\"0\",\"cal_val_2010_9_27\":\"0\",\"cal_val_2010_11_18\":\"0\",\"cal_val_2010_9_26\":\"0\",\"cal_val_2010_11_15\":\"0\",\"wkDrop\":\"1\",\"cal_val_2010_9_25\":\"0\",\"cal_val_2010_11_16\":\"0\",\"cal_val_2010_9_20\":\"0\"}',NULL),(1998948,'2019-05-20 06:45:01',103,'sessionEdit.do',0,'F6425B121216582512FEF4B160E80AD1','1','{\"cal_val_2019_10_9\":\"0\",\"cal_val_2019_10_8\":\"0\",\"cal_val_2019_10_7\":\"0\",\"sessionStart\":\"09/09/2019\",\"cal_val_2019_10_6\":\"0\",\"cal_val_2019_9_31\":\"0\",\"cal_val_2019_9_30\":\"0\",\"examStart\":\"01/08/2020\",\"academicYear\":\"2019\",\"academicInitiative\":\"EIIA\",\"status\":\"input\",\"cal_val_2019_11_29\":\"0\",\"cal_val_2019_11_27\":\"0\",\"cal_val_2019_11_28\":\"0\",\"cal_val_2019_11_25\":\"0\",\"cal_val_2019_11_26\":\"0\",\"cal_val_2019_11_23\":\"0\",\"cal_val_2019_11_24\":\"0\",\"cal_val_2019_11_21\":\"0\",\"cal_val_2019_11_22\":\"0\",\"durationType\":\"1703884\",\"cal_val_2019_11_20\":\"0\",\"cal_select\":\"0\",\"sessionEnd\":\"01/24/2020\",\"refresh\":\"\",\"sessionId\":\"239259\",\"cal_val_2019_11_30\":\"0\",\"cal_val_2019_11_31\":\"0\",\"cal_val_2019_8_16\":\"0\",\"cal_val_2019_8_17\":\"0\",\"eventEnd\":\"01/24/2020\",\"cal_val_2019_8_14\":\"0\",\"wkEnroll\":\"1\",\"cal_val_2019_8_15\":\"0\",\"cal_val_2019_8_12\":\"0\",\"cal_val_2019_8_13\":\"0\",\"cal_val_2019_8_10\":\"0\",\"cal_val_2019_8_11\":\"0\",\"cal_val_2019_8_18\":\"0\",\"cal_val_2019_8_19\":\"0\",\"sectStatus\":\"-1\",\"wkChange\":\"1\",\"cal_val_2019_8_20\":\"0\",\"cal_val_2019_10_30\":\"0\",\"cal_val_2019_8_27\":\"0\",\"cal_val_2019_8_28\":\"0\",\"cal_val_2019_8_25\":\"0\",\"cal_val_2019_8_26\":\"0\",\"cal_val_2019_8_23\":\"0\",\"cal_val_2019_8_24\":\"0\",\"cal_val_2019_8_21\":\"0\",\"cal_val_2019_8_22\":\"0\",\"instructionalMethod\":\"-1\",\"cal_val_2019_8_29\":\"0\",\"cal_val_2020_0_2\":\"0\",\"cal_val_2020_0_1\":\"0\",\"cal_val_2019_11_18\":\"0\",\"cal_val_2019_11_19\":\"0\",\"cal_val_2019_11_16\":\"0\",\"cal_val_2020_0_17\":\"0\",\"cal_val_2019_11_17\":\"0\",\"cal_val_2020_0_16\":\"0\",\"cal_val_2019_11_14\":\"0\",\"cal_val_2020_0_19\":\"0\",\"cal_val_2019_11_15\":\"0\",\"cal_val_2020_0_18\":\"0\",\"cal_val_2019_8_30\":\"0\",\"cal_val_2019_11_12\":\"0\",\"cal_val_2020_0_13\":\"0\",\"cal_val_2019_11_13\":\"0\",\"cal_val_2020_0_12\":\"0\",\"cal_val_2019_11_10\":\"0\",\"cal_val_2020_0_15\":\"0\",\"cal_val_2019_11_11\":\"0\",\"cal_val_2020_0_14\":\"0\",\"cal_val_2020_0_11\":\"0\",\"cal_val_2020_0_10\":\"0\",\"cal_val_2019_9_8\":\"0\",\"cal_val_2019_9_9\":\"0\",\"cal_val_2019_9_2\":\"0\",\"cal_val_2019_9_3\":\"0\",\"cal_val_2020_0_9\":\"0\",\"cal_val_2020_0_8\":\"0\",\"cal_val_2019_9_1\":\"0\",\"cal_val_2020_0_7\":\"0\",\"cal_val_2019_9_6\":\"0\",\"cal_val_2019_11_4\":\"0\",\"cal_val_2020_0_6\":\"0\",\"cal_val_2019_9_7\":\"0\",\"cal_val_2019_11_3\":\"0\",\"cal_val_2020_0_5\":\"0\",\"cal_val_2019_9_4\":\"0\",\"cal_val_2019_11_2\":\"0\",\"cal_val_2020_0_4\":\"0\",\"cal_val_2019_9_5\":\"0\",\"cal_val_2019_11_1\":\"0\",\"cal_val_2020_0_3\":\"0\",\"cal_val_2019_10_18\":\"0\",\"cal_val_2019_11_8\":\"0\",\"cal_val_2019_10_17\":\"0\",\"cal_val_2019_11_7\":\"0\",\"cal_val_2019_11_6\":\"0\",\"cal_val_2019_10_19\":\"0\",\"cal_val_2019_11_5\":\"0\",\"cal_val_2019_10_14\":\"0\",\"cal_val_2020_0_28\":\"0\",\"cal_val_2019_10_13\":\"0\",\"cal_val_2020_0_27\":\"0\",\"cal_val_2019_10_16\":\"0\",\"cal_val_2019_10_15\":\"0\",\"cal_val_2019_11_9\":\"0\",\"cal_val_2020_0_29\":\"0\",\"cal_val_2019_9_10\":\"0\",\"cal_val_2019_10_10\":\"0\",\"cal_val_2020_0_24\":\"0\",\"cal_val_2020_0_23\":\"0\",\"cal_val_2019_10_12\":\"0\",\"cal_val_2020_0_26\":\"0\",\"cal_val_2019_10_11\":\"0\",\"cal_val_2020_0_25\":\"0\",\"cal_val_2020_0_20\":\"0\",\"cal_val_2020_0_22\":\"0\",\"cal_val_2020_0_21\":\"0\",\"cal_val_2019_9_18\":\"0\",\"cal_val_2019_9_17\":\"0\",\"cal_val_2019_9_16\":\"0\",\"classesEnd\":\"12/20/2019\",\"cal_val_2019_9_15\":\"0\",\"cal_val_2019_9_14\":\"0\",\"cal_val_2019_9_13\":\"0\",\"cal_val_2019_9_12\":\"0\",\"cal_val_2019_9_11\":\"0\",\"doit\":\"Update\",\"cal_val_2019_9_19\":\"0\",\"cal_val_2019_10_29\":\"0\",\"cal_val_2019_10_28\":\"0\",\"defaultDatePatternId\":\"\",\"cal_val_2019_10_25\":\"0\",\"cal_val_2019_10_24\":\"0\",\"academicTerm\":\"Primer semestre\",\"cal_val_2019_10_27\":\"0\",\"cal_val_2019_10_26\":\"0\",\"cal_val_2019_9_21\":\"0\",\"cal_val_2019_10_21\":\"0\",\"cal_val_2019_9_20\":\"0\",\"cal_val_2019_10_20\":\"0\",\"eventStart\":\"09/09/2019\",\"cal_val_2019_10_23\":\"0\",\"cal_val_2019_10_22\":\"0\",\"cal_val_2020_0_31\":\"0\",\"cal_val_2020_0_30\":\"0\",\"cal_val_2019_9_29\":\"0\",\"cal_val_2019_9_28\":\"0\",\"cal_val_2019_8_9\":\"0\",\"cal_val_2019_9_27\":\"0\",\"cal_val_2019_9_26\":\"0\",\"cal_val_2019_9_25\":\"0\",\"cal_val_2019_9_24\":\"0\",\"cal_val_2019_9_23\":\"0\",\"wkDrop\":\"1\",\"cal_val_2019_9_22\":\"0\",\"cal_val_2019_8_3\":\"0\",\"cal_val_2019_10_1\":\"0\",\"cal_val_2019_8_4\":\"0\",\"cal_val_2019_8_1\":\"0\",\"cal_val_2019_8_2\":\"0\",\"cal_val_2019_8_7\":\"0\",\"cal_val_2019_10_5\":\"0\",\"cal_val_2019_8_8\":\"0\",\"cal_val_2019_10_4\":\"0\",\"cal_val_2019_8_5\":\"0\",\"cal_val_2019_10_3\":\"0\",\"cal_val_2019_8_6\":\"0\",\"cal_val_2019_10_2\":\"0\"}',NULL),(1998949,'2019-05-20 06:45:01',30,'sessionList.do',0,'F6425B121216582512FEF4B160E80AD1','1','{}',NULL),(1999060,'2019-05-20 06:49:13',42,'timetableManagerEdit.do',0,'42CB4C373C6AC19D0F58128E604FC824','1','{\"lastName\":\"Moya\",\"op\":\"Add Role\",\"roles[0]\":\"1\",\"roleRefs[0]\":\"System Administrator\",\"role\":\"101\",\"deptLabels[0]\":\"EIIA - Planificación docente\",\"deleteType\":\"\",\"externalId\":\"1\",\"solverGr\":\"\",\"dept\":\"\",\"title\":\"\",\"op1\":\"2\",\"firstName\":\"Francisco\",\"primaryRole\":\"1\",\"roleReceiveEmailFlags[0]\":\"on\",\"middleName\":\"\",\"depts[0]\":\"2162688\",\"lookupEnabled\":\"false\",\"deleteId\":\"\",\"uniqueId\":\"470\",\"email\":\"francisco.moya@uclm.es\"}',NULL),(1999061,'2019-05-20 06:49:19',54,'timetableManagerEdit.do',0,'42CB4C373C6AC19D0F58128E604FC824','1','{\"lastName\":\"Moya\",\"roleRefs[1]\":\"Curriculum Manager\",\"op\":\"Update\",\"roles[0]\":\"1\",\"roleRefs[0]\":\"System Administrator\",\"role\":\"101\",\"roles[1]\":\"101\",\"deptLabels[0]\":\"EIIA - Planificación docente\",\"deleteType\":\"\",\"externalId\":\"1\",\"solverGr\":\"\",\"dept\":\"\",\"title\":\"\",\"roleReceiveEmailFlags[1]\":\"on\",\"op1\":\"2\",\"firstName\":\"Francisco\",\"primaryRole\":\"1\",\"roleReceiveEmailFlags[0]\":\"on\",\"middleName\":\"\",\"depts[0]\":\"2162688\",\"lookupEnabled\":\"false\",\"deleteId\":\"\",\"uniqueId\":\"470\",\"email\":\"francisco.moya@uclm.es\"}',NULL),(1999062,'2019-05-20 06:49:29',48,'timetableManagerEdit.do',0,'42CB4C373C6AC19D0F58128E604FC824','1','{\"op\":\"Edit\",\"id\":\"470\"}',NULL),(2162688,'2019-05-20 06:50:45',227,'login.do',0,'B1F44743565F92FF7CBE6476F40F3267','','{}',NULL),(2162689,'2019-05-20 06:50:48',709,'selectPrimaryRole.do',0,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162690,'2019-05-20 06:50:56',216,'timetableManagerList.do',0,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162691,'2019-05-20 06:51:01',135,'timetableManagerEdit.do',0,'157B49A3028753A266C04BD886DBF2DF','1','{\"op\":\"Edit\",\"id\":\"470\"}',NULL),(2162692,'2019-05-20 06:50:46',1,'RPC:VersionInfoRpcRequest',3,'B1F44743565F92FF7CBE6476F40F3267','','{}',NULL),(2162693,'2019-05-20 06:50:46',40,'RPC:MenuRpcRequest',3,'B1F44743565F92FF7CBE6476F40F3267','','{}',NULL),(2162694,'2019-05-20 06:50:48',1,'RPC:IsSessionBusyRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162695,'2019-05-20 06:50:49',1,'RPC:PageNameRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{\"name\":\"University Timetabling Application\"}',NULL),(2162696,'2019-05-20 06:50:49',0,'RPC:VersionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162697,'2019-05-20 06:50:49',13,'RPC:UserInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162698,'2019-05-20 06:50:49',26,'RPC:SessionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162699,'2019-05-20 06:50:49',187,'RPC:MenuRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162700,'2019-05-20 06:50:57',0,'RPC:PageNameRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{\"name\":\"Timetable Managers\"}',NULL),(2162701,'2019-05-20 06:50:57',1,'RPC:SessionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162702,'2019-05-20 06:50:57',2,'RPC:UserInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162703,'2019-05-20 06:50:57',0,'RPC:VersionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162704,'2019-05-20 06:50:57',38,'RPC:MenuRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162705,'2019-05-20 06:51:01',0,'RPC:PageNameRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{\"name\":\"Edit Timetable Manager\"}',NULL),(2162706,'2019-05-20 06:51:01',2,'RPC:SessionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162707,'2019-05-20 06:51:01',0,'RPC:VersionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162708,'2019-05-20 06:51:01',2,'RPC:UserInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162709,'2019-05-20 06:51:01',36,'RPC:MenuRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162710,'2019-05-20 06:51:09',178,'RPC:LookupRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{\"query\":\"Deafult Admin\",\"options\":\"mustHaveExternalId\"}',NULL),(2162711,'2019-05-20 06:51:55',71,'userEdit.do',0,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162712,'2019-05-20 06:51:59',19,'userEdit.do',0,'157B49A3028753A266C04BD886DBF2DF','1','{\"op\":\"Add User\"}',NULL),(2162713,'2019-05-20 06:52:18',35,'userEdit.do',0,'157B49A3028753A266C04BD886DBF2DF','1','{\"op\":\"Back\",\"name\":\"admin\",\"externalId\":\"\"}',NULL),(2162714,'2019-05-20 06:52:22',41,'timetableManagerList.do',0,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162715,'2019-05-20 06:52:24',49,'timetableManagerEdit.do',0,'157B49A3028753A266C04BD886DBF2DF','1','{\"op\":\"Edit\",\"id\":\"470\"}',NULL),(2162716,'2019-05-20 06:52:31',94,'timetableManagerEdit.do',0,'157B49A3028753A266C04BD886DBF2DF','1','{\"op\":\"Update\",\"lastName\":\"Admin\",\"roles[0]\":\"1\",\"roleRefs[0]\":\"System Administrator\",\"role\":\"\",\"deleteType\":\"\",\"externalId\":\"1\",\"solverGr\":\"\",\"dept\":\"\",\"title\":\"\",\"op1\":\"2\",\"firstName\":\"Default\",\"primaryRole\":\"1\",\"roleReceiveEmailFlags[0]\":\"on\",\"middleName\":\"\",\"lookupEnabled\":\"false\",\"deleteId\":\"\",\"uniqueId\":\"470\",\"email\":\"demo@unitime.org\"}',NULL),(2162717,'2019-05-20 06:52:36',3,'login.do',0,'56B8F03FA590C0AF105893AF7E0F96B1','','{}',NULL),(2162718,'2019-05-20 06:52:38',7,'selectPrimaryRole.do',0,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162719,'2019-05-20 06:51:56',0,'RPC:PageNameRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{\"name\":\"Users (Database Authentication)\"}',NULL),(2162720,'2019-05-20 06:51:56',1,'RPC:SessionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162721,'2019-05-20 06:51:56',1,'RPC:UserInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162722,'2019-05-20 06:51:56',0,'RPC:VersionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162723,'2019-05-20 06:51:56',39,'RPC:MenuRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162724,'2019-05-20 06:52:00',0,'RPC:PageNameRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{\"name\":\"Add User\"}',NULL),(2162725,'2019-05-20 06:52:00',1,'RPC:SessionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162726,'2019-05-20 06:52:00',1,'RPC:UserInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162727,'2019-05-20 06:52:00',1,'RPC:VersionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162728,'2019-05-20 06:52:00',24,'RPC:MenuRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162729,'2019-05-20 06:52:18',0,'RPC:PageNameRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{\"name\":\"Users (Database Authentication)\"}',NULL),(2162730,'2019-05-20 06:52:18',1,'RPC:SessionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162731,'2019-05-20 06:52:18',17,'RPC:MenuRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162732,'2019-05-20 06:52:18',0,'RPC:VersionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162733,'2019-05-20 06:52:18',1,'RPC:UserInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162734,'2019-05-20 06:52:23',0,'RPC:PageNameRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{\"name\":\"Timetable Managers\"}',NULL),(2162735,'2019-05-20 06:52:23',1,'RPC:SessionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162736,'2019-05-20 06:52:23',22,'RPC:MenuRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162737,'2019-05-20 06:52:23',0,'RPC:VersionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162738,'2019-05-20 06:52:23',0,'RPC:UserInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162739,'2019-05-20 06:52:24',0,'RPC:PageNameRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{\"name\":\"Edit Timetable Manager\"}',NULL),(2162740,'2019-05-20 06:52:24',13,'RPC:MenuRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162741,'2019-05-20 06:52:24',1,'RPC:SessionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162742,'2019-05-20 06:52:24',0,'RPC:UserInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162743,'2019-05-20 06:52:24',0,'RPC:VersionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162744,'2019-05-20 06:52:31',0,'RPC:PageNameRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{\"name\":\"Timetable Managers\"}',NULL),(2162745,'2019-05-20 06:52:31',14,'RPC:MenuRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162746,'2019-05-20 06:52:31',1,'RPC:UserInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162747,'2019-05-20 06:52:31',3,'RPC:SessionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162748,'2019-05-20 06:52:31',1,'RPC:VersionInfoRpcRequest',3,'157B49A3028753A266C04BD886DBF2DF','1','{}',NULL),(2162749,'2019-05-20 06:52:37',2,'RPC:MenuRpcRequest',3,'56B8F03FA590C0AF105893AF7E0F96B1','','{}',NULL),(2162750,'2019-05-20 06:52:37',0,'RPC:VersionInfoRpcRequest',3,'56B8F03FA590C0AF105893AF7E0F96B1','','{}',NULL),(2162751,'2019-05-20 06:52:39',0,'RPC:PageNameRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{\"name\":\"University Timetabling Application\"}',NULL),(2162752,'2019-05-20 06:52:39',10,'RPC:MenuRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162753,'2019-05-20 06:52:39',1,'RPC:SessionInfoRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162754,'2019-05-20 06:52:39',0,'RPC:UserInfoRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162755,'2019-05-20 06:52:39',0,'RPC:VersionInfoRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162756,'2019-05-20 06:53:00',44,'timetableManagerList.do',0,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162757,'2019-05-20 06:53:05',92,'timetableManagerEdit.do',0,'6E10157EED578C41AD6CE281CA49BF36','1','{\"op\":\"Edit\",\"id\":\"470\"}',NULL),(2162758,'2019-05-20 06:53:15',72,'timetableManagerEdit.do',0,'6E10157EED578C41AD6CE281CA49BF36','1','{\"lastName\":\"Admin\",\"op\":\"Update\",\"roles[0]\":\"1\",\"roleRefs[0]\":\"System Administrator\",\"role\":\"\",\"deleteType\":\"\",\"externalId\":\"1\",\"solverGr\":\"\",\"dept\":\"\",\"title\":\"\",\"op1\":\"2\",\"firstName\":\"Default\",\"primaryRole\":\"1\",\"roleReceiveEmailFlags[0]\":\"on\",\"middleName\":\"\",\"lookupEnabled\":\"false\",\"deleteId\":\"\",\"uniqueId\":\"470\",\"email\":\"francisco.moya@uclm.es\"}',NULL),(2162759,'2019-05-20 06:53:24',2,'login.do',0,'F78D69E1B36A893D5A4486C5A3054248','','{}',NULL),(2162760,'2019-05-20 06:53:26',5,'selectPrimaryRole.do',0,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162761,'2019-05-20 06:53:40',44,'timetableManagerList.do',0,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162762,'2019-05-20 06:53:00',0,'RPC:PageNameRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{\"name\":\"Timetable Managers\"}',NULL),(2162763,'2019-05-20 06:53:00',8,'RPC:MenuRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162764,'2019-05-20 06:53:00',1,'RPC:SessionInfoRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162765,'2019-05-20 06:53:00',1,'RPC:UserInfoRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162766,'2019-05-20 06:53:00',0,'RPC:VersionInfoRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162767,'2019-05-20 06:53:05',0,'RPC:PageNameRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{\"name\":\"Edit Timetable Manager\"}',NULL),(2162768,'2019-05-20 06:53:05',9,'RPC:MenuRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162769,'2019-05-20 06:53:05',1,'RPC:SessionInfoRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162770,'2019-05-20 06:53:05',1,'RPC:UserInfoRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162771,'2019-05-20 06:53:05',0,'RPC:VersionInfoRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162772,'2019-05-20 06:53:15',0,'RPC:PageNameRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{\"name\":\"Timetable Managers\"}',NULL),(2162773,'2019-05-20 06:53:15',10,'RPC:MenuRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162774,'2019-05-20 06:53:15',1,'RPC:SessionInfoRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162775,'2019-05-20 06:53:15',0,'RPC:UserInfoRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162776,'2019-05-20 06:53:15',0,'RPC:VersionInfoRpcRequest',3,'6E10157EED578C41AD6CE281CA49BF36','1','{}',NULL),(2162777,'2019-05-20 06:53:24',1,'RPC:MenuRpcRequest',3,'F78D69E1B36A893D5A4486C5A3054248','','{}',NULL),(2162778,'2019-05-20 06:53:24',0,'RPC:VersionInfoRpcRequest',3,'F78D69E1B36A893D5A4486C5A3054248','','{}',NULL),(2162779,'2019-05-20 06:53:27',0,'RPC:PageNameRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{\"name\":\"University Timetabling Application\"}',NULL),(2162780,'2019-05-20 06:53:27',8,'RPC:MenuRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162781,'2019-05-20 06:53:27',1,'RPC:SessionInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162782,'2019-05-20 06:53:27',1,'RPC:UserInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162783,'2019-05-20 06:53:27',1,'RPC:VersionInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162784,'2019-05-20 06:53:41',0,'RPC:PageNameRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{\"name\":\"Timetable Managers\"}',NULL),(2162785,'2019-05-20 06:53:41',6,'RPC:MenuRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162786,'2019-05-20 06:53:41',1,'RPC:SessionInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162787,'2019-05-20 06:53:41',1,'RPC:UserInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162788,'2019-05-20 06:53:41',0,'RPC:VersionInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162789,'2019-05-20 06:53:44',0,'RPC:PageNameRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{\"name\":\"Edit Timetable Manager\"}',NULL),(2162790,'2019-05-20 06:53:44',11,'RPC:MenuRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162791,'2019-05-20 06:53:44',0,'RPC:SessionInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162792,'2019-05-20 06:53:44',1,'RPC:UserInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162793,'2019-05-20 06:53:44',0,'RPC:VersionInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162794,'2019-05-20 06:53:43',59,'timetableManagerEdit.do',0,'C0C8C79A2147FBAE0BB761684A078D43','1','{\"op\":\"Edit\",\"id\":\"470\"}',NULL),(2162795,'2019-05-20 06:54:05',34,'departmentList.do',0,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162796,'2019-05-20 06:54:08',74,'departmentEdit.do',0,'C0C8C79A2147FBAE0BB761684A078D43','1','{\"op\":\"Add Department\"}',NULL),(2162797,'2019-05-20 06:54:05',0,'RPC:PageNameRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{\"name\":\"Departments\"}',NULL),(2162798,'2019-05-20 06:54:05',8,'RPC:MenuRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162799,'2019-05-20 06:54:05',1,'RPC:SessionInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162800,'2019-05-20 06:54:05',0,'RPC:UserInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162801,'2019-05-20 06:54:05',0,'RPC:VersionInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162802,'2019-05-20 06:54:08',0,'RPC:PageNameRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{\"name\":\"Add Department\"}',NULL),(2162803,'2019-05-20 06:54:08',9,'RPC:MenuRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162804,'2019-05-20 06:54:08',1,'RPC:SessionInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162805,'2019-05-20 06:54:08',1,'RPC:UserInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162806,'2019-05-20 06:54:08',1,'RPC:VersionInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162807,'2019-05-20 06:55:23',113,'departmentEdit.do',0,'C0C8C79A2147FBAE0BB761684A078D43','1','{\"op\":\"Save\",\"allowStudentScheduling\":\"on\",\"statusType\":\"\",\"externalId\":\"\",\"extAbbv\":\"\",\"sessionId\":\"239259\",\"extName\":\"\",\"inheritInstructorPreferences\":\"on\",\"abbv\":\"Ac\",\"name\":\"Planificación docente\",\"distPrefPriority\":\"0\",\"id\":\"\",\"fullyEditable\":\"true\",\"deptCode\":\"EIIA\"}',NULL),(2162808,'2019-05-20 06:55:28',4,'login.do',0,'4DD8FAD3518DC436CD81CCE214147962','','{}',NULL),(2162809,'2019-05-20 06:55:30',3,'selectPrimaryRole.do',0,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162810,'2019-05-20 06:55:38',38,'timetableManagerList.do',0,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162811,'2019-05-20 06:55:40',48,'timetableManagerEdit.do',0,'480CD914828840D59517386A65F478BC','1','{\"op\":\"Edit\",\"id\":\"470\"}',NULL),(2162812,'2019-05-20 06:55:24',0,'RPC:PageNameRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{\"name\":\"Departments\"}',NULL),(2162813,'2019-05-20 06:55:24',1,'RPC:SessionInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162814,'2019-05-20 06:55:24',1,'RPC:UserInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162815,'2019-05-20 06:55:24',0,'RPC:VersionInfoRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162816,'2019-05-20 06:55:24',136,'RPC:MenuRpcRequest',3,'C0C8C79A2147FBAE0BB761684A078D43','1','{}',NULL),(2162817,'2019-05-20 06:55:28',5,'RPC:MenuRpcRequest',3,'4DD8FAD3518DC436CD81CCE214147962','','{}',NULL),(2162818,'2019-05-20 06:55:28',0,'RPC:VersionInfoRpcRequest',3,'4DD8FAD3518DC436CD81CCE214147962','','{}',NULL),(2162819,'2019-05-20 06:55:31',0,'RPC:PageNameRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{\"name\":\"University Timetabling Application\"}',NULL),(2162820,'2019-05-20 06:55:31',1,'RPC:SessionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162821,'2019-05-20 06:55:31',1,'RPC:UserInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162822,'2019-05-20 06:55:31',0,'RPC:VersionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162823,'2019-05-20 06:55:31',106,'RPC:MenuRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162824,'2019-05-20 06:55:38',0,'RPC:PageNameRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{\"name\":\"Timetable Managers\"}',NULL),(2162825,'2019-05-20 06:55:38',1,'RPC:SessionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162826,'2019-05-20 06:55:38',1,'RPC:UserInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162827,'2019-05-20 06:55:38',0,'RPC:VersionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162828,'2019-05-20 06:55:38',97,'RPC:MenuRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162829,'2019-05-20 06:55:40',0,'RPC:PageNameRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{\"name\":\"Edit Timetable Manager\"}',NULL),(2162830,'2019-05-20 06:55:40',1,'RPC:SessionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162831,'2019-05-20 06:55:40',0,'RPC:VersionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162832,'2019-05-20 06:55:40',1,'RPC:UserInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162833,'2019-05-20 06:55:40',79,'RPC:MenuRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162834,'2019-05-20 06:55:46',44,'timetableManagerEdit.do',0,'480CD914828840D59517386A65F478BC','1','{\"lastName\":\"Admin\",\"op\":\"Add Department\",\"roles[0]\":\"1\",\"roleRefs[0]\":\"System Administrator\",\"role\":\"\",\"deleteType\":\"\",\"externalId\":\"1\",\"solverGr\":\"\",\"dept\":\"2260992\",\"title\":\"\",\"op1\":\"2\",\"firstName\":\"Default\",\"primaryRole\":\"1\",\"roleReceiveEmailFlags[0]\":\"on\",\"middleName\":\"\",\"lookupEnabled\":\"false\",\"deleteId\":\"\",\"uniqueId\":\"470\",\"email\":\"francisco.moya@uclm.es\"}',NULL),(2162835,'2019-05-20 06:55:49',56,'timetableManagerEdit.do',0,'480CD914828840D59517386A65F478BC','1','{\"lastName\":\"Admin\",\"op\":\"Update\",\"roles[0]\":\"1\",\"roleRefs[0]\":\"System Administrator\",\"role\":\"\",\"deptLabels[0]\":\"EIIA - Planificación docente\",\"deleteType\":\"\",\"externalId\":\"1\",\"solverGr\":\"\",\"dept\":\"2260992\",\"title\":\"\",\"op1\":\"2\",\"firstName\":\"Default\",\"primaryRole\":\"1\",\"roleReceiveEmailFlags[0]\":\"on\",\"middleName\":\"\",\"depts[0]\":\"2260992\",\"lookupEnabled\":\"false\",\"deleteId\":\"\",\"uniqueId\":\"470\",\"email\":\"francisco.moya@uclm.es\"}',NULL),(2162836,'2019-05-20 06:55:52',41,'timetableManagerEdit.do',0,'480CD914828840D59517386A65F478BC','1','{\"op\":\"Edit\",\"id\":\"470\"}',NULL),(2162837,'2019-05-20 06:55:58',44,'timetableManagerEdit.do',0,'480CD914828840D59517386A65F478BC','1','{\"lastName\":\"Admin\",\"op\":\"Delete\",\"roles[0]\":\"1\",\"roleRefs[0]\":\"System Administrator\",\"role\":\"\",\"deptLabels[0]\":\"EIIA - Planificación docente\",\"deleteType\":\"dept\",\"externalId\":\"1\",\"solverGr\":\"\",\"dept\":\"\",\"title\":\"\",\"op1\":\"2\",\"firstName\":\"Default\",\"primaryRole\":\"1\",\"roleReceiveEmailFlags[0]\":\"on\",\"middleName\":\"\",\"depts[0]\":\"2260992\",\"lookupEnabled\":\"false\",\"deleteId\":\"0\",\"uniqueId\":\"470\",\"email\":\"francisco.moya@uclm.es\"}',NULL),(2162838,'2019-05-20 06:56:01',60,'timetableManagerEdit.do',0,'480CD914828840D59517386A65F478BC','1','{\"lastName\":\"Admin\",\"op\":\"Update\",\"roles[0]\":\"1\",\"roleRefs[0]\":\"System Administrator\",\"role\":\"\",\"deleteType\":\"\",\"externalId\":\"1\",\"solverGr\":\"\",\"dept\":\"\",\"title\":\"\",\"op1\":\"2\",\"firstName\":\"Default\",\"primaryRole\":\"1\",\"roleReceiveEmailFlags[0]\":\"on\",\"middleName\":\"\",\"lookupEnabled\":\"false\",\"deleteId\":\"\",\"uniqueId\":\"470\",\"email\":\"francisco.moya@uclm.es\"}',NULL),(2162839,'2019-05-20 06:56:06',40,'timetableManagerEdit.do',0,'480CD914828840D59517386A65F478BC','1','{\"op\":\"Edit\",\"id\":\"470\"}',NULL),(2162840,'2019-05-20 06:56:18',55,'timetableManagerEdit.do',0,'480CD914828840D59517386A65F478BC','1','{\"lastName\":\"Moya\",\"op\":\"Update\",\"roles[0]\":\"1\",\"roleRefs[0]\":\"System Administrator\",\"role\":\"\",\"deleteType\":\"\",\"externalId\":\"1\",\"solverGr\":\"\",\"dept\":\"\",\"title\":\"\",\"op1\":\"2\",\"firstName\":\"Francisco\",\"primaryRole\":\"1\",\"roleReceiveEmailFlags[0]\":\"on\",\"middleName\":\"\",\"lookupEnabled\":\"false\",\"deleteId\":\"\",\"uniqueId\":\"470\",\"email\":\"francisco.moya@uclm.es\"}',NULL),(2162841,'2019-05-20 06:55:46',0,'RPC:PageNameRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{\"name\":\"Edit Timetable Manager\"}',NULL),(2162842,'2019-05-20 06:55:46',1,'RPC:SessionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162843,'2019-05-20 06:55:46',1,'RPC:UserInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162844,'2019-05-20 06:55:46',0,'RPC:VersionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162845,'2019-05-20 06:55:46',85,'RPC:MenuRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162846,'2019-05-20 06:55:49',0,'RPC:PageNameRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{\"name\":\"Timetable Managers\"}',NULL),(2162847,'2019-05-20 06:55:49',0,'RPC:SessionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162848,'2019-05-20 06:55:49',0,'RPC:UserInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162849,'2019-05-20 06:55:49',0,'RPC:VersionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162850,'2019-05-20 06:55:49',89,'RPC:MenuRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162851,'2019-05-20 06:55:53',0,'RPC:PageNameRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{\"name\":\"Edit Timetable Manager\"}',NULL),(2162852,'2019-05-20 06:55:53',0,'RPC:SessionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162853,'2019-05-20 06:55:53',1,'RPC:UserInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162854,'2019-05-20 06:55:53',0,'RPC:VersionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162855,'2019-05-20 06:55:53',76,'RPC:MenuRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162856,'2019-05-20 06:55:58',0,'RPC:PageNameRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{\"name\":\"Edit Timetable Manager\"}',NULL),(2162857,'2019-05-20 06:55:58',0,'RPC:SessionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162858,'2019-05-20 06:55:58',1,'RPC:UserInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162859,'2019-05-20 06:55:58',0,'RPC:VersionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162860,'2019-05-20 06:55:59',72,'RPC:MenuRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162861,'2019-05-20 06:56:01',0,'RPC:PageNameRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{\"name\":\"Timetable Managers\"}',NULL),(2162862,'2019-05-20 06:56:01',1,'RPC:SessionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162863,'2019-05-20 06:56:01',0,'RPC:UserInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162864,'2019-05-20 06:56:01',0,'RPC:VersionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162865,'2019-05-20 06:56:01',82,'RPC:MenuRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162866,'2019-05-20 06:56:06',0,'RPC:PageNameRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{\"name\":\"Edit Timetable Manager\"}',NULL),(2162867,'2019-05-20 06:56:07',0,'RPC:SessionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162868,'2019-05-20 06:56:07',0,'RPC:UserInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162869,'2019-05-20 06:56:07',0,'RPC:VersionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162870,'2019-05-20 06:56:07',72,'RPC:MenuRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162871,'2019-05-20 06:56:18',0,'RPC:PageNameRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{\"name\":\"Timetable Managers\"}',NULL),(2162872,'2019-05-20 06:56:18',1,'RPC:SessionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162873,'2019-05-20 06:56:18',1,'RPC:UserInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162874,'2019-05-20 06:56:18',1,'RPC:VersionInfoRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL),(2162875,'2019-05-20 06:56:18',62,'RPC:MenuRpcRequest',3,'480CD914828840D59517386A65F478BC','1','{}',NULL);
/*!40000 ALTER TABLE `query_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `related_course_info`
--

DROP TABLE IF EXISTS `related_course_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `related_course_info` (
  `uniqueid` decimal(20,0) NOT NULL,
  `event_id` decimal(20,0) NOT NULL,
  `owner_id` decimal(20,0) NOT NULL,
  `owner_type` bigint(10) NOT NULL,
  `course_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_event_owner_event` (`event_id`),
  KEY `idx_event_owner_owner` (`owner_id`,`owner_type`),
  KEY `fk_event_owner_course` (`course_id`),
  CONSTRAINT `fk_event_owner_course` FOREIGN KEY (`course_id`) REFERENCES `course_offering` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_event_owner_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `related_course_info`
--

LOCK TABLES `related_course_info` WRITE;
/*!40000 ALTER TABLE `related_course_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `related_course_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reservation_type` bigint(10) NOT NULL,
  `expiration_date` date DEFAULT NULL,
  `reservation_limit` bigint(10) DEFAULT NULL,
  `offering_id` decimal(20,0) NOT NULL,
  `group_id` decimal(20,0) DEFAULT NULL,
  `area_id` decimal(20,0) DEFAULT NULL,
  `course_id` decimal(20,0) DEFAULT NULL,
  `override_type` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_reservation_offering` (`offering_id`),
  KEY `fk_reservation_student_group` (`group_id`),
  KEY `fk_reservation_area` (`area_id`),
  KEY `fk_reservation_course` (`course_id`),
  CONSTRAINT `fk_reservation_area` FOREIGN KEY (`area_id`) REFERENCES `academic_area` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_reservation_course` FOREIGN KEY (`course_id`) REFERENCES `course_offering` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_reservation_offering` FOREIGN KEY (`offering_id`) REFERENCES `instructional_offering` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_reservation_student_group` FOREIGN KEY (`group_id`) REFERENCES `student_group` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation_clasf`
--

DROP TABLE IF EXISTS `reservation_clasf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation_clasf` (
  `reservation_id` decimal(20,0) NOT NULL,
  `acad_clasf_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`reservation_id`,`acad_clasf_id`),
  KEY `fk_res_clasf_clasf` (`acad_clasf_id`),
  CONSTRAINT `fk_res_clasf_clasf` FOREIGN KEY (`acad_clasf_id`) REFERENCES `academic_classification` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_res_clasf_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation_clasf`
--

LOCK TABLES `reservation_clasf` WRITE;
/*!40000 ALTER TABLE `reservation_clasf` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservation_clasf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation_class`
--

DROP TABLE IF EXISTS `reservation_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation_class` (
  `reservation_id` decimal(20,0) NOT NULL,
  `class_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`reservation_id`,`class_id`),
  KEY `fk_res_class_class` (`class_id`),
  CONSTRAINT `fk_res_class_class` FOREIGN KEY (`class_id`) REFERENCES `class_` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_res_class_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation_class`
--

LOCK TABLES `reservation_class` WRITE;
/*!40000 ALTER TABLE `reservation_class` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservation_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation_config`
--

DROP TABLE IF EXISTS `reservation_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation_config` (
  `reservation_id` decimal(20,0) NOT NULL,
  `config_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`reservation_id`,`config_id`),
  KEY `fk_res_config_config` (`config_id`),
  CONSTRAINT `fk_res_config_config` FOREIGN KEY (`config_id`) REFERENCES `instr_offering_config` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_res_config_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation_config`
--

LOCK TABLES `reservation_config` WRITE;
/*!40000 ALTER TABLE `reservation_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservation_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation_major`
--

DROP TABLE IF EXISTS `reservation_major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation_major` (
  `reservation_id` decimal(20,0) NOT NULL,
  `major_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`reservation_id`,`major_id`),
  KEY `fk_res_majors_major` (`major_id`),
  CONSTRAINT `fk_res_majors_major` FOREIGN KEY (`major_id`) REFERENCES `pos_major` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_res_majors_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation_major`
--

LOCK TABLES `reservation_major` WRITE;
/*!40000 ALTER TABLE `reservation_major` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservation_major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation_student`
--

DROP TABLE IF EXISTS `reservation_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation_student` (
  `reservation_id` decimal(20,0) NOT NULL,
  `student_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`reservation_id`,`student_id`),
  KEY `fk_res_student_student` (`student_id`),
  CONSTRAINT `fk_res_student_reservation` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_res_student_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation_student`
--

LOCK TABLES `reservation_student` WRITE;
/*!40000 ALTER TABLE `reservation_student` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservation_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rights`
--

DROP TABLE IF EXISTS `rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rights` (
  `role_id` decimal(20,0) NOT NULL,
  `value` varchar(200) NOT NULL,
  PRIMARY KEY (`role_id`,`value`),
  CONSTRAINT `fk_rights_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rights`
--

LOCK TABLES `rights` WRITE;
/*!40000 ALTER TABLE `rights` DISABLE KEYS */;
INSERT INTO `rights` VALUES (1,'AcademicAreaEdit'),(1,'AcademicAreas'),(1,'AcademicClassificationEdit'),(1,'AcademicClassifications'),(1,'AcademicSessionAdd'),(1,'AcademicSessionDelete'),(1,'AcademicSessionEdit'),(1,'AcademicSessions'),(1,'AddCourseOffering'),(1,'AddNonUnivLocation'),(1,'AddRoom'),(1,'AddSpecialUseRoom'),(1,'AddSpecialUseRoomExternalRoom'),(1,'AllowTestSessions'),(1,'ApplicationConfig'),(1,'ApplicationConfigEdit'),(1,'AssignedClasses'),(1,'AssignedExaminations'),(1,'AssignInstructors'),(1,'AssignInstructorsClass'),(1,'AssignmentHistory'),(1,'AttachmentTypeEdit'),(1,'AttachmentTypes'),(1,'BuildingAdd'),(1,'BuildingDelete'),(1,'BuildingEdit'),(1,'BuildingExportPdf'),(1,'BuildingList'),(1,'BuildingUpdateData'),(1,'CanLookupEventContacts'),(1,'CanLookupInstructors'),(1,'CanLookupLdap'),(1,'CanLookupManagers'),(1,'CanLookupStaff'),(1,'CanLookupStudents'),(1,'CanSelectSolverServer'),(1,'CanUseHardDistributionPrefs'),(1,'CanUseHardPeriodPrefs'),(1,'CanUseHardRoomPrefs'),(1,'CanUseHardTimePrefs'),(1,'Chameleon'),(1,'ChangePassword'),(1,'ClassAssignment'),(1,'ClassAssignments'),(1,'ClassAssignmentsExportCsv'),(1,'ClassAssignmentsExportPdf'),(1,'ClassCancel'),(1,'ClassDelete'),(1,'ClassDetail'),(1,'ClassEdit'),(1,'ClassEditClearPreferences'),(1,'Classes'),(1,'ClassesExportPDF'),(1,'ClearHibernateCache'),(1,'ConflictStatistics'),(1,'ConsentApproval'),(1,'CourseCreditFormatEdit'),(1,'CourseCreditFormats'),(1,'CourseCreditTypeEdit'),(1,'CourseCreditTypes'),(1,'CourseCreditUnitEdit'),(1,'CourseCreditUnits'),(1,'CourseOfferingDeleteFromCrossList'),(1,'CourseRequests'),(1,'CourseTimetabling'),(1,'CourseTimetablingAudit'),(1,'CourseTypeEdit'),(1,'CourseTypes'),(1,'CurriculumAdd'),(1,'CurriculumAdmin'),(1,'CurriculumDelete'),(1,'CurriculumDetail'),(1,'CurriculumEdit'),(1,'CurriculumMerge'),(1,'CurriculumProjectionRulesDetail'),(1,'CurriculumProjectionRulesEdit'),(1,'CurriculumView'),(1,'DataExchange'),(1,'DatePatterns'),(1,'DepartmenalRoomFeatureDelete'),(1,'DepartmenalRoomFeatureEdit'),(1,'DepartmenalRoomGroupDelete'),(1,'DepartmenalRoomGroupEdit'),(1,'DepartmentAdd'),(1,'DepartmentDelete'),(1,'DepartmentEdit'),(1,'DepartmentEditChangeExternalManager'),(1,'DepartmentIndependent'),(1,'DepartmentRoomFeatureAdd'),(1,'DepartmentRoomGroupAdd'),(1,'Departments'),(1,'DistributionPreferenceAdd'),(1,'DistributionPreferenceClass'),(1,'DistributionPreferenceDelete'),(1,'DistributionPreferenceDetail'),(1,'DistributionPreferenceEdit'),(1,'DistributionPreferenceExam'),(1,'DistributionPreferences'),(1,'DistributionPreferenceSubpart'),(1,'DistributionTypeEdit'),(1,'DistributionTypes'),(1,'DurationTypeEdit'),(1,'DurationTypes'),(1,'EditCourseOffering'),(1,'EditCourseOfferingCoordinators'),(1,'EditRoomDepartments'),(1,'EditRoomDepartmentsExams'),(1,'EditRoomDepartmentsFinalExams'),(1,'EditRoomDepartmentsMidtermExams'),(1,'EnrollmentAuditPDFReports'),(1,'EventAddCourseRelated'),(1,'EventAddSpecial'),(1,'EventAddUnavailable'),(1,'EventAnyLocation'),(1,'EventApprovePast'),(1,'EventCanEditAcademicTitle'),(1,'EventDate'),(1,'EventDetail'),(1,'EventEdit'),(1,'EventLocation'),(1,'EventLocationApprove'),(1,'EventLocationOverbook'),(1,'EventLocationUnavailable'),(1,'EventLookupContact'),(1,'EventLookupSchedule'),(1,'EventMeetingApprove'),(1,'EventMeetingCancel'),(1,'EventMeetingDelete'),(1,'EventMeetingEdit'),(1,'EventMeetingInquire'),(1,'EventRoomTypeEdit'),(1,'EventRoomTypes'),(1,'Events'),(1,'EventServiceProviderEditDepartment'),(1,'EventServiceProviderEditGlobal'),(1,'EventServiceProviderEditSession'),(1,'EventServiceProviders'),(1,'EventStatusEdit'),(1,'EventStatuses'),(1,'ExactTimes'),(1,'ExaminationAdd'),(1,'ExaminationAssignment'),(1,'ExaminationAssignmentChanges'),(1,'ExaminationClone'),(1,'ExaminationConflictStatistics'),(1,'ExaminationDelete'),(1,'ExaminationDetail'),(1,'ExaminationDistributionPreferenceAdd'),(1,'ExaminationDistributionPreferenceDelete'),(1,'ExaminationDistributionPreferenceDetail'),(1,'ExaminationDistributionPreferenceEdit'),(1,'ExaminationDistributionPreferences'),(1,'ExaminationEdit'),(1,'ExaminationEditClearPreferences'),(1,'ExaminationPdfReports'),(1,'ExaminationPeriods'),(1,'ExaminationReports'),(1,'Examinations'),(1,'ExaminationSchedule'),(1,'ExaminationSolutionExportXml'),(1,'ExaminationSolver'),(1,'ExaminationSolverLog'),(1,'ExaminationStatusEdit'),(1,'ExaminationStatuses'),(1,'ExaminationTimetable'),(1,'ExaminationTimetabling'),(1,'ExaminationView'),(1,'ExamTypeEdit'),(1,'ExamTypes'),(1,'ExtendedDatePatterns'),(1,'ExtendedTimePatterns'),(1,'GlobalRoomFeatureAdd'),(1,'GlobalRoomFeatureDelete'),(1,'GlobalRoomFeatureEdit'),(1,'GlobalRoomGroupAdd'),(1,'GlobalRoomGroupDelete'),(1,'GlobalRoomGroupEdit'),(1,'GlobalRoomGroupEditSetDefault'),(1,'HasRole'),(1,'HibernateStatistics'),(1,'HQLReportAdd'),(1,'HQLReportDelete'),(1,'HQLReportEdit'),(1,'HQLReports'),(1,'HQLReportsAdministration'),(1,'HQLReportsAdminOnly'),(1,'HQLReportsCourses'),(1,'HQLReportsEvents'),(1,'HQLReportsExaminations'),(1,'HQLReportsStudents'),(1,'Inquiry'),(1,'InstrOfferingConfigAdd'),(1,'InstrOfferingConfigDelete'),(1,'InstrOfferingConfigEdit'),(1,'InstrOfferingConfigEditDepartment'),(1,'InstrOfferingConfigEditSubpart'),(1,'InstructionalMethodEdit'),(1,'InstructionalMethods'),(1,'InstructionalOfferingCrossLists'),(1,'InstructionalOfferingDetail'),(1,'InstructionalOfferings'),(1,'InstructionalOfferingsExportPDF'),(1,'InstructionalOfferingsWorksheetPDF'),(1,'InstructionalTypeAdd'),(1,'InstructionalTypeDelete'),(1,'InstructionalTypeEdit'),(1,'InstructionalTypes'),(1,'InstructorAdd'),(1,'InstructorAssignmentPreferences'),(1,'InstructorAttributeAdd'),(1,'InstructorAttributeAssign'),(1,'InstructorAttributeDelete'),(1,'InstructorAttributeEdit'),(1,'InstructorAttributes'),(1,'InstructorAttributeTypeEdit'),(1,'InstructorAttributeTypes'),(1,'InstructorClearAssignmentPreferences'),(1,'InstructorDelete'),(1,'InstructorDetail'),(1,'InstructorEdit'),(1,'InstructorEditClearPreferences'),(1,'InstructorGlobalAttributeEdit'),(1,'InstructorPreferences'),(1,'InstructorRoleEdit'),(1,'InstructorRoles'),(1,'Instructors'),(1,'InstructorScheduling'),(1,'InstructorSchedulingSolutionExportXml'),(1,'InstructorSchedulingSolver'),(1,'InstructorSchedulingSolverLog'),(1,'InstructorsExportPdf'),(1,'IsAdmin'),(1,'LastChanges'),(1,'LimitAndProjectionSnapshot'),(1,'LimitAndProjectionSnapshotSave'),(1,'MajorEdit'),(1,'Majors'),(1,'ManageInstructors'),(1,'ManageSolvers'),(1,'MinorEdit'),(1,'Minors'),(1,'MultipleClassSetup'),(1,'MultipleClassSetupClass'),(1,'MultipleClassSetupDepartment'),(1,'NonUniversityLocationDelete'),(1,'NonUniversityLocationEdit'),(1,'NotAssignedClasses'),(1,'NotAssignedExaminations'),(1,'OfferingCanLock'),(1,'OfferingCanUnlock'),(1,'OfferingConsentTypeEdit'),(1,'OfferingConsentTypes'),(1,'OfferingDelete'),(1,'OfferingEnrollments'),(1,'OfferingMakeNotOffered'),(1,'OfferingMakeOffered'),(1,'OverrideTypeEdit'),(1,'OverrideTypes'),(1,'PageStatistics'),(1,'PermissionEdit'),(1,'Permissions'),(1,'PersonalSchedule'),(1,'PersonalScheduleLookup'),(1,'PointInTimeData'),(1,'PointInTimeDataEdit'),(1,'PointInTimeDataReports'),(1,'PositionTypeEdit'),(1,'PositionTypes'),(1,'PreferenceLevelEdit'),(1,'PreferenceLevels'),(1,'Registration'),(1,'ReservationAdd'),(1,'ReservationDelete'),(1,'ReservationEdit'),(1,'ReservationOffering'),(1,'Reservations'),(1,'RoleEdit'),(1,'Roles'),(1,'RoomAvailability'),(1,'RoomDelete'),(1,'RoomDepartments'),(1,'RoomDetail'),(1,'RoomDetailAvailability'),(1,'RoomDetailEventAvailability'),(1,'RoomDetailPeriodPreferences'),(1,'RoomEdit'),(1,'RoomEditAvailability'),(1,'RoomEditChangeCapacity'),(1,'RoomEditChangeControll'),(1,'RoomEditChangeEventProperties'),(1,'RoomEditChangeExaminationStatus'),(1,'RoomEditChangeExternalId'),(1,'RoomEditChangePicture'),(1,'RoomEditChangeRoomProperties'),(1,'RoomEditChangeType'),(1,'RoomEditEventAvailability'),(1,'RoomEditFeatures'),(1,'RoomEditGlobalFeatures'),(1,'RoomEditGlobalGroups'),(1,'RoomEditGroups'),(1,'RoomEditPreference'),(1,'RoomFeatures'),(1,'RoomFeaturesExportPdf'),(1,'RoomFeatureTypeEdit'),(1,'RoomFeatureTypes'),(1,'RoomGroups'),(1,'RoomGroupsExportPdf'),(1,'Rooms'),(1,'RoomsExportCsv'),(1,'RoomsExportPdf'),(1,'RoomTypes'),(1,'SchedulingAssistant'),(1,'SchedulingDashboard'),(1,'SchedulingReports'),(1,'SchedulingSubpartDetail'),(1,'SchedulingSubpartDetailClearClassPreferences'),(1,'SchedulingSubpartEdit'),(1,'SchedulingSubpartEditClearPreferences'),(1,'ScriptEdit'),(1,'Scripts'),(1,'SessionDefaultCurrent'),(1,'SessionIndependent'),(1,'SessionRollForward'),(1,'SettingsAdmin'),(1,'SettingsUser'),(1,'SolutionChanges'),(1,'SolutionReports'),(1,'Solver'),(1,'SolverConfigurations'),(1,'SolverGroups'),(1,'SolverLog'),(1,'SolverParameterGroups'),(1,'SolverParameters'),(1,'SolverSolutionExportCsv'),(1,'SolverSolutionExportXml'),(1,'SolverSolutionSave'),(1,'SponsoringOrganizationAdd'),(1,'SponsoringOrganizationDelete'),(1,'SponsoringOrganizationEdit'),(1,'SponsoringOrganizations'),(1,'StandardEventNotes'),(1,'StandardEventNotesDepartmentEdit'),(1,'StandardEventNotesGlobalEdit'),(1,'StandardEventNotesSessionEdit'),(1,'StatusIndependent'),(1,'StatusTypes'),(1,'StudentAccommodationEdit'),(1,'StudentAccommodations'),(1,'StudentAdvisorEdit'),(1,'StudentAdvisors'),(1,'StudentEnrollments'),(1,'StudentGroupEdit'),(1,'StudentGroups'),(1,'StudentGroupTypeEdit'),(1,'StudentGroupTypes'),(1,'StudentScheduling'),(1,'StudentSchedulingAdmin'),(1,'StudentSchedulingAdvisor'),(1,'StudentSchedulingAdvisorCanModifyAllStudents'),(1,'StudentSchedulingAdvisorCanModifyMyStudents'),(1,'StudentSchedulingCanEnroll'),(1,'StudentSchedulingCanRegister'),(1,'StudentSchedulingChangeStudentStatus'),(1,'StudentSchedulingEmailStudent'),(1,'StudentSchedulingMassCancel'),(1,'StudentSchedulingStatusTypeEdit'),(1,'StudentSchedulingStatusTypes'),(1,'StudentSectioningSolutionExportXml'),(1,'StudentSectioningSolver'),(1,'StudentSectioningSolverDashboard'),(1,'StudentSectioningSolverLog'),(1,'StudentSectioningSolverSave'),(1,'SubjectAreaAdd'),(1,'SubjectAreaChangeDepartment'),(1,'SubjectAreaDelete'),(1,'SubjectAreaEdit'),(1,'SubjectAreas'),(1,'Suggestions'),(1,'TaskDetail'),(1,'TaskEdit'),(1,'Tasks'),(1,'TeachingResponsibilities'),(1,'TeachingResponsibilityEdit'),(1,'TestHQL'),(1,'TimePatterns'),(1,'TimetableGrid'),(1,'TimetableManagerAdd'),(1,'TimetableManagerDelete'),(1,'TimetableManagerEdit'),(1,'TimetableManagers'),(1,'Timetables'),(1,'TimetablesSolutionChangeNote'),(1,'TimetablesSolutionCommit'),(1,'TimetablesSolutionDelete'),(1,'TimetablesSolutionExportCsv'),(1,'TimetablesSolutionLoad'),(1,'TimetablesSolutionLoadEmpty'),(1,'TravelTimesLoad'),(1,'TravelTimesSave'),(1,'Users'),(21,'AddCourseOffering'),(21,'AddNonUnivLocation'),(21,'AddSpecialUseRoom'),(21,'AddSpecialUseRoomExternalRoom'),(21,'AssignedClasses'),(21,'AssignInstructors'),(21,'AssignInstructorsClass'),(21,'AssignmentHistory'),(21,'CanLookupEventContacts'),(21,'CanLookupInstructors'),(21,'CanLookupLdap'),(21,'CanLookupManagers'),(21,'CanLookupStaff'),(21,'CanLookupStudents'),(21,'CanUseHardDistributionPrefs'),(21,'CanUseHardPeriodPrefs'),(21,'CanUseHardRoomPrefs'),(21,'CanUseHardTimePrefs'),(21,'ChangePassword'),(21,'ClassAssignments'),(21,'ClassAssignmentsExportCsv'),(21,'ClassAssignmentsExportPdf'),(21,'ClassCancel'),(21,'ClassDelete'),(21,'ClassDetail'),(21,'ClassEdit'),(21,'ClassEditClearPreferences'),(21,'Classes'),(21,'ClassesExportPDF'),(21,'ConflictStatistics'),(21,'ConsentApproval'),(21,'CourseOfferingDeleteFromCrossList'),(21,'CourseTimetabling'),(21,'CourseTimetablingAudit'),(21,'CurriculumAdd'),(21,'CurriculumDelete'),(21,'CurriculumDetail'),(21,'CurriculumEdit'),(21,'CurriculumProjectionRulesDetail'),(21,'CurriculumView'),(21,'DepartmenalRoomFeatureDelete'),(21,'DepartmenalRoomFeatureEdit'),(21,'DepartmenalRoomGroupDelete'),(21,'DepartmenalRoomGroupEdit'),(21,'DepartmentRoomFeatureAdd'),(21,'DepartmentRoomGroupAdd'),(21,'DistributionPreferenceAdd'),(21,'DistributionPreferenceClass'),(21,'DistributionPreferenceDelete'),(21,'DistributionPreferenceDetail'),(21,'DistributionPreferenceEdit'),(21,'DistributionPreferenceExam'),(21,'DistributionPreferences'),(21,'DistributionPreferenceSubpart'),(21,'EditCourseOffering'),(21,'EditCourseOfferingCoordinators'),(21,'EditRoomDepartments'),(21,'EventAddCourseRelated'),(21,'EventAddSpecial'),(21,'EventDate'),(21,'EventDetail'),(21,'EventEdit'),(21,'EventLocation'),(21,'EventLookupSchedule'),(21,'EventMeetingCancel'),(21,'EventMeetingDelete'),(21,'EventMeetingEdit'),(21,'Events'),(21,'ExaminationAdd'),(21,'ExaminationClone'),(21,'ExaminationDelete'),(21,'ExaminationDetail'),(21,'ExaminationDistributionPreferenceAdd'),(21,'ExaminationDistributionPreferenceDelete'),(21,'ExaminationDistributionPreferenceDetail'),(21,'ExaminationDistributionPreferenceEdit'),(21,'ExaminationDistributionPreferences'),(21,'ExaminationEdit'),(21,'ExaminationEditClearPreferences'),(21,'ExaminationPdfReports'),(21,'Examinations'),(21,'ExaminationSchedule'),(21,'ExaminationView'),(21,'HasRole'),(21,'HQLReports'),(21,'HQLReportsCourses'),(21,'Inquiry'),(21,'InstrOfferingConfigAdd'),(21,'InstrOfferingConfigDelete'),(21,'InstrOfferingConfigEdit'),(21,'InstrOfferingConfigEditDepartment'),(21,'InstrOfferingConfigEditSubpart'),(21,'InstructionalOfferingCrossLists'),(21,'InstructionalOfferingDetail'),(21,'InstructionalOfferings'),(21,'InstructionalOfferingsExportPDF'),(21,'InstructionalOfferingsWorksheetPDF'),(21,'InstructorAdd'),(21,'InstructorAssignmentPreferences'),(21,'InstructorAttributeAdd'),(21,'InstructorAttributeAssign'),(21,'InstructorAttributeDelete'),(21,'InstructorAttributeEdit'),(21,'InstructorAttributes'),(21,'InstructorClearAssignmentPreferences'),(21,'InstructorDelete'),(21,'InstructorDetail'),(21,'InstructorEdit'),(21,'InstructorEditClearPreferences'),(21,'InstructorPreferences'),(21,'Instructors'),(21,'InstructorScheduling'),(21,'InstructorSchedulingSolver'),(21,'InstructorSchedulingSolverLog'),(21,'InstructorsExportPdf'),(21,'LimitAndProjectionSnapshot'),(21,'ManageInstructors'),(21,'MultipleClassSetup'),(21,'MultipleClassSetupClass'),(21,'MultipleClassSetupDepartment'),(21,'NonUniversityLocationDelete'),(21,'NonUniversityLocationEdit'),(21,'NotAssignedClasses'),(21,'OfferingCanLock'),(21,'OfferingCanUnlock'),(21,'OfferingEnrollments'),(21,'OfferingMakeNotOffered'),(21,'OfferingMakeOffered'),(21,'PersonalSchedule'),(21,'PersonalScheduleLookup'),(21,'PointInTimeData'),(21,'PointInTimeDataReports'),(21,'ReservationAdd'),(21,'ReservationDelete'),(21,'ReservationEdit'),(21,'ReservationOffering'),(21,'Reservations'),(21,'RoomAvailability'),(21,'RoomDepartments'),(21,'RoomDetail'),(21,'RoomDetailAvailability'),(21,'RoomEditAvailability'),(21,'RoomEditChangeCapacity'),(21,'RoomEditChangeExternalId'),(21,'RoomEditChangePicture'),(21,'RoomEditChangeRoomProperties'),(21,'RoomEditChangeType'),(21,'RoomEditFeatures'),(21,'RoomEditGroups'),(21,'RoomEditPreference'),(21,'RoomFeatures'),(21,'RoomFeaturesExportPdf'),(21,'RoomGroups'),(21,'RoomGroupsExportPdf'),(21,'Rooms'),(21,'RoomsExportCsv'),(21,'RoomsExportPdf'),(21,'SchedulingAssistant'),(21,'SchedulingDashboard'),(21,'SchedulingReports'),(21,'SchedulingSubpartDetail'),(21,'SchedulingSubpartDetailClearClassPreferences'),(21,'SchedulingSubpartEdit'),(21,'SchedulingSubpartEditClearPreferences'),(21,'SessionDefaultFirstFuture'),(21,'SettingsUser'),(21,'SolutionChanges'),(21,'SolutionReports'),(21,'Solver'),(21,'SolverLog'),(21,'SolverSolutionExportCsv'),(21,'SolverSolutionSave'),(21,'StudentEnrollments'),(21,'Suggestions'),(21,'TimetableGrid'),(21,'Timetables'),(21,'TimetablesSolutionChangeNote'),(21,'TimetablesSolutionCommit'),(21,'TimetablesSolutionDelete'),(21,'TimetablesSolutionExportCsv'),(21,'TimetablesSolutionLoad'),(21,'TimetablesSolutionLoadEmpty'),(41,'CanUseHardDistributionPrefs'),(41,'CanUseHardPeriodPrefs'),(41,'CanUseHardRoomPrefs'),(41,'CanUseHardTimePrefs'),(41,'ChangePassword'),(41,'ClassAssignments'),(41,'ClassAssignmentsExportCsv'),(41,'ClassAssignmentsExportPdf'),(41,'ClassDetail'),(41,'Classes'),(41,'ClassesExportPDF'),(41,'CurriculumDetail'),(41,'CurriculumProjectionRulesDetail'),(41,'CurriculumView'),(41,'DepartmentIndependent'),(41,'DistributionPreferenceDetail'),(41,'DistributionPreferences'),(41,'EventAddSpecial'),(41,'EventDate'),(41,'EventDetail'),(41,'EventEdit'),(41,'EventLocation'),(41,'EventMeetingCancel'),(41,'EventMeetingDelete'),(41,'EventMeetingEdit'),(41,'Events'),(41,'ExaminationDetail'),(41,'ExaminationDistributionPreferenceDetail'),(41,'ExaminationDistributionPreferences'),(41,'ExaminationPdfReports'),(41,'Examinations'),(41,'ExaminationSchedule'),(41,'ExaminationView'),(41,'HasRole'),(41,'Inquiry'),(41,'InstructionalOfferingDetail'),(41,'InstructionalOfferings'),(41,'InstructionalOfferingsExportPDF'),(41,'InstructionalOfferingsWorksheetPDF'),(41,'InstructorAttributes'),(41,'InstructorDetail'),(41,'Instructors'),(41,'InstructorsExportPdf'),(41,'OfferingEnrollments'),(41,'RoomAvailability'),(41,'RoomDetail'),(41,'RoomDetailAvailability'),(41,'RoomDetailPeriodPreferences'),(41,'RoomFeatures'),(41,'RoomFeaturesExportPdf'),(41,'RoomGroups'),(41,'RoomGroupsExportPdf'),(41,'Rooms'),(41,'RoomsExportCsv'),(41,'RoomsExportPdf'),(41,'SchedulingAssistant'),(41,'SchedulingDashboard'),(41,'SchedulingReports'),(41,'SchedulingSubpartDetail'),(41,'SessionDefaultCurrent'),(41,'SessionIndependentIfNoSessionGiven'),(41,'SettingsUser'),(41,'StudentEnrollments'),(61,'AssignedExaminations'),(61,'CanUseHardDistributionPrefs'),(61,'CanUseHardPeriodPrefs'),(61,'CanUseHardRoomPrefs'),(61,'CanUseHardTimePrefs'),(61,'ChangePassword'),(61,'ClassAssignments'),(61,'ClassAssignmentsExportCsv'),(61,'ClassAssignmentsExportPdf'),(61,'DepartmentIndependent'),(61,'DistributionPreferenceExam'),(61,'EditRoomDepartmentsExams'),(61,'EditRoomDepartmentsFinalExams'),(61,'EditRoomDepartmentsMidtermExams'),(61,'EventAddSpecial'),(61,'EventDate'),(61,'EventDetail'),(61,'EventEdit'),(61,'EventLocation'),(61,'EventMeetingCancel'),(61,'EventMeetingDelete'),(61,'EventMeetingEdit'),(61,'Events'),(61,'ExaminationAdd'),(61,'ExaminationAssignment'),(61,'ExaminationAssignmentChanges'),(61,'ExaminationClone'),(61,'ExaminationConflictStatistics'),(61,'ExaminationDelete'),(61,'ExaminationDetail'),(61,'ExaminationDistributionPreferenceAdd'),(61,'ExaminationDistributionPreferenceDelete'),(61,'ExaminationDistributionPreferenceDetail'),(61,'ExaminationDistributionPreferenceEdit'),(61,'ExaminationDistributionPreferences'),(61,'ExaminationEdit'),(61,'ExaminationEditClearPreferences'),(61,'ExaminationPdfReports'),(61,'ExaminationReports'),(61,'Examinations'),(61,'ExaminationSchedule'),(61,'ExaminationSolver'),(61,'ExaminationSolverLog'),(61,'ExaminationTimetable'),(61,'ExaminationTimetabling'),(61,'ExaminationView'),(61,'HasRole'),(61,'HQLReports'),(61,'HQLReportsExaminations'),(61,'Inquiry'),(61,'InstructorAttributes'),(61,'InstructorDetail'),(61,'Instructors'),(61,'InstructorsExportPdf'),(61,'LimitAndProjectionSnapshot'),(61,'NotAssignedExaminations'),(61,'PointInTimeData'),(61,'PointInTimeDataReports'),(61,'RoomDetail'),(61,'RoomDetailPeriodPreferences'),(61,'RoomEdit'),(61,'RoomEditChangeExaminationStatus'),(61,'RoomFeatures'),(61,'RoomFeaturesExportPdf'),(61,'RoomGroups'),(61,'RoomGroupsExportPdf'),(61,'Rooms'),(61,'RoomsExportCsv'),(61,'RoomsExportPdf'),(61,'SessionDefaultFirstExamination'),(61,'SettingsUser'),(81,'AddNonUnivLocation'),(81,'AddSpecialUseRoom'),(81,'AddSpecialUseRoomExternalRoom'),(81,'CanLookupEventContacts'),(81,'CanLookupInstructors'),(81,'CanLookupLdap'),(81,'CanLookupManagers'),(81,'CanLookupStaff'),(81,'CanLookupStudents'),(81,'CanUseHardDistributionPrefs'),(81,'CanUseHardPeriodPrefs'),(81,'CanUseHardRoomPrefs'),(81,'CanUseHardTimePrefs'),(81,'ChangePassword'),(81,'EventAddCourseRelated'),(81,'EventAddSpecial'),(81,'EventAddUnavailable'),(81,'EventCanEditAcademicTitle'),(81,'EventDate'),(81,'EventDetail'),(81,'EventEdit'),(81,'EventLocation'),(81,'EventLocationApprove'),(81,'EventLocationOverbook'),(81,'EventLocationUnavailable'),(81,'EventLookupContact'),(81,'EventMeetingApprove'),(81,'EventMeetingCancel'),(81,'EventMeetingDelete'),(81,'EventMeetingEdit'),(81,'EventMeetingInquire'),(81,'EventRoomTypeEdit'),(81,'EventRoomTypes'),(81,'Events'),(81,'EventServiceProviderEditDepartment'),(81,'EventStatusEdit'),(81,'EventStatuses'),(81,'ExaminationSchedule'),(81,'ExaminationView'),(81,'HasRole'),(81,'HQLReports'),(81,'HQLReportsEvents'),(81,'Inquiry'),(81,'InstructorRoleEdit'),(81,'InstructorRoles'),(81,'LimitAndProjectionSnapshot'),(81,'NonUniversityLocationDelete'),(81,'NonUniversityLocationEdit'),(81,'PointInTimeData'),(81,'PointInTimeDataReports'),(81,'RoomDetail'),(81,'RoomDetailEventAvailability'),(81,'RoomEditChangeCapacity'),(81,'RoomEditChangeEventProperties'),(81,'RoomEditChangeExternalId'),(81,'RoomEditChangePicture'),(81,'RoomEditChangeRoomProperties'),(81,'RoomEditChangeType'),(81,'RoomEditEventAvailability'),(81,'RoomFeatures'),(81,'RoomFeaturesExportPdf'),(81,'RoomGroups'),(81,'RoomGroupsExportPdf'),(81,'Rooms'),(81,'RoomsExportCsv'),(81,'RoomsExportPdf'),(81,'SessionDefaultCurrent'),(81,'SettingsUser'),(81,'StandardEventNotes'),(81,'StandardEventNotesDepartmentEdit'),(101,'CanUseHardDistributionPrefs'),(101,'CanUseHardPeriodPrefs'),(101,'CanUseHardRoomPrefs'),(101,'CanUseHardTimePrefs'),(101,'ChangePassword'),(101,'CurriculumAdd'),(101,'CurriculumAdmin'),(101,'CurriculumDelete'),(101,'CurriculumDetail'),(101,'CurriculumEdit'),(101,'CurriculumMerge'),(101,'CurriculumProjectionRulesDetail'),(101,'CurriculumProjectionRulesEdit'),(101,'CurriculumView'),(101,'DepartmentIndependent'),(101,'EventAddSpecial'),(101,'EventDate'),(101,'EventDetail'),(101,'EventEdit'),(101,'EventLocation'),(101,'EventMeetingCancel'),(101,'EventMeetingDelete'),(101,'EventMeetingEdit'),(101,'Events'),(101,'ExaminationSchedule'),(101,'ExaminationView'),(101,'HasRole'),(101,'Inquiry'),(101,'RoomAvailability'),(101,'SessionDefaultCurrent'),(101,'SettingsUser'),(1310680,'CanLookupEventContacts'),(1310680,'CanLookupInstructors'),(1310680,'CanLookupLdap'),(1310680,'CanLookupManagers'),(1310680,'CanLookupStaff'),(1310680,'CanLookupStudents'),(1310680,'CanUseHardDistributionPrefs'),(1310680,'CanUseHardPeriodPrefs'),(1310680,'CanUseHardRoomPrefs'),(1310680,'CanUseHardTimePrefs'),(1310680,'ChangePassword'),(1310680,'CourseRequests'),(1310680,'DepartmentIndependent'),(1310680,'EventAddSpecial'),(1310680,'EventDate'),(1310680,'EventDetail'),(1310680,'EventEdit'),(1310680,'EventLocation'),(1310680,'EventLookupSchedule'),(1310680,'EventMeetingCancel'),(1310680,'EventMeetingDelete'),(1310680,'EventMeetingEdit'),(1310680,'Events'),(1310680,'ExaminationSchedule'),(1310680,'ExaminationView'),(1310680,'HasRole'),(1310680,'Inquiry'),(1310680,'OfferingEnrollments'),(1310680,'PersonalSchedule'),(1310680,'PersonalScheduleLookup'),(1310680,'SchedulingAssistant'),(1310680,'SchedulingDashboard'),(1310680,'SchedulingReports'),(1310680,'SessionDefaultCurrent'),(1310680,'SettingsUser'),(1310680,'StudentEnrollments'),(1310680,'StudentSchedulingAdvisor'),(1310680,'StudentSchedulingAdvisorCanModifyAllStudents'),(1310680,'StudentSchedulingAdvisorCanModifyMyStudents'),(1310680,'StudentSchedulingCanEnroll'),(1310680,'StudentSchedulingCanRegister'),(1408981,'ChangePassword'),(1408981,'EventAddSpecial'),(1408981,'EventDate'),(1408981,'EventDetail'),(1408981,'EventEdit'),(1408981,'EventLocation'),(1408981,'EventMeetingCancel'),(1408981,'EventMeetingDelete'),(1408981,'EventMeetingEdit'),(1408981,'Events'),(1408981,'Inquiry'),(1408981,'SchedulingAssistant'),(1408982,'ChangePassword'),(1408982,'CourseRequests'),(1408982,'EventAddSpecial'),(1408982,'EventDate'),(1408982,'EventDetail'),(1408982,'EventEdit'),(1408982,'EventLocation'),(1408982,'EventMeetingCancel'),(1408982,'EventMeetingDelete'),(1408982,'EventMeetingEdit'),(1408982,'Events'),(1408982,'Inquiry'),(1408982,'PersonalSchedule'),(1408982,'SchedulingAssistant'),(1408982,'SessionDefaultCurrent'),(1408982,'StudentEnrollments'),(1408982,'StudentSchedulingCanEnroll'),(1408982,'StudentSchedulingCanRegister'),(1408983,'ChangePassword'),(1408983,'ConsentApproval'),(1408983,'EventAddSpecial'),(1408983,'EventDate'),(1408983,'EventDetail'),(1408983,'EventEdit'),(1408983,'EventLocation'),(1408983,'EventMeetingCancel'),(1408983,'EventMeetingDelete'),(1408983,'EventMeetingEdit'),(1408983,'Events'),(1408983,'Inquiry'),(1408983,'OfferingEnrollments'),(1408983,'PersonalSchedule'),(1408983,'SchedulingAssistant'),(1408983,'SchedulingDashboard'),(1408983,'SchedulingReports'),(1408983,'SessionDefaultCurrent'),(1441748,'AcademicAreaEdit'),(1441748,'AcademicAreas'),(1441748,'AcademicClassificationEdit'),(1441748,'AcademicClassifications'),(1441748,'AcademicSessionEdit'),(1441748,'AcademicSessions'),(1441748,'AddCourseOffering'),(1441748,'AddNonUnivLocation'),(1441748,'AddRoom'),(1441748,'AddSpecialUseRoom'),(1441748,'AddSpecialUseRoomExternalRoom'),(1441748,'AssignedClasses'),(1441748,'AssignedExaminations'),(1441748,'AssignInstructors'),(1441748,'AssignInstructorsClass'),(1441748,'AssignmentHistory'),(1441748,'AttachmentTypes'),(1441748,'BuildingAdd'),(1441748,'BuildingDelete'),(1441748,'BuildingEdit'),(1441748,'BuildingExportPdf'),(1441748,'BuildingList'),(1441748,'BuildingUpdateData'),(1441748,'CanLookupEventContacts'),(1441748,'CanLookupInstructors'),(1441748,'CanLookupLdap'),(1441748,'CanLookupManagers'),(1441748,'CanLookupStaff'),(1441748,'CanLookupStudents'),(1441748,'CanSelectSolverServer'),(1441748,'CanUseHardDistributionPrefs'),(1441748,'CanUseHardPeriodPrefs'),(1441748,'CanUseHardRoomPrefs'),(1441748,'CanUseHardTimePrefs'),(1441748,'ChangePassword'),(1441748,'ClassAssignment'),(1441748,'ClassAssignments'),(1441748,'ClassAssignmentsExportCsv'),(1441748,'ClassAssignmentsExportPdf'),(1441748,'ClassCancel'),(1441748,'ClassDelete'),(1441748,'ClassDetail'),(1441748,'ClassEdit'),(1441748,'ClassEditClearPreferences'),(1441748,'Classes'),(1441748,'ClassesExportPDF'),(1441748,'ConflictStatistics'),(1441748,'ConsentApproval'),(1441748,'CourseCreditFormats'),(1441748,'CourseCreditTypes'),(1441748,'CourseCreditUnits'),(1441748,'CourseOfferingDeleteFromCrossList'),(1441748,'CourseRequests'),(1441748,'CourseTimetabling'),(1441748,'CourseTimetablingAudit'),(1441748,'CourseTypes'),(1441748,'CurriculumAdd'),(1441748,'CurriculumAdmin'),(1441748,'CurriculumDelete'),(1441748,'CurriculumDetail'),(1441748,'CurriculumEdit'),(1441748,'CurriculumMerge'),(1441748,'CurriculumProjectionRulesDetail'),(1441748,'CurriculumProjectionRulesEdit'),(1441748,'CurriculumView'),(1441748,'DatePatterns'),(1441748,'DepartmenalRoomFeatureDelete'),(1441748,'DepartmenalRoomFeatureEdit'),(1441748,'DepartmenalRoomGroupDelete'),(1441748,'DepartmenalRoomGroupEdit'),(1441748,'DepartmentAdd'),(1441748,'DepartmentDelete'),(1441748,'DepartmentEdit'),(1441748,'DepartmentEditChangeExternalManager'),(1441748,'DepartmentIndependent'),(1441748,'DepartmentRoomFeatureAdd'),(1441748,'DepartmentRoomGroupAdd'),(1441748,'Departments'),(1441748,'DistributionPreferenceAdd'),(1441748,'DistributionPreferenceClass'),(1441748,'DistributionPreferenceDelete'),(1441748,'DistributionPreferenceDetail'),(1441748,'DistributionPreferenceEdit'),(1441748,'DistributionPreferenceExam'),(1441748,'DistributionPreferences'),(1441748,'DistributionPreferenceSubpart'),(1441748,'DistributionTypes'),(1441748,'DurationTypes'),(1441748,'EditCourseOffering'),(1441748,'EditCourseOfferingCoordinators'),(1441748,'EditRoomDepartments'),(1441748,'EditRoomDepartmentsExams'),(1441748,'EditRoomDepartmentsFinalExams'),(1441748,'EditRoomDepartmentsMidtermExams'),(1441748,'EnrollmentAuditPDFReports'),(1441748,'EventAddCourseRelated'),(1441748,'EventAddSpecial'),(1441748,'EventAddUnavailable'),(1441748,'EventAnyLocation'),(1441748,'EventApprovePast'),(1441748,'EventCanEditAcademicTitle'),(1441748,'EventDate'),(1441748,'EventDetail'),(1441748,'EventEdit'),(1441748,'EventLocation'),(1441748,'EventLocationApprove'),(1441748,'EventLocationOverbook'),(1441748,'EventLocationUnavailable'),(1441748,'EventLookupContact'),(1441748,'EventLookupSchedule'),(1441748,'EventMeetingApprove'),(1441748,'EventMeetingCancel'),(1441748,'EventMeetingDelete'),(1441748,'EventMeetingEdit'),(1441748,'EventMeetingInquire'),(1441748,'EventRoomTypeEdit'),(1441748,'EventRoomTypes'),(1441748,'Events'),(1441748,'EventServiceProviderEditDepartment'),(1441748,'EventServiceProviders'),(1441748,'EventStatusEdit'),(1441748,'EventStatuses'),(1441748,'ExaminationAdd'),(1441748,'ExaminationAssignment'),(1441748,'ExaminationAssignmentChanges'),(1441748,'ExaminationClone'),(1441748,'ExaminationConflictStatistics'),(1441748,'ExaminationDelete'),(1441748,'ExaminationDetail'),(1441748,'ExaminationDistributionPreferenceAdd'),(1441748,'ExaminationDistributionPreferenceDelete'),(1441748,'ExaminationDistributionPreferenceDetail'),(1441748,'ExaminationDistributionPreferenceEdit'),(1441748,'ExaminationDistributionPreferences'),(1441748,'ExaminationEdit'),(1441748,'ExaminationEditClearPreferences'),(1441748,'ExaminationPdfReports'),(1441748,'ExaminationPeriods'),(1441748,'ExaminationReports'),(1441748,'Examinations'),(1441748,'ExaminationSchedule'),(1441748,'ExaminationSolutionExportXml'),(1441748,'ExaminationSolver'),(1441748,'ExaminationSolverLog'),(1441748,'ExaminationStatuses'),(1441748,'ExaminationTimetable'),(1441748,'ExaminationTimetabling'),(1441748,'ExaminationView'),(1441748,'ExamTypes'),(1441748,'ExtendedDatePatterns'),(1441748,'ExtendedTimePatterns'),(1441748,'GlobalRoomFeatureAdd'),(1441748,'GlobalRoomFeatureDelete'),(1441748,'GlobalRoomFeatureEdit'),(1441748,'GlobalRoomGroupAdd'),(1441748,'GlobalRoomGroupDelete'),(1441748,'GlobalRoomGroupEdit'),(1441748,'GlobalRoomGroupEditSetDefault'),(1441748,'HasRole'),(1441748,'HQLReports'),(1441748,'HQLReportsAdministration'),(1441748,'HQLReportsAdminOnly'),(1441748,'HQLReportsCourses'),(1441748,'HQLReportsEvents'),(1441748,'HQLReportsExaminations'),(1441748,'HQLReportsStudents'),(1441748,'Inquiry'),(1441748,'InstrOfferingConfigAdd'),(1441748,'InstrOfferingConfigDelete'),(1441748,'InstrOfferingConfigEdit'),(1441748,'InstrOfferingConfigEditDepartment'),(1441748,'InstrOfferingConfigEditSubpart'),(1441748,'InstructionalMethods'),(1441748,'InstructionalOfferingCrossLists'),(1441748,'InstructionalOfferingDetail'),(1441748,'InstructionalOfferings'),(1441748,'InstructionalOfferingsExportPDF'),(1441748,'InstructionalOfferingsWorksheetPDF'),(1441748,'InstructionalTypes'),(1441748,'InstructorAdd'),(1441748,'InstructorAssignmentPreferences'),(1441748,'InstructorAttributeAdd'),(1441748,'InstructorAttributeAssign'),(1441748,'InstructorAttributeDelete'),(1441748,'InstructorAttributeEdit'),(1441748,'InstructorAttributes'),(1441748,'InstructorAttributeTypes'),(1441748,'InstructorClearAssignmentPreferences'),(1441748,'InstructorDelete'),(1441748,'InstructorDetail'),(1441748,'InstructorEdit'),(1441748,'InstructorEditClearPreferences'),(1441748,'InstructorGlobalAttributeEdit'),(1441748,'InstructorPreferences'),(1441748,'InstructorRoleEdit'),(1441748,'InstructorRoles'),(1441748,'Instructors'),(1441748,'InstructorScheduling'),(1441748,'InstructorSchedulingSolutionExportXml'),(1441748,'InstructorSchedulingSolver'),(1441748,'InstructorSchedulingSolverLog'),(1441748,'InstructorsExportPdf'),(1441748,'IsAdmin'),(1441748,'LastChanges'),(1441748,'LimitAndProjectionSnapshot'),(1441748,'MajorEdit'),(1441748,'Majors'),(1441748,'ManageInstructors'),(1441748,'ManageSolvers'),(1441748,'MinorEdit'),(1441748,'Minors'),(1441748,'MultipleClassSetup'),(1441748,'MultipleClassSetupClass'),(1441748,'MultipleClassSetupDepartment'),(1441748,'NonUniversityLocationDelete'),(1441748,'NonUniversityLocationEdit'),(1441748,'NotAssignedClasses'),(1441748,'NotAssignedExaminations'),(1441748,'OfferingCanLock'),(1441748,'OfferingCanUnlock'),(1441748,'OfferingConsentTypes'),(1441748,'OfferingDelete'),(1441748,'OfferingEnrollments'),(1441748,'OfferingMakeNotOffered'),(1441748,'OfferingMakeOffered'),(1441748,'OverrideTypes'),(1441748,'Permissions'),(1441748,'PersonalSchedule'),(1441748,'PersonalScheduleLookup'),(1441748,'PointInTimeData'),(1441748,'PointInTimeDataReports'),(1441748,'PositionTypes'),(1441748,'PreferenceLevels'),(1441748,'ReservationAdd'),(1441748,'ReservationDelete'),(1441748,'ReservationEdit'),(1441748,'ReservationOffering'),(1441748,'Reservations'),(1441748,'Roles'),(1441748,'RoomAvailability'),(1441748,'RoomDelete'),(1441748,'RoomDepartments'),(1441748,'RoomDetail'),(1441748,'RoomDetailAvailability'),(1441748,'RoomDetailEventAvailability'),(1441748,'RoomDetailPeriodPreferences'),(1441748,'RoomEdit'),(1441748,'RoomEditAvailability'),(1441748,'RoomEditChangeCapacity'),(1441748,'RoomEditChangeControll'),(1441748,'RoomEditChangeEventProperties'),(1441748,'RoomEditChangeExaminationStatus'),(1441748,'RoomEditChangeExternalId'),(1441748,'RoomEditChangePicture'),(1441748,'RoomEditChangeRoomProperties'),(1441748,'RoomEditChangeType'),(1441748,'RoomEditEventAvailability'),(1441748,'RoomEditFeatures'),(1441748,'RoomEditGlobalFeatures'),(1441748,'RoomEditGlobalGroups'),(1441748,'RoomEditGroups'),(1441748,'RoomEditPreference'),(1441748,'RoomFeatures'),(1441748,'RoomFeaturesExportPdf'),(1441748,'RoomFeatureTypes'),(1441748,'RoomGroups'),(1441748,'RoomGroupsExportPdf'),(1441748,'Rooms'),(1441748,'RoomsExportCsv'),(1441748,'RoomsExportPdf'),(1441748,'SchedulingAssistant'),(1441748,'SchedulingDashboard'),(1441748,'SchedulingReports'),(1441748,'SchedulingSubpartDetail'),(1441748,'SchedulingSubpartDetailClearClassPreferences'),(1441748,'SchedulingSubpartEdit'),(1441748,'SchedulingSubpartEditClearPreferences'),(1441748,'Scripts'),(1441748,'SessionDefaultCurrent'),(1441748,'SettingsUser'),(1441748,'SolutionChanges'),(1441748,'SolutionReports'),(1441748,'Solver'),(1441748,'SolverGroups'),(1441748,'SolverLog'),(1441748,'SolverSolutionExportCsv'),(1441748,'SolverSolutionExportXml'),(1441748,'SolverSolutionSave'),(1441748,'SponsoringOrganizations'),(1441748,'StandardEventNotes'),(1441748,'StandardEventNotesDepartmentEdit'),(1441748,'StandardEventNotesSessionEdit'),(1441748,'StatusIndependent'),(1441748,'StudentAccommodationEdit'),(1441748,'StudentAccommodations'),(1441748,'StudentAdvisorEdit'),(1441748,'StudentAdvisors'),(1441748,'StudentEnrollments'),(1441748,'StudentGroupEdit'),(1441748,'StudentGroups'),(1441748,'StudentGroupTypes'),(1441748,'StudentScheduling'),(1441748,'StudentSchedulingAdmin'),(1441748,'StudentSchedulingAdvisor'),(1441748,'StudentSchedulingAdvisorCanModifyAllStudents'),(1441748,'StudentSchedulingAdvisorCanModifyMyStudents'),(1441748,'StudentSchedulingCanEnroll'),(1441748,'StudentSchedulingCanRegister'),(1441748,'StudentSchedulingChangeStudentStatus'),(1441748,'StudentSchedulingEmailStudent'),(1441748,'StudentSchedulingMassCancel'),(1441748,'StudentSchedulingStatusTypes'),(1441748,'StudentSectioningSolutionExportXml'),(1441748,'StudentSectioningSolver'),(1441748,'StudentSectioningSolverDashboard'),(1441748,'StudentSectioningSolverLog'),(1441748,'StudentSectioningSolverSave'),(1441748,'SubjectAreaAdd'),(1441748,'SubjectAreaChangeDepartment'),(1441748,'SubjectAreaDelete'),(1441748,'SubjectAreaEdit'),(1441748,'SubjectAreas'),(1441748,'Suggestions'),(1441748,'TaskDetail'),(1441748,'Tasks'),(1441748,'TeachingResponsibilities'),(1441748,'TimePatterns'),(1441748,'TimetableGrid'),(1441748,'TimetableManagerAdd'),(1441748,'TimetableManagerDelete'),(1441748,'TimetableManagerEdit'),(1441748,'TimetableManagers'),(1441748,'Timetables'),(1441748,'TimetablesSolutionChangeNote'),(1441748,'TimetablesSolutionCommit'),(1441748,'TimetablesSolutionDelete'),(1441748,'TimetablesSolutionExportCsv'),(1441748,'TimetablesSolutionLoad'),(1441748,'TimetablesSolutionLoadEmpty'),(1441748,'TravelTimesLoad'),(1441748,'TravelTimesSave'),(1507282,'Events'),(1507282,'SchedulingAssistant');
/*!40000 ALTER TABLE `rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `role_id` decimal(20,0) NOT NULL,
  `reference` varchar(20) DEFAULT NULL,
  `abbv` varchar(40) DEFAULT NULL,
  `manager` int(1) DEFAULT '1',
  `enabled` int(1) DEFAULT '1',
  `instructor` int(1) DEFAULT '0',
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `uk_roles_abbv` (`abbv`),
  UNIQUE KEY `uk_roles_reference` (`reference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Sysadmin','System Administrator',1,1,0),(21,'Dept Sched Mgr','Department Schedule Manager',1,1,0),(41,'View All','View All User',1,1,0),(61,'Exam Mgr','Examination Timetabling Manager',1,1,0),(81,'Event Mgr','Event Manager',1,1,0),(101,'Curriculum Mgr','Curriculum Manager',1,1,0),(1310680,'Advisor','Student Advisor',1,1,0),(1408981,'No Role','No Role',0,1,0),(1408982,'Student','Student',0,1,0),(1408983,'Instructor','Instructor',0,1,0),(1441748,'Administrator','Session Administrator',1,1,0),(1507282,'Anonymous','Anonymous',0,1,0);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `uniqueid` decimal(20,0) NOT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `building_id` decimal(20,0) DEFAULT NULL,
  `room_number` varchar(40) DEFAULT NULL,
  `capacity` bigint(10) DEFAULT NULL,
  `coordinate_x` double DEFAULT NULL,
  `coordinate_y` double DEFAULT NULL,
  `ignore_too_far` int(1) DEFAULT NULL,
  `manager_ids` varchar(3000) DEFAULT NULL,
  `pattern` varchar(2048) DEFAULT NULL,
  `ignore_room_check` int(1) DEFAULT '0',
  `classification` varchar(20) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `exam_capacity` bigint(10) DEFAULT '0',
  `permanent_id` decimal(20,0) NOT NULL,
  `room_type` decimal(20,0) DEFAULT NULL,
  `event_dept_id` decimal(20,0) DEFAULT NULL,
  `area` double DEFAULT NULL,
  `break_time` bigint(10) DEFAULT NULL,
  `event_status` bigint(10) DEFAULT NULL,
  `note` varchar(2048) DEFAULT NULL,
  `availability` varchar(2048) DEFAULT NULL,
  `share_note` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_room` (`session_id`,`building_id`,`room_number`),
  KEY `idx_room_building` (`building_id`),
  KEY `idx_room_permid` (`permanent_id`,`session_id`),
  KEY `fk_room_type` (`room_type`),
  KEY `fk_room_event_dept` (`event_dept_id`),
  CONSTRAINT `fk_room_building` FOREIGN KEY (`building_id`) REFERENCES `building` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_room_event_dept` FOREIGN KEY (`event_dept_id`) REFERENCES `department` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_room_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_room_type` FOREIGN KEY (`room_type`) REFERENCES `room_type` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_dept`
--

DROP TABLE IF EXISTS `room_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_dept` (
  `uniqueid` decimal(20,0) NOT NULL,
  `room_id` decimal(20,0) DEFAULT NULL,
  `department_id` decimal(20,0) DEFAULT NULL,
  `is_control` int(1) DEFAULT '0',
  PRIMARY KEY (`uniqueid`),
  KEY `idx_room_dept_dept` (`department_id`),
  KEY `idx_room_dept_room` (`room_id`),
  CONSTRAINT `fk_room_dept_dept` FOREIGN KEY (`department_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_dept`
--

LOCK TABLES `room_dept` WRITE;
/*!40000 ALTER TABLE `room_dept` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_exam_type`
--

DROP TABLE IF EXISTS `room_exam_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_exam_type` (
  `location_id` decimal(20,0) NOT NULL,
  `exam_type_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`location_id`,`exam_type_id`),
  KEY `fk_room_exam_type` (`exam_type_id`),
  CONSTRAINT `fk_room_exam_type` FOREIGN KEY (`exam_type_id`) REFERENCES `exam_type` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_exam_type`
--

LOCK TABLES `room_exam_type` WRITE;
/*!40000 ALTER TABLE `room_exam_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_exam_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_feature`
--

DROP TABLE IF EXISTS `room_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_feature` (
  `uniqueid` decimal(20,0) NOT NULL,
  `discriminator` varchar(10) DEFAULT NULL,
  `label` varchar(60) DEFAULT NULL,
  `sis_reference` varchar(20) DEFAULT NULL,
  `sis_value` varchar(20) DEFAULT NULL,
  `department_id` decimal(20,0) DEFAULT NULL,
  `abbv` varchar(60) DEFAULT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `feature_type_id` decimal(20,0) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_room_feature_dept` (`department_id`),
  KEY `fk_room_feature_session` (`session_id`),
  KEY `fk_feature_type` (`feature_type_id`),
  CONSTRAINT `fk_feature_type` FOREIGN KEY (`feature_type_id`) REFERENCES `feature_type` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_room_feature_dept` FOREIGN KEY (`department_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_room_feature_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_feature`
--

LOCK TABLES `room_feature` WRITE;
/*!40000 ALTER TABLE `room_feature` DISABLE KEYS */;
INSERT INTO `room_feature` VALUES (123,'global','Audio Recording','audioRecording',NULL,NULL,'AudRec',239259,NULL,NULL),(125,'global','Computer','puccComputer',NULL,NULL,'Comp',239259,NULL,NULL),(437,'global','Fixed Seating','fixedSeating',NULL,NULL,'FixSeat',239259,NULL,NULL),(438,'global','Computer Projection','computerProjection',NULL,NULL,'CompPr',239259,NULL,NULL),(440,'global','Tables and Chairs','seatingType','tablesAndChairs',NULL,'Tbls&Chrs',239259,NULL,NULL),(441,'global','Tablet Arm Chairs','seatingType','tabletArmChairs',NULL,'TblArmChr',239259,NULL,NULL),(442,'global','Theater Seats','seatingType','theaterSeats',NULL,'ThtrSeat',239259,NULL,NULL),(468,'global','Chalkboard < 20 Ft.','feetOfChalkboard','< 20',NULL,'Ch<20F',239259,NULL,NULL),(469,'global','Chalkboard >= 20 Ft.','feetOfChalkboard','>= 20',NULL,'Ch>=20F',239259,NULL,NULL);
/*!40000 ALTER TABLE `room_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_feature_pref`
--

DROP TABLE IF EXISTS `room_feature_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_feature_pref` (
  `uniqueid` decimal(20,0) NOT NULL,
  `owner_id` decimal(20,0) DEFAULT NULL,
  `pref_level_id` decimal(20,0) DEFAULT NULL,
  `room_feature_id` decimal(20,0) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_room_feat_pref_level` (`pref_level_id`),
  KEY `idx_room_feat_pref_owner` (`owner_id`),
  KEY `idx_room_feat_pref_room_feat` (`room_feature_id`),
  CONSTRAINT `fk_room_feat_pref_level` FOREIGN KEY (`pref_level_id`) REFERENCES `preference_level` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_room_feat_pref_room_feat` FOREIGN KEY (`room_feature_id`) REFERENCES `room_feature` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_feature_pref`
--

LOCK TABLES `room_feature_pref` WRITE;
/*!40000 ALTER TABLE `room_feature_pref` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_feature_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_group`
--

DROP TABLE IF EXISTS `room_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_group` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `global` int(1) DEFAULT NULL,
  `default_group` int(1) DEFAULT NULL,
  `department_id` decimal(20,0) DEFAULT NULL,
  `abbv` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_room_group_dept` (`department_id`),
  KEY `idx_room_group_session` (`session_id`),
  CONSTRAINT `fk_room_group_dept` FOREIGN KEY (`department_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_room_group_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_group`
--

LOCK TABLES `room_group` WRITE;
/*!40000 ALTER TABLE `room_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_group_pref`
--

DROP TABLE IF EXISTS `room_group_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_group_pref` (
  `uniqueid` decimal(20,0) NOT NULL,
  `owner_id` decimal(20,0) DEFAULT NULL,
  `pref_level_id` decimal(20,0) DEFAULT NULL,
  `room_group_id` decimal(20,0) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_room_group_pref_level` (`pref_level_id`),
  KEY `idx_room_group_pref_owner` (`owner_id`),
  KEY `idx_room_group_pref_room_grp` (`room_group_id`),
  CONSTRAINT `fk_room_group_pref_level` FOREIGN KEY (`pref_level_id`) REFERENCES `preference_level` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_room_group_pref_room_grp` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_group_pref`
--

LOCK TABLES `room_group_pref` WRITE;
/*!40000 ALTER TABLE `room_group_pref` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_group_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_group_room`
--

DROP TABLE IF EXISTS `room_group_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_group_room` (
  `room_group_id` decimal(20,0) NOT NULL,
  `room_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`room_group_id`,`room_id`),
  CONSTRAINT `fk_room_group_room_room_grp` FOREIGN KEY (`room_group_id`) REFERENCES `room_group` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_group_room`
--

LOCK TABLES `room_group_room` WRITE;
/*!40000 ALTER TABLE `room_group_room` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_group_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_join_room_feature`
--

DROP TABLE IF EXISTS `room_join_room_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_join_room_feature` (
  `room_id` decimal(20,0) DEFAULT NULL,
  `feature_id` decimal(20,0) DEFAULT NULL,
  UNIQUE KEY `uk_room_join_room_feat_rm_feat` (`room_id`,`feature_id`),
  KEY `fk_room_join_room_feat_rm_feat` (`feature_id`),
  CONSTRAINT `fk_room_join_room_feat_rm_feat` FOREIGN KEY (`feature_id`) REFERENCES `room_feature` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_join_room_feature`
--

LOCK TABLES `room_join_room_feature` WRITE;
/*!40000 ALTER TABLE `room_join_room_feature` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_join_room_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_picture`
--

DROP TABLE IF EXISTS `room_picture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_picture` (
  `uniqueid` decimal(20,0) NOT NULL,
  `location_id` decimal(20,0) NOT NULL,
  `data_file` longblob NOT NULL,
  `file_name` varchar(260) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `content_type` varchar(260) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `time_stamp` datetime NOT NULL,
  `type_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_room_picture` (`location_id`),
  KEY `fk_room_picture_type` (`type_id`),
  CONSTRAINT `fk_room_picture` FOREIGN KEY (`location_id`) REFERENCES `room` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_room_picture_type` FOREIGN KEY (`type_id`) REFERENCES `attachment_type` (`uniqueid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_picture`
--

LOCK TABLES `room_picture` WRITE;
/*!40000 ALTER TABLE `room_picture` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_picture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_pref`
--

DROP TABLE IF EXISTS `room_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_pref` (
  `uniqueid` decimal(20,0) NOT NULL,
  `owner_id` decimal(20,0) DEFAULT NULL,
  `pref_level_id` decimal(20,0) DEFAULT NULL,
  `room_id` decimal(20,0) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_room_pref_level` (`pref_level_id`),
  KEY `idx_room_pref_owner` (`owner_id`),
  CONSTRAINT `fk_room_pref_level` FOREIGN KEY (`pref_level_id`) REFERENCES `preference_level` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_pref`
--

LOCK TABLES `room_pref` WRITE;
/*!40000 ALTER TABLE `room_pref` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_service_provider`
--

DROP TABLE IF EXISTS `room_service_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_service_provider` (
  `location_id` decimal(20,0) NOT NULL,
  `provider_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`location_id`,`provider_id`),
  KEY `fk_room_service_provider` (`provider_id`),
  CONSTRAINT `fk_room_service_loc` FOREIGN KEY (`location_id`) REFERENCES `room` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_room_service_provider` FOREIGN KEY (`provider_id`) REFERENCES `service_provider` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_service_provider`
--

LOCK TABLES `room_service_provider` WRITE;
/*!40000 ALTER TABLE `room_service_provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_service_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_type`
--

DROP TABLE IF EXISTS `room_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_type` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) NOT NULL,
  `label` varchar(60) NOT NULL,
  `ord` bigint(10) NOT NULL,
  `is_room` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_type`
--

LOCK TABLES `room_type` WRITE;
/*!40000 ALTER TABLE `room_type` DISABLE KEYS */;
INSERT INTO `room_type` VALUES (425,'genClassroom','Classrooms',0,1),(426,'computingLab','Computing Laboratories',1,1),(427,'departmental','Additional Instructional Rooms',2,1),(428,'specialUse','Special Use Rooms',3,1),(429,'nonUniversity','Outside Locations',4,0);
/*!40000 ALTER TABLE `room_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_type_option`
--

DROP TABLE IF EXISTS `room_type_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_type_option` (
  `room_type` decimal(20,0) NOT NULL,
  `status` bigint(10) NOT NULL,
  `message` varchar(2048) DEFAULT NULL,
  `break_time` bigint(10) NOT NULL DEFAULT '0',
  `department_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`room_type`,`department_id`),
  KEY `fk_rtype_option_department` (`department_id`),
  CONSTRAINT `fk_rtype_option_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_rtype_option_type` FOREIGN KEY (`room_type`) REFERENCES `room_type` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_type_option`
--

LOCK TABLES `room_type_option` WRITE;
/*!40000 ALTER TABLE `room_type_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_type_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_hql`
--

DROP TABLE IF EXISTS `saved_hql`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saved_hql` (
  `uniqueid` decimal(20,0) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `query` longtext NOT NULL,
  `type` decimal(10,0) NOT NULL,
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_hql`
--

LOCK TABLES `saved_hql` WRITE;
/*!40000 ALTER TABLE `saved_hql` DISABLE KEYS */;
INSERT INTO `saved_hql` VALUES (1146845,'Not-assigned Classes','List all classes with a time pattern (i.e., classes that should not be Arrange Hours) which do not have a committed assignment.','select c.uniqueId as __Class, co.subjectAreaAbbv || \' \' || co.courseNbr as Course, s.itype.abbv || \' \' || c.sectionNumberCache as Section, co.title as Title from Class_ c inner join c.schedulingSubpart s inner join s.instrOfferingConfig.instructionalOffering.courseOfferings co where c.uniqueId in ( select x.uniqueId from Class_ x, TimePref p where (p.owner = x or p.owner = x.schedulingSubpart) and p.prefLevel.prefProlog = \'R\' ) and co.subjectArea.uniqueId in %SUBJECTS% and c.committedAssignment is null order by co.subjectAreaAbbv, co.courseNbr, s.itype.abbv, c.sectionNumberCache',1),(1146846,'Multi/No Room Classes','List all classes that either:<ul><li>either require more than one room</li><li>or require no room</li><li>or have zero room ratio</li></ul>','select c.uniqueId as __Class, co.subjectAreaAbbv || \' \' || co.courseNbr as Course, s.itype.abbv || \' \' || c.sectionNumberCache as Section, c.nbrRooms as Nbr_Rooms, c.roomRatio as Room_Ratio from Class_ c inner join c.schedulingSubpart s inner join s.instrOfferingConfig.instructionalOffering.courseOfferings co where co.subjectArea.uniqueId in %SUBJECTS% and (c.nbrRooms != 1 or c.roomRatio = 0.0) order by co.subjectAreaAbbv, co.courseNbr, s.itype.abbv, c.sectionNumberCache',1),(1146847,'Schedule Note Classes','List of all classes that has something entered in Student Schedule Note.','select c.uniqueId as __Class, co.subjectAreaAbbv || \' \' || co.courseNbr as Course, s.itype.abbv || \' \' || c.sectionNumberCache as Section, c.schedulePrintNote as Student_Schedule_Note from Class_ c inner join c.schedulingSubpart s inner join s.instrOfferingConfig.instructionalOffering.courseOfferings co where co.subjectArea.uniqueId in %SUBJECTS% and c.schedulePrintNote is not null order by co.subjectAreaAbbv, co.courseNbr, s.itype.abbv, c.sectionNumberCache',1),(1146848,'Request Notes Classes','List of all classes that has something entered in Requests / Notes to Schedule Manager.','select c.uniqueId as __Class, co.subjectAreaAbbv || \' \' || co.courseNbr as Course, s.itype.abbv || \' \' || c.sectionNumberCache as Section, c.notes as Notes_to_Schedule_Manager from Class_ c inner join c.schedulingSubpart s inner join s.instrOfferingConfig.instructionalOffering.courseOfferings co where co.subjectArea.uniqueId in %SUBJECTS% and c.notes is not null order by co.subjectAreaAbbv, co.courseNbr, s.itype.abbv, c.sectionNumberCache',1),(1146849,'Schedule Book Note Courses','List of all courses that has something entered in Schedule Book Note.','select co.instructionalOffering.uniqueId as __Offering, co.subjectAreaAbbv || \' \' || co.courseNbr as Course, co.scheduleBookNote as Schedule_Book_Note from CourseOffering co where co.subjectArea.uniqueId in %SUBJECTS% and co.scheduleBookNote is not null order by co.subjectAreaAbbv, co.courseNbr',1),(1146850,'New Courses','List of all courses that do not have external unique id and courses that have no title.','select co.instructionalOffering.uniqueId as __Offering, co.subjectAreaAbbv || \' \' || co.courseNbr as Course, co.title as Title from CourseOffering co where co.subjectArea.uniqueId in %SUBJECTS% and (co.externalUniqueId is null or co.title is null) order by co.subjectAreaAbbv, co.courseNbr',1),(1146851,'Arrange Hours Classes','List all classes that do not have a time pattern.','select c.uniqueId as __Class, co.subjectAreaAbbv || \' \' || co.courseNbr as Course, s.itype.abbv || \' \' || c.sectionNumberCache as Section, co.title as Title from Class_ c inner join c.schedulingSubpart s inner join s.instrOfferingConfig.instructionalOffering.courseOfferings co where c.uniqueId not in ( select x.uniqueId from Class_ x, TimePref p where (p.owner = x or p.owner = x.schedulingSubpart) and p.prefLevel.prefProlog = \'R\' ) and co.subjectArea.uniqueId in %SUBJECTS% order by co.subjectAreaAbbv, co.courseNbr, s.itype.abbv, c.sectionNumberCache',1),(1146852,'Cross-listed Courses','List all courses of a given subject area (or subject areas) that are cross-listed.','select co.instructionalOffering.uniqueId as __Offering, co.subjectAreaAbbv || \' \' || co.courseNbr as Course, co.title as Course_Title, ctr.subjectAreaAbbv || \' \' || ctr.courseNbr as Controlling, ctr.title as Controlling_Title from CourseOffering co, CourseOffering ctr where co.subjectArea in %SUBJECTS% and co.isControl is false and co.instructionalOffering = ctr.instructionalOffering and ctr.isControl is true order by co.subjectAreaAbbv, co.courseNbr',1),(1146853,'No-conflict Instructors','List of instructors (and their classes) that are not checked for instructor conflicts.','select c.uniqueId as __Class, co.subjectAreaAbbv || \' \' || co.courseNbr as Course, s.itype.abbv || \' \' || c.sectionNumberCache as Section, i.instructor.lastName || \', \' || i.instructor.firstName || \' \' || i.instructor.middleName as Instructor, i.instructor.externalUniqueId as External_Id from ClassInstructor i inner join i.classInstructing c inner join c.schedulingSubpart s inner join s.instrOfferingConfig.instructionalOffering.courseOfferings co where i.lead = false and co.subjectArea.uniqueId in %SUBJECTS% order by co.subjectAreaAbbv, co.courseNbr, s.itype.abbv, c.sectionNumberCache, i.instructor.lastName',1),(1146854,'Small Room Classes','List all classes that require (or prefer) a room that is too small for the class to fit in.','select c.uniqueId as __Class, co.subjectAreaAbbv || \' \' || co.courseNbr as Course, s.itype.abbv || \' \' || c.sectionNumberCache as Section, p.room.building.abbreviation || \' \' || p.room.roomNumber as Room, p.room.capacity as Size, case c.roomRatio when 1.0 then (c.expectedCapacity || \'\') else (floor(c.expectedCapacity * c.roomRatio) || \' (\' || c.roomRatio || \' x \' || c.expectedCapacity || \')\') end as Needed, p.prefLevel.prefName as Preference from Class_ c inner join c.schedulingSubpart s inner join s.instrOfferingConfig.instructionalOffering.courseOfferings co, RoomPref p where co.subjectArea.uniqueId in %SUBJECTS% and (p.owner = c or p.owner = s) and floor(c.expectedCapacity * c.roomRatio) > p.room.capacity and p.prefLevel.prefProlog in (\'R\', \'-1\', \'-2\') and c.nbrRooms > 0 order by co.subjectAreaAbbv, co.courseNbr, s.itype.abbv, c.sectionNumberCache',1),(1638350,'Message Log','Display message log','select\n  timeStamp as Time,\n  (case level when 50000 then \'<font color=\"red\">Fatal</font>\' when 40000 then \'<font color=\"red\">Error</font>\' when 30000 then \'<font color=\"orange\">Warning</font>\' when 20000 then \'Info\' when 10000 then \'Debug\' else \'Other\' end) as Level,\n  logger as Logger,\n  (case when exception is null then message when message is null then exception else (message || \'\\\\n\' || exception) end) as Message,\n  (case when ndc is null then thread else (thread || \'\\\\n\' || ndc) end) as Context\nfrom MessageLog order by timeStamp desc',16),(1638351,'Query Log','Display query log','select\n  m.lastName || \' \' || m.firstName as User,\n  case\n    when q.uri like \'%.gwt: %\' then substring(q.uri, instr(q.uri, \':\') + 1)\n    else q.uri end as Query,\n  case\n    when q.uri like \'%.gwt: %\' and length(q.query) <= 165 + instr(q.query, \'org.unitime.timetable.gwt.services.\')\n      then substring(q.query, instr(q.query, \'org.unitime.timetable.gwt.services.\') + 35)\n    when q.uri like \'%.gwt: %\'\n      then (substring(substring(q.query, instr(q.query, \'org.unitime.timetable.gwt.services.\') + 35), 1, 130) || \'...\')\n    when q.query is null or length(q.query) < 130 then q.query\n    else (substring(q.query, 1, 130) || \'...\') end as Parameters,\n  q.timeStamp as Time_Stamp,\n  q.timeSpent / 1000.0 as Time\nfrom QueryLog q, TimetableManager m\nwhere \n  q.uid = m.externalUniqueId and q.uri not like \'menu.gwt%\'\norder by q.timeStamp desc',16);
/*!40000 ALTER TABLE `saved_hql` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduling_subpart`
--

DROP TABLE IF EXISTS `scheduling_subpart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduling_subpart` (
  `uniqueid` decimal(20,0) NOT NULL,
  `min_per_wk` int(4) DEFAULT NULL,
  `parent` decimal(20,0) DEFAULT NULL,
  `config_id` decimal(20,0) DEFAULT NULL,
  `itype` int(2) DEFAULT NULL,
  `date_pattern_id` decimal(20,0) DEFAULT NULL,
  `auto_time_spread` int(1) DEFAULT '1',
  `subpart_suffix` varchar(5) DEFAULT NULL,
  `student_allow_overlap` int(1) DEFAULT '0',
  `last_modified_time` datetime DEFAULT NULL,
  `uid_rolled_fwd_from` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_sched_subpart_config` (`config_id`),
  KEY `idx_sched_subpart_date_pattern` (`date_pattern_id`),
  KEY `idx_sched_subpart_itype` (`itype`),
  KEY `idx_sched_subpart_parent` (`parent`),
  CONSTRAINT `fk_sched_subpart_config` FOREIGN KEY (`config_id`) REFERENCES `instr_offering_config` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_sched_subpart_date_pattern` FOREIGN KEY (`date_pattern_id`) REFERENCES `date_pattern` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_sched_subpart_itype` FOREIGN KEY (`itype`) REFERENCES `itype_desc` (`itype`) ON DELETE CASCADE,
  CONSTRAINT `fk_sched_subpart_parent` FOREIGN KEY (`parent`) REFERENCES `scheduling_subpart` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduling_subpart`
--

LOCK TABLES `scheduling_subpart` WRITE;
/*!40000 ALTER TABLE `scheduling_subpart` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduling_subpart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `script`
--

DROP TABLE IF EXISTS `script`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `script` (
  `uniqueid` decimal(20,0) NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `engine` varchar(32) NOT NULL,
  `permission` varchar(128) DEFAULT NULL,
  `script` longtext NOT NULL,
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `script`
--

LOCK TABLES `script` WRITE;
/*!40000 ALTER TABLE `script` DISABLE KEYS */;
/*!40000 ALTER TABLE `script` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `script_parameter`
--

DROP TABLE IF EXISTS `script_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `script_parameter` (
  `script_id` decimal(20,0) NOT NULL,
  `name` varchar(128) NOT NULL,
  `label` varchar(256) DEFAULT NULL,
  `type` varchar(2048) NOT NULL,
  `default_value` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`script_id`,`name`),
  CONSTRAINT `fk_script_parameter` FOREIGN KEY (`script_id`) REFERENCES `script` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `script_parameter`
--

LOCK TABLES `script_parameter` WRITE;
/*!40000 ALTER TABLE `script_parameter` DISABLE KEYS */;
/*!40000 ALTER TABLE `script_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sct_solution_log`
--

DROP TABLE IF EXISTS `sct_solution_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sct_solution_log` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) NOT NULL,
  `owner_id` decimal(20,0) NOT NULL,
  `time_stamp` datetime NOT NULL,
  `data` longblob NOT NULL,
  `info` varchar(4000) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_sct_sol_log_session` (`session_id`),
  KEY `fk_sct_sol_log_owner` (`owner_id`),
  CONSTRAINT `fk_sct_sol_log_owner` FOREIGN KEY (`owner_id`) REFERENCES `timetable_manager` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_sct_sol_log_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sct_solution_log`
--

LOCK TABLES `sct_solution_log` WRITE;
/*!40000 ALTER TABLE `sct_solution_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sct_solution_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sect_pref`
--

DROP TABLE IF EXISTS `sect_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sect_pref` (
  `uniqueid` decimal(20,0) NOT NULL,
  `preference_type` decimal(10,0) NOT NULL,
  `request_id` decimal(20,0) NOT NULL,
  `required` int(1) NOT NULL,
  `class_id` decimal(20,0) DEFAULT NULL,
  `instr_mthd_id` decimal(20,0) DEFAULT NULL,
  `label` varchar(60) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_sct_pref_request` (`request_id`),
  KEY `fk_sct_pref_class` (`class_id`),
  KEY `fk_sct_pref_im` (`instr_mthd_id`),
  KEY `idx_sect_pref_label` (`label`,`required`),
  CONSTRAINT `fk_sct_pref_class` FOREIGN KEY (`class_id`) REFERENCES `class_` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_sct_pref_im` FOREIGN KEY (`instr_mthd_id`) REFERENCES `instructional_method` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_sct_pref_request` FOREIGN KEY (`request_id`) REFERENCES `course_request` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sect_pref`
--

LOCK TABLES `sect_pref` WRITE;
/*!40000 ALTER TABLE `sect_pref` DISABLE KEYS */;
/*!40000 ALTER TABLE `sect_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sectioning_course_types`
--

DROP TABLE IF EXISTS `sectioning_course_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sectioning_course_types` (
  `sectioning_status_id` decimal(20,0) NOT NULL,
  `course_type_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`sectioning_status_id`,`course_type_id`),
  KEY `fk_sect_course_type` (`course_type_id`),
  CONSTRAINT `fk_sect_course_status` FOREIGN KEY (`sectioning_status_id`) REFERENCES `sectioning_status` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_sect_course_type` FOREIGN KEY (`course_type_id`) REFERENCES `course_type` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sectioning_course_types`
--

LOCK TABLES `sectioning_course_types` WRITE;
/*!40000 ALTER TABLE `sectioning_course_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `sectioning_course_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sectioning_info`
--

DROP TABLE IF EXISTS `sectioning_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sectioning_info` (
  `uniqueid` decimal(20,0) NOT NULL,
  `class_id` decimal(20,0) DEFAULT NULL,
  `nbr_exp_students` double DEFAULT NULL,
  `nbr_hold_students` double DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_sectioning_info_class` (`class_id`),
  CONSTRAINT `fk_sectioning_info_class` FOREIGN KEY (`class_id`) REFERENCES `class_` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sectioning_info`
--

LOCK TABLES `sectioning_info` WRITE;
/*!40000 ALTER TABLE `sectioning_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `sectioning_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sectioning_log`
--

DROP TABLE IF EXISTS `sectioning_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sectioning_log` (
  `uniqueid` decimal(20,0) NOT NULL,
  `time_stamp` datetime NOT NULL,
  `student` varchar(40) NOT NULL,
  `session_id` decimal(20,0) NOT NULL,
  `operation` varchar(20) NOT NULL,
  `action` longblob NOT NULL,
  `result` bigint(10) DEFAULT NULL,
  `user_id` varchar(40) DEFAULT NULL,
  `cpu_time` bigint(20) DEFAULT NULL,
  `wall_time` bigint(20) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `api_get_time` bigint(20) DEFAULT NULL,
  `api_post_time` bigint(20) DEFAULT NULL,
  `api_exception` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_sectioning_log_session` (`session_id`),
  KEY `idx_sectioning_log` (`time_stamp`,`student`,`session_id`,`operation`),
  CONSTRAINT `fk_sectioning_log_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sectioning_log`
--

LOCK TABLES `sectioning_log` WRITE;
/*!40000 ALTER TABLE `sectioning_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sectioning_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sectioning_queue`
--

DROP TABLE IF EXISTS `sectioning_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sectioning_queue` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) NOT NULL,
  `type` bigint(10) NOT NULL,
  `time_stamp` datetime NOT NULL,
  `message` longtext,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_sect_queue_session_ts` (`session_id`,`time_stamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sectioning_queue`
--

LOCK TABLES `sectioning_queue` WRITE;
/*!40000 ALTER TABLE `sectioning_queue` DISABLE KEYS */;
INSERT INTO `sectioning_queue` VALUES (2097152,239259,2,'2019-05-20 06:45:01','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<generic><user id=\"1\">Admin, Deafult</user></generic>');
/*!40000 ALTER TABLE `sectioning_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sectioning_status`
--

DROP TABLE IF EXISTS `sectioning_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sectioning_status` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) NOT NULL,
  `label` varchar(60) NOT NULL,
  `status` bigint(10) NOT NULL,
  `message` varchar(500) DEFAULT NULL,
  `fallback_id` decimal(20,0) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `stop_date` date DEFAULT NULL,
  `start_slot` bigint(10) DEFAULT NULL,
  `stop_slot` bigint(10) DEFAULT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_sct_status_fallback` (`fallback_id`),
  KEY `fk_sct_status_session` (`session_id`),
  CONSTRAINT `fk_sct_status_fallback` FOREIGN KEY (`fallback_id`) REFERENCES `sectioning_status` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_sct_status_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sectioning_status`
--

LOCK TABLES `sectioning_status` WRITE;
/*!40000 ALTER TABLE `sectioning_status` DISABLE KEYS */;
INSERT INTO `sectioning_status` VALUES (1343447,'Enabled','Access enabled',28631,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1343448,'Disabled','Access disabled',20,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1343449,'Not Available','Temporarily not available',16535,'Access is temporarily disabled. Please try again later...',NULL,NULL,NULL,NULL,NULL,NULL),(1343450,'No Email','Access enabled, no email notification',28627,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `sectioning_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_provider`
--

DROP TABLE IF EXISTS `service_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_provider` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) NOT NULL,
  `label` varchar(60) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `department_id` decimal(20,0) DEFAULT NULL,
  `all_rooms` int(1) DEFAULT '1',
  `visible` int(1) DEFAULT '1',
  PRIMARY KEY (`uniqueid`),
  KEY `fk_service_provider_session` (`session_id`),
  KEY `fk_service_provider_dept` (`department_id`),
  CONSTRAINT `fk_service_provider_dept` FOREIGN KEY (`department_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_service_provider_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_provider`
--

LOCK TABLES `service_provider` WRITE;
/*!40000 ALTER TABLE `service_provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_config`
--

DROP TABLE IF EXISTS `session_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session_config` (
  `session_id` decimal(20,0) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` varchar(4000) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`session_id`,`name`),
  CONSTRAINT `fk_session_config` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_config`
--

LOCK TABLES `session_config` WRITE;
/*!40000 ALTER TABLE `session_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `session_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `academic_initiative` varchar(20) DEFAULT NULL,
  `session_begin_date_time` datetime DEFAULT NULL,
  `classes_end_date_time` datetime DEFAULT NULL,
  `session_end_date_time` datetime DEFAULT NULL,
  `uniqueid` decimal(20,0) NOT NULL,
  `holidays` varchar(400) DEFAULT NULL,
  `def_datepatt_id` decimal(20,0) DEFAULT NULL,
  `status_type` decimal(20,0) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `academic_year` varchar(4) DEFAULT NULL,
  `academic_term` varchar(20) DEFAULT NULL,
  `exam_begin_date` datetime DEFAULT NULL,
  `event_begin_date` datetime DEFAULT NULL,
  `event_end_date` datetime DEFAULT NULL,
  `sect_status` decimal(20,0) DEFAULT NULL,
  `wk_enroll` bigint(10) NOT NULL DEFAULT '1',
  `wk_change` bigint(10) NOT NULL DEFAULT '1',
  `wk_drop` bigint(10) NOT NULL DEFAULT '1',
  `duration_type_id` decimal(20,0) DEFAULT NULL,
  `instr_method_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_sessions_date_pattern` (`def_datepatt_id`),
  KEY `idx_sessions_status_type` (`status_type`),
  KEY `fk_session_sect_status` (`sect_status`),
  KEY `fk_session_durtype` (`duration_type_id`),
  KEY `fk_session_insmtd` (`instr_method_id`),
  CONSTRAINT `fk_session_datepatt` FOREIGN KEY (`def_datepatt_id`) REFERENCES `date_pattern` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_session_durtype` FOREIGN KEY (`duration_type_id`) REFERENCES `duration_type` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_session_insmtd` FOREIGN KEY (`instr_method_id`) REFERENCES `instructional_method` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_session_sect_status` FOREIGN KEY (`sect_status`) REFERENCES `sectioning_status` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_sessions_status_type` FOREIGN KEY (`status_type`) REFERENCES `dept_status_type` (`uniqueid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('EIIA','2019-09-09 00:00:00','2019-12-20 00:00:00','2020-01-24 00:00:00',239259,'000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',NULL,266,NULL,'2019','Primer semestre','2020-01-08 00:00:00','2019-09-09 00:00:00','2020-01-24 00:00:00',NULL,1,1,1,1703884,NULL);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `uniqueid` decimal(20,0) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `default_value` varchar(100) DEFAULT NULL,
  `allowed_values` varchar(500) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (42,'timeGrid','vertical','horizontal,vertical,text','Time grid display format'),(85,'name','last-initial','last-first,first-last,initial-last,last-initial,first-middle-last,short,title-first-middle-last,last-first-middle-title,title-initial-last,title-last-initial','Instructor name display format'),(86,'cfgAutoCalc','yes','yes,no','Automatically calculate number of classes and room size when editing configuration'),(87,'timeGridSize','Workdays x Daytime','Workdays x Daytime,All Week x Daytime,Workdays x Evening,All Week x Evening,All Week x All Times','Time grid default selection'),(88,'jsConfirm','yes','yes,no','Display confirmation dialogs'),(89,'inheritInstrPref','never','ask,always,never','Inherit instructor preferences on a class'),(108,'showVarLimits','no','yes,no','Show the option to set variable class limits'),(128,'keepSort','no','yes,no','Sort classes on detail pages'),(148,'roomFeaturesInOneColumn','yes','yes,no','Display Room Features In One Column'),(168,'dispLastChanges','yes','yes,no','Display information from the change log in pages.'),(188,'printNoteDisplay','icon','icon,shortened text,full text','Display an icon or shortened text when a class has a schedule print note.'),(189,'crsOffrNoteDisplay','icon','icon,shortened text,full text','Display an icon or shortened text when a course offering has a schedule note.'),(190,'mgrNoteDisplay','icon','icon,shortened text,full text','Display an icon or shortened text when a class has a note to the schedule manager.'),(208,'unitime.menu.style','Dynamic On Top','Dynamic On Top,Static On Top,Tree On Side,Stack On Side','Menu style');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solution`
--

DROP TABLE IF EXISTS `solution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solution` (
  `uniqueid` decimal(20,0) NOT NULL,
  `created` datetime DEFAULT NULL,
  `valid` int(1) DEFAULT NULL,
  `commited` int(1) DEFAULT NULL,
  `commit_date` datetime DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `creator` varchar(250) DEFAULT NULL,
  `owner_id` decimal(20,0) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_solution_owner` (`owner_id`),
  CONSTRAINT `fk_solution_owner` FOREIGN KEY (`owner_id`) REFERENCES `solver_group` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solution`
--

LOCK TABLES `solution` WRITE;
/*!40000 ALTER TABLE `solution` DISABLE KEYS */;
/*!40000 ALTER TABLE `solution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solver_gr_to_tt_mgr`
--

DROP TABLE IF EXISTS `solver_gr_to_tt_mgr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solver_gr_to_tt_mgr` (
  `solver_group_id` decimal(20,0) NOT NULL,
  `timetable_mgr_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`solver_group_id`,`timetable_mgr_id`),
  KEY `fk_solver_gr_to_tt_mgr_tt_mgr` (`timetable_mgr_id`),
  CONSTRAINT `fk_solver_gr_to_tt_mgr_solvgrp` FOREIGN KEY (`solver_group_id`) REFERENCES `solver_group` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_solver_gr_to_tt_mgr_tt_mgr` FOREIGN KEY (`timetable_mgr_id`) REFERENCES `timetable_manager` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solver_gr_to_tt_mgr`
--

LOCK TABLES `solver_gr_to_tt_mgr` WRITE;
/*!40000 ALTER TABLE `solver_gr_to_tt_mgr` DISABLE KEYS */;
/*!40000 ALTER TABLE `solver_gr_to_tt_mgr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solver_group`
--

DROP TABLE IF EXISTS `solver_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solver_group` (
  `uniqueid` decimal(20,0) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `abbv` varchar(50) DEFAULT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_solver_group_session` (`session_id`),
  CONSTRAINT `fk_solver_group_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solver_group`
--

LOCK TABLES `solver_group` WRITE;
/*!40000 ALTER TABLE `solver_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `solver_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solver_info`
--

DROP TABLE IF EXISTS `solver_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solver_info` (
  `uniqueid` decimal(20,0) NOT NULL,
  `type` bigint(10) DEFAULT NULL,
  `value` longblob,
  `opt` varchar(250) DEFAULT NULL,
  `solver_info_def_id` decimal(20,0) DEFAULT NULL,
  `solution_id` decimal(20,0) DEFAULT NULL,
  `assignment_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_solver_info` (`assignment_id`),
  KEY `idx_solver_info_solution` (`solution_id`,`solver_info_def_id`),
  KEY `fk_solver_info_def` (`solver_info_def_id`),
  CONSTRAINT `fk_solver_info_assignment` FOREIGN KEY (`assignment_id`) REFERENCES `assignment` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_solver_info_def` FOREIGN KEY (`solver_info_def_id`) REFERENCES `solver_info_def` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_solver_info_solution` FOREIGN KEY (`solution_id`) REFERENCES `solution` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solver_info`
--

LOCK TABLES `solver_info` WRITE;
/*!40000 ALTER TABLE `solver_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `solver_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solver_info_def`
--

DROP TABLE IF EXISTS `solver_info_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solver_info_def` (
  `uniqueid` decimal(20,0) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `implementation` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solver_info_def`
--

LOCK TABLES `solver_info_def` WRITE;
/*!40000 ALTER TABLE `solver_info_def` DISABLE KEYS */;
INSERT INTO `solver_info_def` VALUES (1,'GlobalInfo','Global solution information table','org.unitime.timetable.solver.ui.PropertiesInfo'),(2,'CBSInfo','Conflict-based statistics','org.unitime.timetable.solver.ui.ConflictStatisticsInfo'),(3,'AssignmentInfo','Preferences of a single assignment','org.unitime.timetable.solver.ui.AssignmentPreferenceInfo'),(4,'DistributionInfo','Distribution (group constraint) preferences','org.unitime.timetable.solver.ui.GroupConstraintInfo'),(5,'JenrlInfo','Student conflicts','org.unitime.timetable.solver.ui.JenrlInfo'),(6,'LogInfo','Solver Log','org.unitime.timetable.solver.ui.LogInfo'),(7,'BtbInstructorInfo','Back-to-back instructor preferences','org.unitime.timetable.solver.ui.BtbInstructorConstraintInfo');
/*!40000 ALTER TABLE `solver_info_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solver_parameter`
--

DROP TABLE IF EXISTS `solver_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solver_parameter` (
  `uniqueid` decimal(20,0) DEFAULT NULL,
  `value` varchar(2048) DEFAULT NULL,
  `solver_param_def_id` decimal(20,0) DEFAULT NULL,
  `solution_id` decimal(20,0) DEFAULT NULL,
  `solver_predef_setting_id` decimal(20,0) DEFAULT NULL,
  KEY `idx_solver_param_def` (`solver_param_def_id`),
  KEY `idx_solver_param_predef` (`solver_predef_setting_id`),
  KEY `idx_solver_param_solution` (`solution_id`),
  CONSTRAINT `fk_solver_param_def` FOREIGN KEY (`solver_param_def_id`) REFERENCES `solver_parameter_def` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_solver_param_predef_stg` FOREIGN KEY (`solver_predef_setting_id`) REFERENCES `solver_predef_setting` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_solver_param_solution` FOREIGN KEY (`solution_id`) REFERENCES `solution` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solver_parameter`
--

LOCK TABLES `solver_parameter` WRITE;
/*!40000 ALTER TABLE `solver_parameter` DISABLE KEYS */;
INSERT INTO `solver_parameter` VALUES (24921,'300',54,NULL,3),(1701,'false',10,NULL,3),(1,'MPP',1,NULL,1),(2,'on',3,NULL,1),(3,'false',4,NULL,1),(5,'0',17,NULL,1),(6,'false',4,NULL,2),(7,'Save and Unload',2,NULL,2),(8,'0',54,NULL,2),(11,'0.0',56,NULL,3),(12,'0.0',57,NULL,3),(13,'0.0',58,NULL,3),(14,'0.0',59,NULL,3),(15,'0.0',60,NULL,3),(16,'0.0',61,NULL,3),(17,'0.0',62,NULL,3),(24922,'false',4,NULL,3),(18,'0.0',63,NULL,3),(19,'0.0',64,NULL,3),(20,'0.0',65,NULL,3),(21,'0.0',66,NULL,3),(22,'0.0',67,NULL,3),(24,'1.0',94,NULL,3),(25,'1.0',95,NULL,3),(27,'0.0',97,NULL,3),(28,'0.0',98,NULL,3),(29,'0.0',99,NULL,3),(31,'0.0',101,NULL,3),(32,'0.0',102,NULL,3),(33,'0.0',103,NULL,3),(34,'0.0',104,NULL,3),(35,'0.0',105,NULL,3),(36,'0.0',106,NULL,3),(37,'0.0',107,NULL,3),(38,'0.0',140,NULL,3),(39,'0.0',143,NULL,3),(40,'0.0',108,NULL,3),(20974,'DIFF_TIME',202,NULL,1),(20975,'on',55,NULL,3),(90439,'20.0',99,NULL,4),(91742,'7.6',56,NULL,4),(91743,'2.4',57,NULL,4),(94676,'on',261,NULL,4),(94677,'on',13,NULL,4),(1212384,'0.0',1212379,NULL,3),(1212385,'0.0',1212381,NULL,3);
/*!40000 ALTER TABLE `solver_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solver_parameter_def`
--

DROP TABLE IF EXISTS `solver_parameter_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solver_parameter_def` (
  `uniqueid` decimal(20,0) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `default_value` varchar(2048) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `type` varchar(1000) DEFAULT NULL,
  `ord` bigint(10) DEFAULT NULL,
  `visible` int(1) DEFAULT NULL,
  `solver_param_group_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_solv_param_def_gr` (`solver_param_group_id`),
  CONSTRAINT `fk_solv_param_def_solv_par_grp` FOREIGN KEY (`solver_param_group_id`) REFERENCES `solver_parameter_group` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solver_parameter_def`
--

LOCK TABLES `solver_parameter_def` WRITE;
/*!40000 ALTER TABLE `solver_parameter_def` DISABLE KEYS */;
INSERT INTO `solver_parameter_def` VALUES (1,'Basic.Mode','Initial','Solver mode','enum(Initial,MPP)',0,1,1),(2,'Basic.WhenFinished','No Action','When finished','enum(No Action,Save,Save as New,Save and Unload,Save as New and Unload)',1,1,1),(3,'Basic.DisobeyHard','false','Allow breaking of hard constraints','boolean',6,1,1),(4,'General.SwitchStudents','true','Students sectioning','boolean',2,0,1),(5,'General.DeptBalancing','false','Use departmental balancing','boolean',9,1,2),(6,'General.CBS','true','Use conflict-based statistics','boolean',0,1,2),(7,'General.SaveBestUnassigned','-1','Minimal number of unassigned variables to save best solution found (-1 always save)','integer',1,0,2),(9,'General.UseDistanceConstraints','true','Use building distances','boolean',2,0,2),(10,'General.Spread','true','Use same subpart balancing','boolean',3,1,2),(11,'General.AutoSameStudents','true','Use automatic same_students constraints','boolean',4,1,2),(12,'General.NormalizedPrefDecreaseFactor','0.77','Time preference normalization decrease factor','double',5,1,2),(13,'Global.LoadStudentEnrlsFromSolution','false','Load student enrollments from solution<BR>(faster, but it ignores new classes)','boolean',7,1,2),(14,'DeptBalancing.SpreadFactor','1.2','Initial allowance of the slots for a particular time','double',0,1,5),(15,'DeptBalancing.Unassignments2Weaken','0','Increase the initial allowance when it causes the given number of unassignments','integer',1,1,5),(16,'Spread.SpreadFactor','1.2','Initial allowance of the slots for a particular time','double',0,1,12),(17,'Spread.Unassignments2Weaken','50','Increase the initial allowance when it causes the given number of unassignments','integer',1,1,12),(18,'ConflictStatistics.Ageing','1.0','Ageing (koef)','double',0,0,6),(19,'ConflictStatistics.AgeingHalfTime','0','Ageing -- half time (number of iteration)','integer',1,0,6),(20,'ConflictStatistics.Print','true','Print conflict statistics','boolean',2,0,6),(21,'ConflictStatistics.PrintInterval','-1','Number of iterations to print CBS (-1 just keep in memory and save within the solution)','integer',3,0,6),(22,'PerturbationCounter.Class','org.cpsolver.coursett.heuristics.UniversalPerturbationsCounter','Perturbations counter','text',0,0,11),(23,'Termination.Class','org.cpsolver.ifs.termination.MPPTerminationCondition','Termination condition','text',1,0,11),(24,'Comparator.Class','org.cpsolver.coursett.heuristics.TimetableComparator','Solution comparator','text',2,0,11),(25,'Variable.Class','org.cpsolver.coursett.heuristics.LectureSelection','Lecture selection','text',3,0,11),(26,'Value.Class','org.cpsolver.coursett.heuristics.PlacementSelection','Placement selection','text',4,0,11),(27,'TimetableLoader','org.unitime.timetable.solver.TimetableDatabaseLoader','Loader class','text',5,0,11),(28,'TimetableSaver','org.unitime.timetable.solver.TimetableDatabaseSaver','Saver class','text',6,0,11),(29,'Perturbations.DifferentPlacement','0.0','Different value than initial is assigned','double',0,1,4),(30,'Perturbations.AffectedStudentWeight','0.1','Number of students which are enrolled in a class which is placed to a different location than initial','double',1,1,4),(32,'Perturbations.AffectedInstructorWeight','0.0','Number of classes which are placed to a different room than initial','double',2,1,4),(34,'Perturbations.DifferentRoomWeight','0.0','Number of classes which are placed to a different room than initial','double',3,1,4),(35,'Perturbations.DifferentBuildingWeight','0.0','Number of classes which are placed to a different building than initial','double',4,1,4),(36,'Perturbations.DifferentTimeWeight','0.0','Number of classes which are placed in a different time than initial','double',5,1,4),(37,'Perturbations.DifferentDayWeight','0.0','Number of classes which are placed in a different days than initial','double',6,1,4),(38,'Perturbations.DifferentHourWeight','0.0','Number of classes which are placed in a different hours than initial','double',7,1,4),(39,'Perturbations.DeltaStudentConflictsWeight','0.0','Difference of student conflicts of classes assigned to current placements instead of initial placements','double',8,1,4),(40,'Perturbations.NewStudentConflictsWeight','0.0','New created student conflicts -- particular students are taken into account','double',9,1,4),(41,'Perturbations.TooFarForInstructorsWeight','0.0','New placement of a class is too far from the intial placement (instructor-wise)','double',10,1,4),(42,'Perturbations.TooFarForStudentsWeight','0.0','New placement of a class is too far from the intial placement (student-wise)','double',11,1,4),(43,'Perturbations.DeltaInstructorDistancePreferenceWeight','0.0','Difference between number of instructor distance preferences of the initial ','double',12,1,4),(44,'Perturbations.DeltaRoomPreferenceWeight','0.0','Difference between room preferences of the initial and the current solution','double',13,1,4),(45,'Perturbations.DeltaTimePreferenceWeight','0.0','Difference between time preferences of the initial and the current solution','double',14,1,4),(46,'Perturbations.AffectedStudentByTimeWeight','0.0','Number of students which are enrolled in a class which is placed to a different time than initial','double',15,1,4),(47,'Perturbations.AffectedInstructorByTimeWeight','0.0','Number of instructors which are assigned to classes which are placed to different time than initial','double',16,1,4),(48,'Perturbations.AffectedStudentByRoomWeight','0.0','Number of students which are enrolled in a class which is placed to a different room than initial','double',17,1,4),(49,'Perturbations.AffectedInstructorByRoomWeight','0.0','Number of instructors which are assigned to classes which are placed to different room than initial','double',18,1,4),(50,'Perturbations.AffectedStudentByBldgWeight','0.0','Number of students which are enrolled in a class which is placed to a different building than initial','double',19,1,4),(51,'Perturbations.AffectedInstructorByBldgWeight','0.0','Number of instructors which are assigned to classes which are placed to different building than initial','double',20,1,4),(52,'Termination.MinPerturbances','-1','Minimal allowed number of perturbances (-1 not use)','integer',0,0,7),(53,'Termination.MaxIters','-1','Maximal number of iteration','integer',1,0,7),(54,'Termination.TimeOut','1800','Maximal solver time (in sec)','integer',2,1,7),(55,'Termination.StopWhenComplete','false','Stop computation when a complete solution is found','boolean',3,1,7),(56,'Comparator.HardStudentConflictWeight','0.8','Weight of hard student conflict','double',0,1,8),(57,'Comparator.StudentConflictWeight','0.2','Weight of student conflict','double',1,1,8),(58,'Comparator.TimePreferenceWeight','0.3','Time preferences weight','double',2,1,8),(59,'Comparator.ContrPreferenceWeight','2.0','Distribution preferences weight','double',3,1,8),(60,'Comparator.RoomPreferenceWeight','1.0','Room preferences weight','double',4,1,8),(61,'Comparator.UselessSlotWeight','0.1','Useless slots weight','double',5,1,8),(62,'Comparator.TooBigRoomWeight','0.1','Too big room weight','double',6,1,8),(63,'Comparator.DistanceInstructorPreferenceWeight','1.0','Back-to-back instructor preferences weight','double',7,1,8),(64,'Comparator.PerturbationPenaltyWeight','1.0','Perturbation penalty weight','double',8,1,8),(65,'Comparator.DeptSpreadPenaltyWeight','1.0','Department balancing weight','double',10,1,8),(66,'Comparator.SpreadPenaltyWeight','1.0','Same subpart balancing weight','double',11,1,8),(67,'Comparator.CommitedStudentConflictWeight','1.0','Commited student conflict weight','double',12,1,8),(68,'Lecture.RouletteWheelSelection','true','Roulette wheel selection','boolean',0,0,9),(69,'Lecture.RandomWalkProb','1.0','Random walk probability','double',1,0,9),(70,'Lecture.DomainSizeWeight','30.0','Domain size weight','double',2,0,9),(71,'Lecture.NrAssignmentsWeight','10.0','Number of assignments weight','double',3,0,9),(72,'Lecture.InitialAssignmentWeight','20.0','Initial assignment weight','double',4,0,9),(73,'Lecture.NrConstraintsWeight','0.0','Number of constraint weight','double',5,0,9),(74,'Lecture.HardStudentConflictWeight','%Comparator.HardStudentConflictWeight%','Hard student conflict weight','double',6,0,9),(75,'Lecture.StudentConflictWeight','%Comparator.StudentConflictWeight%','Student conflict weight','double',7,0,9),(76,'Lecture.TimePreferenceWeight','%Comparator.TimePreferenceWeight%','Time preference weight','double',8,0,9),(77,'Lecture.ContrPreferenceWeight','%Comparator.ContrPreferenceWeight%','Constraint preference weight','double',9,0,9),(78,'Lecture.RoomPreferenceWeight','%Comparator.RoomPreferenceWeight%','Room preference weight','double',11,0,9),(79,'Lecture.UselessSlotWeight','%Comparator.UselessSlotWeight%','Useless slot weight','double',12,0,9),(81,'Lecture.TooBigRoomWeight','%Comparator.TooBigRoomWeight%','Too big room weight','double',13,0,9),(82,'Lecture.DistanceInstructorPreferenceWeight','%Comparator.DistanceInstructorPreferenceWeight%','Back-to-back instructor preferences weight','double',14,0,9),(83,'Lecture.DeptSpreadPenaltyWeight','%Comparator.DeptSpreadPenaltyWeight%','Department balancing weight','double',15,0,9),(84,'Lecture.SelectionSubSet','true','Selection among subset of lectures (faster)','boolean',16,0,9),(85,'Lecture.SelectionSubSetMinSize','10','Minimal subset size','integer',17,0,9),(86,'Lecture.SelectionSubSetPart','0.2','Subset size in percentage of all lectures available for selection','double',18,0,9),(87,'Lecture.SpreadPenaltyWeight','%Comparator.SpreadPenaltyWeight%','Same subpart balancing weight','double',19,0,9),(88,'Lecture.CommitedStudentConflictWeight','%Comparator.CommitedStudentConflictWeight%','Commited student conflict weight','double',20,0,9),(89,'Placement.RandomWalkProb','0.00','Random walk probability','double',0,1,10),(90,'Placement.MPP_InitialProb','0.20','MPP initial selection probability ','double',1,1,10),(91,'Placement.MPP_Limit','-1','MPP limit (-1 for no limit)','integer',2,1,10),(92,'Placement.MPP_PenaltyLimit','-1.0','Limit of the perturbations penalty (-1 for no limit)','double',3,1,10),(93,'Placement.NrAssignmentsWeight1','0.0','Number of assignments weight (level 1)','double',4,0,10),(94,'Placement.NrConflictsWeight1','1.0','Number of conflicts weight (level 1)','double',5,1,10),(95,'Placement.WeightedConflictsWeight1','2.0','Weighted conflicts weight (CBS, level 1)','double',6,1,10),(96,'Placement.NrPotentialConflictsWeight1','0.0','Number of potential conflicts weight (CBS, level 1)','double',7,0,10),(97,'Placement.MPP_DeltaInitialAssignmentWeight1','0.1','Delta initial assigments weight (MPP, level 1)','double',8,1,10),(98,'Placement.NrHardStudConfsWeight1','0.3','Hard student conflicts weight (level 1)','double',9,1,10),(99,'Placement.NrStudConfsWeight1','0.05','Student conflicts weight (level 1)','double',10,1,10),(100,'Placement.TimePreferenceWeight1','0.0','Time preference weight (level 1)','double',12,0,10),(101,'Placement.DeltaTimePreferenceWeight1','0.2','Time preference delta weight (level 1)','double',14,1,10),(102,'Placement.ConstrPreferenceWeight1','0.25','Constraint preference weight (level 1)','double',16,1,10),(103,'Placement.RoomPreferenceWeight1','0.1','Room preference weight (level 1)','double',17,1,10),(104,'Placement.UselessSlotsWeight1','0.0','Useless slot weight (level 1)','double',18,1,10),(105,'Placement.TooBigRoomWeight1','0.01','Too big room weight (level 1)','double',19,1,10),(106,'Placement.DistanceInstructorPreferenceWeight1','0.1','Back-to-back instructor preferences weight (level 1)','double',20,1,10),(107,'Placement.DeptSpreadPenaltyWeight1','0.1','Department balancing: penalty of when a slot over initial allowance is used (level 1)','double',21,1,10),(108,'Placement.ThresholdKoef1','0.1','Threshold koeficient (level 1)','double',22,1,10),(109,'Placement.NrAssignmentsWeight2','0.0','Number of assignments weight (level 2)','double',23,0,10),(110,'Placement.NrConflictsWeight2','0.0','Number of conflicts weight (level 2)','double',24,1,10),(111,'Placement.WeightedConflictsWeight2','0.0','Weighted conflicts weight (CBS, level 2)','double',25,1,10),(112,'Placement.NrPotentialConflictsWeight2','0.0','Number of potential conflicts weight (CBS, level 2)','double',26,0,10),(113,'Placement.MPP_DeltaInitialAssignmentWeight2','%Comparator.PerturbationPenaltyWeight%','Delta initial assigments weight (MPP, level 2)','double',27,0,10),(114,'Placement.NrHardStudConfsWeight2','%Comparator.HardStudentConflictWeight%','Hard student conflicts weight (level 2)','double',28,0,10),(115,'Placement.NrStudConfsWeight2','%Comparator.StudentConflictWeight%','Student conflicts weight (level 2)','double',29,0,10),(116,'Placement.TimePreferenceWeight2','%Comparator.TimePreferenceWeight%','Time preference weight (level 2)','double',30,0,10),(117,'Placement.DeltaTimePreferenceWeight2','0.0','Time preference delta weight (level 2)','double',31,0,10),(118,'Placement.ConstrPreferenceWeight2','%Comparator.ContrPreferenceWeight%','Constraint preference weight (level 2)','double',32,0,10),(119,'Placement.RoomPreferenceWeight2','%Comparator.RoomPreferenceWeight%','Room preference weight (level 2)','double',33,0,10),(120,'Placement.UselessSlotsWeight2','%Comparator.UselessSlotWeight%','Useless slot weight (level 2)','double',34,0,10),(121,'Placement.TooBigRoomWeight2','%Comparator.TooBigRoomWeight%','Too big room weight (level 2)','double',35,0,10),(122,'Placement.DistanceInstructorPreferenceWeight2','%Comparator.DistanceInstructorPreferenceWeight%','Back-to-back instructor preferences weight (level 2)','double',36,0,10),(123,'Placement.DeptSpreadPenaltyWeight2','%Comparator.DeptSpreadPenaltyWeight%','Department balancing: penalty of when a slot over initial allowance is used (level 2)','double',37,0,10),(124,'Placement.ThresholdKoef2','0.1','Threshold koeficient (level 2)','double',38,0,10),(125,'Placement.NrAssignmentsWeight3','0.0','Number of assignments weight (level 3)','double',39,0,10),(126,'Placement.NrConflictsWeight3','0.0','Number of conflicts weight (level 3)','double',40,0,10),(127,'Placement.WeightedConflictsWeight3','0.0','Weighted conflicts weight (CBS, level 3)','double',41,0,10),(128,'Placement.NrPotentialConflictsWeight3','0.0','Number of potential conflicts weight (CBS, level 3)','double',42,0,10),(129,'Placement.MPP_DeltaInitialAssignmentWeight3','0.0','Delta initial assigments weight (MPP, level 3)','double',43,0,10),(130,'Placement.NrHardStudConfsWeight3','0.0','Hard student conflicts weight (level 3)','double',44,0,10),(131,'Placement.NrStudConfsWeight3','0.0','Student conflicts weight (level 3)','double',45,0,10),(132,'Placement.TimePreferenceWeight3','0.0','Time preference weight (level 3)','double',46,0,10),(133,'Placement.DeltaTimePreferenceWeight3','0.0','Time preference delta weight (level 3)','double',47,0,10),(134,'Placement.ConstrPreferenceWeight3','0.0','Constraint preference weight (level 3)','double',48,0,10),(135,'Placement.RoomPreferenceWeight3','0.0','Room preference weight (level 3)','double',49,0,10),(136,'Placement.UselessSlotsWeight3','0.0','Useless slot weight (level 3)','double',50,0,10),(137,'Placement.TooBigRoomWeight3','0.0','Too big room weight (level 3)','double',51,0,10),(138,'Placement.DistanceInstructorPreferenceWeight3','0.0','Back-to-back instructor preferences weight (level 3)','double',52,0,10),(139,'Placement.DeptSpreadPenaltyWeight3','0.0','Department balancing: penalty of when a slot over initial allowance is used (level 3)','double',53,0,10),(140,'Placement.SpreadPenaltyWeight1','0.1','Same subpart balancing: penalty of when a slot over initial allowance is used (level 1)','double',54,1,10),(141,'Placement.SpreadPenaltyWeight2','%Comparator.SpreadPenaltyWeight%','Same subpart balancing: penalty of when a slot over initial allowance is used (level 2)','double',55,0,10),(142,'Placement.SpreadPenaltyWeight3','0.0','Same subpart balancing: penalty of when a slot over initial allowance is used (level 3)','double',56,0,10),(143,'Placement.NrCommitedStudConfsWeight1','0.5','Commited student conlict weight (level 1)','double',57,1,10),(144,'Placement.NrCommitedStudConfsWeight2','%Comparator.CommitedStudentConflictWeight%','Commited student conlict weight (level 2)','double',58,0,10),(145,'Placement.NrCommitedStudConfsWeight3','0.0','Commited student conlict weight (level 3)','double',59,0,10),(146,'SearchIntensification.IterationLimit','100','Iteration limit (number of iteration after which the search is restarted to the best known solution)','integer',0,1,13),(147,'SearchIntensification.ResetInterval','5','Number of consecutive restarts to increase iteration limit (if this number of restarts is reached, iteration limit is increased)','integer',1,1,13),(148,'SearchIntensification.MultiplyInterval','2','Iteration limit incremental coefficient (when a better solution is found, iteration limit is changed back to initial)','integer',2,1,13),(149,'SearchIntensification.Multiply','2','Reset conflict-based statistics (number of consecutive restarts after which CBS is cleared, zero means no reset of CBS)','integer',3,1,13),(150,'General.SearchIntensification','true','Use search intensification','boolean',6,1,2),(161,'Placement.CanUnassingSingleton','true','Can unassign a singleton value','boolean',60,1,10),(162,'General.SettingsId','-1','Settings Id','integer',8,0,2),(181,'TimePreferences.Weight','0.0','Time preferences weight','double',0,1,21),(182,'TimePreferences.Pref','2222222222222224222222222222222223333222222222222222222222222224222222222222222223333222222222222222222222222224222222222222222223333222222222222222222222222224222222222222222223333222222222222222222222222224222222222222222223333222222222222222222222','Time preferences','timepref',1,1,21),(201,'General.SolverWarnings',NULL,'Solver Warnings','text',10,0,2),(202,'General.AutoSameStudentsConstraint','SAME_STUDENTS','Automatic same student constraint','enum(SAME_STUDENTS,DIFF_TIME)',11,1,2),(203,'Instructor.NoPreferenceLimit','0.0','Instructor Constraint: No Preference Limit','double',0,1,41),(204,'Instructor.DiscouragedLimit','50.0','Instructor Constraint: Discouraged Limit','double',1,1,41),(205,'Instructor.ProhibitedLimit','200.0','Instructor Constraint: Prohibited Limit','double',2,1,41),(206,'Student.DistanceLimit','67.0','Student Conflict: Distance Limit (deprecated)','double',3,0,41),(207,'Student.DistanceLimit75min','100.0','Student Conflict: Distance Limit (after 75min class, deprecated)','double',4,0,41),(221,'Neighbour.Class','org.cpsolver.coursett.heuristics.NeighbourSelectionWithSuggestions','Neighbour Selection','text',7,0,11),(222,'Neighbour.SuggestionProbability','0.1','Probability of using suggestions','double',0,1,61),(223,'Neighbour.SuggestionTimeout','500','Suggestions timeout','integer',1,1,61),(224,'Neighbour.SuggestionDepth','4','Suggestions depth','integer',2,1,61),(225,'Neighbour.SuggestionProbabilityAllAssigned','0.5','Probability of using suggestions (when all classes are assigned)','double',3,1,61),(241,'General.IgnoreRoomSharing','false','Ignore Room Sharing','boolean',12,1,2),(261,'OnFlySectioning.Enabled','false','Enable on fly sectioning (if enabled, students will be resectioned after each iteration)','boolean',0,1,81),(262,'OnFlySectioning.Recursive','true','Recursively resection lectures affected by a student swap','boolean',1,1,81),(263,'OnFlySectioning.ConfigAsWell','false','Resection students between configurations as well','boolean',2,1,81),(264,'ExamBasic.Mode','Initial','Solver mode','enum(Initial,MPP)',0,1,82),(265,'ExamBasic.WhenFinished','No Action','When finished','enum(No Action,Save,Save and Unload)',1,1,82),(266,'Exams.MaxRooms','4','Default number of room splits per exam','integer',0,1,83),(267,'Exams.IsDayBreakBackToBack','false','Consider back-to-back over day break','boolean',1,1,83),(268,'Exams.DirectConflictWeight','1000.0','Direct conflict weight','double',2,1,83),(269,'Exams.MoreThanTwoADayWeight','100.0','Three or more exams a day conflict weight','double',3,1,83),(270,'Exams.BackToBackConflictWeight','10.0','Back-to-back conflict weight','double',4,1,83),(271,'Exams.DistanceBackToBackConflictWeight','25.0','Distance back-to-back conflict weight','double',5,1,83),(272,'Exams.BackToBackDistance','-1','Back-to-back distance (-1 means disabled)','double',6,1,83),(273,'Exams.PeriodWeight','1.0','Period preference weight','double',7,1,83),(274,'Exams.RoomWeight','1.0','Room preference weight','double',8,1,83),(275,'Exams.DistributionWeight','1.0','Distribution preference weight','double',9,1,83),(276,'Exams.RoomSplitWeight','10.0','Room split weight','double',10,1,83),(277,'Exams.RoomSizeWeight','0.001','Excessive room size weight','double',11,1,83),(279,'Exams.RotationWeight','0.001','Exam rotation weight','double',12,1,83),(280,'Neighbour.Class','org.cpsolver.exam.heuristics.ExamNeighbourSelection','Examination timetabling neighbour selection class','text',0,0,84),(281,'Termination.TimeOut','1800','Maximal solver time (in sec)','integer',1,1,84),(282,'Exam.Algorithm','Great Deluge','Used heuristics','enum(Great Deluge,Simulated Annealing)',2,1,84),(283,'HillClimber.MaxIdle','25000','Hill Climber: maximal idle iteration','integer',3,1,84),(284,'Termination.StopWhenComplete','false','Stop when a complete solution if found','boolean',4,0,84),(285,'General.SaveBestUnassigned','-1','Save best when x unassigned','integer',5,0,84),(286,'GreatDeluge.CoolRate','0.99999995','Cooling rate','double',0,1,85),(287,'GreatDeluge.UpperBoundRate','1.05','Upper bound rate','double',1,1,85),(288,'GreatDeluge.LowerBoundRate','0.95','Lower bound rate','double',2,1,85),(289,'SimulatedAnnealing.InitialTemperature','1.5','Initial temperature','double',0,1,86),(290,'SimulatedAnnealing.CoolingRate','0.95','Cooling rate','double',1,1,86),(291,'SimulatedAnnealing.TemperatureLength','25000','Temperature length','integer',2,1,86),(292,'SimulatedAnnealing.ReheatLengthCoef','5','Reheat length coefficient','double',3,1,86),(301,'Exams.InstructorDirectConflictWeight','0.0','Direct instructor conflict weight','double',13,1,83),(302,'Exams.InstructorMoreThanTwoADayWeight','0.0','Three or more exams a day instructor conflict weight','double',14,1,83),(303,'Exams.InstructorBackToBackConflictWeight','0.0','Back-to-back instructor conflict weight','double',15,1,83),(304,'Exams.InstructorDistanceBackToBackConflictWeight','0.0','Distance back-to-back instructor conflict weight','double',16,1,83),(305,'Exams.PerturbationWeight','0.001','Perturbation penalty weight','double',17,1,83),(321,'Exams.RoomSplitDistanceWeight','0.01','If an examination in split between two or more rooms, weight for an average distance between these rooms','double',18,1,83),(322,'Exams.LargeSize','-1','Large Exam Penalty: minimal size of a large exam (disabled if -1)','integer',19,1,83),(323,'Exams.LargePeriod','0.67','Large Exam Penalty: first discouraged period = number of periods x this factor','double',20,1,83),(324,'Exams.LargeWeight','1.0','Large Exam Penalty: weight of a large exam that is assigned on or after the first discouraged period','double',21,1,83),(325,'StudentSctBasic.Mode','Initial','Solver mode','enum(Initial,MPP,Projection)',0,1,101),(326,'StudentSctBasic.WhenFinished','No Action','When finished','enum(No Action,Save,Save and Unload)',1,1,101),(327,'Termination.Class','org.cpsolver.ifs.termination.GeneralTerminationCondition','Student sectioning termination class','text',0,0,102),(328,'Termination.StopWhenComplete','true','Stop when a complete solution if found','boolean',1,1,102),(329,'Termination.TimeOut','28800','Maximal solver time (in sec)','integer',2,1,102),(330,'Comparator.Class','org.cpsolver.ifs.solution.GeneralSolutionComparator','Student sectioning solution comparator class','text',3,0,102),(331,'Value.Class','org.cpsolver.studentsct.heuristics.EnrollmentSelection','Student sectioning value selection class','text',4,0,102),(332,'Value.WeightConflicts','1.0','CBS weight','double',5,0,102),(333,'Value.WeightNrAssignments','0.0','Number of past assignments weight','double',6,0,102),(334,'Variable.Class','org.cpsolver.ifs.heuristics.GeneralVariableSelection','Student sectioning variable selection class','text',7,0,102),(335,'Neighbour.Class','org.cpsolver.studentsct.heuristics.StudentSctNeighbourSelection','Student sectioning neighbour selection class','text',8,0,102),(336,'General.SaveBestUnassigned','0','Save best even when no complete solution is found','integer',9,0,102),(337,'StudentSct.StudentDist','true','Use student distance conflicts','boolean',10,1,102),(338,'StudentSct.CBS','true','Use conflict-based statistics','boolean',11,1,102),(339,'Load.IncludeCourseDemands','true','Load real student requests','boolean',12,0,102),(340,'Load.IncludeLastLikeStudents','false','Load last-like course demands (deprecated)','boolean',13,0,102),(341,'SectionLimit.PreferDummyStudents','true','Section limit constraint: favour unassignment of last-like course requests','boolean',14,0,102),(342,'Student.DummyStudentWeight','0.01','Last-like student request weight','double',15,1,102),(343,'Neighbour.BranchAndBoundMinimizePenalty','false','Branch&bound: If true, section penalties (instead of section values) are minimized','boolean',16,0,102),(344,'Neighbour.BranchAndBoundTimeout','5000','Branch&bound: Timeout for each neighbour selection (in milliseconds)','integer',17,1,102),(345,'Neighbour.RandomUnassignmentProb','0.5','Random Unassignment: Probability of a random selection of a student','double',18,1,102),(346,'Neighbour.RandomUnassignmentOfProblemStudentProb','0.9','Random Unassignment: Probability of a random selection of a problematic student','double',19,1,102),(347,'Neighbour.SwapStudentsTimeout','5000','Student Swap: Timeout for each neighbour selection (in milliseconds)','integer',20,1,102),(348,'Neighbour.SwapStudentsMaxValues','100','Student Swap: Limit for the number of considered values for each course request','integer',21,1,102),(349,'Neighbour.MaxValues','100','Backtrack: Limit on the number of enrollments to be visited of each course request','integer',22,1,102),(350,'Neighbour.BackTrackTimeout','5000','Backtrack: Timeout for each neighbour selection (in milliseconds)','integer',23,1,102),(351,'Neighbour.BackTrackDepth','4','Backtrack: Search depth','integer',24,1,102),(352,'CourseRequest.SameTimePrecise','true','More precise (but slower) computation of enrollments of a course request while skipping enrollments with the same times','boolean',25,0,102),(361,'Exams.PeriodSizeWeight','1.0','Examination period x examination size weight','double',22,1,83),(362,'Exams.PeriodIndexWeight','0.0000001','Examination period index weight','double',23,1,83),(363,'Exams.RoomPerturbationWeight','0.1','Room perturbation penalty (change of room) weight','double',24,1,83),(364,'Comparator.Class','org.cpsolver.ifs.solution.GeneralSolutionComparator','Examination solution comparator class','text',6,0,84),(365,'General.IgnoreCommittedStudentConflicts','false','Do not load committed student conflicts (deprecated)','boolean',13,0,2),(366,'General.WeightStudents','true','Weight last-like students (deprecated)','boolean',14,0,2),(367,'Curriculum.StudentCourseDemadsClass','Projected Student Course Demands','Student course demands','enum(Last Like Student Course Demands,Weighted Last Like Student Course Demands,Projected Student Course Demands,Curricula Course Demands,Curricula Last Like Course Demands,Student Course Requests,Enrolled Student Course Demands)',4,1,1),(368,'General.CommittedStudentConflicts','Load','Committed student conflicts','enum(Load,Compute,Ignore)',5,1,1),(369,'General.LoadCommittedAssignments','false','Load committed assignments','boolean',3,1,1),(370,'Distances.Ellipsoid','DEFAULT','Ellipsoid to be used to compute distances','enum(DEFAULT,LEGACY,WGS84,GRS80,Airy1830,Intl1924,Clarke1880,GRS67)',5,1,41),(371,'Distances.Speed','67.0','Student speed in meters per minute','double',6,1,41),(1048545,'StudentWeights.Priority','0.5010','Priority','double',0,1,1048544),(1048546,'StudentWeights.FirstAlternative','0.5010','First alternative','double',1,1,1048544),(1048547,'StudentWeights.SecondAlternative','0.2510','Second alternative','double',2,1,1048544),(1048548,'StudentWeights.DistanceConflict','0.0500','Distance conflict','double',3,1,1048544),(1048549,'StudentWeights.TimeOverlapFactor','1.0000','Time overlap','double',4,1,1048544),(1048550,'StudentWeights.TimeOverlapMaxLimit','0.5000','Time overlap limit','double',5,0,1048544),(1048551,'StudentWeights.BalancingFactor','0.0050','Section balancing','double',6,1,1048544),(1048552,'StudentWeights.AlternativeRequestFactor','0.1260','Alternative request (equal weights)','double',7,1,1048544),(1048553,'StudentWeights.LeftoverSpread','false','Spread leftover weight equaly','boolean',8,1,1048544),(1048554,'StudentWeights.Mode','Priority','Student weights','enum(Priority,Equal,Legacy)',2,1,101),(1048555,'StudentSct.TimeOverlaps','true','Use time overlaps','boolean',26,1,102),(1048556,'Load.TweakLimits','false','Tweak class limits to fit all enrolled students','boolean',27,1,102),(1081311,'StudentSct.ProjectedCourseDemadsClass','None','Projected student course demands','enum(None,Last Like Student Course Demands,Projected Student Course Demands,Curricula Course Demands,Curricula Last Like Course Demands,Student Course Requests,Enrolled Student Course Demands)',3,1,101),(1114078,'StudentWeights.ProjectedStudentWeight','0.0100','Projected student request','double',9,1,1048544),(1212379,'Comparator.DistStudentConflictWeight','0.2','Weight of distance student conflict','double',9,1,8),(1212380,'Lecture.DistStudentConflictWeight','%Comparator.DistStudentConflictWeight%','Distance student conflict weight','double',10,0,9),(1212381,'Placement.NrDistStudConfsWeight1','0.05','Distance student conflict weight (level 1)','double',11,1,10),(1212382,'Placement.NrDistStudConfsWeight2','%Comparator.DistStudentConflictWeight%','Distance student conflict weight (level 2)','double',13,0,10),(1212383,'Placement.NrDistStudConfsWeight3','0.0','Distance student conflict weight (level 3)','double',15,0,10),(1605583,'Distances.ComputeDistanceConflictsBetweenNonBTBClasses','false','Compute Distance Conflicts Between Non BTB Classes','boolean',7,1,41),(1605584,'Instructor.InstructorLongTravelInMinutes','30.0','Instructor Long Travel in Minutes (only when computing distances between non-BTB classes is enabled)','double',8,1,41),(1605585,'General.AutoPrecedence','Neutral','Automatic precedence constraint','enum(Required,Strongly Preferred,Preferred,Neutral)',15,1,2),(1605586,'DiscouragedRoom.Unassignments2Weaken','1000','Number of unassignments for the discouraged room constraint to weaken','integer',16,1,2),(1605587,'CurriculaCourseDemands.IncludeOtherStudents','true','Curriculum Course Demands: Include Other Students','boolean',17,1,2),(1605588,'General.AdditionalCriteria','org.cpsolver.coursett.criteria.additional.ImportantStudentConflict;org.cpsolver.coursett.criteria.additional.ImportantStudentHardConflict','Additional Criteria (semicolon separated list of class names)','text',18,0,2),(1605589,'General.PurgeInvalidPlacements','true','Purge invalid placements during the data load','boolean',19,0,2),(1605590,'CurriculumEnrollmentPriority.GroupMatch','.*','Important Curriculum Groups (regexp matching the group name -- all courses of a matching group are marked as important)','text',20,0,2),(1605591,'Precedence.ConsiderDatePatterns','true','Precedence Constraint: consider date patterns','text',21,1,2),(1605592,'General.JenrlMaxConflicts','1.0','Joint Enrollment Constraint: conflict limit (% limit of the smaller class)','double',22,1,2),(1605593,'General.JenrlMaxConflictsWeaken','0.001','Joint Enrollment Constraint: limit weakening','double',23,1,2),(1605594,'Comparator.ImportantStudentConflictWeight','0.0','Weight of important student conflict','double',13,1,8),(1605595,'Comparator.ImportantHardStudentConflictWeight','0.0','Weight of important hard student conflict','double',14,1,8),(1605596,'Placement.NrImportantStudConfsWeight1','0.0','Important student conflict weight (level 1)','double',61,1,10),(1605597,'Placement.NrImportantStudConfsWeight2','%Comparator.ImportantStudentConflictWeight%','Important student conflict weight (level 2)','double',62,0,10),(1605598,'Placement.NrImportantStudConfsWeight3','0.0','Important student conflict weight (level 3)','double',63,0,10),(1605599,'Placement.NrImportantHardStudConfsWeight1','0.0','Important hard student conflict weight (level 1)','double',64,1,10),(1605600,'Placement.NrImportantHardStudConfsWeight2','%Comparator.ImportantHardStudentConflictWeight%','Important hard student conflict weight (level 2)','double',65,0,10),(1605601,'Placement.NrImportantHardStudConfsWeight3','0.0','Important hard student conflict weight (level 3)','double',66,0,10),(1605602,'Exams.RoomSizeFactor','1.0','Excessive room size factor','double',25,1,83),(1605603,'Exams.DistanceToStronglyPreferredRoomWeight','0.0','Distance to strongly preferred room weight','double',26,1,83),(1605604,'Exams.AdditionalCriteria','org.cpsolver.exam.criteria.additional.DistanceToStronglyPreferredRoom','Additional Criteria (semicolon separated list of class names)','text',7,1,84),(1671119,'InstructorLunch.Enabled','false','Enable Instructor Lunch Breaks','boolean',0,1,1671117),(1671120,'InstructorLunch.Weight','0.18','Weight','double',1,1,1671117),(1671121,'InstructorLunch.StartSlot','132','Start slot','integer',2,1,1671117),(1671122,'InstructorLunch.EndSlot','162','End slot','integer',3,1,1671117),(1671123,'InstructorLunch.Length','6','Minum break length (in slots)','integer',4,1,1671117),(1671124,'InstructorLunch.Multiplier','1.15','Violations multiplication factor','double',5,1,1671117),(1671125,'InstructorLunch.InfoShowViolations','false','Show violations in the solution info','boolean',6,1,1671117),(1671126,'Curriculum.Phases','HC,Deluge','Search Phases','text',0,0,1671118),(1671127,'Curriculum.HC.MaxIdle','1000','Hill Climber: max idle iterations','integer',1,1,1671118),(1671128,'Curriculum.Deluge.Factor','0.999999','Great Deluge: cooling rate','double',2,1,1671118),(1671129,'Curriculum.Deluge.UpperBound','1.25','Great Deluge: upper bound','double',3,1,1671118),(1671130,'Curriculum.Deluge.LowerBound','0.75','Great Deluge: lower bound','double',4,1,1671118),(1671131,'Global.LoadStudentInstructorConflicts','false','Load student instructor conflicts','boolean',24,1,2),(1671132,'General.AutomaticHierarchicalConstraints','','Automatic hierarchical constraints (comma separated list of a preference, a constraint name and optional date pattern)','text',25,1,2),(1671133,'General.CompleteSolutionFixInterval','1','Fix complete solution interval (min number of iteration from the previous best solution)','integer',26,0,2),(1671134,'General.IncompleteSolutionFixInterval','5000','Fix incomplete solution interval (min number of non improving iterations, -1 to disable)','integer',27,0,2),(1671135,'General.SearchAlgorithm','GD','Search Algorithm','enum(IFS,GD,SA,Default,Experimental)',28,1,2),(1671136,'General.StudentSectioning','Default','Student Sectioning','enum(Default,Deterministic,Branch & Bound,Local Search,B&B Groups)',29,1,2),(1671137,'Comparator.RoomSizeWeight','0.001','Excessive room size weight','double',15,1,8),(1671138,'Comparator.RoomSizeFactor','1.05','Excessive room size factor','double',16,1,8),(1671139,'FlexibleConstraint.Weight','%Comparator.ContrPreferenceWeight%','Flexible constraint weight','double',17,0,8),(1671140,'Construction.Class','org.cpsolver.coursett.heuristics.NeighbourSelectionWithSuggestions','Construction: heuristics','text',4,0,61),(1671141,'Construction.UntilComplete','false','Construction: use construction heuristic untill a complete solution is found','boolean',5,0,61),(1671142,'Search.GreatDeluge','true','Use great deluge (instead of simulated annealing)','boolean',6,1,61),(1671143,'HillClimber.MaxIdle','10000','Hill Climber: max idle iterations','integer',7,1,61),(1671144,'HillClimber.AdditionalNeighbours','org.cpsolver.coursett.neighbourhoods.TimeChange;org.cpsolver.coursett.neighbourhoods.RoomChange;org.cpsolver.coursett.neighbourhoods.TimeSwap@0.01;org.cpsolver.coursett.neighbourhoods.RoomSwap@0.01','Hill Climber: Additional neighbourhoods','text',8,0,61),(1671145,'GreatDeluge.CoolRate','0.9999999','Great Deluge: cooling rate','double',9,1,61),(1671146,'GreatDeluge.UpperBoundRate','1.05','Great Deluge: upper bound','double',10,1,61),(1671147,'GreatDeluge.LowerBoundRate','0.95','Great Deluge: lower bound','double',11,1,61),(1671148,'GreatDeluge.AdditionalNeighbours','org.cpsolver.coursett.neighbourhoods.TimeChange;org.cpsolver.coursett.neighbourhoods.RoomChange;org.cpsolver.coursett.neighbourhoods.TimeSwap@0.01;org.cpsolver.coursett.neighbourhoods.RoomSwap@0.01','Great Deluge: Additional neighbourhoods','text',12,0,61),(1671149,'SimulatedAnnealing.InitialTemperature','1.5','Simulated Annealing: initial temperature','double',13,1,61),(1671150,'SimulatedAnnealing.TemperatureLength','2500','Simulated Annealing: temperature length (number of iterations between temperature decrements)','integer',14,1,61),(1671151,'SimulatedAnnealing.CoolingRate','0.95','Simulated Annealing: cooling rate','double',15,1,61),(1671152,'SimulatedAnnealing.ReheatLengthCoef','5.0','Simulated Annealing: temperature re-heat length coefficient','double',16,1,61),(1671153,'SimulatedAnnealing.ReheatRate','-1','Simulated Annealing: temperature re-heating rate (default (1/coolingRate)^(reheatLengthCoef*1.7))','double',17,0,61),(1671154,'SimulatedAnnealing.RestoreBestLengthCoef','-1','Simulated Annealing: restore best length coefficient (default reheatLengthCoef^2)','double',18,0,61),(1671155,'SimulatedAnnealing.StochasticHC','false','Simulated Annealing: stochastic search acceptance','boolean',19,0,61),(1671156,'SimulatedAnnealing.RelativeAcceptance','true','Simulated Annealing: relative acceptance (compare with current solution, not the best one)','boolean',20,0,61),(1671157,'SimulatedAnnealing.AdditionalNeighbours','org.cpsolver.coursett.neighbourhoods.TimeChange;org.cpsolver.coursett.neighbourhoods.RoomChange;org.cpsolver.coursett.neighbourhoods.TimeSwap@0.01;org.cpsolver.coursett.neighbourhoods.RoomSwap@0.01','Simulated Annealing: Additional neighbourhoods','text',21,0,61),(1671158,'Reservation.CanAssignOverTheLimit','true','Allow over limit for individual reservations','boolean',28,1,102),(1671159,'Placement.FlexibleConstrPreferenceWeight1','%Placement.ConstrPreferenceWeight1%','Flexible constraint preference weight (level 1)','double',67,0,10),(1671160,'Placement.FlexibleConstrPreferenceWeight2','%FlexibleConstraint.Weight%','Flexible constraint preference weight (level 2)','double',68,0,10),(1671161,'Placement.FlexibleConstrPreferenceWeight3','%Placement.ConstrPreferenceWeight3%','Flexible constraint preference weight (level 3)','double',69,0,10),(1671162,'ClassWeightProvider.Class','Default Class Weights','Class Weights','enum(Default Class Weights,Average Hours A Week Class Weights)',30,1,2),(1802186,'Load.StudentQuery','','Student Filter','text',4,1,101),(1802187,'Interactive.UpdateCourseRequests','true','Update course requests','boolean',29,1,102),(1802188,'Load.RequestGroups','false','Load request groups','boolean',30,1,102),(1802189,'StudentWeights.SameGroup','0.1000','Same request group','double',10,1,1048544),(1802190,'Sectioning.KeepInitialAssignments','false','MPP: Initial enrollment must be assigned','boolean',31,1,102),(1802191,'StudentWeights.Perturbation','0.1000','MPP: Perturbation weight','double',11,1,1048544),(1802192,'StudentWeights.SameChoice','0.900','MPP: Different section, but same time and instructor','double',12,1,1048544),(1802193,'StudentWeights.SameTime','0.700','MPP: Different section, but same time','double',13,1,1048544),(1802194,'Load.CheckEnabledForScheduling','true','Check enabled for scheduling toggle','boolean',31,1,102),(1802195,'Load.CheckForNoBatchStatus','true','Check no-batch student status','boolean',32,1,102),(1802196,'StudentWeights.NoTimeFactor','0.050','Additional Weights: Section with no time','double',0,1,1802185),(1802197,'StudentWeights.SelectionFactor','0.3750','Additional Weights: Section selected','double',1,1,1802185),(1802198,'StudentWeights.PenaltyFactor','0.250','Additional Weights: Section over-expected','double',2,1,1802185),(1802199,'StudentWeights.AvgPenaltyFactor','0.001','Additional Weights: Average penalty','double',3,1,1802185),(1802200,'StudentWeights.AvailabilityFactor','0.050','Additional Weights: Section availability','double',4,1,1802185),(1802201,'StudentWeights.Class','org.cpsolver.studentsct.online.selection.StudentSchedulingAssistantWeights','Student weights model','text',5,0,1802185),(1802202,'OverExpectedCriterion.Class','org.cpsolver.studentsct.online.expectations.AvoidUnbalancedWhenNoExpectations','Over-expected criterion','text',6,0,1802185),(1802203,'Suggestions.Timeout','1000','Suggestions: Time limit in milliseconds','integer',7,1,1802185),(1802204,'Suggestions.MaxDepth','4','Suggestions: Maximal search depth','integer',8,1,1802185),(1802205,'Suggestions.MaxSuggestions','20','Suggestions: Number of results','integer',9,1,1802185),(1802206,'StudentWeights.MultiCriteria','true','Use multi-criterion selection','boolean',10,1,1802185),(1802207,'OverExpected.Disbalance','0.100','Expectations: Allowed dis-balance','double',11,1,1802185),(1802208,'General.BalanceUnlimited','false','Expectations: Balance unlimited sections','boolean',12,1,1802185),(1802209,'OverExpected.Percentage','1.000','Expectations: Expectation multiplicator','double',13,1,1802185),(1802210,'OverExpected.Rounding','ROUND','Expectations: rounding','enum(NONE,CEIL,FLOOR,ROUND)',14,1,1802185),(1802211,'OnlineStudentSectioning.TimesToAvoidHeuristics','true','Online Selection: avoid times needed by other courses','boolean',15,1,1802185),(1802212,'StudentWeights.SameChoiceFactor','0.125','Resectioning: Same choice (time and instructor)','double',16,1,1802185),(1802213,'StudentWeights.SameRoomsFactor','0.007','Resectioning: Same room','double',17,1,1802185),(1802214,'StudentWeights.SameTimeFactor','0.070','Resectioning: Same time','double',18,1,1802185),(1802215,'StudentWeights.SameNameFactor','0.014','Resectioning: Same section name','double',19,1,1802185),(1802216,'StudentWeights.PreferenceFactor','0.500','Suggestions: Preferred section','double',20,1,1802185),(1802217,'Enrollment.CanKeepCancelledClass','false','Can a student keep cancelled class','boolean',21,1,1802185),(1867723,'Basic.Mode','Initial','Solver Mode','enum(Initial,MPP)',0,1,1867719),(1867724,'Basic.WhenFinished','No Action','When Finished','enum(No Action,Save,Save as New,Save and Unload,Save as New and Unload)',1,1,1867719),(1867725,'General.CBS','true','Use conflict-based statistics','boolean',0,1,1867720),(1867726,'General.CommonItypes','lec','Common Instructional Types (comma separated)','text',1,1,1867720),(1867727,'General.IgnoreOtherInstructors','false','Ignore Other Instructors','boolean',2,1,1867720),(1867728,'General.SaveBestUnassigned','-1','Minimal number of unassigned variables to save best solution found (-1 always save)','integer',3,0,1867720),(1867729,'Termination.StopWhenComplete','false','Stop computation when a complete solution is found','boolean',4,1,1867720),(1867730,'Termination.TimeOut','300','Maximal solver time (in sec)','integer',5,1,1867720),(1867731,'Value.RandomWalkProb','0.02','Randon Walk Probability','double',6,1,1867720),(1867732,'Value.WeightConflicts','1000.0','Conflict Weight','double',0,1,1867721),(1867733,'Weight.TeachingPreferences','10.0','Teaching Preference Weight','double',1,1,1867721),(1867734,'Weight.AttributePreferences','1000.0','Attribute Preference Weight','double',2,1,1867721),(1867735,'Weight.CoursePreferences','1.0','Course Preference Weight','double',3,1,1867721),(1867736,'Weight.TimePreferences','1.0','Time Preference Weight','double',4,1,1867721),(1867737,'Weight.InstructorPreferences','1.0','Instructor Preference Weight','double',5,1,1867721),(1867738,'Weight.BackToBack','1.0','Back-to-Back Weight','double',6,1,1867721),(1867739,'BackToBack.DifferentRoomWeight','0.8','Back-to-Back Different Room','double',7,1,1867721),(1867740,'BackToBack.DifferentTypeWeight','0.6','Back-to-Back Different Type','double',8,1,1867721),(1867741,'Weight.DifferentLecture','1000.0','Different Lecture Weight','double',9,1,1867721),(1867742,'Weight.SameInstructor','10.0','Same Instructor Weight','double',10,1,1867721),(1867743,'Weight.SameLink','100.0','Same Link Weight','double',11,1,1867721),(1867744,'Weight.TimeOverlaps','1000.0','Allowed Time Overlap Weight','double',12,1,1867721),(1867745,'Weight.OriginalInstructor','100.0','Original Instructor Weight (MPP)','double',13,1,1867721),(1867746,'Termination.Class','org.cpsolver.ifs.termination.GeneralTerminationCondition','Termination Class','text',0,0,1867722),(1867747,'Comparator.Class','org.cpsolver.ifs.solution.GeneralSolutionComparator','Comparator Class','text',1,0,1867722),(1867748,'Value.Class','org.cpsolver.ifs.heuristics.GeneralValueSelection','Value Selection Class','text',2,0,1867722),(1867749,'Variable.Class','org.cpsolver.ifs.heuristics.GeneralVariableSelection','Variable Selection Class','text',3,0,1867722),(1867750,'Neighbour.Class','org.cpsolver.ifs.algorithms.SimpleSearch','Neighbour Selection Class','text',4,0,1867722),(1966020,'Distances.ShortDistanceAccommodationReference','SD','Need short distances accommodation reference','text',33,1,102),(1966021,'StudentLunch.StartSlot','132','Student Lunch Breeak: first time slot','integer',34,1,102),(1966022,'StudentLunch.EndStart','156','Student Lunch Breeak: last time slot','integer',35,1,102),(1966023,'StudentLunch.Length','6','Student Lunch Breeak: time for lunch (number of slots)','integer',36,1,102),(1966024,'TravelTime.MaxTravelGap','12','Travel Time: max travel gap (number of slots)','integer',37,1,102),(1966025,'WorkDay.WorkDayLimit','72','Work Day: initial allowance (number of slots)','integer',38,1,102),(1966026,'WorkDay.EarlySlot','102','Work Day: early morning time slot','integer',39,1,102),(1966027,'WorkDay.LateSlot','210','Work Day: late evening time slot','integer',40,1,102),(1966028,'StudentWeights.BackToBackDistance','6','Work Day: max back-to-back distance (number of slots)','integer',41,1,102),(1966029,'StudentWeights.ShortDistanceConflict','0.2000','Distance conflict (students needed short distances)','double',14,1,1048544),(1966030,'StudentWeights.LunchBreakFactor','0.0050','Lunch break conflict','double',15,1,1048544),(1966031,'StudentWeights.TravelTimeFactor','0.0010','Travel time conflict (multiplied by distance in minutes)','double',16,1,1048544),(1966032,'StudentWeights.BackToBackFactor','-0.0010','Back-to-back conflict (negative value: prefer no gaps)','double',17,1,1048544),(1966033,'StudentWeights.WorkDayFactor','0.0100','Work-day conflict (multiplied by the number of hours over the allowance)','double',18,1,1048544),(1966034,'StudentWeights.TooEarlyFactor','0.0500','Too early conflict','double',19,1,1048544),(1966035,'StudentWeights.TooLateFactor','0.0250','Too late conflict','double',20,1,1048544);
/*!40000 ALTER TABLE `solver_parameter_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solver_parameter_group`
--

DROP TABLE IF EXISTS `solver_parameter_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solver_parameter_group` (
  `uniqueid` decimal(20,0) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `condition` varchar(250) DEFAULT NULL,
  `ord` bigint(10) DEFAULT NULL,
  `param_type` bigint(10) DEFAULT '0',
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solver_parameter_group`
--

LOCK TABLES `solver_parameter_group` WRITE;
/*!40000 ALTER TABLE `solver_parameter_group` DISABLE KEYS */;
INSERT INTO `solver_parameter_group` VALUES (1,'Basic','Basic Settings',NULL,0,0),(2,'General','General Settings',NULL,1,0),(3,'MPP','Minimal-perturbation Setting',NULL,2,0),(4,'Perturbations','Perturbation Penalty',NULL,3,0),(5,'DepartmentSpread','Departmental Balancing',NULL,4,0),(6,'ConflictStatistics','Conflict-based Statistics',NULL,5,0),(7,'Termination','Termination Conditions',NULL,6,0),(8,'Comparator','Solution Comparator Weights',NULL,7,0),(9,'Variable','Lecture Selection',NULL,8,0),(10,'Value','Placement Selection',NULL,9,0),(11,'Classes','Implementations',NULL,10,0),(12,'Spread','Same Subpart Balancing',NULL,11,0),(13,'SearchIntensification','Search Intensification',NULL,12,0),(21,'TimePreferences','Default Time Preferences',NULL,13,0),(41,'Distance','Distances',NULL,14,0),(61,'Neighbour','Neighbour Selection',NULL,15,0),(81,'OnFlySectioning','On Fly Student Sectioning',NULL,16,0),(82,'ExamBasic','Basic Parameters',NULL,17,1),(83,'ExamWeights','Examination Weights',NULL,18,1),(84,'Exam','General Parameters',NULL,19,1),(85,'ExamGD','Great Deluge Parameters',NULL,20,1),(86,'ExamSA','Simulated Annealing Parameters',NULL,21,1),(101,'StudentSctBasic','Basic Parameters',NULL,22,2),(102,'StudentSct','General Parameters',NULL,23,2),(1048544,'StudentSctWeights','Student Weitghts',NULL,24,2),(1671117,'InstructorLunch','Instructor Lunch Breaks',NULL,25,0),(1671118,'Curriculum','Curriculum Conversion',NULL,26,0),(1802185,'StudentSctOnline','Online Student Scheduling',NULL,27,2),(1867719,'InstrSchd.Basic','Instructor Scheduling: Basic',NULL,28,3),(1867720,'InstrSchd.General','Instructor Scheduling: General',NULL,29,3),(1867721,'InstrSchd.Weight','Instructor Scheduling: Weights',NULL,30,3),(1867722,'InstrSchd.Implementation','Instructor Scheduling: Implementation',NULL,31,3);
/*!40000 ALTER TABLE `solver_parameter_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solver_predef_setting`
--

DROP TABLE IF EXISTS `solver_predef_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solver_predef_setting` (
  `uniqueid` decimal(20,0) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `appearance` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solver_predef_setting`
--

LOCK TABLES `solver_predef_setting` WRITE;
/*!40000 ALTER TABLE `solver_predef_setting` DISABLE KEYS */;
INSERT INTO `solver_predef_setting` VALUES (1,'Default.Interactive','Interactive',0),(2,'Default.Validate','Validate',1),(3,'Default.Check','Check',1),(4,'Default.Solver','Default',1),(101,'Exam.Default','Default',2),(121,'StudentSct.Default','Default',3),(1867751,'InstrSchd.Default','Default',4);
/*!40000 ALTER TABLE `solver_predef_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsoring_organization`
--

DROP TABLE IF EXISTS `sponsoring_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sponsoring_organization` (
  `uniqueid` decimal(20,0) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsoring_organization`
--

LOCK TABLES `sponsoring_organization` WRITE;
/*!40000 ALTER TABLE `sponsoring_organization` DISABLE KEYS */;
/*!40000 ALTER TABLE `sponsoring_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff` (
  `uniqueid` decimal(20,0) NOT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `fname` varchar(100) DEFAULT NULL,
  `mname` varchar(100) DEFAULT NULL,
  `lname` varchar(100) DEFAULT NULL,
  `pos_code` varchar(20) DEFAULT NULL,
  `dept` varchar(50) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `pos_type` decimal(20,0) DEFAULT NULL,
  `acad_title` varchar(50) DEFAULT NULL,
  `campus` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_staff_pos_type` (`pos_type`),
  CONSTRAINT `fk_staff_pos_type` FOREIGN KEY (`pos_type`) REFERENCES `position_type` (`uniqueid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `standard_event_note`
--

DROP TABLE IF EXISTS `standard_event_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `standard_event_note` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `discriminator` varchar(10) DEFAULT 'global',
  `session_id` decimal(20,0) DEFAULT NULL,
  `department_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_stdevt_note_session` (`session_id`),
  KEY `fk_stdevt_note_dept` (`department_id`),
  CONSTRAINT `fk_stdevt_note_dept` FOREIGN KEY (`department_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_stdevt_note_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `standard_event_note`
--

LOCK TABLES `standard_event_note` WRITE;
/*!40000 ALTER TABLE `standard_event_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `standard_event_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `std_group_type`
--

DROP TABLE IF EXISTS `std_group_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `std_group_type` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) NOT NULL,
  `label` varchar(60) NOT NULL,
  `together` int(1) NOT NULL,
  `allow_disabled` int(5) NOT NULL DEFAULT '0',
  `advisor` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `std_group_type`
--

LOCK TABLES `std_group_type` WRITE;
/*!40000 ALTER TABLE `std_group_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `std_group_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `uniqueid` decimal(20,0) NOT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `free_time_cat` bigint(10) DEFAULT '0',
  `schedule_preference` bigint(10) DEFAULT '0',
  `session_id` decimal(20,0) DEFAULT NULL,
  `sect_status` decimal(20,0) DEFAULT NULL,
  `schedule_emailed` datetime DEFAULT NULL,
  `max_credit` float DEFAULT NULL,
  `req_credit` float DEFAULT NULL,
  `req_status` bigint(10) DEFAULT NULL,
  `req_extid` varchar(40) DEFAULT NULL,
  `req_ts` datetime DEFAULT NULL,
  `min_credit` float DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_student_session` (`session_id`),
  KEY `idx_student_external_uid` (`external_uid`),
  KEY `fk_student_sect_status` (`sect_status`),
  CONSTRAINT `fk_student_sect_status` FOREIGN KEY (`sect_status`) REFERENCES `sectioning_status` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_student_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_acad_area`
--

DROP TABLE IF EXISTS `student_acad_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_acad_area` (
  `uniqueid` decimal(20,0) NOT NULL,
  `student_id` decimal(20,0) DEFAULT NULL,
  `acad_clasf_id` decimal(20,0) DEFAULT NULL,
  `acad_area_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_student_acad_area` (`student_id`,`acad_clasf_id`,`acad_area_id`),
  KEY `idx_student_acad_area` (`student_id`,`acad_area_id`,`acad_clasf_id`),
  KEY `fk_student_acad_area_area` (`acad_area_id`),
  KEY `fk_student_acad_area_clasf` (`acad_clasf_id`),
  CONSTRAINT `fk_student_acad_area_area` FOREIGN KEY (`acad_area_id`) REFERENCES `academic_area` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_acad_area_clasf` FOREIGN KEY (`acad_clasf_id`) REFERENCES `academic_classification` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_acad_area_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_acad_area`
--

LOCK TABLES `student_acad_area` WRITE;
/*!40000 ALTER TABLE `student_acad_area` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_acad_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_accomodation`
--

DROP TABLE IF EXISTS `student_accomodation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_accomodation` (
  `uniqueid` decimal(20,0) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `abbreviation` varchar(20) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_student_accom_session` (`session_id`),
  CONSTRAINT `fk_student_accom_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_accomodation`
--

LOCK TABLES `student_accomodation` WRITE;
/*!40000 ALTER TABLE `student_accomodation` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_accomodation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_advisor`
--

DROP TABLE IF EXISTS `student_advisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_advisor` (
  `student_id` decimal(20,0) NOT NULL,
  `advisor_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`student_id`,`advisor_id`),
  KEY `fk_std_adv_advisor` (`advisor_id`),
  CONSTRAINT `fk_std_adv_advisor` FOREIGN KEY (`advisor_id`) REFERENCES `advisor` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_std_adv_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_advisor`
--

LOCK TABLES `student_advisor` WRITE;
/*!40000 ALTER TABLE `student_advisor` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_advisor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_area_clasf_major`
--

DROP TABLE IF EXISTS `student_area_clasf_major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_area_clasf_major` (
  `uniqueid` decimal(20,0) NOT NULL,
  `student_id` decimal(20,0) NOT NULL,
  `acad_area_id` decimal(20,0) NOT NULL,
  `acad_clasf_id` decimal(20,0) NOT NULL,
  `major_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_student_area_clasf_major` (`student_id`,`acad_area_id`,`acad_clasf_id`,`major_id`),
  KEY `fk_student_acmaj_area` (`acad_area_id`),
  KEY `fk_student_acmaj_clasf` (`acad_clasf_id`),
  KEY `fk_student_acmaj_major` (`major_id`),
  CONSTRAINT `fk_student_acmaj_area` FOREIGN KEY (`acad_area_id`) REFERENCES `academic_area` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_acmaj_clasf` FOREIGN KEY (`acad_clasf_id`) REFERENCES `academic_classification` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_acmaj_major` FOREIGN KEY (`major_id`) REFERENCES `pos_major` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_acmaj_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_area_clasf_major`
--

LOCK TABLES `student_area_clasf_major` WRITE;
/*!40000 ALTER TABLE `student_area_clasf_major` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_area_clasf_major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_area_clasf_minor`
--

DROP TABLE IF EXISTS `student_area_clasf_minor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_area_clasf_minor` (
  `uniqueid` decimal(20,0) NOT NULL,
  `student_id` decimal(20,0) NOT NULL,
  `acad_area_id` decimal(20,0) NOT NULL,
  `acad_clasf_id` decimal(20,0) NOT NULL,
  `minor_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_student_area_clasf_minor` (`student_id`,`acad_area_id`,`acad_clasf_id`,`minor_id`),
  KEY `fk_student_acmin_area` (`acad_area_id`),
  KEY `fk_student_acmin_clasf` (`acad_clasf_id`),
  KEY `fk_student_acmin_minor` (`minor_id`),
  CONSTRAINT `fk_student_acmin_area` FOREIGN KEY (`acad_area_id`) REFERENCES `academic_area` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_acmin_clasf` FOREIGN KEY (`acad_clasf_id`) REFERENCES `academic_classification` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_acmin_minor` FOREIGN KEY (`minor_id`) REFERENCES `pos_minor` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_acmin_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_area_clasf_minor`
--

LOCK TABLES `student_area_clasf_minor` WRITE;
/*!40000 ALTER TABLE `student_area_clasf_minor` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_area_clasf_minor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_class_enrl`
--

DROP TABLE IF EXISTS `student_class_enrl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_class_enrl` (
  `uniqueid` decimal(20,0) NOT NULL,
  `student_id` decimal(20,0) DEFAULT NULL,
  `course_request_id` decimal(20,0) DEFAULT NULL,
  `class_id` decimal(20,0) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `course_offering_id` decimal(20,0) DEFAULT NULL,
  `approved_date` datetime DEFAULT NULL,
  `approved_by` varchar(40) DEFAULT NULL,
  `changed_by` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_student_class_enrl_class` (`class_id`),
  KEY `idx_student_class_enrl_course` (`course_offering_id`),
  KEY `idx_student_class_enrl_req` (`course_request_id`),
  KEY `idx_student_class_enrl_student` (`student_id`),
  CONSTRAINT `fk_student_class_enrl_class` FOREIGN KEY (`class_id`) REFERENCES `class_` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_class_enrl_course` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_class_enrl_request` FOREIGN KEY (`course_request_id`) REFERENCES `course_request` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_class_enrl_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_class_enrl`
--

LOCK TABLES `student_class_enrl` WRITE;
/*!40000 ALTER TABLE `student_class_enrl` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_class_enrl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_enrl`
--

DROP TABLE IF EXISTS `student_enrl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_enrl` (
  `uniqueid` decimal(20,0) NOT NULL,
  `student_id` decimal(20,0) DEFAULT NULL,
  `solution_id` decimal(20,0) DEFAULT NULL,
  `class_id` decimal(20,0) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_student_enrl` (`solution_id`),
  KEY `idx_student_enrl_assignment` (`solution_id`,`class_id`),
  KEY `idx_student_enrl_class` (`class_id`),
  CONSTRAINT `fk_student_enrl_class` FOREIGN KEY (`class_id`) REFERENCES `class_` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_enrl_solution` FOREIGN KEY (`solution_id`) REFERENCES `solution` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_enrl`
--

LOCK TABLES `student_enrl` WRITE;
/*!40000 ALTER TABLE `student_enrl` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_enrl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_enrl_msg`
--

DROP TABLE IF EXISTS `student_enrl_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_enrl_msg` (
  `uniqueid` decimal(20,0) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `msg_level` bigint(10) DEFAULT '0',
  `type` bigint(10) DEFAULT '0',
  `timestamp` datetime DEFAULT NULL,
  `course_demand_id` decimal(20,0) DEFAULT NULL,
  `ord` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_student_enrl_msg_dem` (`course_demand_id`),
  CONSTRAINT `fk_student_enrl_msg_demand` FOREIGN KEY (`course_demand_id`) REFERENCES `course_demand` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_enrl_msg`
--

LOCK TABLES `student_enrl_msg` WRITE;
/*!40000 ALTER TABLE `student_enrl_msg` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_enrl_msg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_group`
--

DROP TABLE IF EXISTS `student_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_group` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `group_abbreviation` varchar(30) DEFAULT NULL,
  `group_name` varchar(90) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `expected_size` int(10) DEFAULT NULL,
  `type_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_student_group_session_sis` (`session_id`,`group_abbreviation`),
  KEY `fk_std_group_type` (`type_id`),
  CONSTRAINT `fk_std_group_type` FOREIGN KEY (`type_id`) REFERENCES `std_group_type` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_student_group_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_group`
--

LOCK TABLES `student_group` WRITE;
/*!40000 ALTER TABLE `student_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_major`
--

DROP TABLE IF EXISTS `student_major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_major` (
  `student_id` decimal(20,0) NOT NULL,
  `major_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`student_id`,`major_id`),
  KEY `fk_student_major_major` (`major_id`),
  CONSTRAINT `fk_student_major_major` FOREIGN KEY (`major_id`) REFERENCES `pos_major` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_major_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_major`
--

LOCK TABLES `student_major` WRITE;
/*!40000 ALTER TABLE `student_major` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_minor`
--

DROP TABLE IF EXISTS `student_minor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_minor` (
  `student_id` decimal(20,0) NOT NULL,
  `minor_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`student_id`,`minor_id`),
  KEY `fk_student_minor_minor` (`minor_id`),
  CONSTRAINT `fk_student_minor_minor` FOREIGN KEY (`minor_id`) REFERENCES `pos_minor` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_minor_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_minor`
--

LOCK TABLES `student_minor` WRITE;
/*!40000 ALTER TABLE `student_minor` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_minor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_note`
--

DROP TABLE IF EXISTS `student_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_note` (
  `uniqueid` decimal(20,0) NOT NULL,
  `student_id` decimal(20,0) NOT NULL,
  `text_note` varchar(1000) DEFAULT NULL,
  `time_stamp` datetime NOT NULL,
  `user_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_note`
--

LOCK TABLES `student_note` WRITE;
/*!40000 ALTER TABLE `student_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_sect_hist`
--

DROP TABLE IF EXISTS `student_sect_hist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_sect_hist` (
  `uniqueid` decimal(20,0) NOT NULL,
  `student_id` decimal(20,0) DEFAULT NULL,
  `data` longblob,
  `type` bigint(10) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_student_sect_hist_student` (`student_id`),
  CONSTRAINT `fk_student_sect_hist_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_sect_hist`
--

LOCK TABLES `student_sect_hist` WRITE;
/*!40000 ALTER TABLE `student_sect_hist` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_sect_hist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_to_acomodation`
--

DROP TABLE IF EXISTS `student_to_acomodation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_to_acomodation` (
  `student_id` decimal(20,0) NOT NULL,
  `accomodation_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`student_id`,`accomodation_id`),
  KEY `fk_student_acomodation_student` (`accomodation_id`),
  CONSTRAINT `fk_student_acomodation_accom` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_acomodation_student` FOREIGN KEY (`accomodation_id`) REFERENCES `student_accomodation` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_to_acomodation`
--

LOCK TABLES `student_to_acomodation` WRITE;
/*!40000 ALTER TABLE `student_to_acomodation` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_to_acomodation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_to_group`
--

DROP TABLE IF EXISTS `student_to_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_to_group` (
  `student_id` decimal(20,0) NOT NULL,
  `group_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`student_id`,`group_id`),
  KEY `fk_student_group_student` (`group_id`),
  CONSTRAINT `fk_student_group_group` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_student_group_student` FOREIGN KEY (`group_id`) REFERENCES `student_group` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_to_group`
--

LOCK TABLES `student_to_group` WRITE;
/*!40000 ALTER TABLE `student_to_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_to_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_area`
--

DROP TABLE IF EXISTS `subject_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subject_area` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  `subject_area_abbreviation` varchar(40) DEFAULT NULL,
  `long_title` varchar(100) DEFAULT NULL,
  `department_uniqueid` decimal(20,0) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_subject_area` (`session_id`,`subject_area_abbreviation`),
  KEY `idx_subject_area_dept` (`department_uniqueid`),
  CONSTRAINT `fk_subject_area_dept` FOREIGN KEY (`department_uniqueid`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_area`
--

LOCK TABLES `subject_area` WRITE;
/*!40000 ALTER TABLE `subject_area` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `uniqueid` decimal(20,0) NOT NULL,
  `name` varchar(128) NOT NULL,
  `session_id` decimal(20,0) NOT NULL,
  `script_id` decimal(20,0) NOT NULL,
  `owner_id` decimal(20,0) NOT NULL,
  `email` varchar(1000) DEFAULT NULL,
  `input_file` longblob,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_task_sesssion` (`session_id`),
  KEY `fk_task_script` (`script_id`),
  KEY `fk_task_owner` (`owner_id`),
  CONSTRAINT `fk_task_owner` FOREIGN KEY (`owner_id`) REFERENCES `timetable_manager` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_task_script` FOREIGN KEY (`script_id`) REFERENCES `script` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_task_sesssion` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_execution`
--

DROP TABLE IF EXISTS `task_execution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_execution` (
  `uniqueid` decimal(20,0) NOT NULL,
  `task_id` decimal(20,0) NOT NULL,
  `exec_date` bigint(10) NOT NULL,
  `exec_period` bigint(10) NOT NULL,
  `status` bigint(10) NOT NULL,
  `created_date` datetime NOT NULL,
  `scheduled_date` datetime NOT NULL,
  `queued_date` datetime DEFAULT NULL,
  `started_date` datetime DEFAULT NULL,
  `finished_date` datetime DEFAULT NULL,
  `log_file` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `output_file` longblob,
  `output_name` varchar(260) DEFAULT NULL,
  `output_content` varchar(260) DEFAULT NULL,
  `status_message` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_taskexec_task` (`task_id`),
  KEY `idx_taskexe_schdstatus` (`status`,`scheduled_date`),
  CONSTRAINT `fk_taskexec_task` FOREIGN KEY (`task_id`) REFERENCES `task` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_execution`
--

LOCK TABLES `task_execution` WRITE;
/*!40000 ALTER TABLE `task_execution` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_execution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_parameter`
--

DROP TABLE IF EXISTS `task_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_parameter` (
  `task_id` decimal(20,0) NOT NULL,
  `name` varchar(128) NOT NULL,
  `value` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`task_id`,`name`),
  CONSTRAINT `fk_taskparam_task` FOREIGN KEY (`task_id`) REFERENCES `task` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_parameter`
--

LOCK TABLES `task_parameter` WRITE;
/*!40000 ALTER TABLE `task_parameter` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teaching_request`
--

DROP TABLE IF EXISTS `teaching_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teaching_request` (
  `uniqueid` decimal(20,0) NOT NULL,
  `offering_id` decimal(20,0) NOT NULL,
  `nbr_instructors` decimal(10,0) NOT NULL,
  `teaching_load` float NOT NULL,
  `same_course_pref` decimal(20,0) DEFAULT NULL,
  `same_common_pref` decimal(20,0) DEFAULT NULL,
  `responsibility_id` decimal(20,0) DEFAULT NULL,
  `assign_coordinator` int(1) NOT NULL,
  `percent_share` int(3) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_teachreq_offering` (`offering_id`),
  KEY `fk_teachreq_same_course` (`same_course_pref`),
  KEY `fk_teachreq_same_common` (`same_common_pref`),
  KEY `fk_teachreq_responsibility` (`responsibility_id`),
  CONSTRAINT `fk_teachreq_offering` FOREIGN KEY (`offering_id`) REFERENCES `instructional_offering` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_teachreq_responsibility` FOREIGN KEY (`responsibility_id`) REFERENCES `teaching_responsibility` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_teachreq_same_common` FOREIGN KEY (`same_common_pref`) REFERENCES `preference_level` (`uniqueid`) ON DELETE SET NULL,
  CONSTRAINT `fk_teachreq_same_course` FOREIGN KEY (`same_course_pref`) REFERENCES `preference_level` (`uniqueid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teaching_request`
--

LOCK TABLES `teaching_request` WRITE;
/*!40000 ALTER TABLE `teaching_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `teaching_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teaching_responsibility`
--

DROP TABLE IF EXISTS `teaching_responsibility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teaching_responsibility` (
  `uniqueid` decimal(20,0) NOT NULL,
  `reference` varchar(20) NOT NULL,
  `label` varchar(60) NOT NULL,
  `coordinator` int(1) NOT NULL,
  `instructor` int(1) NOT NULL,
  `abbreviation` varchar(40) DEFAULT NULL,
  `options` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teaching_responsibility`
--

LOCK TABLES `teaching_responsibility` WRITE;
/*!40000 ALTER TABLE `teaching_responsibility` DISABLE KEYS */;
/*!40000 ALTER TABLE `teaching_responsibility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachreq_class`
--

DROP TABLE IF EXISTS `teachreq_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teachreq_class` (
  `uniqueid` decimal(20,0) NOT NULL,
  `percent_share` int(3) NOT NULL,
  `is_lead` int(1) NOT NULL,
  `can_overlap` int(1) NOT NULL,
  `request_id` decimal(20,0) NOT NULL,
  `class_id` decimal(20,0) NOT NULL,
  `assign_instructor` int(1) NOT NULL,
  `common` int(1) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_teachreq_crequest` (`request_id`),
  KEY `fk_teachreq_class` (`class_id`),
  CONSTRAINT `fk_teachreq_class` FOREIGN KEY (`class_id`) REFERENCES `class_` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_teachreq_crequest` FOREIGN KEY (`request_id`) REFERENCES `teaching_request` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachreq_class`
--

LOCK TABLES `teachreq_class` WRITE;
/*!40000 ALTER TABLE `teachreq_class` DISABLE KEYS */;
/*!40000 ALTER TABLE `teachreq_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachreq_instructor`
--

DROP TABLE IF EXISTS `teachreq_instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teachreq_instructor` (
  `request_id` decimal(20,0) NOT NULL,
  `instructor_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`request_id`,`instructor_id`),
  KEY `fk_teachreq_instructor` (`instructor_id`),
  CONSTRAINT `fk_teachreq_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `departmental_instructor` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_teachreq_request` FOREIGN KEY (`request_id`) REFERENCES `teaching_request` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachreq_instructor`
--

LOCK TABLES `teachreq_instructor` WRITE;
/*!40000 ALTER TABLE `teachreq_instructor` DISABLE KEYS */;
/*!40000 ALTER TABLE `teachreq_instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_pattern`
--

DROP TABLE IF EXISTS `time_pattern`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_pattern` (
  `uniqueid` decimal(20,0) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `mins_pmt` bigint(10) DEFAULT NULL,
  `slots_pmt` bigint(10) DEFAULT NULL,
  `nr_mtgs` bigint(10) DEFAULT NULL,
  `visible` int(1) DEFAULT NULL,
  `type` bigint(10) DEFAULT NULL,
  `break_time` int(3) DEFAULT NULL,
  `session_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_time_pattern_session` (`session_id`),
  CONSTRAINT `fk_time_pattern_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_pattern`
--

LOCK TABLES `time_pattern` WRITE;
/*!40000 ALTER TABLE `time_pattern` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_pattern` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_pattern_days`
--

DROP TABLE IF EXISTS `time_pattern_days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_pattern_days` (
  `uniqueid` decimal(20,0) NOT NULL,
  `day_code` bigint(10) DEFAULT NULL,
  `time_pattern_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_time_pattern_days` (`time_pattern_id`),
  CONSTRAINT `fk_time_pattern_days_time_patt` FOREIGN KEY (`time_pattern_id`) REFERENCES `time_pattern` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_pattern_days`
--

LOCK TABLES `time_pattern_days` WRITE;
/*!40000 ALTER TABLE `time_pattern_days` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_pattern_days` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_pattern_dept`
--

DROP TABLE IF EXISTS `time_pattern_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_pattern_dept` (
  `dept_id` decimal(20,0) NOT NULL,
  `pattern_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`dept_id`,`pattern_id`),
  KEY `fk_time_pattern_dept_pattern` (`pattern_id`),
  CONSTRAINT `fk_time_pattern_dept_dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_time_pattern_dept_pattern` FOREIGN KEY (`pattern_id`) REFERENCES `time_pattern` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_pattern_dept`
--

LOCK TABLES `time_pattern_dept` WRITE;
/*!40000 ALTER TABLE `time_pattern_dept` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_pattern_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_pattern_time`
--

DROP TABLE IF EXISTS `time_pattern_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_pattern_time` (
  `uniqueid` decimal(20,0) NOT NULL,
  `start_slot` bigint(10) DEFAULT NULL,
  `time_pattern_id` decimal(20,0) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_time_pattern_time` (`time_pattern_id`),
  CONSTRAINT `fk_time_pattern_time` FOREIGN KEY (`time_pattern_id`) REFERENCES `time_pattern` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_pattern_time`
--

LOCK TABLES `time_pattern_time` WRITE;
/*!40000 ALTER TABLE `time_pattern_time` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_pattern_time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_pref`
--

DROP TABLE IF EXISTS `time_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_pref` (
  `uniqueid` decimal(20,0) NOT NULL,
  `owner_id` decimal(20,0) DEFAULT NULL,
  `pref_level_id` decimal(20,0) DEFAULT NULL,
  `preference` varchar(2048) DEFAULT NULL,
  `time_pattern_id` decimal(20,0) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_time_pref_owner` (`owner_id`),
  KEY `idx_time_pref_pref_level` (`pref_level_id`),
  KEY `idx_time_pref_time_ptrn` (`time_pattern_id`),
  CONSTRAINT `fk_time_pref_pref_level` FOREIGN KEY (`pref_level_id`) REFERENCES `preference_level` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_time_pref_time_ptrn` FOREIGN KEY (`time_pattern_id`) REFERENCES `time_pattern` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_pref`
--

LOCK TABLES `time_pref` WRITE;
/*!40000 ALTER TABLE `time_pref` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_pref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timetable_manager`
--

DROP TABLE IF EXISTS `timetable_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timetable_manager` (
  `uniqueid` decimal(20,0) NOT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email_address` varchar(200) DEFAULT NULL,
  `last_modified_time` datetime DEFAULT NULL,
  `acad_title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_timetable_manager_puid` (`external_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timetable_manager`
--

LOCK TABLES `timetable_manager` WRITE;
/*!40000 ALTER TABLE `timetable_manager` DISABLE KEYS */;
INSERT INTO `timetable_manager` VALUES (470,'1','Francisco','','Moya','francisco.moya@uclm.es',NULL,'');
/*!40000 ALTER TABLE `timetable_manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tmtbl_mgr_to_roles`
--

DROP TABLE IF EXISTS `tmtbl_mgr_to_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tmtbl_mgr_to_roles` (
  `manager_id` decimal(20,0) DEFAULT NULL,
  `role_id` decimal(20,0) DEFAULT NULL,
  `uniqueid` decimal(20,0) NOT NULL,
  `is_primary` int(1) DEFAULT NULL,
  `receive_emails` int(1) DEFAULT '1',
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `uk_tmtbl_mgr_to_roles_mgr_role` (`manager_id`,`role_id`),
  KEY `fk_tmtbl_mgr_to_roles_role` (`role_id`),
  CONSTRAINT `fk_tmtbl_mgr_to_roles_manager` FOREIGN KEY (`manager_id`) REFERENCES `timetable_manager` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_tmtbl_mgr_to_roles_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tmtbl_mgr_to_roles`
--

LOCK TABLES `tmtbl_mgr_to_roles` WRITE;
/*!40000 ALTER TABLE `tmtbl_mgr_to_roles` DISABLE KEYS */;
INSERT INTO `tmtbl_mgr_to_roles` VALUES (470,1,510,1,1);
/*!40000 ALTER TABLE `tmtbl_mgr_to_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `travel_time`
--

DROP TABLE IF EXISTS `travel_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `travel_time` (
  `uniqueid` decimal(20,0) NOT NULL,
  `session_id` decimal(20,0) NOT NULL,
  `loc1_id` decimal(20,0) NOT NULL,
  `loc2_id` decimal(20,0) NOT NULL,
  `distance` decimal(10,0) NOT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `fk_trvltime_session` (`session_id`),
  CONSTRAINT `fk_trvltime_session` FOREIGN KEY (`session_id`) REFERENCES `sessions` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `travel_time`
--

LOCK TABLES `travel_time` WRITE;
/*!40000 ALTER TABLE `travel_time` DISABLE KEYS */;
/*!40000 ALTER TABLE `travel_time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_data`
--

DROP TABLE IF EXISTS `user_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_data` (
  `external_uid` varchar(40) NOT NULL,
  `name` varchar(100) NOT NULL,
  `value` varchar(4000) DEFAULT NULL,
  PRIMARY KEY (`external_uid`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_data`
--

LOCK TABLES `user_data` WRITE;
/*!40000 ALTER TABLE `user_data` DISABLE KEYS */;
INSERT INTO `user_data` VALUES ('1','LastUsed.acadSessionId','239259');
/*!40000 ALTER TABLE `user_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `username` varchar(15) NOT NULL,
  `password` varchar(25) DEFAULT NULL,
  `external_uid` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin','ISMvKXpXpadDiUoOSoAfww==','1');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waitlist`
--

DROP TABLE IF EXISTS `waitlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waitlist` (
  `uniqueid` decimal(20,0) NOT NULL,
  `student_id` decimal(20,0) DEFAULT NULL,
  `course_offering_id` decimal(20,0) DEFAULT NULL,
  `type` bigint(10) DEFAULT '0',
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  KEY `idx_waitlist_offering` (`course_offering_id`),
  KEY `idx_waitlist_student` (`student_id`),
  CONSTRAINT `fk_waitlist_course_offering` FOREIGN KEY (`course_offering_id`) REFERENCES `course_offering` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_waitlist_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waitlist`
--

LOCK TABLES `waitlist` WRITE;
/*!40000 ALTER TABLE `waitlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `waitlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xconflict`
--

DROP TABLE IF EXISTS `xconflict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xconflict` (
  `uniqueid` decimal(20,0) NOT NULL,
  `conflict_type` bigint(10) NOT NULL,
  `distance` double DEFAULT NULL,
  PRIMARY KEY (`uniqueid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xconflict`
--

LOCK TABLES `xconflict` WRITE;
/*!40000 ALTER TABLE `xconflict` DISABLE KEYS */;
/*!40000 ALTER TABLE `xconflict` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xconflict_exam`
--

DROP TABLE IF EXISTS `xconflict_exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xconflict_exam` (
  `conflict_id` decimal(20,0) NOT NULL,
  `exam_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`conflict_id`,`exam_id`),
  KEY `idx_xconflict_exam` (`exam_id`),
  CONSTRAINT `fk_xconflict_ex_conf` FOREIGN KEY (`conflict_id`) REFERENCES `xconflict` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_xconflict_ex_exam` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xconflict_exam`
--

LOCK TABLES `xconflict_exam` WRITE;
/*!40000 ALTER TABLE `xconflict_exam` DISABLE KEYS */;
/*!40000 ALTER TABLE `xconflict_exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xconflict_instructor`
--

DROP TABLE IF EXISTS `xconflict_instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xconflict_instructor` (
  `conflict_id` decimal(20,0) NOT NULL,
  `instructor_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`conflict_id`,`instructor_id`),
  KEY `fk_xconflict_in_instructor` (`instructor_id`),
  CONSTRAINT `fk_xconflict_in_conf` FOREIGN KEY (`conflict_id`) REFERENCES `xconflict` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_xconflict_in_instructor` FOREIGN KEY (`instructor_id`) REFERENCES `departmental_instructor` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xconflict_instructor`
--

LOCK TABLES `xconflict_instructor` WRITE;
/*!40000 ALTER TABLE `xconflict_instructor` DISABLE KEYS */;
/*!40000 ALTER TABLE `xconflict_instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xconflict_student`
--

DROP TABLE IF EXISTS `xconflict_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xconflict_student` (
  `conflict_id` decimal(20,0) NOT NULL,
  `student_id` decimal(20,0) NOT NULL,
  PRIMARY KEY (`conflict_id`,`student_id`),
  KEY `idx_xconflict_st_student` (`student_id`),
  CONSTRAINT `fk_xconflict_st_conf` FOREIGN KEY (`conflict_id`) REFERENCES `xconflict` (`uniqueid`) ON DELETE CASCADE,
  CONSTRAINT `fk_xconflict_st_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`uniqueid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xconflict_student`
--

LOCK TABLES `xconflict_student` WRITE;
/*!40000 ALTER TABLE `xconflict_student` DISABLE KEYS */;
/*!40000 ALTER TABLE `xconflict_student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-20  6:56:45

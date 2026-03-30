-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 66.113.191.11    Database: elandv2
-- ------------------------------------------------------
-- Server version	5.1.73

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
-- Table structure for table `attendee`
--

DROP TABLE IF EXISTS `attendee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendee` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` datetime DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  `ModifyBy` int(4) DEFAULT NULL,
  `event` int(11) DEFAULT NULL,
  `regstatus` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT 'INCOMPLETE',
  `regtype` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT 'REGISTRANT',
  `reggroupkey` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `reggroupcontact` int(11) DEFAULT NULL,
  `fname` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `lname` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `title` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `company` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `address1` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `address2` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `city` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `state` tinyint(4) DEFAULT '0',
  `zip` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `province` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `country` int(2) DEFAULT '0',
  `phone` varchar(30) DEFAULT NULL,
  `mobilephone` varchar(30) DEFAULT NULL,
  `fax` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `weburl` varchar(255) DEFAULT NULL,
  `subscribe` tinyint(4) DEFAULT '0',
  `couponcode` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `regoption` varchar(1000) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `payamount` decimal(10,2) DEFAULT '0.00',
  `paymethod` char(10) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `ponumber` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `orderid` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `transid` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `dem_q1answer` varchar(1000) DEFAULT NULL,
  `dem_q1other` varchar(1000) DEFAULT NULL,
  `dem_q1subanswer` varchar(1000) DEFAULT NULL,
  `dem_q1subother` varchar(1000) DEFAULT NULL,
  `dem_q2answer` varchar(1000) DEFAULT NULL,
  `dem_q2other` varchar(1000) DEFAULT NULL,
  `dem_q2subanswer` varchar(1000) DEFAULT NULL,
  `dem_q2subother` varchar(1000) DEFAULT NULL,
  `dem_q3answer` varchar(1000) DEFAULT NULL,
  `dem_q3other` varchar(1000) DEFAULT NULL,
  `dem_q3subanswer` varchar(1000) DEFAULT NULL,
  `dem_q3subother` varchar(1000) DEFAULT NULL,
  `dem_q4answer` varchar(1000) DEFAULT NULL,
  `dem_q4other` varchar(1000) DEFAULT NULL,
  `dem_q4subanswer` varchar(1000) DEFAULT NULL,
  `dem_q4subother` varchar(1000) DEFAULT NULL,
  `dem_q5answer` varchar(1000) DEFAULT NULL,
  `dem_q5other` varchar(1000) DEFAULT NULL,
  `dem_q5subanswer` varchar(1000) DEFAULT NULL,
  `dem_q5subother` varchar(1000) DEFAULT NULL,
  `dem_q6answer` varchar(1000) DEFAULT NULL,
  `dem_q6other` varchar(1000) DEFAULT NULL,
  `dem_q6subanswer` varchar(1000) DEFAULT NULL,
  `dem_q6subother` varchar(1000) DEFAULT NULL,
  `dem_q7answer` varchar(1000) DEFAULT NULL,
  `dem_q7other` varchar(1000) DEFAULT NULL,
  `dem_q7subanswer` varchar(1000) DEFAULT NULL,
  `dem_q7subother` varchar(1000) DEFAULT NULL,
  `dem_q8answer` varchar(1000) DEFAULT NULL,
  `dem_q8other` varchar(1000) DEFAULT NULL,
  `dem_q8subanswer` varchar(1000) DEFAULT NULL,
  `dem_q8subother` varchar(1000) DEFAULT NULL,
  `dem_q9answer` varchar(1000) DEFAULT NULL,
  `dem_q9other` varchar(1000) DEFAULT NULL,
  `dem_q9subanswer` varchar(1000) DEFAULT NULL,
  `dem_q9subother` varchar(1000) DEFAULT NULL,
  `dem_q10answer` varchar(1000) DEFAULT NULL,
  `dem_q10other` varchar(1000) DEFAULT NULL,
  `dem_q10subanswer` varchar(1000) DEFAULT NULL,
  `dem_q10subother` varchar(1000) DEFAULT NULL,
  `user_ipaddress` varchar(15) DEFAULT NULL,
  `user_clientinfo` varchar(255) DEFAULT NULL,
  `receiptsent` tinyint(4) DEFAULT '0',
  `adminnote` text,
  `printdate` datetime DEFAULT NULL,
  `printloc` varchar(10) DEFAULT NULL,
  `ribbons` varchar(255) DEFAULT NULL,
  `exhibitor` int(11) DEFAULT NULL,
  `memberID` varchar(50) DEFAULT NULL,
  `age` tinyint(3) DEFAULT NULL,
  `dob` varchar(10) DEFAULT NULL,
  `tshirt` varchar(20) DEFAULT NULL,
  `waiverdate` varchar(20) DEFAULT NULL,
  `waiversig` varchar(255) DEFAULT NULL,
  `redircode` varchar(20) DEFAULT NULL,
  `redircode_laststep` varchar(20) DEFAULT NULL,
  `emergencycontactname` varchar(255) DEFAULT NULL,
  `emergencycontactphone` varchar(100) DEFAULT NULL,
  `emergencycontactrel` varchar(100) DEFAULT NULL,
  `foodallergies` varchar(1000) DEFAULT NULL,
  `drugallergies` varchar(1000) DEFAULT NULL,
  `termsagree` tinyint(1) DEFAULT '0',
  `confirmnum` varchar(20) DEFAULT NULL,
  `hsi` varchar(20) DEFAULT NULL,
  `optOutNotShowMgmtEmail` tinyint(1) DEFAULT NULL,
  `optOutNateMobileAppConnect` tinyint(1) DEFAULT NULL,
  `guestforprimaryID` int(11) DEFAULT NULL,
  `covidvax` tinyint(1) DEFAULT NULL,
  `oldID` int(11) DEFAULT NULL,
  `newID` int(11) DEFAULT NULL,
  `county` varchar(50) DEFAULT NULL,
  `rejectEventAccess` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`,`event`),
  KEY `memberID` (`memberID`,`ID`,`event`),
  KEY `ix_ID_exhibitor` (`ID`,`exhibitor`,`regstatus`)
) ENGINE=MyISAM AUTO_INCREMENT=424090 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attendee_seloption`
--

DROP TABLE IF EXISTS `attendee_seloption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendee_seloption` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `attendee` int(11) DEFAULT NULL,
  `optcode` varchar(10) COLLATE latin1_general_ci DEFAULT NULL,
  `cost` float DEFAULT NULL,
  `basecost` float DEFAULT NULL,
  `days` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  `couponcode` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `coupondiscount` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `membercomppass` tinyint(1) DEFAULT NULL,
  `exhibitorcomppass` tinyint(1) DEFAULT NULL,
  `note` varchar(500) COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_attendee_seloption_attendee` (`attendee`)
) ENGINE=MyISAM AUTO_INCREMENT=2714331 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attendee_seloption_extrainfo`
--

DROP TABLE IF EXISTS `attendee_seloption_extrainfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendee_seloption_extrainfo` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `attendee_seloption` int(11) DEFAULT NULL,
  `golfername1` varchar(100) DEFAULT NULL,
  `golfershirtsz1` varchar(10) DEFAULT NULL,
  `golfername2` varchar(100) DEFAULT NULL,
  `golfershirtsz2` varchar(10) DEFAULT NULL,
  `golfername3` varchar(100) DEFAULT NULL,
  `golfershirtsz3` varchar(10) DEFAULT NULL,
  `golfername4` varchar(100) DEFAULT NULL,
  `golfershirtsz4` varchar(10) DEFAULT NULL,
  `5kshirtsz` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2051 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attendeereg_couponcode`
--

DROP TABLE IF EXISTS `attendeereg_couponcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendeereg_couponcode` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` datetime DEFAULT NULL,
  `CreateBy` int(4) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  `ModifyBy` int(4) DEFAULT NULL,
  `event` int(11) DEFAULT NULL,
  `code` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `grouplabel` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `value` varchar(10) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT '$0',
  `applytoregoption` varchar(1000) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `isactive` tinyint(4) DEFAULT '1',
  `maxuses` int(4) DEFAULT NULL,
  `curruses` int(4) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=7117 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attendeereg_demog_answer`
--

DROP TABLE IF EXISTS `attendeereg_demog_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendeereg_demog_answer` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `attendeereg_demog_question` int(11) DEFAULT NULL,
  `answercode` varchar(10) DEFAULT NULL,
  `answervalue` varchar(255) DEFAULT NULL,
  `useotherbox` tinyint(1) DEFAULT '0',
  `displayorder` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=3420 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attendeereg_demog_answersub`
--

DROP TABLE IF EXISTS `attendeereg_demog_answersub`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendeereg_demog_answersub` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `displayorder` tinyint(2) DEFAULT NULL,
  `attendeereg_demog_answer` int(11) DEFAULT NULL,
  `subanswertext` varchar(255) DEFAULT NULL,
  `subanswertextpos` char(10) DEFAULT NULL,
  `subanswercode` varchar(10) DEFAULT NULL,
  `subanswervalue` varchar(255) DEFAULT NULL,
  `useotherbox` tinyint(1) DEFAULT NULL,
  `attendeereg_demog_answersubcol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=207 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attendeereg_demog_question`
--

DROP TABLE IF EXISTS `attendeereg_demog_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendeereg_demog_question` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `event` int(11) DEFAULT NULL,
  `questiontype` varchar(10) DEFAULT NULL,
  `subquestiontype` varchar(10) DEFAULT NULL,
  `displayorder` float DEFAULT NULL,
  `question` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=526 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attendeereg_option`
--

DROP TABLE IF EXISTS `attendeereg_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendeereg_option` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `attendeereg_optiongroup` int(11) DEFAULT NULL,
  `optionstatus` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `optioncode` varchar(10) COLLATE latin1_general_ci DEFAULT NULL,
  `optionlabel` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `displayorder` float DEFAULT NULL,
  `maxcapacity` int(4) DEFAULT NULL,
  `membersonly` tinyint(1) DEFAULT '0',
  `allowdiscount` tinyint(1) DEFAULT '0',
  `ribboncontent` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `showconflicts` tinyint(1) DEFAULT '0',
  `optiondate` date DEFAULT NULL,
  `optionstarttime` varchar(8) CHARACTER SET latin1 DEFAULT NULL,
  `optionendtime` varchar(8) CHARACTER SET latin1 DEFAULT NULL,
  `priceincrease_date1` datetime DEFAULT NULL,
  `priceincrease_date2` datetime DEFAULT NULL,
  `base_price` decimal(10,2) DEFAULT '0.00',
  `base_increaseprice1` decimal(10,2) DEFAULT NULL,
  `base_increaseprice2` decimal(10,2) DEFAULT NULL,
  `base_daychoice` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `base_allownumchoices` tinyint(1) DEFAULT NULL,
  `member_price` decimal(10,2) DEFAULT NULL,
  `member_increaseprice1` decimal(10,2) DEFAULT NULL,
  `member_increaseprice2` decimal(10,2) DEFAULT NULL,
  `member_daychoice` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `member_allownumchoices` tinyint(1) DEFAULT NULL,
  `optiondeschtml` text CHARACTER SET latin1,
  `optiondesctext` text CHARACTER SET latin1,
  `allowattmod` varchar(3) COLLATE latin1_general_ci DEFAULT NULL,
  `badgebgcolor` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2230 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attendeereg_optiongroup`
--

DROP TABLE IF EXISTS `attendeereg_optiongroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendeereg_optiongroup` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `event` int(11) DEFAULT NULL,
  `heading` varchar(255) COLLATE latin1_general_ci DEFAULT NULL,
  `groupstatus` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `displayorder` float DEFAULT NULL,
  `allowmultiselect` tinyint(1) DEFAULT '1',
  `reqselection` tinyint(1) DEFAULT '0',
  `content` text COLLATE latin1_general_ci,
  `notes` text COLLATE latin1_general_ci,
  `summaryreportprimaryopt` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=575 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `booth`
--

DROP TABLE IF EXISTS `booth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booth` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` datetime DEFAULT NULL,
  `CreateBy` int(11) DEFAULT NULL,
  `ModifiedDate` datetime DEFAULT NULL,
  `ModifiedBy` int(11) DEFAULT NULL,
  `event` int(11) DEFAULT NULL,
  `exhibitor` int(11) DEFAULT NULL,
  `label` varchar(45) DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  `depth` int(11) DEFAULT NULL,
  `corners` tinyint(4) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `adminnotes` text,
  `cost` decimal(7,2) DEFAULT NULL,
  `hidefromdisplay` tinyint(1) DEFAULT '0',
  `exhibitor_invoiceID` int(11) DEFAULT NULL,
  `elandPayment` tinyint(1) DEFAULT NULL,
  `elandExpectedCommission` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=410 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `boothapp`
--

DROP TABLE IF EXISTS `boothapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boothapp` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` datetime DEFAULT NULL,
  `CreateBy` int(4) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  `ModifyBy` int(11) DEFAULT NULL,
  `event` int(11) DEFAULT NULL,
  `assignedbooth` varchar(50) DEFAULT NULL,
  `convert_status` varchar(20) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `weburl` varchar(200) DEFAULT NULL,
  `logourl` varchar(200) DEFAULT NULL,
  `description` text,
  `address1` varchar(100) DEFAULT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` int(4) DEFAULT '0',
  `province` varchar(50) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `country` int(4) DEFAULT '0',
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(400) DEFAULT NULL,
  `contactfname` varchar(50) DEFAULT NULL,
  `contactlname` varchar(50) DEFAULT NULL,
  `contacttitle` varchar(100) DEFAULT NULL,
  `contactphone` varchar(20) DEFAULT NULL,
  `contactemail` varchar(400) DEFAULT NULL,
  `amtdue` decimal(7,2) DEFAULT NULL,
  `paystatus` varchar(20) DEFAULT NULL,
  `paymethod` varchar(10) DEFAULT NULL,
  `invoicenum` varchar(20) DEFAULT NULL,
  `ponumber` varchar(100) DEFAULT NULL,
  `transactionID` varchar(255) DEFAULT NULL,
  `bill_fname` varchar(45) DEFAULT NULL,
  `bill_lname` varchar(45) DEFAULT NULL,
  `bill_address` varchar(45) DEFAULT NULL,
  `bill_city` varchar(45) DEFAULT NULL,
  `bill_state` int(4) DEFAULT NULL,
  `bill_zip` varchar(45) DEFAULT NULL,
  `bill_country` int(4) DEFAULT NULL,
  `termsagree` tinyint(1) DEFAULT '0',
  `adminnotes` text,
  `receiptsent` tinyint(1) DEFAULT '0',
  `exhibitorID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=165 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `boothapp_selection`
--

DROP TABLE IF EXISTS `boothapp_selection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boothapp_selection` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` datetime DEFAULT NULL,
  `CreateBy` int(11) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  `ModifyBy` int(11) DEFAULT NULL,
  `boothapp` int(11) DEFAULT NULL,
  `selection` tinyint(4) DEFAULT NULL,
  `b1_boothID` int(11) DEFAULT NULL,
  `b1_label` varchar(45) DEFAULT NULL,
  `b1_length` tinyint(4) DEFAULT NULL,
  `b1_depth` tinyint(4) DEFAULT NULL,
  `b1_corners` tinyint(4) DEFAULT NULL,
  `b1_type` varchar(20) DEFAULT NULL,
  `b1_cost` decimal(7,2) DEFAULT NULL,
  `b2_boothID` int(11) DEFAULT NULL,
  `b2_label` varchar(45) DEFAULT NULL,
  `b2_length` tinyint(4) DEFAULT NULL,
  `b2_depth` tinyint(4) DEFAULT NULL,
  `b2_corners` tinyint(4) DEFAULT NULL,
  `b2_type` varchar(20) DEFAULT NULL,
  `b2_cost` decimal(7,2) DEFAULT NULL,
  `b3_boothID` int(11) DEFAULT NULL,
  `b3_label` varchar(45) DEFAULT NULL,
  `b3_length` tinyint(4) DEFAULT NULL,
  `b3_depth` tinyint(4) DEFAULT NULL,
  `b3_corners` tinyint(4) DEFAULT NULL,
  `b3_type` varchar(20) DEFAULT NULL,
  `b3_cost` decimal(7,2) DEFAULT NULL,
  `boothnote` text,
  `adminnotes` text,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=190 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` datetime DEFAULT NULL,
  `CreateBy` int(2) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  `ModifyBy` int(2) DEFAULT NULL,
  `Status` varchar(20) DEFAULT 'APPROVED',
  `company` varchar(100) DEFAULT NULL,
  `clientcode` varchar(8) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` int(3) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `country` int(3) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `contactname` varchar(100) DEFAULT NULL,
  `contactphone` varchar(50) DEFAULT NULL,
  `contactmobile` varchar(50) DEFAULT NULL,
  `contactemail` varchar(100) DEFAULT NULL,
  `clientnotes` text,
  `pp_payproctype` varchar(20) DEFAULT NULL,
  `pp_partnerid` varchar(50) DEFAULT NULL,
  `pp_vendorid` varchar(50) DEFAULT NULL,
  `pp_loginid` varchar(50) DEFAULT NULL,
  `pp_pass` varchar(50) DEFAULT NULL,
  `pp_antranskey` varchar(50) DEFAULT NULL,
  `pp_anloginid` varchar(50) DEFAULT NULL,
  `pp_liveurl` varchar(255) DEFAULT NULL,
  `pp_testurl` varchar(255) DEFAULT NULL,
  `pp_usebillingaddressfields` tinyint(1) DEFAULT NULL,
  `ca_username` varchar(255) DEFAULT NULL,
  `ca_password` varchar(20) DEFAULT NULL,
  `ca_allowregoptions` tinyint(1) DEFAULT '0',
  `ca_allowcouponcodes` tinyint(1) DEFAULT '0',
  `ca_allowdemogs` tinyint(1) DEFAULT '0',
  `ca_allowattreg` tinyint(1) DEFAULT '0',
  `ca_allowattregreports` tinyint(1) DEFAULT '0',
  `ca_allowexhproducts` tinyint(1) DEFAULT '0',
  `ca_allowexhibitors` tinyint(1) DEFAULT '0',
  `ca_allowexhreports` tinyint(1) DEFAULT '0',
  `ca_mgeventpref` int(11) DEFAULT NULL,
  `ca_mgeventprefdefault` int(11) DEFAULT NULL,
  `reportcenterurl` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=98 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` datetime DEFAULT NULL,
  `CreateBy` int(4) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  `ModifyBy` int(4) DEFAULT NULL,
  `client` int(11) DEFAULT NULL,
  `Title` varchar(100) DEFAULT NULL,
  `EventCode` varchar(20) DEFAULT NULL,
  `useregistration` tinyint(1) DEFAULT '1',
  `useleadtracking` tinyint(1) DEFAULT '0',
  `StartDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `Tagline` varchar(100) DEFAULT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `Location2` varchar(100) DEFAULT NULL,
  `eventlogo` varchar(255) DEFAULT NULL,
  `weburl` varchar(255) DEFAULT NULL,
  `ccaccepted` varchar(100) DEFAULT NULL,
  `allowcheckpayment` tinyint(1) DEFAULT '1',
  `checkaddress` text,
  `allowpurchaseorder` tinyint(1) DEFAULT '1',
  `poinstructions` text,
  `attregreqapproval` tinyint(1) DEFAULT '0',
  `attregapprovalmsg` varchar(255) DEFAULT NULL,
  `attregrejectmsg` varchar(255) DEFAULT NULL,
  `attregusecustomform` tinyint(1) DEFAULT '0',
  `attregstartdate` datetime DEFAULT NULL,
  `attregenddate` datetime DEFAULT NULL,
  `attregdisable` tinyint(1) DEFAULT '0',
  `attusememberlogin` tinyint(1) DEFAULT NULL,
  `attregloginmethod` varchar(30) DEFAULT NULL,
  `attinternalmembertbl` varchar(100) DEFAULT NULL,
  `attexternalmemberxml` varchar(255) DEFAULT NULL,
  `attcomppassfld` varchar(100) DEFAULT NULL,
  `attcomppassregopt` varchar(100) DEFAULT NULL,
  `attregpaymode` varchar(20) DEFAULT NULL,
  `adminFROMemail` varchar(255) DEFAULT NULL,
  `adminCCemail` varchar(255) DEFAULT NULL,
  `formintroHTML` text,
  `globalfooterHTML` text,
  `regformoptinhtml` text,
  `receiptintroHTML` text,
  `receiptfooterHTML` text,
  `emailtpl_receipt` varchar(255) DEFAULT NULL,
  `exhregstartdate` datetime DEFAULT NULL,
  `exhregenddate` datetime DEFAULT NULL,
  `exhregdisable` tinyint(1) DEFAULT '0',
  `exhallowleadretr` tinyint(1) DEFAULT '0',
  `exhdefaultregopt` int(11) DEFAULT NULL,
  `exhfullconfregopt` int(11) DEFAULT NULL,
  `exhadminFROMemail` varchar(255) DEFAULT NULL,
  `exhadminCCemail` varchar(255) DEFAULT NULL,
  `emailtpl_exhwelcome` varchar(255) DEFAULT NULL,
  `exhmgmtusecompanydesc` tinyint(1) DEFAULT '1',
  `exhmgmtuseproductdesc` tinyint(1) DEFAULT '1',
  `exhformintroHTML` text,
  `exhglobalfooterHTML` text,
  `badgetpltype` varchar(255) DEFAULT NULL,
  `badgehdrimg` varchar(255) DEFAULT NULL,
  `badgepdf417flds` text,
  `badgeattprinttpl` varchar(255) DEFAULT NULL,
  `badgeexhprinttpl` varchar(255) DEFAULT NULL,
  `attregusecompanylookup` tinyint(1) DEFAULT NULL,
  `attregcompanylookuptbl` varchar(100) DEFAULT NULL,
  `attregmaxpersubmission` int(11) DEFAULT NULL,
  `attregallowguest` tinyint(1) DEFAULT NULL,
  `attregguestregopt` int(11) DEFAULT NULL,
  `bypassregoptselection` tinyint(1) DEFAULT NULL,
  `bypassregoptautoassignopt` int(11) DEFAULT NULL,
  `attregusesummary` tinyint(1) DEFAULT '0',
  `attregreceipttpl_submission` varchar(255) DEFAULT NULL,
  `attregreceipttpl_submissionsubject` varchar(255) DEFAULT NULL,
  `attregreceipttpl_generalpaidattendee` varchar(255) DEFAULT NULL,
  `attregreceipttpl_preapproved` varchar(255) DEFAULT NULL,
  `attregreceipttpl_preapprovedsubject` varchar(255) DEFAULT NULL,
  `attregreceipttpl_pending` varchar(255) DEFAULT NULL,
  `attregreceipttpl_pendingsubject` varchar(255) DEFAULT NULL,
  `attregapprovalmsg_subject` varchar(255) DEFAULT NULL,
  `attregrejectmsg_subject` varchar(255) DEFAULT NULL,
  `adminBCCemail` varchar(255) DEFAULT NULL,
  `exhemailtpl_regreceipt` varchar(255) DEFAULT NULL,
  `exhemailtpl_regreceiptsubject` varchar(255) DEFAULT NULL,
  `exhemailtpl_welcomemsgsubject` varchar(100) DEFAULT NULL,
  `exhallowdiscountcode` tinyint(4) DEFAULT NULL,
  `exhallowcomppass` tinyint(1) DEFAULT NULL,
  `exhhidepaymentsection` tinyint(1) DEFAULT NULL,
  `attregreceipttpl_press` varchar(255) DEFAULT NULL,
  `attregreceipttpl_presssubject` varchar(255) DEFAULT NULL,
  `attregreceipttpl_pressapproved` varchar(255) DEFAULT NULL,
  `attregreceipttpl_pressapprovedsubject` varchar(255) DEFAULT NULL,
  `attregreceipttpl_pressrejected` varchar(255) DEFAULT NULL,
  `attregreceipttpl_pressrejectedsubject` varchar(255) DEFAULT NULL,
  `attregreceipttpl_balancedue` varchar(255) DEFAULT NULL,
  `attregreceipttpl_balanceduesubject` varchar(255) DEFAULT NULL,
  `atthousingurl` varchar(400) DEFAULT NULL,
  `exhhousingurl` varchar(400) DEFAULT NULL,
  `badgetpltypeonsite` varchar(255) DEFAULT NULL,
  `receiptemailheaderimgurl` varchar(255) DEFAULT NULL,
  `bypassregoptshowgroups` varchar(255) DEFAULT NULL,
  `exhregmaxpersubmission` tinyint(2) DEFAULT NULL,
  `adminFROMemailpw` varchar(45) DEFAULT NULL,
  `adminFROMname` varchar(45) DEFAULT NULL,
  `exhadminFROMemailpw` varchar(45) DEFAULT NULL,
  `exhadminFROMname` varchar(45) DEFAULT NULL,
  `badgetpltypethermal` varchar(255) DEFAULT NULL,
  `allowattmod` tinyint(1) DEFAULT '0',
  `attrequniqueemail` tinyint(1) DEFAULT '0',
  `eventcol` varchar(45) DEFAULT '0',
  `exhreceiptintroHTML` text,
  `exhreceiptfooterHTML` text,
  `attallowpublicguestreg` tinyint(1) DEFAULT '0',
  `attregDoExistingAttendeeLookup` tinyint(1) DEFAULT '0',
  `attrregUseExhibitorCompanyLookup` tinyint(1) DEFAULT '0',
  `emailtpl_boothpaymentinvite` varchar(255) DEFAULT NULL,
  `boothcostpersqft` decimal(7,2) DEFAULT '0.00',
  `boothcostpercorner` decimal(7,2) DEFAULT '0.00',
  `exhTermsAgreementPdf` varchar(255) DEFAULT NULL,
  `exhShowFloorMapPdf` varchar(255) DEFAULT NULL,
  `emailtpl_boothappreceipt` varchar(255) DEFAULT NULL,
  `boothappmailingaddr` text,
  `boothapppaymode` varchar(20) DEFAULT NULL,
  `exhboothadminFROMemail` varchar(100) DEFAULT NULL,
  `exhboothadminFROMname` varchar(45) DEFAULT NULL,
  `exhboothadminFROMemailpw` varchar(45) DEFAULT NULL,
  `exhboothadminCCemail` varchar(100) DEFAULT NULL,
  `exhboothGenIntroHtml` text,
  `exhboothGenFooterHtml` text,
  `exhboothPrintInvoiceTpl` varchar(255) DEFAULT NULL,
  `emailtpl_sponsorshippaymentinvite` varchar(255) DEFAULT NULL,
  `emailtpl_sponsorshippurchasereceipt` varchar(255) DEFAULT NULL,
  `sponsorshipPaymentPrintInvoiceTpl` varchar(255) DEFAULT NULL,
  `sponsorshippaymode` varchar(20) DEFAULT NULL,
  `exhInvoicePaymentReceiptTpl` varchar(255) DEFAULT NULL,
  `exhInvoicePaymode` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=229 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_badgetemplate`
--

DROP TABLE IF EXISTS `event_badgetemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_badgetemplate` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TplLabel` varchar(255) DEFAULT NULL,
  `AttendeeTplURL` varchar(255) DEFAULT NULL,
  `ExhibitorTplURL` varchar(255) DEFAULT NULL,
  `adminNotes` text,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_checkin_cfg`
--

DROP TABLE IF EXISTS `event_checkin_cfg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_checkin_cfg` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `active_event` int(11) DEFAULT NULL,
  `use_admin` int(11) DEFAULT NULL,
  `set_event_timezone` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `id_UNIQUE` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_gate`
--

DROP TABLE IF EXISTS `event_gate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_gate` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `event` int(11) DEFAULT NULL,
  `gate` varchar(45) DEFAULT NULL,
  `allowRegOption` varchar(100) DEFAULT NULL,
  `openScanningDT` varchar(30) DEFAULT NULL,
  `closeScanningDT` varchar(30) DEFAULT NULL,
  `restrictSingleCheckin` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=412 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_gate_log`
--

DROP TABLE IF EXISTS `event_gate_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_gate_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` datetime DEFAULT NULL,
  `eventID` int(11) DEFAULT NULL,
  `attendeeID` int(11) DEFAULT NULL,
  `gateID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `idx_event_gate_log_attendeeID_gateID` (`attendeeID`,`gateID`)
) ENGINE=MyISAM AUTO_INCREMENT=303378 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exhibitor`
--

DROP TABLE IF EXISTS `exhibitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exhibitor` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` datetime DEFAULT NULL,
  `CreateBy` int(4) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  `ModifyBy` int(11) DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  `event` int(11) DEFAULT NULL,
  `booth` varchar(50) DEFAULT NULL,
  `amtdue` decimal(7,2) DEFAULT NULL,
  `exhwelcomelastsent` varchar(255) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `passcode` varchar(50) DEFAULT NULL,
  `compedpasses` tinyint(2) DEFAULT '0',
  `weburl` varchar(200) DEFAULT NULL,
  `logourl` varchar(200) DEFAULT NULL,
  `address1` varchar(100) DEFAULT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` int(4) DEFAULT '0',
  `stateother` varchar(50) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `country` int(4) DEFAULT '0',
  `countryother` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `email` varchar(400) DEFAULT NULL,
  `contactfname` varchar(50) DEFAULT NULL,
  `contactlname` varchar(50) DEFAULT NULL,
  `contacttitle` varchar(100) DEFAULT NULL,
  `contactaddress1` varchar(100) DEFAULT NULL,
  `contactaddress2` varchar(50) DEFAULT NULL,
  `contactcity` varchar(50) DEFAULT NULL,
  `contactstate` int(4) DEFAULT '0',
  `contactstateother` varchar(50) DEFAULT NULL,
  `contactzip` varchar(20) DEFAULT NULL,
  `contactcountry` int(4) DEFAULT '0',
  `contactcountryother` varchar(50) DEFAULT NULL,
  `contactphone` varchar(20) DEFAULT NULL,
  `contactfax` varchar(20) DEFAULT NULL,
  `contactemail` varchar(400) DEFAULT NULL,
  `termsagree` tinyint(1) DEFAULT '0',
  `description` text,
  `adminnotes` text,
  `oldID` int(11) DEFAULT NULL,
  `isSponsor` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ix_ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=16214 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exhibitor_invite`
--

DROP TABLE IF EXISTS `exhibitor_invite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exhibitor_invite` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` datetime DEFAULT NULL,
  `CreateBy` int(4) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  `ModifyBy` int(11) DEFAULT NULL,
  `event` int(11) DEFAULT NULL,
  `invite_lastsent` varchar(255) DEFAULT NULL,
  `prioritypoints` int(11) DEFAULT '0',
  `prevEventBoothInfo` text,
  `amtdue` decimal(7,2) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `weburl` varchar(200) DEFAULT NULL,
  `logourl` varchar(200) DEFAULT NULL,
  `address1` varchar(100) DEFAULT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT '0',
  `province` varchar(50) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `country` varchar(50) DEFAULT '0',
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(400) DEFAULT NULL,
  `contactfname` varchar(50) DEFAULT NULL,
  `contactlname` varchar(50) DEFAULT NULL,
  `contacttitle` varchar(100) DEFAULT NULL,
  `contactphone` varchar(20) DEFAULT NULL,
  `contactemail` varchar(400) DEFAULT NULL,
  `termsagree` tinyint(1) DEFAULT '0',
  `description` text,
  `adminnotes` text,
  `preveventSponsor` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ix_ID` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=541 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exhibitor_invoice`
--

DROP TABLE IF EXISTS `exhibitor_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exhibitor_invoice` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CreateBy` int(11) DEFAULT NULL,
  `LastModify` datetime DEFAULT NULL,
  `ModifyBy` int(11) DEFAULT NULL,
  `event` int(11) DEFAULT NULL,
  `exhibitor` int(11) DEFAULT NULL,
  `invoicedate` datetime DEFAULT NULL,
  `invoicenum` varchar(50) DEFAULT NULL,
  `ponumber` varchar(50) DEFAULT NULL,
  `addlinvoicenotes` text,
  `invoicetotalamt` decimal(10,2) DEFAULT NULL,
  `paystatus` varchar(20) DEFAULT NULL,
  `paymethod` varchar(10) DEFAULT NULL,
  `transactionID` varchar(255) DEFAULT NULL,
  `bill_fname` varchar(45) DEFAULT NULL,
  `bill_lname` varchar(45) DEFAULT NULL,
  `bill_address` varchar(45) DEFAULT NULL,
  `bill_city` varchar(45) DEFAULT NULL,
  `bill_state` int(4) DEFAULT NULL,
  `bill_province` varchar(45) DEFAULT NULL,
  `bill_zip` varchar(10) DEFAULT NULL,
  `bill_country` int(4) DEFAULT NULL,
  `receiptsent` tinyint(1) DEFAULT '0',
  `adminnote` text,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=223 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exhibitor_product`
--

DROP TABLE IF EXISTS `exhibitor_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exhibitor_product` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Status` varchar(20) DEFAULT NULL,
  `exhibitor_productcat` int(11) DEFAULT NULL,
  `product` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=499 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exhibitor_productcat`
--

DROP TABLE IF EXISTS `exhibitor_productcat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exhibitor_productcat` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `event` int(11) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `displayorder` float DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=146 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `linker_exhibitor_product`
--

DROP TABLE IF EXISTS `linker_exhibitor_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `linker_exhibitor_product` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `exhibitor` int(11) DEFAULT NULL,
  `exhibitor_product` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2825 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lookup_attendeecompany`
--

DROP TABLE IF EXISTS `lookup_attendeecompany`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lookup_attendeecompany` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `clientID` int(11) DEFAULT NULL,
  `eventID` int(11) DEFAULT '0',
  `company` varchar(100) DEFAULT NULL,
  `address1` varchar(100) DEFAULT NULL,
  `address2` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=1623 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lookup_attendeecompany_import`
--

DROP TABLE IF EXISTS `lookup_attendeecompany_import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lookup_attendeecompany_import` (
  `company` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `address1` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `address2` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `city` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `state` varchar(2) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `stateAbbrev` varchar(255) DEFAULT NULL,
  `zip` varchar(10) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `province` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `country` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `countryName` varchar(255) DEFAULT NULL,
  `phone` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `fax` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lookup_country`
--

DROP TABLE IF EXISTS `lookup_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lookup_country` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CountryCode` varchar(20) DEFAULT NULL,
  `FullName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=191 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lookup_state`
--

DROP TABLE IF EXISTS `lookup_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lookup_state` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Abbrev` varchar(10) DEFAULT NULL,
  `FullName` varchar(50) DEFAULT NULL,
  `notUSState` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `redirecturl`
--

DROP TABLE IF EXISTS `redirecturl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `redirecturl` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `event` int(11) DEFAULT NULL,
  `codestatus` varchar(20) DEFAULT 'ACTIVE',
  `code` varchar(20) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `hits` int(11) DEFAULT NULL,
  `adminnotes` text,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=473 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sponsorship`
--

DROP TABLE IF EXISTS `sponsorship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sponsorship` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` datetime DEFAULT NULL,
  `CreateBy` int(11) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  `ModifyBy` int(11) DEFAULT NULL,
  `displaystatus` char(10) DEFAULT NULL,
  `displayorder` int(11) DEFAULT '0',
  `title` varchar(100) DEFAULT NULL,
  `imgurl` varchar(255) DEFAULT NULL,
  `description` text,
  `itemamt` decimal(10,2) DEFAULT '0.00',
  `numavailable` int(11) DEFAULT NULL,
  `event` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sponsorship_purchase`
--

DROP TABLE IF EXISTS `sponsorship_purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sponsorship_purchase` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` datetime DEFAULT NULL,
  `CreateBy` int(11) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  `ModifyBy` int(11) DEFAULT NULL,
  `event` int(11) DEFAULT NULL,
  `sponsorship` int(11) DEFAULT NULL,
  `exhibitor` int(11) DEFAULT NULL,
  `invite_lastsent` varchar(45) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `weburl` varchar(200) DEFAULT NULL,
  `logourl` varchar(200) DEFAULT NULL,
  `description` text,
  `address1` varchar(100) DEFAULT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `province` varchar(50) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `country` int(11) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(400) DEFAULT NULL,
  `contactfname` varchar(50) DEFAULT NULL,
  `contactlname` varchar(50) DEFAULT NULL,
  `contactphone` varchar(20) DEFAULT NULL,
  `contactemail` varchar(400) DEFAULT NULL,
  `amtdue` decimal(10,2) DEFAULT '0.00',
  `paystatus` varchar(20) DEFAULT NULL,
  `paymethod` varchar(10) DEFAULT NULL,
  `invoicenum` varchar(20) DEFAULT NULL,
  `ponumber` varchar(100) DEFAULT NULL,
  `transactionID` varchar(255) DEFAULT NULL,
  `bill_fname` varchar(45) DEFAULT NULL,
  `bill_lname` varchar(45) DEFAULT NULL,
  `bill_address` varchar(45) DEFAULT NULL,
  `bill_city` varchar(45) DEFAULT NULL,
  `bill_state` int(4) DEFAULT NULL,
  `bill_province` varchar(45) DEFAULT NULL,
  `bill_zip` varchar(10) DEFAULT NULL,
  `bill_country` int(4) DEFAULT NULL,
  `receiptsent` tinyint(1) DEFAULT NULL,
  `adminnotes` text,
  `usernotes` text,
  `exhibitor_invoiceID` int(11) DEFAULT NULL,
  `premieresponsor` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trackresendreceiptemail`
--

DROP TABLE IF EXISTS `trackresendreceiptemail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trackresendreceiptemail` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` datetime DEFAULT NULL,
  `attendeeID` int(11) DEFAULT NULL,
  `sendresult` int(11) DEFAULT NULL,
  `sendresultreason` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=62407 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trackroutingcode_codes`
--

DROP TABLE IF EXISTS `trackroutingcode_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trackroutingcode_codes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` datetime DEFAULT NULL,
  `CreateBy` int(11) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  `ModifyBy` int(11) DEFAULT NULL,
  `event` int(11) DEFAULT NULL,
  `codeset` text,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trackroutingcode_usage`
--

DROP TABLE IF EXISTS `trackroutingcode_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trackroutingcode_usage` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` datetime DEFAULT NULL,
  `attendeeID` int(11) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CreateDate` datetime DEFAULT NULL,
  `CreateBy` int(11) DEFAULT NULL,
  `processor` varchar(30) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `transtype` varchar(45) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT 'PAYMENT',
  `proctype` varchar(20) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `eventID` int(11) DEFAULT NULL,
  `attendeeID` int(11) DEFAULT NULL,
  `forAttendeeID` varchar(500) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `reggroupkey` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `boothappID` int(11) DEFAULT NULL,
  `sponsorship_purchaseID` int(11) DEFAULT NULL,
  `exhibitorinvoiceID` int(11) DEFAULT NULL,
  `chargeDate` datetime DEFAULT NULL,
  `chargeAmt` decimal(10,2) DEFAULT NULL,
  `ccnumber` varchar(50) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `exp_date` varchar(6) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `transID` varchar(30) CHARACTER SET latin1 COLLATE latin1_general_ci DEFAULT NULL,
  `adminnote` text CHARACTER SET latin1 COLLATE latin1_general_ci,
  `bill_address` varchar(60) DEFAULT NULL,
  `bill_city` varchar(40) DEFAULT NULL,
  `bill_state` varchar(2) DEFAULT NULL,
  `bill_province` varchar(40) DEFAULT NULL,
  `bill_zip` varchar(20) DEFAULT NULL,
  `bill_country` varchar(60) DEFAULT NULL,
  `ponum` varchar(50) DEFAULT NULL,
  `bill_fname` varchar(50) DEFAULT NULL,
  `bill_lname` varchar(50) DEFAULT NULL,
  `bill_email` varchar(100) DEFAULT NULL,
  `bill_phone` varchar(30) DEFAULT NULL,
  `emailreceipt` tinyint(1) DEFAULT NULL,
  `emailreceiptdate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_transaction_reggroupkey` (`reggroupkey`),
  KEY `idx_transaction_CreateDate` (`CreateDate`)
) ENGINE=MyISAM AUTO_INCREMENT=20021 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-29  7:07:16

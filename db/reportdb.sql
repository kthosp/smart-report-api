/*
 Navicat Premium Data Transfer

 Source Server         : mariadb-3310
 Source Server Type    : MySQL
 Source Server Version : 100315
 Source Host           : localhost:3310
 Source Schema         : reportdb

 Target Server Type    : MySQL
 Target Server Version : 100315
 File Encoding         : 65001

 Date: 22/08/2019 13:43:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hosp_system
-- ----------------------------
DROP TABLE IF EXISTS `hosp_system`;
CREATE TABLE `hosp_system` (
  `hoscode` varchar(50) NOT NULL,
  `hosname` varchar(200) DEFAULT NULL,
  `topic` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`hoscode`) USING BTREE,
  UNIQUE KEY `idx_hoscode` (`hoscode`) USING BTREE,
  UNIQUE KEY `idx_topic` (`topic`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hosp_system
-- ----------------------------
BEGIN;
INSERT INTO `hosp_system` VALUES ('10957', 'โรงพยาบาลตาลสุม', '4555654443');
COMMIT;

-- ----------------------------
-- Table structure for rep_levels
-- ----------------------------
DROP TABLE IF EXISTS `rep_levels`;
CREATE TABLE `rep_levels` (
  `level_id` int(11) NOT NULL AUTO_INCREMENT,
  `level_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`level_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of rep_levels
-- ----------------------------
BEGIN;
INSERT INTO `rep_levels` VALUES (1, 'Users', 'เจ้าหน้าที่โรงพยาบาล');
INSERT INTO `rep_levels` VALUES (2, 'Super User', 'องค์กรแพทย์ พยาบาล');
INSERT INTO `rep_levels` VALUES (3, 'Supervisor', 'นักวิชาการคอมพิวเตอร์');
INSERT INTO `rep_levels` VALUES (4, 'Administrator', 'ผู้ดูแลระบบ');
INSERT INTO `rep_levels` VALUES (5, 'TB', 'ผูู้ดูแลโรคติดต่อ');
COMMIT;

-- ----------------------------
-- Table structure for rep_menu_item
-- ----------------------------
DROP TABLE IF EXISTS `rep_menu_item`;
CREATE TABLE `rep_menu_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_name` varchar(255) NOT NULL,
  `comment` text DEFAULT NULL,
  `item_status` enum('Y','N') DEFAULT 'Y',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rep_menu_item
-- ----------------------------
BEGIN;
INSERT INTO `rep_menu_item` VALUES (1, 'ผู้ป่วยนอก', 'MDR', 'Y');
INSERT INTO `rep_menu_item` VALUES (2, 'การเงิน', 'การเงิน', 'Y');
INSERT INTO `rep_menu_item` VALUES (7, 'refer', 'refer', 'Y');
INSERT INTO `rep_menu_item` VALUES (8, 'อุบัติเหตุ', NULL, 'Y');
INSERT INTO `rep_menu_item` VALUES (9, 'เสียชีวิต', NULL, 'Y');
INSERT INTO `rep_menu_item` VALUES (10, 'ห้องผ่าตัด', 'or', 'Y');
INSERT INTO `rep_menu_item` VALUES (11, 'ผู้ป่วยใน', 'ipd', 'Y');
INSERT INTO `rep_menu_item` VALUES (12, 'pcu', 'สรุป Hba1c  ราย PCU', 'Y');
INSERT INTO `rep_menu_item` VALUES (13, 'โรคติดต่อ', 'วัณโรค', 'Y');
INSERT INTO `rep_menu_item` VALUES (14, 'ห้องบัตร', 'card', 'Y');
INSERT INTO `rep_menu_item` VALUES (15, 'โรคไม่ติดต่อ', 'โรคจิต', 'Y');
INSERT INTO `rep_menu_item` VALUES (17, 'สูตินารีเวช', 'test', 'Y');
INSERT INTO `rep_menu_item` VALUES (18, 'ศัลยกรรม', 'test', 'Y');
INSERT INTO `rep_menu_item` VALUES (19, 'อายุรกรรม ', 'test', 'Y');
INSERT INTO `rep_menu_item` VALUES (20, 'เด็ก', 'test', 'Y');
INSERT INTO `rep_menu_item` VALUES (21, 'สุขภิบาลและป้องกันโรค', 'สุขภิบาลและป้องกันโรค', 'Y');
COMMIT;

-- ----------------------------
-- Table structure for rep_query_item
-- ----------------------------
DROP TABLE IF EXISTS `rep_query_item`;
CREATE TABLE `rep_query_item` (
  `query_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `query_name` varchar(255) DEFAULT NULL,
  `query_sql` text DEFAULT NULL,
  `query_params` varchar(255) DEFAULT NULL,
  `template` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `level_id` enum('0','1','2','3','4') NOT NULL DEFAULT '0',
  `date_update` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`query_id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rep_query_item
-- ----------------------------
BEGIN;
INSERT INTO `rep_query_item` VALUES (1, 12, 'รายงานวัคซีน', 'SELECT\npt.hn,\npt.fname,pt.brthdate,\npt.lname,oapp.fudate,pop_id,\npt.brthdate,\npt.addrpart,\nmooban.namemoob,\ntumbon.nametumb,\nampur.nameampur,\nchangwat.namechw,ovst.pttype,epi.vac,hpt.namehpt,year(NOW())-YEAR(date(pt.brthdate)) AS age\nFROM ovst inner join epi on ovst.vn=epi.vn inner join pt on ovst.hn=pt.hn left join hpt on epi.vac=hpt.codehpt left join oapp on ovst.vn=oapp.vn\n\nLEFT JOIN mooban ON pt.chwpart = mooban.chwpart AND pt.amppart = mooban.amppart AND pt.tmbpart = mooban.tmbpart AND pt.moopart = mooban.moopart\nLEFT  JOIN ampur ON pt.chwpart = ampur.chwpart AND pt.amppart = ampur.amppart\nLEFT  JOIN tumbon ON pt.chwpart = tumbon.chwpart AND pt.amppart = tumbon.amppart AND pt.tmbpart = tumbon.tmbpart\nLEFT  JOIN changwat ON pt.chwpart = changwat.chwpart\nwhere  (ovst.vstdttm between ? and ?)', 'datestart,dateend', 'hi', NULL, '1', '2019-01-10 08:37:44');
INSERT INTO `rep_query_item` VALUES (2, 11, 'จำนวนวันนอนผู้ป่วยในตามวันที่', 'set @datestr = ?;\nset @datestp = ?;\nSELECT \nsum(timestampdiff(day,ipt.rgtdate,ipt.dchdate))  as \'จำนวนวันนอนผู้ป่วยใน\'\nFROM ipt where   (date(ipt.dchdate) between @datestr and @datestp)', 'datestart,dateend', 'hi', NULL, '1', NULL);
INSERT INTO `rep_query_item` VALUES (3, 11, 'รายงาน แพทย์ Admit', 'SELECT\r\n		A.dct,\r\n    A.fname,\r\n    A.lname,\r\n    MAX(IF(A.D=\'1\', จำนวน, 0 )) AS \'01\',\r\n    MAX(IF(A.D=\'2\', จำนวน, 0 )) AS \'02\',\r\n		MAX(IF(A.D=\'3\', จำนวน, 0 )) AS \'03\',\r\n		MAX(IF(A.D=\'4\', จำนวน, 0 )) AS \'04\',\r\n		MAX(IF(A.D=\'5\', จำนวน, 0 )) AS \'05\',\r\n		MAX(IF(A.D=\'6\', จำนวน, 0 )) AS \'06\',\r\n		MAX(IF(A.D=\'7\', จำนวน, 0 )) AS \'07\',\r\n		MAX(IF(A.D=\'8\', จำนวน, 0 )) AS \'08\',\r\n		MAX(IF(A.D=\'9\', จำนวน, 0 )) AS \'09\',\r\n		MAX(IF(A.D=\'10\', จำนวน, 0 )) AS \'10\',\r\n		MAX(IF(A.D=\'11\', จำนวน, 0 )) AS \'11\',\r\n		MAX(IF(A.D=\'12\', จำนวน, 0 )) AS \'12\',\r\n		MAX(IF(A.D=\'13\', จำนวน, 0 )) AS \'13\',\r\n		MAX(IF(A.D=\'14\', จำนวน, 0 )) AS \'14\',\r\n		MAX(IF(A.D=\'15\', จำนวน, 0 )) AS \'15\',\r\n		MAX(IF(A.D=\'16\', จำนวน, 0 )) AS \'16\',\r\n		MAX(IF(A.D=\'17\', จำนวน, 0 )) AS \'17\',\r\n		MAX(IF(A.D=\'18\', จำนวน, 0 )) AS \'18\',\r\n		MAX(IF(A.D=\'19\', จำนวน, 0 )) AS \'19\',\r\n		MAX(IF(A.D=\'20\', จำนวน, 0 )) AS \'20\',\r\n		MAX(IF(A.D=\'21\', จำนวน, 0 )) AS \'21\',\r\n		MAX(IF(A.D=\'22\', จำนวน, 0 )) AS \'22\',\r\n		MAX(IF(A.D=\'23\', จำนวน, 0 )) AS \'23\',\r\n    MAX(IF(A.D=\'24\', จำนวน, 0 )) AS \'24\',\r\n    MAX(IF(A.D=\'25\', จำนวน, 0 )) AS \'25\',\r\n		MAX(IF(A.D=\'26\', จำนวน, 0 )) AS \'26\',\r\n		MAX(IF(A.D=\'27\', จำนวน, 0 )) AS \'27\',\r\n		MAX(IF(A.D=\'28\', จำนวน, 0 )) AS \'28\',\r\n		MAX(IF(A.D=\'29\', จำนวน, 0 )) AS \'29\',\r\n		MAX(IF(A.D=\'30\', จำนวน, 0 )) AS \'30\',\r\n		MAX(IF(A.D=\'31\', จำนวน, 0 )) AS \'31\'\r\nFROM (\r\n	SELECT \r\n		dct.dct,\r\n		dct.fname,\r\n		dct.lname,\r\n		COUNT(ovst.vn) AS \'จำนวน\',\r\n		DATE(ovst.vstdttm) AS DD, \r\n		DAY(ovst.vstdttm) AS D\r\n	FROM ovst\r\n	INNER JOIN dct ON  (\r\n		CASE WHEN LENGTH(ovst.dct) = 5 THEN dct.lcno = ovst.dct \r\n			WHEN LENGTH(ovst.dct) = 4 THEN dct.dct = substr(ovst.dct,3,4)  \r\n			WHEN LENGTH(ovst.dct) = 2 THEN dct.dct = ovst.dct END )	\r\n	WHERE (ovst.vstdttm BETWEEN ? and ? ) and ovst.dct != \'\' and ovst.an  > \'0\'  \r\n	GROUP BY DATE(ovst.vstdttm), dct.lcno\r\n) A\r\nGROUP BY A.dct', 'datestart,dateend', NULL, NULL, '0', NULL);
INSERT INTO `rep_query_item` VALUES (4, 15, 'รายงานผู้ป่วย ความดัน ผู้ป่วย', 'SELECT\npt.hn,\npt.fname,pt.brthdate,\npt.lname,pop_id,\npt.brthdate,\npt.addrpart,\nmooban.namemoob,\ntumbon.nametumb,\nampur.nameampur,\nchangwat.namechw,year(NOW())-YEAR(date(pt.brthdate)) AS age,ovst.sbp,ovst.dbp\nFROM ovst inner join pt on ovst.hn=pt.hn inner join ovstdx on ovst.vn=ovstdx.vn\nLEFT JOIN mooban ON pt.chwpart = mooban.chwpart AND pt.amppart = mooban.amppart AND pt.tmbpart = mooban.tmbpart AND pt.moopart = mooban.moopart\nLEFT  JOIN ampur ON pt.chwpart = ampur.chwpart AND pt.amppart = ampur.amppart\nLEFT  JOIN tumbon ON pt.chwpart = tumbon.chwpart AND pt.amppart = tumbon.amppart AND pt.tmbpart = tumbon.tmbpart\nLEFT  JOIN changwat ON pt.chwpart = changwat.chwpart \nwhere  (ovst.vstdttm between ? and ?) and (ovst.sbp>? or ovst.dbp>?) and (ovstdx.icd10 between \'I10\' and \'I15\' or ovstdx.icd10 between \'E10\' and \'E14\')', 'datestart,dateend,bpst,bped', 'hi', 'hi', '0', '2019-08-21 02:04:41');
INSERT INTO `rep_query_item` VALUES (4, 15, 'ทดสอบ', 'set @datestr = \'20180101\';\nset @datestp = \'20180131\';\nset @bpst = 140;\nset @bped= 90;\nSELECT\npt.hn,\npt.fname,pt.brthdate,\npt.lname,pop_id,\npt.brthdate,\npt.addrpart,\nmooban.namemoob,\ntumbon.nametumb,\nampur.nameampur,\nchangwat.namechw,year(NOW())-YEAR(date(pt.brthdate)) AS age,ovst.sbp,ovst.dbp\nFROM ovst inner join pt on ovst.hn=pt.hn inner join ovstdx on ovst.vn=ovstdx.vn\nLEFT JOIN mooban ON pt.chwpart = mooban.chwpart AND pt.amppart = mooban.amppart AND pt.tmbpart = mooban.tmbpart AND pt.moopart = mooban.moopart\nLEFT  JOIN ampur ON pt.chwpart = ampur.chwpart AND pt.amppart = ampur.amppart\nLEFT  JOIN tumbon ON pt.chwpart = tumbon.chwpart AND pt.amppart = tumbon.amppart AND pt.tmbpart = tumbon.tmbpart\nLEFT  JOIN changwat ON pt.chwpart = changwat.chwpart \nwhere  (ovst.vstdttm between @datestr and @datestp) and (ovst.sbp>@bpst or ovst.dbp>@bped) and (ovstdx.icd10 between \'I10\' and \'I15\' or ovstdx.icd10 between \'E10\' and \'E14\')', NULL, 'hi', 'hi', '0', '2019-08-21 02:04:42');
INSERT INTO `rep_query_item` VALUES (5, 15, 'รายงาน CVDrisk', 'select ovst.vstdttm,pt.hn,pt.fname,pt.lname,pt.brthdate,pt.addrpart,mooban.namemoob,tumbon.nametumb,ampur.nameampur,changwat.namechw,pillness.pillness,ovstdx.icd10\nfrom ovst inner join  pillness on ovst.vn= pillness.vn inner join pt on ovst.hn=pt.hn inner join ovstdx on ovst.vn=ovstdx.vn\nLEFT JOIN mooban ON pt.chwpart = mooban.chwpart AND pt.amppart = mooban.amppart AND pt.tmbpart = mooban.tmbpart AND pt.moopart = mooban.moopart\nLEFT  JOIN ampur ON pt.chwpart = ampur.chwpart AND pt.amppart = ampur.amppart\nLEFT  JOIN tumbon ON pt.chwpart = tumbon.chwpart AND pt.amppart = tumbon.amppart AND pt.tmbpart = tumbon.tmbpart\nLEFT  JOIN changwat ON pt.chwpart = changwat.chwpart\nwhere (ovst.vstdttm between ? and ?) and   pillness.pillness like \'%CVD%\'  GROUP BY hn ', 'datestart,dateend', 'hi', 'hi', '0', '2019-08-21 02:04:47');
INSERT INTO `rep_query_item` VALUES (6, 15, 'รายงาน CKD', 'SELECT\npt.hn,ovst.vstdttm,\npt.fname,\npt.lname,\npt.brthdate,year(NOW())-YEAR(date(pt.brthdate)) AS age,\npt.addrpart,\nmooban.namemoob,\ntumbon.nametumb,\nampur.nameampur,\nchangwat.namechw,\npt.pop_id,\novstdx.icd10\nFROM pt\nLEFT JOIN mooban ON pt.chwpart = mooban.chwpart AND pt.amppart = mooban.amppart AND pt.tmbpart = mooban.tmbpart AND pt.moopart = mooban.moopart\nLEFT  JOIN ampur ON pt.chwpart = ampur.chwpart AND pt.amppart = ampur.amppart\nLEFT  JOIN tumbon ON pt.chwpart = tumbon.chwpart AND pt.amppart = tumbon.amppart AND pt.tmbpart = tumbon.tmbpart\nLEFT  JOIN changwat ON pt.chwpart = changwat.chwpart \ninner join ovst on pt.hn=ovst.hn inner join ovstdx on ovst.vn=ovstdx.vn where ovstdx.icd10 in(\'N181\',\'N182\',\'N183\',\'N184\',\'N185\',\'I519\',\'J449\') and   (ovst.vstdttm between ? and ?) ', 'datestart,dateend', 'hi', 'hi', '0', '2019-08-21 02:04:45');
INSERT INTO `rep_query_item` VALUES (7, 1, 'รายงานแจกแจงรายโรค', 'SELECT\npt.hn,\npt.fname,pt.brthdate,\npt.lname,pop_id,\npt.brthdate,\npt.addrpart,\nmooban.namemoob,\ntumbon.nametumb,\nampur.nameampur,\nchangwat.namechw,year(NOW())-YEAR(date(pt.brthdate)) AS age,ovstdx.icd10,ovst.sbp,ovst.dbp\nFROM ovst inner join pt on ovst.hn=pt.hn inner join ovstdx on ovst.vn=ovstdx.vn\nLEFT JOIN mooban ON pt.chwpart = mooban.chwpart AND pt.amppart = mooban.amppart AND pt.tmbpart = mooban.tmbpart AND pt.moopart = mooban.moopart\nLEFT  JOIN ampur ON pt.chwpart = ampur.chwpart AND pt.amppart = ampur.amppart\nLEFT  JOIN tumbon ON pt.chwpart = tumbon.chwpart AND pt.amppart = tumbon.amppart AND pt.tmbpart = tumbon.tmbpart\nLEFT  JOIN changwat ON pt.chwpart = changwat.chwpart \nwhere  (ovst.vstdttm between ? and ?)  and (ovstdx.icd10 between ?and ?)', 'datestart,dateend,dx1,dx2', 'hi', 'hi', '1', '2019-02-15 03:59:01');
INSERT INTO `rep_query_item` VALUES (8, 1, 'จำนวนใบสั่งยา ในเวลาราชการ นอกเวลราชการ', 'select \'จำนวน\' as \'ใบสังยา\'  ,count(o.vn) as \'ทั้งหมด\',\ncount(case when (DAYOFWEEK( o.vstdttm ) between 2 and 6 and time(o.vstdttm) BETWEEN \'08:00:00\' and \'16:00:00\' and date(vstdttm) not in (select holiday.date from holiday)) then o.vn end) as \'เวลารชการ\'\n\n\n,count(case when (time(o.vstdttm) between \'17:59:00\'and \'23:59:00\' or (time(o.vstdttm) between \'00:00:00\' and \'07:59:00\')or(DAYOFWEEK(o.vstdttm) = 1 OR DAYOFWEEK(o.vstdttm) = 7) \nor  date(vstdttm) IN ( SELECT holiday.date FROM holiday )) then o.vn end) as \'นอกเวลาราชการ\'\n\nfrom ovst as o inner join prsc on o.vn=prsc.vn where (o.vstdttm between ? and ?) ', 'datestart,dateend', 'hi', 'hi', '0', '2019-08-21 02:04:48');
INSERT INTO `rep_query_item` VALUES (9, 1, 'รายางใบสั่งยาตามเวร', 'select \'จำนวน\' as \'ใบสังยา\'  ,count(o.vn) as \'ทั้งหมด\',\ncount(case when time(o.vstdttm) between \'00:00:00\' and \'08:00:00\' then o.vn end) as \'เวรดึก\'\n\n,count(case when time(o.vstdttm) between \'08:00:01\' and \'16:00:00\' then o.vn end) as \'เวรเช้า\'\n\n,count(case when time(o.vstdttm) between \'16:00:01\' and \'23:59:59\' then o.vn end) as \'เวรดึก\'\nfrom ovst as o inner join prsc on o.vn=prsc.vn  where (o.vstdttm between ? and ?) ', 'datestart,dateend', 'hi', 'hi', '0', '2019-08-21 02:04:53');
COMMIT;

-- ----------------------------
-- Table structure for rep_users
-- ----------------------------
DROP TABLE IF EXISTS `rep_users`;
CREATE TABLE `rep_users` (
  `user_id` int(4) NOT NULL AUTO_INCREMENT,
  `cid` varchar(13) NOT NULL,
  `fullname` varchar(200) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `device_token` varchar(255) DEFAULT NULL,
  `level_id` enum('0','1','2','3','4') NOT NULL DEFAULT '0',
  `user_type` enum('ADMIN','MEMBER') NOT NULL DEFAULT 'MEMBER',
  `is_accept` enum('Y','N') NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rep_users
-- ----------------------------
BEGIN;
INSERT INTO `rep_users` VALUES (1, '3341200274298', 'Administartor', 'admin', '383bdcdb33047bf9a8a2bd11f0055d36', NULL, '3', 'ADMIN', 'Y');
COMMIT;

-- ----------------------------
-- Table structure for rep_user_type
-- ----------------------------
DROP TABLE IF EXISTS `rep_user_type`;
CREATE TABLE `rep_user_type` (
  `type_id` int(5) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(100) NOT NULL,
  `type_status` enum('Y','N') DEFAULT 'Y',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rep_user_type
-- ----------------------------
BEGIN;
INSERT INTO `rep_user_type` VALUES (1, 'General Personnel', 'Y');
INSERT INTO `rep_user_type` VALUES (2, 'User Management', 'Y');
INSERT INTO `rep_user_type` VALUES (3, 'Supervisor', 'Y');
INSERT INTO `rep_user_type` VALUES (4, 'Administrator', 'Y');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

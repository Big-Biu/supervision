/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50624
Source Host           : localhost:3306
Source Database       : supervision

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2019-05-10 15:31:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `text` varchar(128) NOT NULL,
  `_s` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK_DICTIONARY_TYPE_idx` (`type`),
  CONSTRAINT `FK_DICTIONARY_TYPE` FOREIGN KEY (`type`) REFERENCES `dictionary_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES ('1', '1', '通知', '1');
INSERT INTO `dictionary` VALUES ('2', '1', '公告', '1');
INSERT INTO `dictionary` VALUES ('3', '2', '发布', '1');
INSERT INTO `dictionary` VALUES ('4', '2', '失效', '1');
INSERT INTO `dictionary` VALUES ('5', '2', '过期', '1');
INSERT INTO `dictionary` VALUES ('6', '3', '企业', '1');
INSERT INTO `dictionary` VALUES ('7', '3', '学校', '1');
INSERT INTO `dictionary` VALUES ('8', '4', '行政', '1');
INSERT INTO `dictionary` VALUES ('9', '4', '技术', '1');
INSERT INTO `dictionary` VALUES ('10', '4', '教师', '1');
INSERT INTO `dictionary` VALUES ('11', '5', '正常', '1');
INSERT INTO `dictionary` VALUES ('12', '5', '注销', '1');

-- ----------------------------
-- Table structure for dictionary_type
-- ----------------------------
DROP TABLE IF EXISTS `dictionary_type`;
CREATE TABLE `dictionary_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `_s` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dictionary_type
-- ----------------------------
INSERT INTO `dictionary_type` VALUES ('1', '通知公告', '1');
INSERT INTO `dictionary_type` VALUES ('2', '通知状态', '1');
INSERT INTO `dictionary_type` VALUES ('3', '企业类型', '1');
INSERT INTO `dictionary_type` VALUES ('4', '人员类型', '1');
INSERT INTO `dictionary_type` VALUES ('5', '企业状态', '1');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `type` int(11) DEFAULT NULL,
  `id_papers` varchar(32) DEFAULT NULL,
  `car_papers` varchar(32) DEFAULT NULL,
  `qualification_papers` varchar(32) DEFAULT NULL,
  `enterprise` int(11) NOT NULL,
  `_s` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`,`enterprise`),
  KEY `FK_EMPLOYEE_ENTERPRISE_idx` (`enterprise`),
  KEY `FK_EMPLOYEE_TYPE_idx` (`type`),
  CONSTRAINT `FK_EMPLOYEE_ENTERPRISE` FOREIGN KEY (`enterprise`) REFERENCES `enterprise` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_EMPLOYEE_TYPE` FOREIGN KEY (`type`) REFERENCES `dictionary` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('1', '张三', '9', '1111111111111', '1111111111111', '1111', '1', '1');

-- ----------------------------
-- Table structure for employee_certificate
-- ----------------------------
DROP TABLE IF EXISTS `employee_certificate`;
CREATE TABLE `employee_certificate` (
  `id` int(10) unsigned zerofill NOT NULL,
  `train_employee` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_EMPLOYEE_CERFIFICATION_TRAIN_EMPLOYEE_idx` (`train_employee`),
  CONSTRAINT `FK_EMPLOYEE_CERFIFICATION_TRAIN_EMPLOYEE` FOREIGN KEY (`train_employee`) REFERENCES `train_employee` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee_certificate
-- ----------------------------

-- ----------------------------
-- Table structure for employee_credit
-- ----------------------------
DROP TABLE IF EXISTS `employee_credit`;
CREATE TABLE `employee_credit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee_credit
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise
-- ----------------------------
DROP TABLE IF EXISTS `enterprise`;
CREATE TABLE `enterprise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL,
  `name` varchar(128) NOT NULL,
  `label` varchar(32) NOT NULL,
  `organize` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `legal_representative` varchar(32) DEFAULT NULL,
  `contacts` varchar(32) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `fax` varchar(32) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `memo` longtext,
  `state` tinyint(4) DEFAULT '1' COMMENT '1, 当前，2，变更',
  `_s` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`,`time`),
  KEY `FK_ENTERPRISE_TYPE_idx` (`type`),
  CONSTRAINT `FK_ENTERPRISE_TYPE` FOREIGN KEY (`type`) REFERENCES `dictionary` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of enterprise
-- ----------------------------
INSERT INTO `enterprise` VALUES ('1', '2019-04-24 00:00:00', '中国电信', '中国电信', '1', '6', 'XXX', '10000', '10000', '10000', null, null, '11', '1');

-- ----------------------------
-- Table structure for enterprise_certificate
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_certificate`;
CREATE TABLE `enterprise_certificate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of enterprise_certificate
-- ----------------------------

-- ----------------------------
-- Table structure for enterprise_credit
-- ----------------------------
DROP TABLE IF EXISTS `enterprise_credit`;
CREATE TABLE `enterprise_credit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of enterprise_credit
-- ----------------------------

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `title` varchar(256) NOT NULL,
  `content` longtext,
  `time` datetime NOT NULL,
  `author` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT '3',
  `_s` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK_NOTICE_TYPE_idx` (`type`),
  KEY `FK_NOTICE_STATE_idx` (`state`),
  CONSTRAINT `FK_NOTICE_STATE` FOREIGN KEY (`state`) REFERENCES `dictionary` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_NOTICE_TYPE` FOREIGN KEY (`type`) REFERENCES `dictionary` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES ('1', '1', '系统上线通知', '欢迎使用“行业服务与监管平台”', '2019-04-01 00:00:00', '1', '3', '1');

-- ----------------------------
-- Table structure for notice_file
-- ----------------------------
DROP TABLE IF EXISTS `notice_file`;
CREATE TABLE `notice_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(128) DEFAULT NULL,
  `size` bigint(20) DEFAULT NULL,
  `file` longblob,
  `notice` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notice_file
-- ----------------------------

-- ----------------------------
-- Table structure for organize
-- ----------------------------
DROP TABLE IF EXISTS `organize`;
CREATE TABLE `organize` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `region` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `contacts` varchar(32) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `fax` varchar(32) DEFAULT NULL,
  `address` varchar(256) DEFAULT NULL,
  `memo` longtext,
  `_s` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK_ORGANIZE_REGION_idx` (`region`),
  CONSTRAINT `FK_ORGANIZE_REGION` FOREIGN KEY (`region`) REFERENCES `region` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organize
-- ----------------------------
INSERT INTO `organize` VALUES ('1', '1', '工信部', '工信部1', '12381', '12381', '中国北京西长安街13号', '中华人民共和国工业和信息化部', '1');

-- ----------------------------
-- Table structure for region
-- ----------------------------
DROP TABLE IF EXISTS `region`;
CREATE TABLE `region` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(128) NOT NULL,
  `code` varchar(32) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `pinyin` varchar(128) DEFAULT NULL,
  `_s` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of region
-- ----------------------------
INSERT INTO `region` VALUES ('1', 'cn', 'cn', '中华人民共和国', 'ghrmghg', '1');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `_s` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '系统管理员', '1');
INSERT INTO `role` VALUES ('2', '行政人员', '1');
INSERT INTO `role` VALUES ('3', '普通用户', '1');

-- ----------------------------
-- Table structure for train
-- ----------------------------
DROP TABLE IF EXISTS `train`;
CREATE TABLE `train` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of train
-- ----------------------------

-- ----------------------------
-- Table structure for train_employee
-- ----------------------------
DROP TABLE IF EXISTS `train_employee`;
CREATE TABLE `train_employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of train_employee
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organize` int(11) NOT NULL,
  `role` int(11) NOT NULL,
  `username` varchar(32) NOT NULL,
  `password` varchar(64) NOT NULL,
  `name` varchar(32) NOT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `email` varchar(64) DEFAULT NULL,
  `qq` varchar(16) DEFAULT NULL,
  `sex` varchar(8) DEFAULT NULL,
  `_s` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK_USER_ORGANIZE_idx` (`organize`),
  KEY `FK_USER_ROLE_idx` (`role`),
  CONSTRAINT `FK_USER_ORGANIZE` FOREIGN KEY (`organize`) REFERENCES `organize` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_USER_ROLE` FOREIGN KEY (`role`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '1', '1', 'admin', 'admin', '工信部管理员', '87654321', 'gxb1@supervision.com', '87654321', '男', '1');
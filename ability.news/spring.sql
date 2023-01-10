/*
 Navicat Premium Data Transfer

 Source Server         : Xingyu Zhou
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : ability

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 09/08/2021 20:39:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `author_number` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `img_lists` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `if_public` int NOT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `source_id` int NOT NULL,
  `read_count` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `like` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (1, 'https://pic1.zhimg.com/80/v2-86bbd91afd5c16ffa3181140258a50ad_720w.jpg?source=1940ef5c', '1', '测试1', '测试内容', NULL, 1, '2021-07-25 18:07:13', NULL, 2, NULL, NULL, 1);
INSERT INTO `article` VALUES (2, 'https://pic1.zhimg.com/v2-9ac8f17b37fb38e47608af86faf58058_r.jpg?source=1940ef5c', '2', '测试2', '测试内容2', NULL, 1, NULL, NULL, 2, NULL, NULL, 1);
INSERT INTO `article` VALUES (3, 'https://pic3.zhimg.com/80/v2-372936fbc10186e739e3babedeb10543_720w.jpg?source=1940ef5c', '41', '测试3', '测试内容3', NULL, 1, NULL, NULL, 2, NULL, NULL, 1);
INSERT INTO `article` VALUES (4, 'https://pic2.zhimg.com/80/v2-b6eae3250bb62fadb3d2527f466cf033_720w.jpg?source=1940ef5c', 'zhou970518', '测试1', 'fasfasfzxvjaskflajf', NULL, 1, '2021-08-08 17:15:17', NULL, 2, '0', '0', 1);
INSERT INTO `article` VALUES (5, 'https://pic2.zhimg.com/80/v2-b6eae3250bb62fadb3d2527f466cf033_720w.jpg?source=1940ef5c', 'zhou970518', '测试4', '测试内容', NULL, 1, '2021-08-08 17:18:09', NULL, 2, '0', '0', 1);
INSERT INTO `article` VALUES (6, 'https://pic2.zhimg.com/80/v2-b6eae3250bb62fadb3d2527f466cf033_720w.jpg?source=1940ef5c', '节操粉碎机', '测试5', 'dasfdqwfasdadfasdfasf', NULL, 1, '2021-08-08 17:22:41', NULL, 2, '0', '0', 1);

-- ----------------------------
-- Table structure for skill
-- ----------------------------
DROP TABLE IF EXISTS `skill`;
CREATE TABLE `skill`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `skill_desc_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of skill
-- ----------------------------
INSERT INTO `skill` VALUES (1, 'Java', 'Java是一种面向对象的编程语言');

-- ----------------------------
-- Table structure for skill_level
-- ----------------------------
DROP TABLE IF EXISTS `skill_level`;
CREATE TABLE `skill_level`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `skill_id` int NOT NULL,
  `skill_level` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of skill_level
-- ----------------------------
INSERT INTO `skill_level` VALUES (1, 1, '50', 'zhou970518', '2021-07-26 15:06:44', '2021-07-26 15:06:47');

-- ----------------------------
-- Table structure for source
-- ----------------------------
DROP TABLE IF EXISTS `source`;
CREATE TABLE `source`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `source_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of source
-- ----------------------------
INSERT INTO `source` VALUES (1, '转载');
INSERT INTO `source` VALUES (2, '原创');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nickname` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` int NOT NULL,
  `create_time` datetime NOT NULL,
  `retain1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `retain2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `retain3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (3, 'zhou970518', '节操粉碎机', '11be203bb2aec79d165cf1e73cd13f9c', 'zhou970518@outlook.com', 'https://pic2.zhimg.com/80/v2-b6eae3250bb62fadb3d2527f466cf033_720w.jpg?source=1940ef5c', 0, '2021-07-24 19:54:40', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for user_else_info
-- ----------------------------
DROP TABLE IF EXISTS `user_else_info`;
CREATE TABLE `user_else_info`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `intro_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `git_addr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `look_count` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_else_info
-- ----------------------------
INSERT INTO `user_else_info` VALUES (1, 'zhou970518', '我是一个保安', 'https://github.com/zzxxyy518', '1');

SET FOREIGN_KEY_CHECKS = 1;

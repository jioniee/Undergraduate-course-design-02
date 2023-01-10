/*
 Navicat Premium Data Transfer

 Source Server         : Xingyu Zhou
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : abilitynews

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 10/08/2021 21:39:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint NULL DEFAULT NULL,
  `time` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (4, 'admin1', '25f9e794323b453885f5181f1b624d0b', 0, 1618131992);

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sort` tinyint NULL DEFAULT NULL,
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES (2, '123', 'www.123.com', 1, '/upload/banner/16193646268921971.jpg');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` int NULL DEFAULT NULL,
  `like` int NULL DEFAULT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` int NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` int NULL DEFAULT NULL,
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `summary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (5, 2, 'Disability Support Pension payment increase for people under 21', '/upload/news/16208333311307732.jpg', 1620801027, 'Tom', '<p><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">From 1 April 2021, some payments permanently increased by $50 per fortnight. You might have already noticed this in your most recent Disability Support Pension (DSP) payment.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">You’ll get the higher rate starting from 1 April. Your first payment after this date may have some pay at the old rate and some at the new rate.</span><br/><img src=\"/images/ueditor/1392502026872688640.jpg\" title=\"\" alt=\"FCC0[M03DI[@W~Z_W_)~BKH.jpg\"/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">There’s no need to contact us to get the new rate. You’ll get it automatically, and this will be your usual rate from now on.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">When you’re under 21, the amount of&nbsp;</span><a href=\"https://www.servicesaustralia.gov.au/individuals/services/centrelink/disability-support-pension\" style=\"box-sizing: border-box; background-color: rgb(255, 255, 255); color: rgb(51, 122, 183); text-decoration-line: none; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal;\">DSP</a><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">&nbsp;you get usually depends on whether we assess you as&nbsp;</span><a href=\"https://www.servicesaustralia.gov.au/individuals/services/centrelink/disability-support-pension/how-much-you-can-get/dependent-or-independent\" style=\"box-sizing: border-box; background-color: rgb(255, 255, 255); color: rgb(51, 122, 183); text-decoration-line: none; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal;\">dependent or independent</a><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">.</span></p>', 'If you’re under 21 with no dependent children, we’ve increased your payment.');
INSERT INTO `news` VALUES (6, 1, 'Disability Support Pension payment increase for people under 21', '/upload/news/16208997075085761.jpg', 1620885307, 'Tom', '<p><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">From 1 April 2021, some payments permanently increased by $50 per fortnight. You might have already noticed this in your most recent Disability Support Pension (DSP) payment.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">You’ll get the higher rate starting from 1 April. Your first payment after this date may have some pay at the old rate and some at the new rate.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">There’s no need to contact us to get the new rate. You’ll get it automatically, and this will be your usual rate from now on.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">When you’re under 21, the amount of&nbsp;</span><a href=\"https://www.servicesaustralia.gov.au/individuals/services/centrelink/disability-support-pension\" style=\"box-sizing: border-box; background-color: rgb(255, 255, 255); color: rgb(51, 122, 183); text-decoration-line: none; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal;\">DSP</a><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">&nbsp;you get usually depends on whether we assess you as&nbsp;</span><a href=\"https://www.servicesaustralia.gov.au/individuals/services/centrelink/disability-support-pension/how-much-you-can-get/dependent-or-independent\" style=\"box-sizing: border-box; background-color: rgb(255, 255, 255); color: rgb(51, 122, 183); text-decoration-line: none; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal;\">dependent or independent</a><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">.</span></p>', 'If you\'re under 21 with no dependent children, we\'ve increased your payment.');
INSERT INTO `news` VALUES (7, 3, 'Worksheet2-G37', '/upload/news/16208853879169284.jpg', 1620885388, 'Tom', '<p>SAFASFASFQWRFQWFQ</p>', 'Reading personalization');
INSERT INTO `news` VALUES (8, 4, 'WANTED: 21 Military Volunteers for Rugby League World Cup’s Wheelchair Tournament', '/upload/news/16209444447673374.jpg', 1620885411, 'Tom', '<p><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">THE SEARCH is on to enlist 21 military volunteers to play key roles on the opening day of next year’s Rugby League World Cup wheelchair tournament, taking place on Armistice Day at the Copper Box Arena, London.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">The armed-forces volunteers – to be known as “James’ Squad” – will have special roles to play at the opening fixtures when hosts England take on Australia, and Spain play Norway.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">James Simpson, who plays for England and Leeds Rhinos wheelchair teams, is helping to recruit the volunteers. A lifelong Rugby League fan, James joined the Yorkshire Regiment 1st Battalion in 2001 and undertook several overseas missions from Central America to Iraq during his ten-year stint in the military.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">In 2009, while in deployment in Afghanistan, James tripped an IED whilst on a routine patrol, causing life-changing injuries which saw him lose both of his legs, three fingers and the muscle from his right forearm.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">Following a lengthy recovery process, James discovered the sport of Wheelchair Rugby League while watching his beloved Leeds Rhinos at Headingley in 2013.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">After a couple of training sessions with the Leeds Rhinos Wheelchair team, he was hooked and has played ever since, going on to represent England at the World Cup in France in 2017 – and he is hoping to represent England next year.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">James said: “A total of 21 nations will be competing in the Rugby World Cup in 2021 and having 21 members of the military in the arena alongside me will be an emotional and proud moment. I look forward to reading the entries and creating James’ Squad.”</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">The wheelchair tournament will be contested by eight teams over 15 days with the showpiece final taking place at the M&amp;S Bank Arena, Liverpool on Friday 26 November.</span><br/><br/></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; margin-left: 4rem; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255); text-indent: -1rem;\"><span style=\"box-sizing: border-box;\">• Wheelchair Rugby League is an inclusive sport – not solely a disability sport, as able-bodied people can compete as well and both men and women can play in the same team.</span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; margin-left: 4rem; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255); text-indent: -1rem;\"><span style=\"box-sizing: border-box;\">• Personnel within the Armed Forces have the opportunity to apply for the volunteer roles until 30 November via:<a href=\"https://www.rlwc2021.com/volunteers/military-volunteer-sign-up\" style=\"box-sizing: border-box; background-color: transparent; color: rgb(51, 122, 183); text-decoration-line: none;\">RLWC2021.com/JamesSquad</a>.</span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; margin-left: 4rem; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255); text-indent: -1rem;\"><span style=\"box-sizing: border-box;\">• To apply for tickets visit&nbsp;<a href=\"https://www.rlwc2021.com/tickets\" style=\"box-sizing: border-box; background-color: transparent; color: rgb(51, 122, 183); text-decoration-line: none;\">rlwc2021.com/tickets</a>.<br/></span></p><p><br/><span style=\"font-size:24px\"><span style=\"box-sizing: border-box; font-weight: 700;\">ABOUT RUGBY LEAGUE WORLD CUP 2021</span></span><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\"></span><br/></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; margin-left: 4rem; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255); text-indent: -1rem;\"><span style=\"box-sizing: border-box;\">• The Rugby League World Cup is the pinnacle major event of rugby league, globally contested every four years. RLWC2021 will be a breakthrough moment in the tournament’s history with the men’s, women’s and wheelchair competitions being staged together for the first time.</span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; margin-left: 4rem; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255); text-indent: -1rem;\"><span style=\"box-sizing: border-box;\">• The three tournaments will take place across 21 venues throughout England. Both the women’s and wheelchair competitions will be contested by two groups of four teams, whilst the men’s tournament will see 16 teams compete across four groups.<br/></span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; margin-left: 4rem; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255); text-indent: -1rem;\"><span style=\"box-sizing: border-box;\">• All 61 games in the men’s, women’s and wheelchair competitions will be broadcast live on the BBC.</span></p><p><br/></p>', 'Welcome to the party!');
INSERT INTO `news` VALUES (9, 5, 'WANTED: 21 Military Volunteers for Rugby League World Cup’s Wheelchair Tournament', '/upload/news/16208994412371123.jpg', 1620885463, 'Xingyu Zhou', '<p>sfasafqwwwwwwwwwwwwwwqafaswfaafafsa</p>', 'Reading personalization');
INSERT INTO `news` VALUES (10, 4, 'Disability Support Pension payment increase for people under 21', '/upload/news/16285145370913834.jpg', 1628514537, 'Tom', '<p>wfsafasfffffffffffffffffff</p>', 'If you’re under 21 with no dependent children, we’ve increased your payment.');

-- ----------------------------
-- Table structure for registereduser
-- ----------------------------
DROP TABLE IF EXISTS `registereduser`;
CREATE TABLE `registereduser`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint NULL DEFAULT NULL,
  `time` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of registereduser
-- ----------------------------
INSERT INTO `registereduser` VALUES (1, 'user', '25f9e794323b453885f5181f1b624d0b', 0, 1618131992);

-- ----------------------------
-- Table structure for topadmin
-- ----------------------------
DROP TABLE IF EXISTS `topadmin`;
CREATE TABLE `topadmin`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of topadmin
-- ----------------------------
INSERT INTO `topadmin` VALUES (1, 'admin', '25f9e794323b453885f5181f1b624d0b');

-- ----------------------------
-- Table structure for topic
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sort` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `keywords` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of topic
-- ----------------------------
INSERT INTO `topic` VALUES (1, 'SUPPORTS', '5', 'SUPPORTS', 'news about the entertainment');
INSERT INTO `topic` VALUES (2, 'PEOPLE', '2', 'PEOPLE', 'The most hot news in recent days');
INSERT INTO `topic` VALUES (3, 'IDEAS', '4', 'IDEAS', 'IDEAS');
INSERT INTO `topic` VALUES (4, 'POLICY', '5', 'POLICY', 'POLICY');
INSERT INTO `topic` VALUES (5, 'SPEICAILIST PROVIDERS', '1', 'SPEICAILIST PROVIDERS', 'SPEICAILIST PROVIDERS');

SET FOREIGN_KEY_CHECKS = 1;

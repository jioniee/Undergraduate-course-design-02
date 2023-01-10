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

 Date: 11/10/2021 19:11:28
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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (4, 'admin', '25d55ad283aa400af464c76d713c07ad', 0, 1618131992);

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
  `news_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 'Adam', 1620885307, NULL, 'Good News!', 1);
INSERT INTO `comment` VALUES (2, 'Tim', 1620885388, NULL, 'Like it!', 1);
INSERT INTO `comment` VALUES (24, 'NoName', 1633924896, NULL, 'Amazing news!', 1);
INSERT INTO `comment` VALUES (25, 'NoName', 1633924984, NULL, 'Test comment!', 1);
INSERT INTO `comment` VALUES (26, 'NoName', 1633931965, NULL, 'Test news commment!', 1);
INSERT INTO `comment` VALUES (27, 'NoName', 1633932245, NULL, 'Test', 12);
INSERT INTO `comment` VALUES (28, 'NoName', 1633932348, NULL, 'Test2', 12);
INSERT INTO `comment` VALUES (29, 'NoName', 1633934055, NULL, 'Testll', 1);
INSERT INTO `comment` VALUES (30, 'NoName', 1633934060, NULL, 'Testll', 1);

-- ----------------------------
-- Table structure for editor
-- ----------------------------
DROP TABLE IF EXISTS `editor`;
CREATE TABLE `editor`  (
  `editor_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  PRIMARY KEY (`editor_id`) USING BTREE,
  INDEX `editor_id`(`user_id`) USING BTREE,
  CONSTRAINT `editor_id` FOREIGN KEY (`user_id`) REFERENCES `registered_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of editor
-- ----------------------------
INSERT INTO `editor` VALUES (1, 11);
INSERT INTO `editor` VALUES (2, 20);
INSERT INTO `editor` VALUES (3, 21);
INSERT INTO `editor` VALUES (4, 22);

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
  `likeNumber` int NULL DEFAULT NULL,
  `recommended` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (1, 1, 'Disability Support Pension payment increase for people under 21', '/upload/news/16208997075085761.jpg', 1620885307, 'Tom', '<p><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">From 1 April 2021, some payments permanently increased by $50 per fortnight. You might have already noticed this in your most recent Disability Support Pension (DSP) payment.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">You’ll get the higher rate starting from 1 April. Your first payment after this date may have some pay at the old rate and some at the new rate.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">There’s no need to contact us to get the new rate. You’ll get it automatically, and this will be your usual rate from now on.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">When you’re under 21, the amount of&nbsp;</span><a href=\"https://www.servicesaustralia.gov.au/individuals/services/centrelink/disability-support-pension\" style=\"box-sizing: border-box; background-color: rgb(255, 255, 255); color: rgb(51, 122, 183); text-decoration-line: none; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal;\">DSP</a><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">&nbsp;you get usually depends on whether we assess you as&nbsp;</span><a href=\"https://www.servicesaustralia.gov.au/individuals/services/centrelink/disability-support-pension/how-much-you-can-get/dependent-or-independent\" style=\"box-sizing: border-box; background-color: rgb(255, 255, 255); color: rgb(51, 122, 183); text-decoration-line: none; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal;\">dependent or independent</a><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">.</span></p>', 'If you\'re under 21 with no dependent children, we\'ve increased your payment.', 28, 1);
INSERT INTO `news` VALUES (2, 1, 'ACT COVID-19 update: NDS launches ACT COVID disability workforce register', '/upload/news/16209444447676374.png', 1620885388, 'nds.org.au', '<p>To help maintain staff levels during COVID, NDS has launched a service that links organisations that have excess workforce with organisations that are facing workforce shortages. This service has been funded by the ACT Office for Disability.\n\nNDS’s matching service assists community organisations that might otherwise have to stand staff down with disability support providers that are experiencing staff shortages.\n\nAny organisation that has excess staff with disability support experience or transferrable skills, and providers facing staff shortages, are encouraged to contact NDS via this submit enquiry/feedback form. Please include your name, organisation, contact details and a brief description.\n\nNDS’s COVID-19 Administration Officer Chris Myjak, will then contact each organisation to facilitate the sharing of staff.\n\nNDS’s HR/IR partner, WorkplacePLUS has drafted a proforma Service Agreement [Word] which may assist organisations in formalising their sharing of staff.\n\n</p>', 'Reading personalization', 0, 0);
INSERT INTO `news` VALUES (3, 1, 'WANTED: 21 Military Volunteers for Rugby League World Cup’s Wheelchair Tournament', '/upload/news/16209444447673374.jpg', 1620885411, 'rlwc2021', '<p><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">THE SEARCH is on to enlist 21 military volunteers to play key roles on the opening day of next year’s Rugby League World Cup wheelchair tournament, taking place on Armistice Day at the Copper Box Arena, London.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">The armed-forces volunteers – to be known as “James’ Squad” – will have special roles to play at the opening fixtures when hosts England take on Australia, and Spain play Norway.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">James Simpson, who plays for England and Leeds Rhinos wheelchair teams, is helping to recruit the volunteers. A lifelong Rugby League fan, James joined the Yorkshire Regiment 1st Battalion in 2001 and undertook several overseas missions from Central America to Iraq during his ten-year stint in the military.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">In 2009, while in deployment in Afghanistan, James tripped an IED whilst on a routine patrol, causing life-changing injuries which saw him lose both of his legs, three fingers and the muscle from his right forearm.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">Following a lengthy recovery process, James discovered the sport of Wheelchair Rugby League while watching his beloved Leeds Rhinos at Headingley in 2013.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">After a couple of training sessions with the Leeds Rhinos Wheelchair team, he was hooked and has played ever since, going on to represent England at the World Cup in France in 2017 – and he is hoping to represent England next year.</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">James said: “A total of 21 nations will be competing in the Rugby World Cup in 2021 and having 21 members of the military in the arena alongside me will be an emotional and proud moment. I look forward to reading the entries and creating James’ Squad.”</span><br/><br/><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\">The wheelchair tournament will be contested by eight teams over 15 days with the showpiece final taking place at the M&amp;S Bank Arena, Liverpool on Friday 26 November.</span><br/><br/></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; margin-left: 4rem; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255); text-indent: -1rem;\"><span style=\"box-sizing: border-box;\">• Wheelchair Rugby League is an inclusive sport – not solely a disability sport, as able-bodied people can compete as well and both men and women can play in the same team.</span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; margin-left: 4rem; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255); text-indent: -1rem;\"><span style=\"box-sizing: border-box;\">• Personnel within the Armed Forces have the opportunity to apply for the volunteer roles until 30 November via:<a href=\"https://www.rlwc2021.com/volunteers/military-volunteer-sign-up\" style=\"box-sizing: border-box; background-color: transparent; color: rgb(51, 122, 183); text-decoration-line: none;\">RLWC2021.com/JamesSquad</a>.</span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; margin-left: 4rem; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255); text-indent: -1rem;\"><span style=\"box-sizing: border-box;\">• To apply for tickets visit&nbsp;<a href=\"https://www.rlwc2021.com/tickets\" style=\"box-sizing: border-box; background-color: transparent; color: rgb(51, 122, 183); text-decoration-line: none;\">rlwc2021.com/tickets</a>.<br/></span></p><p><br/><span style=\"font-size:24px\"><span style=\"box-sizing: border-box; font-weight: 700;\">ABOUT RUGBY LEAGUE WORLD CUP 2021</span></span><span style=\"font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; background-color: rgb(255, 255, 255);\"></span><br/></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; margin-left: 4rem; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255); text-indent: -1rem;\"><span style=\"box-sizing: border-box;\">• The Rugby League World Cup is the pinnacle major event of rugby league, globally contested every four years. RLWC2021 will be a breakthrough moment in the tournament’s history with the men’s, women’s and wheelchair competitions being staged together for the first time.</span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; margin-left: 4rem; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255); text-indent: -1rem;\"><span style=\"box-sizing: border-box;\">• The three tournaments will take place across 21 venues throughout England. Both the women’s and wheelchair competitions will be contested by two groups of four teams, whilst the men’s tournament will see 16 teams compete across four groups.<br/></span></p><p style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; margin-left: 4rem; font-family: TiemposText, Georgia, &quot;Times New Roman&quot;, Times, serif; font-size: 18px; white-space: normal; background-color: rgb(255, 255, 255); text-indent: -1rem;\"><span style=\"box-sizing: border-box;\">• All 61 games in the men’s, women’s and wheelchair competitions will be broadcast live on the BBC.</span></p><p><br/></p>', 'Welcome to the party!', 0, 0);
INSERT INTO `news` VALUES (4, 1, 'Tokyo Paralympics: Sarah Storey wins 15th Paralympic gold as GB claim six medals', '/upload/news/16208994412371125.png', 1620885463, 'Disability Sport', '<p>Sarah Storey put in another world record-breaking performance on her way to claiming her 15th Paralympic title, as Great Britain claimed six medals on the first day of Tokyo 2020.\n\nThe 43-year-old smashed her world best by more than four seconds in the C5 3,000m individual pursuit qualifying and in the final caught team-mate Crystal Lane-Wright, who matched her silver medal from Rio 2016.\n\nStorey is just one behind Mike Kenny\'s British record of 16 golds.\n\nThere was also silver for tandem pair Steve Bate and Adam Duggleby in the B 4,000m pursuit.\n\nBate and Duggleby were defending champions but the Dutch pair of Tristan Bangma and Patrick Bos, who set a world record in qualifying, caught the Britons in the final.\n\nAnd there were three swimming medals for ParalympicsGB, with silvers for Reece Dunn in the S14 100m butterfly and Tully Kearney in the S5 200m freestyle, as well as bronze for Toni Shaw in the S9 400m freestyle.</p>', 'Reading personalization', 3, 1);
INSERT INTO `news` VALUES (5, 1, 'Tokyo 2020: does the Paralympics empower disabled people?', '/upload/news/16285145370913834.png', 1628514537, 'Misha Ketchell', '<p>The Tokyo 2020 Paralympics are being used as a catalyst for a new <a href=\"https://www.wethe15.org/\">global campaign</a> aimed at removing discrimination faced by disabled people. Entitled We the 15, this new effort has been launched by the International Paralympic Committee (IPC) and the International Disability Alliance along with a host of other sports, human rights and business organisations. The goal is to create more opportunities – and <a href=\"https://theconversation.com/paralympics-havent-decreased-barriers-to-physical-activity-for-most-people-with-disabilities-165145\">greater accessibility</a> – for people with impairments.</p><h2>Representation matters</h2><p>Elite sport is by definition an exclusive domain, and the Paralympics are <a href=\"https://theconversation.com/the-paralympics-strive-for-inclusion-but-some-rules-unfairly-exclude-athletes-with-severe-disabilities-166347\">no exception</a>. The <a href=\"https://www.telegraph.co.uk/paralympic-sport/2021/08/22/tokyo-2020-paralympics-how-does-classification-system-work/\">classification system</a> used to determine athletes’ eligibility to compete is based on their impairment and how it influences their sporting performance. But only a <a href=\"https://doi.org/10.1080/17430437.2016.1225885\">narrow range</a> of impairments are considered, and the wider process has been <a href=\"https://link.springer.com/chapter/10.1057/9780230367463_23\">criticised by scholars</a> as disempowering.</p><p>The Tokyo 2020 Paralympics are being used as a catalyst for a new <a href=\"https://www.wethe15.org/\">global campaign</a> aimed at removing discrimination faced by disabled people. Entitled We the 15, this new effort has been launched by the International Paralympic Committee (IPC) and the International Disability Alliance along with a host of other sports, human rights and business organisations. The goal is to create more opportunities – and <a href=\"https://theconversation.com/paralympics-havent-decreased-barriers-to-physical-activity-for-most-people-with-disabilities-165145\">greater accessibility</a> – for people with impairments.</p><h2>Representation matters</h2><p>Elite sport is by definition an exclusive domain, and the Paralympics are <a href=\"https://theconversation.com/the-paralympics-strive-for-inclusion-but-some-rules-unfairly-exclude-athletes-with-severe-disabilities-166347\">no exception</a>. The <a href=\"https://www.telegraph.co.uk/paralympic-sport/2021/08/22/tokyo-2020-paralympics-how-does-classification-system-work/\">classification system</a> used to determine athletes’ eligibility to compete is based on their impairment and how it influences their sporting performance. But only a <a href=\"https://doi.org/10.1080/17430437.2016.1225885\">narrow range</a> of impairments are considered, and the wider process has been <a href=\"https://link.springer.com/chapter/10.1057/9780230367463_23\">criticised by scholars</a> as disempowering.</p><p>The Tokyo 2020 Paralympics are being used as a catalyst for a new <a href=\"https://www.wethe15.org/\">global campaign</a> aimed at removing discrimination faced by disabled people. Entitled We the 15, this new effort has been launched by the International Paralympic Committee (IPC) and the International Disability Alliance along with a host of other sports, human rights and business organisations. The goal is to create more opportunities – and <a href=\"https://theconversation.com/paralympics-havent-decreased-barriers-to-physical-activity-for-most-people-with-disabilities-165145\">greater accessibility</a> – for people with impairments.</p><h2>Representation matters</h2><p>Elite sport is by definition an exclusive domain, and the Paralympics are <a href=\"https://theconversation.com/the-paralympics-strive-for-inclusion-but-some-rules-unfairly-exclude-athletes-with-severe-disabilities-166347\">no exception</a>. The <a href=\"https://www.telegraph.co.uk/paralympic-sport/2021/08/22/tokyo-2020-paralympics-how-does-classification-system-work/\">classification system</a> used to determine athletes’ eligibility to compete is based on their impairment and how it influences their sporting performance. But only a <a href=\"https://doi.org/10.1080/17430437.2016.1225885\">narrow range</a> of impairments are considered, and the wider process has been <a href=\"https://link.springer.com/chapter/10.1057/9780230367463_23\">criticised by scholars</a> as disempowering.</p><p>The Tokyo 2020 Paralympics are being used as a catalyst for a new <a href=\"https://www.wethe15.org/\">global campaign</a> aimed at removing discrimination faced by disabled people. Entitled We the 15, this new effort has been launched by the International Paralympic Committee (IPC) and the International Disability Alliance along with a host of other sports, human rights and business organisations. The goal is to create more opportunities – and <a href=\"https://theconversation.com/paralympics-havent-decreased-barriers-to-physical-activity-for-most-people-with-disabilities-165145\">greater accessibility</a> – for people with impairments.</p><h2>Representation matters</h2><p>Elite sport is by definition an exclusive domain, and the Paralympics are <a href=\"https://theconversation.com/the-paralympics-strive-for-inclusion-but-some-rules-unfairly-exclude-athletes-with-severe-disabilities-166347\">no exception</a>. The <a href=\"https://www.telegraph.co.uk/paralympic-sport/2021/08/22/tokyo-2020-paralympics-how-does-classification-system-work/\">classification system</a> used to determine athletes’ eligibility to compete is based on their impairment and how it influences their sporting performance. But only a <a href=\"https://doi.org/10.1080/17430437.2016.1225885\">narrow range</a> of impairments are considered, and the wider process has been <a href=\"https://link.springer.com/chapter/10.1057/9780230367463_23\">criticised by scholars</a> as disempowering.</p>', 'The Tokyo 2020 Paralympics are being used as a catalyst for a new global campaign aimed at removing discrimination faced by disabled people. ', 0, 0);

-- ----------------------------
-- Table structure for registered_users
-- ----------------------------
DROP TABLE IF EXISTS `registered_users`;
CREATE TABLE `registered_users`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_first_name` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_last_name` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `log_in_status` tinyint(1) NULL DEFAULT 0,
  `last_log_in_time’` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of registered_users
-- ----------------------------
INSERT INTO `registered_users` VALUES (1, NULL, NULL, 'u6614123', NULL, 'defac44447b57f152d14f30cea7a73cb', 0, NULL);
INSERT INTO `registered_users` VALUES (2, NULL, NULL, 'u6614123anu', NULL, '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (3, NULL, NULL, 'abcdef', NULL, '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (4, NULL, NULL, 'u6614123e', NULL, '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (5, NULL, NULL, 'u6614123wq', NULL, '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (7, NULL, NULL, 'u6614123we', NULL, '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (8, NULL, NULL, 'u6614123cd', NULL, '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (9, NULL, NULL, 'u6614123ef', NULL, '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (11, NULL, NULL, 'u6614123re', NULL, '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (12, NULL, NULL, 'u6614123qw', 'u6614123@anu.edu.au', '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (13, NULL, NULL, 'u6614123aq', 'u6614123@anu.edu.au', '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (14, NULL, NULL, 'u6614123zz', 'u6614112@anu.edu.au', '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (15, NULL, NULL, 'u6614123aa', 'u6614123@anu.edu.au', '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (16, NULL, NULL, 'u6614123kk', 'u6614123@anu.edu.au', '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (17, NULL, NULL, 'u6614123mm', 'u6614123@anu.edu.au', '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (18, NULL, NULL, 'u6614123ll', 'u6614123@anu.edu.au', '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (19, NULL, NULL, 'u6614123cc', 'u6614123@anu.edu.au', '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (20, NULL, NULL, 'abcdefg', 'u6614123@anu.edu.au', '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (21, NULL, NULL, 'u6614123cs', 'u6614123@anu.edu.au', '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (22, NULL, NULL, 'aqu6614123', 'u6614123@anu.edu.au', '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (23, NULL, NULL, 'mmu6614123', 'u6614123@anu.edu.au', '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (24, NULL, NULL, 'aau6614123', 'u6614123@anu.edu.au', '25d55ad283aa400af464c76d713c07ad', 0, NULL);
INSERT INTO `registered_users` VALUES (25, NULL, NULL, 'u6614123vv', 'u6614123@anu.edu.au', '25d55ad283aa400af464c76d713c07ad', 0, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of registereduser
-- ----------------------------
INSERT INTO `registereduser` VALUES (1, 'user', '25f9e794323b453885f5181f1b624d0b', 0, 1618131992);

-- ----------------------------
-- Table structure for reporter
-- ----------------------------
DROP TABLE IF EXISTS `reporter`;
CREATE TABLE `reporter`  (
  `reporter_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`reporter_id`) USING BTREE,
  INDEX `reporter_id`(`user_id`) USING BTREE,
  CONSTRAINT `reporter_id` FOREIGN KEY (`user_id`) REFERENCES `registered_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reporter
-- ----------------------------
INSERT INTO `reporter` VALUES (1, 13);
INSERT INTO `reporter` VALUES (2, 14);
INSERT INTO `reporter` VALUES (3, 15);
INSERT INTO `reporter` VALUES (4, 16);
INSERT INTO `reporter` VALUES (5, 17);
INSERT INTO `reporter` VALUES (6, 18);
INSERT INTO `reporter` VALUES (7, 19);
INSERT INTO `reporter` VALUES (8, 23);
INSERT INTO `reporter` VALUES (9, 24);
INSERT INTO `reporter` VALUES (10, 25);

-- ----------------------------
-- Table structure for topadmin
-- ----------------------------
DROP TABLE IF EXISTS `topadmin`;
CREATE TABLE `topadmin`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of topic
-- ----------------------------
INSERT INTO `topic` VALUES (1, 'SUPPORTS', '5', 'SUPPORTS', 'news about the entertainment');
INSERT INTO `topic` VALUES (2, 'PEOPLE', '2', 'PEOPLE', 'The most hot news in recent days');
INSERT INTO `topic` VALUES (3, 'IDEAS', '4', 'IDEAS', 'IDEAS');
INSERT INTO `topic` VALUES (4, 'POLICY', '5', 'POLICY', 'POLICY');
INSERT INTO `topic` VALUES (5, 'SPEICAILIST PROVIDERS', '1', 'SPEICAILIST PROVIDERS', 'SPEICAILIST PROVIDERS');

SET FOREIGN_KEY_CHECKS = 1;

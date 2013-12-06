/*
Navicat MySQL Data Transfer

Source Server         : jww
Source Server Version : 50532
Source Host           : localhost:3306
Source Database       : Fit_Diet

Target Server Type    : MYSQL
Target Server Version : 50532
File Encoding         : 65001

Date: 2013-08-17 10:51:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `englishName` varchar(20) DEFAULT NULL,
  `weekShouldEat` float(10,2) DEFAULT NULL,
  `monthShouldEat` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '蔬菜', 'vegetable', '3500.00', '15000.00');
INSERT INTO `category` VALUES ('2', '奶类', 'diary_products', '2100.00', '9000.00');
INSERT INTO `category` VALUES ('3', '豆类', 'beans', '350.00', '1500.00');
INSERT INTO `category` VALUES ('4', '肉类', 'meat', '525.00', '2250.00');
INSERT INTO `category` VALUES ('5', '鱼虾类', 'fish', '700.00', '3000.00');
INSERT INTO `category` VALUES ('6', '蛋类', 'egg', '350.00', '1500.00');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `phone` varchar(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `userName` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `hobby` varchar(50) DEFAULT NULL,
  `workCategory` int(2) DEFAULT NULL,
  `isHealth` int(2) DEFAULT NULL,
  `isFat` int(2) DEFAULT NULL,
  `isHypertension` int(2) DEFAULT NULL,
  `isHyperlipidemia` int(2) DEFAULT NULL,
  `isCardiopathy` int(2) DEFAULT NULL,
  `isGlycuresis` int(2) DEFAULT NULL,
  `isAnemia` int(2) DEFAULT NULL,
  `healthStr` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('1', '', '', '男', '1991-10-16', 'jww', 'e10adc3949ba59abbe56', '', '1', '1', '1', '1', '1', '1', '1', '1', '1111111');
INSERT INTO `customer` VALUES ('2', '', '', '男', '1991-10-16', 'haha', '25f9e794323b453885f5', '', '0', '1', '1', '0', '1', '0', '0', '0', '1101000');

-- ----------------------------
-- Table structure for dessert
-- ----------------------------
DROP TABLE IF EXISTS `dessert`;
CREATE TABLE `dessert` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `pictureUrl` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dessert
-- ----------------------------
INSERT INTO `dessert` VALUES ('1', '毒酒草莓', 'td1.png');
INSERT INTO `dessert` VALUES ('2', '草莓蛋糕', 'td2.png');
INSERT INTO `dessert` VALUES ('3', '梅香樱蕉', 'td3.png');
INSERT INTO `dessert` VALUES ('4', '婚纱蛋糕', 'td4.png');
INSERT INTO `dessert` VALUES ('5', '玫瑰巧克力层', 'td5.png');
INSERT INTO `dessert` VALUES ('6', '草莓巧克力', 'td6.png');
INSERT INTO `dessert` VALUES ('7', '蛋糕汉堡', 'td7.png');

-- ----------------------------
-- Table structure for favorite
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `userID` int(20) DEFAULT NULL,
  `foodID` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of favorite
-- ----------------------------
INSERT INTO `favorite` VALUES ('1', '1', '1');
INSERT INTO `favorite` VALUES ('2', '1', '2');

-- ----------------------------
-- Table structure for finishorder
-- ----------------------------
DROP TABLE IF EXISTS `finishorder`;
CREATE TABLE `finishorder` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `userID` int(20) DEFAULT NULL,
  `foodID` int(20) DEFAULT NULL,
  `ifCooking` int(2) DEFAULT NULL,
  `ifFinish` int(2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `orderdetail_userid` (`userID`),
  KEY `orderdetail_foodid` (`foodID`),
  CONSTRAINT `orderdetail_foodid` FOREIGN KEY (`foodID`) REFERENCES `food` (`ID`),
  CONSTRAINT `orderdetail_userid` FOREIGN KEY (`userID`) REFERENCES `customer` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of finishorder
-- ----------------------------
INSERT INTO `finishorder` VALUES ('1', '1', '1', '1', '1');
INSERT INTO `finishorder` VALUES ('2', '1', '1', '0', '0');
INSERT INTO `finishorder` VALUES ('3', '1', '3', '0', '1');

-- ----------------------------
-- Table structure for food
-- ----------------------------
DROP TABLE IF EXISTS `food`;
CREATE TABLE `food` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `step` varchar(200) DEFAULT NULL,
  `pictureUrl` varchar(50) DEFAULT NULL,
  `fitPeople` varchar(200) DEFAULT NULL,
  `effect` varchar(50) DEFAULT NULL,
  `buyLocation` varchar(200) DEFAULT NULL,
  `remind` varchar(200) DEFAULT NULL,
  `price` float(10,2) DEFAULT NULL,
  `time` int(10) DEFAULT NULL,
  `factory` varchar(50) DEFAULT NULL,
  `nurtrition` varchar(50) DEFAULT NULL,
  `times` int(20) DEFAULT NULL,
  `stepToMircrowave` varchar(100) DEFAULT NULL,
  `nutritionValue` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of food
-- ----------------------------
INSERT INTO `food` VALUES ('1', '鱼香肉丝', '取1个碗，加入半碗水，依次放入盐，糖，醋，生粉及酱油，调匀备用-其它食材切丝或切末-里脊肉切丝，加入盐，鸡粉胡椒粉生粉加少许水-抓至发粘腌制10分钟-锅中放油烧热后放入肉丝迅速拨散，至颜色变白即关火盛出备用-锅中留底油爆香蒜末及姜末，接着加入豆瓣酱适量炒香-依次放入胡萝卜及茭白丝翻炒至软后，再加入香菇，青椒，最后加入大蒜及肉丝-倒入鱼香汁翻匀即可出锅', 'yxrs.png', '阴虚不足，头晕，贫血，老人燥咳无痰，大便干结，以及营养不良者', '主治热病伤津，消渴赢瘦，身虚体弱，产后血虚，燥咳，便密，滋阴，润燥，润肌肤，利二便和止消渴', '沃尔玛（厦大店）', '', '20.00', '15', '贝太厨房', '厦大餐饮', '12', '5:3:0:加热三分钟-0:0:0:取出器皿，用筷子将器皿中的花生米均匀翻动一下，再次将器皿放入微波炉-3:3:0:加热两分钟-0:0:0:老醋花生做好啦，快去尝尝吧！', '补血调理,脾调养调理,肝炎调理,肾调养调理,肝调养调理,学龄前儿童食谱,丰胸调理');
INSERT INTO `food` VALUES ('2', '麻婆豆腐', '尖椒洗净切丁、姜、蒜、葱切末、与豆瓣、油拌匀。豆腐切方丁放入烤碗中-把拌匀的调料放入微波炉中叮一分钟，取出倒在豆腐上，撒上盐、花椒粉、辣椒粉、蒸鱼豉油、蚝油、黄酒、糖、高汤，稍微拌一下，放入微波炉中叮3 分钟', 'mpdf.png', '阴虚不足，头晕，贫血，老人燥咳无痰，大便干结，以及营养不良者', '主治热病伤津，消渴赢瘦，身虚体弱，产后血虚，燥咳，便密，滋阴，润燥，润肌肤，利二便和止消渴', '新华都（厦大店），沃尔玛（火车站店）', '', '13.00', '12', '贝太厨房', '厦大餐饮', '2', '5:3:0:加热三分钟-0:0:0:取出器皿，用筷子将器皿中的花生米均匀翻动一下，再次将器皿放入微波炉-3:3:0:加热两分钟-0:0:0:老醋花生做好啦，快去尝尝吧！', '补血调理,脾调养调理,肝炎调理,肾调养调理,肝调养调理,学龄前儿童食谱,丰胸调理');
INSERT INTO `food` VALUES ('3', '老醋花生', '老陈醋中加入绵白糖和盐（1/2茶匙，3g）调成味汁。花生米用清水洗净，沥干水分-取一个适用于微波炉的器皿（不用盖子），放入洗好的花生米，调入剩余的盐（2g）和油，拌均匀。将器皿移入微波炉，以500瓦火力（或中火档）加热3分钟，取出器皿（一定要用布或者专用手套，以免烫伤手），用筷子将器皿中的花生米均匀翻动一下，再次将器皿放入微波炉，以500瓦火力（或中火档）加热2分钟-取出器皿，待花生米完全变凉变脆', 'lchs.png', '阴虚不足，头晕，贫血，老人燥咳无痰，大便干结，以及营养不良者', '主治热病伤津，消渴赢瘦，身虚体弱，产后血虚，燥咳，便密，滋阴，润燥，润肌肤，利二便和止消渴', '沃尔玛（厦大店）', '', '23.00', '10', '贝太厨房', '厦大餐饮', '3', '5:3:0:加热三分钟-0:0:0:取出器皿，用筷子将器皿中的花生米均匀翻动一下，再次将器皿放入微波炉-3:3:0:加热两分钟-0:0:0:老醋花生做好啦，快去尝尝吧！', '补血调理,脾调养调理,肝炎调理,肾调养调理,肝调养调理,学龄前儿童食谱,丰胸调理');
INSERT INTO `food` VALUES ('4', '番茄菜花', '菜花去除根部，用小刀切割成小朵，再用清水冲洗干净。番茄洗净，切成小丁- 锅中放入适量热水，大火烧沸后将菜花小朵放入汆煮2分钟，再捞出沥干待用-中火烧热锅中的油，待烧至六成热时将大葱花放入爆香，随后放入番茄酱翻炒片刻，再调入少许清水大火烧沸-将菜花小朵和番茄小丁放入锅中，再调入盐和白砂糖翻炒均匀', 'fqch.png', '阴虚不足，头晕，贫血，老人燥咳无痰，大便干结，以及营养不良者', '主治热病伤津，消渴赢瘦，身虚体弱，产后血虚，燥咳，便密，滋阴，润燥，润肌肤，利二便和止消渴', '沃尔玛（厦大店）', '', '23.00', '23', '贝太厨房', '厦大餐饮', '55', '5:3:0:加热三分钟-0:0:0:取出器皿，用筷子将器皿中的花生米均匀翻动一下，再次将器皿放入微波炉-3:3:0:加热两分钟-0:0:0:老醋花生做好啦，快去尝尝吧！', '补血调理,脾调养调理,肝炎调理,肾调养调理,肝调养调理,学龄前儿童食谱,丰胸调理');
INSERT INTO `food` VALUES ('5', '喷香芝麻茄子条', '将长茄子削皮、切成10cm的长条，放入汤碗中加入高汤、老抽、白砂糖、米酒混合拌匀，腌制5分钟。将香葱洗净，切成小葱花，备用-用保鲜膜将装有腌好茄子条的汤碗包好，放入微波炉中，中火加热8分钟-从汤碗中取出茄条，码入 盘子，吃的时候撒上白芝麻和香葱花，即', 'pxzmqzt.png', '阴虚不足，头晕，贫血，老人燥咳无痰，大便干结，以及营养不良者', '主治热病伤津，消渴赢瘦，身虚体弱，产后血虚，燥咳，便密，滋阴，润燥，润肌肤，利二便和止消渴', '沃尔玛（厦大店）', '', '43.00', '12', '贝太厨房', '厦大餐饮', '321', '5:3:0:加热三分钟-0:0:0:取出器皿，用筷子将器皿中的花生米均匀翻动一下，再次将器皿放入微波炉-3:3:0:加热两分钟-0:0:0:老醋花生做好啦，快去尝尝吧！', '补血调理,脾调养调理,肝炎调理,肾调养调理,肝调养调理,学龄前儿童食谱,丰胸调理');

-- ----------------------------
-- Table structure for foodcategory
-- ----------------------------
DROP TABLE IF EXISTS `foodcategory`;
CREATE TABLE `foodcategory` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `foodID` int(20) DEFAULT NULL,
  `categoryID` int(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of foodcategory
-- ----------------------------
INSERT INTO `foodcategory` VALUES ('1', '1', '4');

-- ----------------------------
-- Table structure for foodmaterial
-- ----------------------------
DROP TABLE IF EXISTS `foodmaterial`;
CREATE TABLE `foodmaterial` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `foodID` int(20) DEFAULT NULL,
  `materialID` int(20) DEFAULT NULL,
  `materialWeight` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `foodID` (`foodID`),
  KEY `materialID` (`materialID`),
  CONSTRAINT `foodID` FOREIGN KEY (`foodID`) REFERENCES `food` (`ID`),
  CONSTRAINT `materialID` FOREIGN KEY (`materialID`) REFERENCES `foodmaterial` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of foodmaterial
-- ----------------------------
INSERT INTO `foodmaterial` VALUES ('1', '1', '1', '250');
INSERT INTO `foodmaterial` VALUES ('2', '1', '2', '150');
INSERT INTO `foodmaterial` VALUES ('3', '1', '3', '100克');
INSERT INTO `foodmaterial` VALUES ('4', '1', '5', '15克');
INSERT INTO `foodmaterial` VALUES ('5', '1', '6', '3朵');
INSERT INTO `foodmaterial` VALUES ('6', '1', '7', '0.5个');
INSERT INTO `foodmaterial` VALUES ('7', '1', '8', '10克');
INSERT INTO `foodmaterial` VALUES ('8', '1', '9', '5克');
INSERT INTO `foodmaterial` VALUES ('9', '2', '4', '500克');
INSERT INTO `foodmaterial` VALUES ('10', '2', '10', '100克');
INSERT INTO `foodmaterial` VALUES ('11', '2', '11', '100克');
INSERT INTO `foodmaterial` VALUES ('12', '2', '12', '20克');
INSERT INTO `foodmaterial` VALUES ('13', '2', '13', '15毫升');
INSERT INTO `foodmaterial` VALUES ('14', '2', '14', '8克');
INSERT INTO `foodmaterial` VALUES ('15', '2', '15', '50克');
INSERT INTO `foodmaterial` VALUES ('16', '2', '16', '5毫升');
INSERT INTO `foodmaterial` VALUES ('17', '3', '19', '200克');
INSERT INTO `foodmaterial` VALUES ('18', '3', '20', '20克');
INSERT INTO `foodmaterial` VALUES ('19', '3', '11', '1根');
INSERT INTO `foodmaterial` VALUES ('20', '3', '21', '1根');
INSERT INTO `foodmaterial` VALUES ('21', '3', '9', '30毫升');
INSERT INTO `foodmaterial` VALUES ('22', '3', '5', '5克');
INSERT INTO `foodmaterial` VALUES ('23', '3', '22', '5克');
INSERT INTO `foodmaterial` VALUES ('24', '3', '13', '5毫升');
INSERT INTO `foodmaterial` VALUES ('25', '4', '23', '400克');
INSERT INTO `foodmaterial` VALUES ('26', '4', '24', '30毫升');
INSERT INTO `foodmaterial` VALUES ('27', '4', '25', '200克');
INSERT INTO `foodmaterial` VALUES ('28', '4', '5', '15克');
INSERT INTO `foodmaterial` VALUES ('29', '4', '22', '5克');
INSERT INTO `foodmaterial` VALUES ('30', '4', '11', '5克');
INSERT INTO `foodmaterial` VALUES ('31', '4', '13', '15毫升');
INSERT INTO `foodmaterial` VALUES ('32', '4', '11', '5克');
INSERT INTO `foodmaterial` VALUES ('33', '5', '26', '400克');
INSERT INTO `foodmaterial` VALUES ('34', '5', '27', '5克');
INSERT INTO `foodmaterial` VALUES ('35', '5', '11', '1根');
INSERT INTO `foodmaterial` VALUES ('36', '5', '28', '60毫升');
INSERT INTO `foodmaterial` VALUES ('37', '5', '8', '10毫升');
INSERT INTO `foodmaterial` VALUES ('38', '5', '5', '10克');
INSERT INTO `foodmaterial` VALUES ('39', '5', '16', '30毫升');

-- ----------------------------
-- Table structure for foodnutrition
-- ----------------------------
DROP TABLE IF EXISTS `foodnutrition`;
CREATE TABLE `foodnutrition` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `foodID` int(20) DEFAULT NULL,
  `caloryAmount` float(10,2) DEFAULT NULL,
  `carbohydrateAmount` float(10,2) DEFAULT NULL,
  `fatAmount` float(10,2) DEFAULT NULL,
  `proteinAmount` float(10,2) DEFAULT NULL,
  `naAmount` float(10,2) DEFAULT NULL,
  `vitaminAAmount` float(10,2) DEFAULT NULL,
  `vitaminCAmount` float(10,2) DEFAULT NULL,
  `caAmount` float(10,2) DEFAULT NULL,
  `feAmount` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `foodNutrition_foodid` (`foodID`),
  CONSTRAINT `foodNutrition_foodid` FOREIGN KEY (`foodID`) REFERENCES `food` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of foodnutrition
-- ----------------------------
INSERT INTO `foodnutrition` VALUES ('1', '1', '300.00', '100.00', '150.00', '2.00', '4.00', '1.00', '2.00', '3.00', '3.00');
INSERT INTO `foodnutrition` VALUES ('2', '2', '200.00', '100.00', '100.00', '2.00', '1.00', '3.00', '3.00', '2.00', '1.00');
INSERT INTO `foodnutrition` VALUES ('3', '3', '70.00', '120.00', '100.00', '3.00', '6.00', '4.00', '2.00', '1.00', '4.00');
INSERT INTO `foodnutrition` VALUES ('4', '4', '70.00', '120.00', '100.00', '3.00', '6.00', '4.00', '2.00', '1.00', '4.00');
INSERT INTO `foodnutrition` VALUES ('5', '5', '130.00', '23.00', '12.00', '43.00', '12.00', '1.00', '1.00', '2.00', '1.00');

-- ----------------------------
-- Table structure for foodstyle
-- ----------------------------
DROP TABLE IF EXISTS `foodstyle`;
CREATE TABLE `foodstyle` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `foodID` int(20) DEFAULT NULL,
  `labelID` int(20) DEFAULT NULL,
  `matchDegree` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `food` (`foodID`),
  KEY `label` (`labelID`),
  CONSTRAINT `food` FOREIGN KEY (`foodID`) REFERENCES `food` (`ID`),
  CONSTRAINT `label` FOREIGN KEY (`labelID`) REFERENCES `style` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of foodstyle
-- ----------------------------
INSERT INTO `foodstyle` VALUES ('1', '1', '2', '0.80');
INSERT INTO `foodstyle` VALUES ('2', '2', '2', '0.90');
INSERT INTO `foodstyle` VALUES ('3', '3', '3', '0.90');
INSERT INTO `foodstyle` VALUES ('4', '4', '4', '1.00');
INSERT INTO `foodstyle` VALUES ('5', '5', '5', '0.70');

-- ----------------------------
-- Table structure for foodtaste
-- ----------------------------
DROP TABLE IF EXISTS `foodtaste`;
CREATE TABLE `foodtaste` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `foodID` int(11) DEFAULT NULL,
  `styleID` int(11) DEFAULT NULL,
  `matchDegree` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of foodtaste
-- ----------------------------
INSERT INTO `foodtaste` VALUES ('1', '1', '4', '0.70');

-- ----------------------------
-- Table structure for fruit
-- ----------------------------
DROP TABLE IF EXISTS `fruit`;
CREATE TABLE `fruit` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `pictureUrl` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fruit
-- ----------------------------
INSERT INTO `fruit` VALUES ('1', '橙子', 'chengzi.png');
INSERT INTO `fruit` VALUES ('2', '荔枝', 'lizhi.png');
INSERT INTO `fruit` VALUES ('3', '猕猴桃', 'mihoutao.png');
INSERT INTO `fruit` VALUES ('4', '杨桃', 'yangtao.png');
INSERT INTO `fruit` VALUES ('5', '油桃', 'youtao.png');
INSERT INTO `fruit` VALUES ('6', '西瓜', 'xigua.png');

-- ----------------------------
-- Table structure for historyorder
-- ----------------------------
DROP TABLE IF EXISTS `historyorder`;
CREATE TABLE `historyorder` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `finishTime` datetime DEFAULT NULL,
  `finalPrice` float(10,2) DEFAULT NULL,
  `finalNum` int(20) DEFAULT NULL,
  `userID` int(20) DEFAULT NULL,
  `foodID` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `finalorder_userid` (`userID`),
  CONSTRAINT `finalorder_userid` FOREIGN KEY (`userID`) REFERENCES `customer` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of historyorder
-- ----------------------------
INSERT INTO `historyorder` VALUES ('1', '2013-07-17 15:14:02', '20.00', '1', '1', '1');
INSERT INTO `historyorder` VALUES ('2', '2013-07-25 10:19:56', '50.00', '1', '1', '2');
INSERT INTO `historyorder` VALUES ('3', '2013-07-25 10:20:26', '30.00', '1', '1', '3');
INSERT INTO `historyorder` VALUES ('4', '2013-07-25 10:20:23', '60.00', '1', '1', '4');
INSERT INTO `historyorder` VALUES ('5', '2013-07-25 10:20:21', '24.00', '1', '1', '5');

-- ----------------------------
-- Table structure for initialorder
-- ----------------------------
DROP TABLE IF EXISTS `initialorder`;
CREATE TABLE `initialorder` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `userID` int(20) DEFAULT NULL,
  `foodID` int(20) DEFAULT NULL,
  `foodNum` int(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `init_userid` (`userID`),
  KEY `init_foodid` (`foodID`),
  CONSTRAINT `init_foodid` FOREIGN KEY (`foodID`) REFERENCES `food` (`ID`),
  CONSTRAINT `init_userid` FOREIGN KEY (`userID`) REFERENCES `customer` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of initialorder
-- ----------------------------
INSERT INTO `initialorder` VALUES ('1', '1', '1', '2');
INSERT INTO `initialorder` VALUES ('2', '1', '3', '4');
INSERT INTO `initialorder` VALUES ('3', '1', '5', '1');

-- ----------------------------
-- Table structure for material
-- ----------------------------
DROP TABLE IF EXISTS `material`;
CREATE TABLE `material` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `calory` float(10,2) DEFAULT NULL,
  `carbohydrate` float(10,2) DEFAULT NULL,
  `fat` float(10,2) DEFAULT NULL,
  `protein` float(10,2) DEFAULT NULL,
  `na` float(10,2) DEFAULT NULL,
  `vitaminA` float(10,2) DEFAULT NULL,
  `vitaminC` float(10,2) DEFAULT NULL,
  `ca` float(10,2) DEFAULT NULL,
  `fe` float(10,2) DEFAULT NULL,
  `materialName` varchar(50) DEFAULT NULL,
  `categoryID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of material
-- ----------------------------
INSERT INTO `material` VALUES ('1', '300.00', '100.00', '150.00', '2.00', '4.00', '1.00', '2.00', '3.00', '3.00', '猪瘦肉', '4');
INSERT INTO `material` VALUES ('2', '200.00', '100.00', '20.00', '2.00', '2.00', '1.00', '3.00', '3.00', '1.00', '青椒', '1');
INSERT INTO `material` VALUES ('3', '100.00', '100.00', '140.00', '2.00', '1.00', null, '1.00', '2.00', null, '冬笋', '1');
INSERT INTO `material` VALUES ('4', '123.00', '156.00', '9.00', '120.00', null, null, null, '3.00', '1.00', '豆腐', '3');
INSERT INTO `material` VALUES ('5', '490.00', '100.00', '123.00', '9.00', null, null, null, null, null, '糖', null);
INSERT INTO `material` VALUES ('6', '12.00', '12.00', '21.00', '12.00', '12.00', null, null, null, null, '香菇', null);
INSERT INTO `material` VALUES ('7', '12.00', '23.00', '23.00', '21.00', '1.00', '1.00', '2.00', '2.00', '2.00', '黑木耳', null);
INSERT INTO `material` VALUES ('8', '1.00', '2.00', '1.00', '21.00', '32.00', '1.00', '12.00', '2.00', '3.00', '酱油', null);
INSERT INTO `material` VALUES ('9', '12.00', '3.00', '1.00', '34.00', '3.00', '2.00', '2.00', '2.00', '43.00', '醋', null);
INSERT INTO `material` VALUES ('10', '1.00', '12.00', '21.00', '212.00', '1.00', '2.00', '1.00', '3.00', '1.00', '尖椒', '1');
INSERT INTO `material` VALUES ('11', '12.00', '1.00', '1.00', '321.00', '123.00', '42.00', '1.00', '1.00', '1.00', '葱', '1');
INSERT INTO `material` VALUES ('12', '1.00', '12.00', '2.00', '1.00', '1.00', '2.00', '1.00', '1.00', '3.00', '姜', '1');
INSERT INTO `material` VALUES ('13', '1234.00', '12.00', '123.00', '12.00', '12.00', '1.00', '1.00', '1.00', '1.00', '食用油', null);
INSERT INTO `material` VALUES ('14', '1.00', '23.00', '32.00', '11.00', '32.00', '12.00', '21.00', '32.00', '3.00', '辣椒粉', null);
INSERT INTO `material` VALUES ('15', '1.00', '21.00', '12.00', '32.00', '12.00', '42.00', '12.00', '3.00', '3.00', '大蒜', '1');
INSERT INTO `material` VALUES ('16', '2.00', '3.00', '1.00', '4.00', '1.00', '4.00', '2.00', '1.00', '4.00', '黄酒', null);
INSERT INTO `material` VALUES ('17', '2.00', '3.00', '2.00', '23.00', '2.00', '2.00', '2.00', '2.00', '3.00', '杭椒', '1');
INSERT INTO `material` VALUES ('18', '1.00', '2.00', '3.00', '4.00', '5.00', '6.00', '2.00', '1.00', '2.00', '美人椒', '1');
INSERT INTO `material` VALUES ('19', '234.00', '12.00', '42.00', '324.00', '12.00', '23.00', '4.00', '4.00', '5.00', '花生', '3');
INSERT INTO `material` VALUES ('20', '21.00', '12.00', '21.00', '21.00', '21.00', '21.00', '21.00', '2.00', '1.00', '黄瓜', '1');
INSERT INTO `material` VALUES ('21', '12.00', '2.00', '1.00', '2.00', '4.00', '4.00', '1.00', '12.00', '3.00', '香菜', '1');
INSERT INTO `material` VALUES ('22', '1.00', '1.00', '1.00', '1.00', '34.00', '1.00', '1.00', '1.00', '1.00', '盐', null);
INSERT INTO `material` VALUES ('23', '12.00', '23.00', '123.00', '321.00', '21.00', '23.00', '12.00', '32.00', '12.00', '菜花', '1');
INSERT INTO `material` VALUES ('24', '12.00', '21.00', '23.00', '42.00', '12.00', '3.00', '1.00', '2.00', '23.00', '番茄', '1');
INSERT INTO `material` VALUES ('25', '12.00', '32.00', '43.00', '5.00', '4.00', '2.00', '1.00', '3.00', '1.00', '番茄酱', null);
INSERT INTO `material` VALUES ('26', '23.00', '43.00', '12.00', '43.00', '3.00', '53.00', '34.00', '23.00', '1.00', '茄子', '1');
INSERT INTO `material` VALUES ('27', '1.00', '2.00', '234.00', '4.00', '5.00', '12.00', '23.00', '23.00', '12.00', '白芝麻', null);
INSERT INTO `material` VALUES ('28', '23.00', '12.00', '43.00', '12.00', '12.00', '1.00', '2.00', '2.00', '1.00', '高汤', null);

-- ----------------------------
-- Table structure for style
-- ----------------------------
DROP TABLE IF EXISTS `style`;
CREATE TABLE `style` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `styleName` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of style
-- ----------------------------
INSERT INTO `style` VALUES ('1', '家常', null);
INSERT INTO `style` VALUES ('2', '川菜', null);
INSERT INTO `style` VALUES ('3', '湘菜', null);
INSERT INTO `style` VALUES ('4', '京菜', null);
INSERT INTO `style` VALUES ('5', '家常菜', null);

-- ----------------------------
-- Table structure for taste
-- ----------------------------
DROP TABLE IF EXISTS `taste`;
CREATE TABLE `taste` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `tasteName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=gbk;

-- ----------------------------
-- Records of taste
-- ----------------------------
INSERT INTO `taste` VALUES ('1', '酸');
INSERT INTO `taste` VALUES ('2', '甜');
INSERT INTO `taste` VALUES ('3', '苦');
INSERT INTO `taste` VALUES ('4', '辣');
INSERT INTO `taste` VALUES ('5', '咸');

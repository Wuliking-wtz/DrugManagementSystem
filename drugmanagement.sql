/*
SQLyog Enterprise v12.08 (64 bit)
MySQL - 8.0.13 : Database - drug_management_system
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`drug_management_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;

USE `drug_management_system`;

/*Table structure for table `agency` */

DROP TABLE IF EXISTS `agency`;

CREATE TABLE `agency` (
  `ano` int(11) NOT NULL AUTO_INCREMENT,
  `aname` varchar(8) DEFAULT NULL,
  `asex` varchar(1) DEFAULT NULL,
  `aphone` varchar(12) DEFAULT NULL,
  `aremark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ano`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `agency` */

insert  into `agency`(`ano`,`aname`,`asex`,`aphone`,`aremark`) values (1,'孔子','男','551-479','思想家、教育家和政治家'),(2,'扁鹊','男','407-310','名医');

/*Table structure for table `client` */

DROP TABLE IF EXISTS `client`;

CREATE TABLE `client` (
  `cno` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(8) DEFAULT NULL,
  `csex` varchar(1) DEFAULT NULL,
  `cage` int(4) DEFAULT NULL,
  `caddress` varchar(50) DEFAULT NULL,
  `cphone` varchar(12) DEFAULT NULL,
  `cremark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cno`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

/*Data for the table `client` */

insert  into `client`(`cno`,`cname`,`csex`,`cage`,`caddress`,`cphone`,`cremark`) values (1,'诸葛亮','男',40,'山东省沂南','181-234','七擒孟获'),(2,'刘备','男',63,'河北省涿县','161-223','三顾茅庐请出诸葛亮为军师'),(3,'关羽','男',58,'山西省临猗西南','161-220','五虎大将排名第一位'),(4,'张飞','男',55,'河北省涿县','171-221','五虎大将中第二位'),(5,'公孙瓒','男',51,'河北省迁安','188-199','与袁绍为争夺北方连年交战'),(8,'孙权','男',50,'江苏省南京','182-252','吴国建立者'),(33,'庄子','男',56,'安徽省蒙城县','369-289','道家学说的主要创始人'),(34,'商鞅','男',66,'河南省濮阳','390-338','变法'),(35,'晋文公','男',29,'湖北省荆州','697-328','中国春秋时期晋国的第二十二任君主'),(36,'伯牙','男',18,'湖北省荆州','666-444','当时著名的琴师'),(37,'孙武','男',45,'河南省淮阴','545-470','著名的大军事家'),(38,'西施','女',56,'浙江省诸暨苎萝村','555-135','闭月羞花之貌，沉鱼落雁之容'),(39,'范蠡','男',65,'河南省南阳','536-448','著作有《计然篇》、《陶朱公生意经》等'),(40,'管仲','男',46,'安徽省','564-645','尊称“仲父”'),(41,'宋玉','男',22,'广东省','564-564','历史上与潘安齐名的最著名的两大帅哥之一'),(42,'白起','男',66,'陕西省眉县常兴镇白家村','452-563','战国四大名将之一'),(43,'老子','男',23,'河南省鹿邑县东','571-471','他的语录流传浙广');

/*Table structure for table `medicine` */

DROP TABLE IF EXISTS `medicine`;

CREATE TABLE `medicine` (
  `mno` int(11) NOT NULL AUTO_INCREMENT,
  `mname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `mmode` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `mefficacy` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`mno`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `medicine` */

insert  into `medicine`(`mno`,`mname`,`mmode`,`mefficacy`) values (1,'头孢拉定','内服','用于呼吸道、泌尿道、皮肤和软组织等部位的敏感菌感染，注射剂也用于败血症和骨感染。'),(2,'去甲万古霉素','口服','主要用于葡萄球菌（包括产酶株和耐甲氧西林株）、难辨梭状芽胞杆菌等所致的系统感染和肠道感染，如心内膜炎、败血症、伪膜性肠炎等。'),(3,'舒巴坦','内服','可应用于一些不产β-内酰胺酶的链球菌（包括肺炎链球菌、粪链球菌）、脑膜炎球菌以及梭状芽胞杆菌等敏感菌株所致的周围感染'),(4,'克林霉素','口服','主要用于厌氧菌（包括脆弱拟杆菌、产气荚膜杆菌、放线菌等）引起的腹腔和妇科感染'),(5,'依匹西林','口服','临床主要用于敏感菌引起的呼吸道感染、尿路感染及皮肤软组织等感染。'),(6,'替卡西林钠','肌内注射','用于绿脓假单胞菌和各种敏感革兰阴性菌所致的菌血症、呼吸系统感染、泌尿系统感染、胆管感染等。'),(7,'他唑西林','静脉注射','用于敏感菌所致下呼吸道感染、泌尿系统感染、骨关节和皮肤软组织感染及菌血症等严重感染。'),(8,'萘夫西林钠','口服','主要用于耐药金葡菌所致的呼吸道感染、皮肤感染，也可用于骨髓炎。'),(9,'海他西林','口服','用于敏感菌所致的感染，如菌血症、呼吸系统感染、心内膜炎、脑膜炎、泌尿系统感染、胆管或肠道感染等。'),(10,'阿扑西林','静注','临床上用于敏感菌引起的败血症、心内膜炎、呼吸道感染、胆道感染、腹膜炎等。'),(11,'卡芦莫南钠','肌注','用于严重革兰阴性需氧杆菌引起的下呼吸道感染、有合并症的尿路感染、胆管炎、胆囊炎、腹膜炎等腹内感染和菌血症等。'),(12,'氨曲南','口服','主要用于敏感的革兰阴性留所致的感染'),(13,'菌刻单','肌注','敏感菌所致的各类感染：尿路感染、下呼吸道感染、败血症、胆系腹腔感染、盆腔感染'),(14,'阿扑西林','静注','临床上用于敏感菌引起的败血症、心内膜炎、呼吸道感染、胆道感染、腹膜炎等。'),(15,'头孢呋辛钠粉针剂','外用','对普通变形杆菌、摩根变形杆菌、脆弱拟杆菌亦有中等强度的抗菌作用。');

/*Table structure for table `sold` */

DROP TABLE IF EXISTS `sold`;

CREATE TABLE `sold` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `csymptom` varchar(50) DEFAULT NULL COMMENT '症状',
  `cno` int(11) NOT NULL,
  `mno` int(11) NOT NULL,
  `ano` int(11) NOT NULL,
  `cdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ID1` (`cno`),
  KEY `FK_ID3` (`ano`),
  KEY `FK_ID2` (`mno`),
  CONSTRAINT `FK_ID1` FOREIGN KEY (`cno`) REFERENCES `client` (`cno`),
  CONSTRAINT `FK_ID2` FOREIGN KEY (`mno`) REFERENCES `medicine` (`mno`),
  CONSTRAINT `FK_ID3` FOREIGN KEY (`ano`) REFERENCES `agency` (`ano`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `sold` */

insert  into `sold`(`id`,`csymptom`,`cno`,`mno`,`ano`,`cdate`) values (6,'头疼',1,1,1,'2020-12-17 16:00:00');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `account` varchar(10) NOT NULL,
  `password` varchar(10) DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'general',
  PRIMARY KEY (`account`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`account`,`password`,`type`) values ('agency','123456','agency'),('client','123456','general'),('medicine','123456','medicine'),('root','123456','总管理员'),('sold','123456','sold');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

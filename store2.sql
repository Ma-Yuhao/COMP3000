/*
 Navicat Premium Data Transfer

 Source Server         : 11111
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : store2

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 20/05/2021 21:40:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (5, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (8, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (9, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (10, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (11, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (12, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (17, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (18, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (19, 'Can add address', 7, 'add_address');
INSERT INTO `auth_permission` VALUES (20, 'Can change address', 7, 'change_address');
INSERT INTO `auth_permission` VALUES (21, 'Can delete address', 7, 'delete_address');
INSERT INTO `auth_permission` VALUES (22, 'Can add account', 8, 'add_passport');
INSERT INTO `auth_permission` VALUES (23, 'Can change account', 8, 'change_passport');
INSERT INTO `auth_permission` VALUES (24, 'Can delete account', 8, 'delete_passport');
INSERT INTO `auth_permission` VALUES (25, 'Can add shelves', 9, 'add_products');
INSERT INTO `auth_permission` VALUES (26, 'Can change shelves', 9, 'change_products');
INSERT INTO `auth_permission` VALUES (27, 'Can delete shelves', 9, 'delete_products');
INSERT INTO `auth_permission` VALUES (28, 'Can add types', 10, 'add_productstype');
INSERT INTO `auth_permission` VALUES (29, 'Can change types', 10, 'change_productstype');
INSERT INTO `auth_permission` VALUES (30, 'Can delete types', 10, 'delete_productstype');
INSERT INTO `auth_permission` VALUES (31, 'Can add order', 11, 'add_orderinfo');
INSERT INTO `auth_permission` VALUES (32, 'Can change order', 11, 'change_orderinfo');
INSERT INTO `auth_permission` VALUES (33, 'Can delete order', 11, 'delete_orderinfo');
INSERT INTO `auth_permission` VALUES (34, 'Can add order products', 12, 'add_orderproducts');
INSERT INTO `auth_permission` VALUES (35, 'Can change order products', 12, 'change_orderproducts');
INSERT INTO `auth_permission` VALUES (36, 'Can delete order products', 12, 'delete_orderproducts');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$36000$GcprnUzlcFlz$juKBnpOmJxifIRo4WGc65zWNJs8B5o7szU2U9STHtxo=', '2021-05-20 06:25:21.363301', 1, 'admin', '', '', '', 1, 1, '2021-05-16 14:51:38.744499');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NULL DEFAULT NULL,
  `object_id` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2021-05-16 14:52:13.956751', '1', 'Games', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (2, '2021-05-16 14:54:44.235744', '1', 'BF4', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (3, '2021-05-16 14:55:28.045707', '2', 'COD:Cold war', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (4, '2021-05-16 14:55:54.473110', '1', 'Games', 2, '[{\"changed\": {\"fields\": [\"image\"]}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (5, '2021-05-16 14:56:22.694949', '2', 'Model', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (6, '2021-05-16 14:56:30.551244', '3', 'Wear', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (7, '2021-05-16 14:58:12.541990', '3', 'TAMIYA Type90', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (8, '2021-05-16 14:59:08.117450', '4', 'TAMIYA MK.II', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (9, '2021-05-16 15:00:09.480340', '5', 'Nike JEDI T-shirt', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (10, '2021-05-17 04:18:35.464867', '4', 'TAMIYA MK.II', 2, '[{\"changed\": {\"fields\": [\"desc\", \"price\", \"sales\", \"detail\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (11, '2021-05-17 04:20:37.325529', '3', 'TAMIYA Type90', 2, '[{\"changed\": {\"fields\": [\"desc\", \"price\", \"stock\", \"detail\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (12, '2021-05-17 04:23:10.431157', '5', 'Nike JEDI T-shirt', 2, '[{\"changed\": {\"fields\": [\"price\", \"detail\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (13, '2021-05-17 04:28:06.791942', '2', 'COD:Cold war', 2, '[{\"changed\": {\"fields\": [\"desc\", \"price\", \"stock\", \"detail\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (14, '2021-05-17 04:29:43.713433', '1', 'BF4', 2, '[{\"changed\": {\"fields\": [\"desc\", \"price\", \"detail\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (15, '2021-05-17 04:41:56.980893', '6', 'Resident Evil:Vilage', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (16, '2021-05-17 06:07:35.908429', '7', 'Forza Horizon 4', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (17, '2021-05-17 06:12:11.811634', '8', 'Death Stranding', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (18, '2021-05-17 06:18:48.357566', '9', 'Sekiro', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (19, '2021-05-17 06:20:05.799905', '1', 'Battlefield 4', 2, '[{\"changed\": {\"fields\": [\"name\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (20, '2021-05-19 16:38:17.931595', '9', 'Sekiro', 2, '[{\"changed\": {\"fields\": [\"detail_image1\", \"detail_image2\", \"detail_image3\", \"detail_image4\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (21, '2021-05-19 16:40:33.871496', '9', 'Sekiro', 2, '[{\"changed\": {\"fields\": [\"detail_image1\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (22, '2021-05-19 17:10:52.173476', '9', 'Sekiro', 2, '[{\"changed\": {\"fields\": [\"image\", \"detail_image1\", \"detail_image2\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (23, '2021-05-19 17:11:35.547470', '9', 'Sekiro', 2, '[{\"changed\": {\"fields\": [\"detail_image1\", \"detail_image2\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (24, '2021-05-19 17:12:49.414878', '9', 'Sekiro', 2, '[{\"changed\": {\"fields\": [\"detail_image3\", \"detail_image4\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (25, '2021-05-19 17:15:38.804979', '8', 'Death Stranding', 2, '[{\"changed\": {\"fields\": [\"detail_image1\", \"detail_image2\", \"detail_image3\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (26, '2021-05-19 17:18:22.165396', '9', 'Sekiro', 2, '[{\"changed\": {\"fields\": [\"detail_image3\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (27, '2021-05-19 17:20:48.614986', '7', 'Forza Horizon 4', 2, '[{\"changed\": {\"fields\": [\"detail_image1\", \"detail_image2\", \"detail_image3\", \"detail_image4\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (28, '2021-05-19 17:24:22.030640', '2', 'COD:Cold war', 2, '[{\"changed\": {\"fields\": [\"detail_image1\", \"detail_image2\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (29, '2021-05-19 17:26:14.490664', '1', 'Battlefield 4', 2, '[{\"changed\": {\"fields\": [\"detail_image1\", \"detail_image2\", \"detail_image3\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (30, '2021-05-19 17:29:03.026284', '6', 'Resident Evil:Vilage', 2, '[{\"changed\": {\"fields\": [\"detail_image1\", \"detail_image2\", \"detail_image3\", \"detail_image4\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (31, '2021-05-20 06:34:36.870272', '10', 'Cyberpunk 2077', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (32, '2021-05-20 06:39:44.449825', '10', 'Cyberpunk 2077', 2, '[{\"changed\": {\"fields\": [\"detail\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (33, '2021-05-20 06:47:42.916657', '11', 'Nioh 2', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (34, '2021-05-20 06:50:59.219047', '3', 'TAMIYA Type90', 2, '[{\"changed\": {\"fields\": [\"detail_image1\", \"detail_image2\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (35, '2021-05-20 06:56:28.258803', '4', 'Valentine MK.II', 2, '[{\"changed\": {\"fields\": [\"name\", \"detail\", \"image\", \"detail_image1\", \"detail_image2\", \"detail_image3\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (36, '2021-05-20 07:05:46.045819', '12', 'Yamato Model', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (37, '2021-05-20 07:11:08.843867', '13', 'King George V', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (38, '2021-05-20 07:11:28.783768', '12', 'Yamato', 2, '[{\"changed\": {\"fields\": [\"name\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (39, '2021-05-20 07:11:42.490808', '3', 'Type90', 2, '[{\"changed\": {\"fields\": [\"name\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (40, '2021-05-20 07:16:38.385370', '14', 'P51D', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (41, '2021-05-20 07:18:29.049859', '5', 'Nike JEDI T-shirt', 2, '[{\"changed\": {\"fields\": [\"detail_image1\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (42, '2021-05-20 07:22:12.630379', '15', 'Darth Vader T-shirt', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (43, '2021-05-20 12:03:56.495118', '16', 'Nike Sweat pants', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (44, '2021-05-20 12:05:17.611380', '17', 'Supreme pants', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (45, '2021-05-20 12:05:57.039243', '18', 'Gundam T-shirt', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (46, '2021-05-20 12:06:41.927459', '19', 'Pokémon T-shirt', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (47, '2021-05-20 12:07:32.151019', '20', 'Street Fighter T-shi', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (48, '2021-05-20 12:14:22.927935', '21', 'Marvel T-shirt', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (49, '2021-05-20 12:20:35.121292', '22', 'GVK T-shirt', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (50, '2021-05-20 12:21:03.864808', '21', 'Marvel T-shirt', 2, '[{\"changed\": {\"fields\": [\"detail\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (51, '2021-05-20 12:21:28.950067', '18', 'Gundam T-shirt', 2, '[{\"changed\": {\"fields\": [\"stock\", \"sales\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (52, '2021-05-20 12:21:37.431514', '15', 'Darth Vader T-shirt', 2, '[{\"changed\": {\"fields\": [\"sales\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (53, '2021-05-20 12:27:19.199236', '23', 'Demon Slayer T-shirt', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (54, '2021-05-20 12:37:04.207494', '24', 'Devil May Cry5', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (55, '2021-05-20 12:42:51.839942', '25', 'Monster Hunter:Rise', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (56, '2021-05-20 12:48:45.924894', '26', '1/24 1989 Benz C9', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (57, '2021-05-20 12:53:10.671586', '27', 'Battelship Bismarck', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (58, '2021-05-20 12:55:54.921024', '27', 'Battelship Bismarck', 2, '[{\"changed\": {\"fields\": [\"detail_image2\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (59, '2021-05-20 13:01:03.456139', '28', 'Mercedes AMG GT3', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (60, '2021-05-20 13:09:00.121015', '29', 'F35 fighter', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (61, '2021-05-20 13:17:23.552896', '30', 'Tiger I', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (62, '2021-05-20 13:19:14.793700', '13', 'King George V', 2, '[{\"changed\": {\"fields\": [\"detail\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (63, '2021-05-20 13:19:23.783920', '26', '1989 Benz C9', 2, '[{\"changed\": {\"fields\": [\"name\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (64, '2021-05-20 13:20:38.391125', '12', 'Yamato', 2, '[{\"changed\": {\"fields\": [\"detail\"]}}]', 9, 1);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (11, 'order', 'orderinfo');
INSERT INTO `django_content_type` VALUES (12, 'order', 'orderproducts');
INSERT INTO `django_content_type` VALUES (9, 'products', 'products');
INSERT INTO `django_content_type` VALUES (10, 'products', 'productstype');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (7, 'users', 'address');
INSERT INTO `django_content_type` VALUES (8, 'users', 'passport');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `applied` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2021-05-16 14:51:17.141094');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2021-05-16 14:51:17.725345');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2021-05-16 14:51:17.855050');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2021-05-16 14:51:17.863093');
INSERT INTO `django_migrations` VALUES (5, 'contenttypes', '0002_remove_content_type_name', '2021-05-16 14:51:17.975720');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0002_alter_permission_name_max_length', '2021-05-16 14:51:18.020479');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0003_alter_user_email_max_length', '2021-05-16 14:51:18.070411');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0004_alter_user_username_opts', '2021-05-16 14:51:18.077636');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0005_alter_user_last_login_null', '2021-05-16 14:51:18.122533');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0006_require_contenttypes_0002', '2021-05-16 14:51:18.125562');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0007_alter_validators_add_error_messages', '2021-05-16 14:51:18.133709');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0008_alter_user_username_max_length', '2021-05-16 14:51:18.192328');
INSERT INTO `django_migrations` VALUES (13, 'users', '0001_initial', '2021-05-16 14:51:18.327977');
INSERT INTO `django_migrations` VALUES (14, 'products', '0001_initial', '2021-05-16 14:51:18.480080');
INSERT INTO `django_migrations` VALUES (15, 'order', '0001_initial', '2021-05-16 14:51:18.733740');
INSERT INTO `django_migrations` VALUES (16, 'sessions', '0001_initial', '2021-05-16 14:51:18.777449');
INSERT INTO `django_migrations` VALUES (17, 'products', '0002_auto_20210520_0037', '2021-05-19 16:37:38.465691');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expire_date` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of django_session
-- ----------------------------

-- ----------------------------
-- Table structure for s_order_info
-- ----------------------------
DROP TABLE IF EXISTS `s_order_info`;
CREATE TABLE `s_order_info`  (
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `order_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `total_count` int(11) NOT NULL,
  `total_price` decimal(10, 2) NOT NULL,
  `transit_price` decimal(10, 2) NOT NULL,
  `pay_method` smallint(6) NOT NULL,
  `status` smallint(6) NOT NULL,
  `addr_id` int(11) NOT NULL,
  `passport_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `s_order_info_addr_id_a4592912_fk_s_user_address_id`(`addr_id`) USING BTREE,
  INDEX `s_order_info_passport_id_cd2da7b2_fk_s_user_account_id`(`passport_id`) USING BTREE,
  CONSTRAINT `s_order_info_addr_id_a4592912_fk_s_user_address_id` FOREIGN KEY (`addr_id`) REFERENCES `s_user_address` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `s_order_info_passport_id_cd2da7b2_fk_s_user_account_id` FOREIGN KEY (`passport_id`) REFERENCES `s_user_account` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of s_order_info
-- ----------------------------
INSERT INTO `s_order_info` VALUES (0, '2021-05-16 15:02:47.018363', '2021-05-16 15:02:47.119412', '202105162302471', 6, 744.00, -10.00, 3, 1, 1, 1);
INSERT INTO `s_order_info` VALUES (0, '2021-05-16 15:07:44.449928', '2021-05-16 15:07:44.518255', '202105162307441', 2, 368.00, -10.00, 4, 1, 1, 1);
INSERT INTO `s_order_info` VALUES (0, '2021-05-17 06:29:53.488308', '2021-05-17 06:29:53.557382', '202105171429531', 4, 100.00, -10.00, 5, 1, 1, 1);
INSERT INTO `s_order_info` VALUES (0, '2021-05-20 13:26:50.969096', '2021-05-20 13:26:51.278817', '202105202126501', 5, 150.00, -10.00, 4, 1, 1, 1);

-- ----------------------------
-- Table structure for s_order_products
-- ----------------------------
DROP TABLE IF EXISTS `s_order_products`;
CREATE TABLE `s_order_products`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `count` int(11) NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `order_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `products_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `s_order_products_order_id_c0689ccd_fk_s_order_info_order_id`(`order_id`) USING BTREE,
  INDEX `s_order_products_products_id_c6d13370_fk_s_products_id`(`products_id`) USING BTREE,
  CONSTRAINT `s_order_products_order_id_c0689ccd_fk_s_order_info_order_id` FOREIGN KEY (`order_id`) REFERENCES `s_order_info` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `s_order_products_products_id_c6d13370_fk_s_products_id` FOREIGN KEY (`products_id`) REFERENCES `s_products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of s_order_products
-- ----------------------------
INSERT INTO `s_order_products` VALUES (4, 0, '2021-05-16 15:02:47.021870', '2021-05-16 15:02:47.021870', 1, 99.00, '202105162302471', 1);
INSERT INTO `s_order_products` VALUES (5, 0, '2021-05-16 15:02:47.048986', '2021-05-16 15:02:47.048986', 5, 129.00, '202105162302471', 4);
INSERT INTO `s_order_products` VALUES (6, 0, '2021-05-16 15:07:44.456952', '2021-05-16 15:07:44.456952', 1, 299.00, '202105162307441', 2);
INSERT INTO `s_order_products` VALUES (7, 0, '2021-05-16 15:07:44.476045', '2021-05-16 15:07:44.476045', 1, 69.00, '202105162307441', 3);
INSERT INTO `s_order_products` VALUES (8, 0, '2021-05-17 06:29:53.492302', '2021-05-17 06:29:53.492302', 2, 30.00, '202105171429531', 9);
INSERT INTO `s_order_products` VALUES (9, 0, '2021-05-17 06:29:53.510394', '2021-05-17 06:29:53.511393', 2, 20.00, '202105171429531', 8);
INSERT INTO `s_order_products` VALUES (10, 0, '2021-05-20 13:26:50.989051', '2021-05-20 13:26:50.989051', 1, 40.00, '202105202126501', 7);
INSERT INTO `s_order_products` VALUES (11, 0, '2021-05-20 13:26:51.196681', '2021-05-20 13:26:51.196681', 2, 40.00, '202105202126501', 28);
INSERT INTO `s_order_products` VALUES (12, 0, '2021-05-20 13:26:51.238275', '2021-05-20 13:26:51.238275', 2, 15.00, '202105202126501', 21);

-- ----------------------------
-- Table structure for s_products
-- ----------------------------
DROP TABLE IF EXISTS `s_products`;
CREATE TABLE `s_products`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `desc` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `unit` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stock` int(11) NOT NULL,
  `sales` int(11) NOT NULL,
  `detail` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` smallint(6) NOT NULL,
  `type_id_id` int(11) NOT NULL,
  `detail_image1` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `detail_image2` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `detail_image3` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `detail_image4` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `s_products_type_id_id_9ba7a182_fk_s_productstype_type_id`(`type_id_id`) USING BTREE,
  CONSTRAINT `s_products_type_id_id_9ba7a182_fk_s_productstype_type_id` FOREIGN KEY (`type_id_id`) REFERENCES `s_productstype` (`type_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of s_products
-- ----------------------------
INSERT INTO `s_products` VALUES (1, 0, '2021-05-16 14:54:44.178731', '2021-05-19 17:26:14.443471', 'Battlefield 4', 'XBOX disc', 10.00, NULL, 88, 3, '\"Battlefield 4\" is a first-person shooter game produced by Digital Illusions CE in Sweden and published by Electronic Arts.\r\nThis is a XBOX disc of Battlefield4.', 'products/u19810697151558617706fm26gp0_XNNmYkO.jpg', 1, 1, 'products/bf1.jpg', 'products/bf2.jpg', 'products/bf3.jpg', '');
INSERT INTO `s_products` VALUES (2, 0, '2021-05-16 14:55:27.994061', '2021-05-19 17:24:21.974579', 'COD:Cold war', 'PS4/PS5 Disc', 45.00, NULL, 76, 5, '\"Call of Duty: Black Ops Cold War\" is a first-person shooter game produced by Treyarch and released by Activision. It is also the 17th work in the \"Call of Duty\" game series. The game will lead players to the 1980s and explore the crisis-ridden political situation during the Cold War.\r\nThis is an installation disc for Call of Duty 17. This disc can only be used on PS4 and PS5.', 'products/u12496785231071030784fm224gp0_mBXc8tr.jpg', 1, 1, 'products/COD1.jpg', 'products/COD2.jpg', '', '');
INSERT INTO `s_products` VALUES (3, 0, '2021-05-16 14:58:12.482474', '2021-05-20 07:11:42.446271', 'Type90', 'Tank model', 19.00, NULL, 90, 12, 'This is a 1/35 Japan Ground self defense force TYPE 90 Tank model.\r\nThe model needs to be assembled and painted by yourself.You can find the model and assembly instructions in the box.', 'products/90_BcsPw9a.jfif', 1, 2, 'products/901.jpg', 'products/902.jpg', '', '');
INSERT INTO `s_products` VALUES (4, 0, '2021-05-16 14:59:08.046854', '2021-05-20 06:56:28.102276', 'Valentine MK.II', 'Tank model', 14.00, NULL, 72, 11, 'This is a 1/35 British tank Valentine mk.II model.\r\nThe model needs to be assembled and painted by yourself.You can find the model and assembly instructions in the box.', 'products/u32266351351822871147fm224gp0.jpg', 1, 2, 'products/V1.jpg', 'products/V2.jpg', 'products/V3.jpg', '');
INSERT INTO `s_products` VALUES (5, 0, '2021-05-16 15:00:09.401480', '2021-05-20 07:18:29.006575', 'Nike JEDI T-shirt', 'T-shirt', 14.00, NULL, 99, 13, 'A limited-edition Nike T-shirt for Star Wars events.', 'products/srchttp___i1.ygimg.cn_pics_nike_2014_99959115_99959115_01_l.jpg_3referhttp___i1.ygimg.jfif', 1, 3, 'products/srchttp___i1.ygimg.cn_pics_nike_2014_99959115_99959115_01_l.jpg_3referhttp___i_nvU6aqs.jfif', '', '', '');
INSERT INTO `s_products` VALUES (6, 0, '2021-05-17 04:41:56.934466', '2021-05-19 17:29:02.897018', 'Resident Evil:Vilage', 'Steam CDK', 55.00, NULL, 100, 33, '\"Resident Evil: Village\" is the sequel and finale of \"Resident Evil 7\". The game takes a village on the border of a certain Eastern European country as the stage. The story takes place a few years after \"Resident Evil 7\".\r\nSeveral years have passed since the tragedy of Baker\'s family... Ethan Winters, who survived the tragedy, lived peacefully with his wife Mia Winters and his daughter Rose under the aegis of the Bioterrorism Security Assessment Alliance \"BSAA\" .\r\nHowever, such a happy life was shattered by the attack of BSAA captain Chris Redfield. In order to regain the stolen daughter, Ethan embarks on the journey again.', 'products/srchttp___pic2.52pk.com_files_200621_7913996_103551_1.jpgreferhttp___pic2.52pk.jpg', 1, 1, 'products/RE1.jpg', 'products/RE2.jpg', 'products/RE3.jpg', 'products/RE4.jpg');
INSERT INTO `s_products` VALUES (7, 0, '2021-05-17 06:07:35.857441', '2021-05-20 13:26:50.994037', 'Forza Horizon 4', 'Steam CDK', 40.00, NULL, 199, 47, 'This is a Steam CDK of \"Forza Horizon 4\". After the user purchases this product, the system will automatically send the CDK to the user\'s mailbox.\r\nThe magnificent Great Britain, richer vehicles, and season-changing tracks make this racing game almost invincible. If you are a persistent and bohemian driver who wants to enjoy a free and unrestrained driving experience, then take this British travel guide, experience the unique charm of the honey stone architecture on Broadway, and ride on the shores of Lake House.', 'products/FORZA.jpg', 1, 1, 'products/FH1.jpg', 'products/FH2.jpg', 'products/FH3.jpg', 'products/FH4.jpg');
INSERT INTO `s_products` VALUES (8, 0, '2021-05-17 06:12:11.695305', '2021-05-19 17:15:38.680065', 'Death Stranding', 'Steam CDK', 20.00, NULL, 198, 21, '\"Death Stranding\" is an action game developed by Kojima Productions and released on November 8, 2019 by Sony Interactive Entertainment.\r\n\r\nThe protagonist Sam must bravely face the world unrecognizable due to death stranding, unite the existing society, and save human beings in different spaces.\r\n\r\nOn January 1, 2021, \"Death Stranding\" won the PC Gamer 2020 Game of the Year Award.', 'products/DS.jpg', 1, 1, 'products/DS1.jpg', 'products/DS3.jpg', 'products/DS2.jpg', '');
INSERT INTO `s_products` VALUES (9, 0, '2021-05-17 06:18:48.310886', '2021-05-19 17:18:22.135356', 'Sekiro', 'PS4 Disc', 30.00, NULL, 53, 4, '\"Sekiro: Shadows Die Twice\" is a third-person action-adventure sandbox game produced by From Software. Players will control a ninja to save his master and avenge his enemies.\r\n\r\nOn December 13, 2019, \"Sekiro: Shadows Die Twice\" won TGA 2019 Best Game of the Year', 'products/sekiro_wAhnjoz.jpg', 1, 1, 'products/sekiro1_BpsZK2m.jpg', 'products/sekiro2_qXXlUgI.jpg', 'products/sekiro3.jpg', '');
INSERT INTO `s_products` VALUES (10, 0, '2021-05-20 06:34:36.798149', '2021-05-20 06:39:44.401464', 'Cyberpunk 2077', 'Steam CDK', 40.00, NULL, 300, 77, 'Cyberpunk 2077 is an open-world, action-adventure role-playing video game, developed and published by CD Projekt RED that was released December 10, 2020.\r\nCyberpunk 2077 is a continuation of the events of Cyberpunk 2020, taking an alternate path to that of Cyberpunk V3.0. The game is set in the dystopian metropolis of Night City. It is set in the Free State of Northern California. Night City is located south of San Francisco around the area of Morro Bay, CA. During Cyberpunk 2020, Night City is said to have a population of more than five million inhabitants. However, this number is suspected to be considerably larger in 2077.\r\n\r\nFollowing an economic collapse sometime during the early 21st century, the United States is forced to rely on large corporations to survive. These corporations deal in a wide range of areas, such as weapons, robotics, cybernetics, pharmaceuticals, communications, and biotechnology; many of these companies operate above the law.\r\n\r\nThe game follows the story of V — a hired gun on the rise in Night City, the most violent and dangerous metropolis of the corporate-ruled future. A robust character creator will allow players to choose V\'s gender, visual appearance, as well as historical background — all of which may influence the shape of the game.', 'products/CP00.jpg', 1, 1, 'products/CP1.jpg', 'products/CP2.jpg', 'products/CP3.jpg', 'products/CP4.jpg');
INSERT INTO `s_products` VALUES (11, 0, '2021-05-20 06:47:42.876482', '2021-05-20 06:47:42.876482', 'Nioh 2', 'PS4 Disc', 35.00, NULL, 600, 111, 'Experience the thrill of taking on hordes of fearsome yokai in a battle to the death in this brutal masocore Action RPG.\r\nCreate your own original protagonist and embark on an adventure that will take you through devastated locales across Japan during the Sengoku period.', 'products/Nioh2jpg.jpg', 1, 1, 'products/N1.jpg', 'products/N2.jpg', 'products/N3.jpg', 'products/N4.jpg');
INSERT INTO `s_products` VALUES (12, 0, '2021-05-20 07:05:46.011443', '2021-05-20 13:20:38.353125', 'Yamato', 'Ship Model', 40.00, NULL, 100, 46, 'This is the assembled model of Tamiya\'s 1/350 Imperial Japanese Navy Yamato battleship. The box contains the assembled model and instructions.', 'products/Yamato.jpg', 1, 2, 'products/Yamto1.jpg', 'products/Yamato2.jpg', 'products/Yamto3.jpg', 'products/Yamto4.jpg');
INSERT INTO `s_products` VALUES (13, 0, '2021-05-20 07:11:08.801865', '2021-05-20 13:19:14.753701', 'King George V', 'Ship Model', 30.00, NULL, 222, 134, 'This is the assembled model of Tamiya’s 1/700 British Royal Navy battleship George V. The box contains the assembled model and instructions.', 'products/KGV.jpg', 1, 2, 'products/KGV1.jpg', 'products/KGV2.jpg', 'products/KGV3.jpg', '');
INSERT INTO `s_products` VALUES (14, 0, '2021-05-20 07:16:38.226849', '2021-05-20 07:16:38.226849', 'P51D', 'Airplane model', 25.00, NULL, 200, 117, 'This is the assembled model of the US Air Force P51D fighter. The box contains an assembled model and instructions.', 'products/P51D.jpg', 1, 2, 'products/P51D1.jpg', 'products/P51D2.jpg', 'products/P51D3.jpg', '');
INSERT INTO `s_products` VALUES (15, 0, '2021-05-20 07:22:12.581296', '2021-05-20 12:21:37.391513', 'Darth Vader T-shirt', 'T-shirt', 50.00, NULL, 99, 29, 'This is a Nike Darth Vader short-sleeved T-shirt. If you like Darth Vader in Star Wars, put on this dress and join him in the dark side.', 'products/Nike2.jpg', 1, 3, 'products/Nike2_Wn12d8I.jpg', '', '', '');
INSERT INTO `s_products` VALUES (16, 0, '2021-05-20 12:03:56.444110', '2021-05-20 12:03:56.444110', 'Nike Sweat pants', 'Pants', 19.00, NULL, 207, 83, 'This is Nike\'s black sports pants, which are suitable for summer.', 'products/N0.jpg', 1, 3, 'products/N0_okawNMC.jpg', 'products/N2_a9ja9wj.jpg', '', '');
INSERT INTO `s_products` VALUES (17, 0, '2021-05-20 12:05:17.571455', '2021-05-20 12:05:17.571455', 'Supreme pants', 'Pants', 30.00, NULL, 278, 123, 'This is Supreme\'s casual pant. The color of the pants is black and white. This pair of pants is very suitable for young people to wear in spring and autumn.', 'products/S0.jpg', 1, 3, 'products/S1.jpg', 'products/S2.jpg', 'products/S3.jpg', '');
INSERT INTO `s_products` VALUES (18, 0, '2021-05-20 12:05:56.854663', '2021-05-20 12:21:28.910027', 'Gundam T-shirt', 'T-shirt', 15.00, NULL, 300, 199, 'This is a T-shirt to commemorate the 40th anniversary of Mobile Suit Gundam. If you are also a fan of Gundam, then this is a good choice.', 'products/G1.jpg', 1, 3, 'products/G1_1lYojK1.jpg', 'products/G2.jpg', '', '');
INSERT INTO `s_products` VALUES (19, 0, '2021-05-20 12:06:41.885822', '2021-05-20 12:06:41.885822', 'Pokémon T-shirt', 'T-shirt', 15.00, NULL, 403, 127, 'This is a Pokémon co-branded T-shirt. If you are a fan of Pokémon, you will definitely like it.', 'products/P1.jpg', 1, 3, 'products/P1_Pvp5m3I.jpg', '', '', '');
INSERT INTO `s_products` VALUES (20, 0, '2021-05-20 12:07:32.104046', '2021-05-20 12:07:32.104046', 'Street Fighter T-shi', 'T-shirt', 20.00, NULL, 210, 133, 'This is a T-shirt co-branded by Street Fighter. Have you also had the experience of playing Street Fighter in your childhood? You won\'t mind having one more memory of your childhood in your shopping cart,right?', 'products/ST0.jpg', 1, 3, 'products/ST0_fZFmGX1.jpg', 'products/ST1.jpg', 'products/ST2.jpg', '');
INSERT INTO `s_products` VALUES (21, 0, '2021-05-20 12:14:22.891875', '2021-05-20 13:26:51.238777', 'Marvel T-shirt', 'T-shirt', 15.00, NULL, 198, 161, 'This is UNIQLO\'s Marvel co-branded T-shirt. If you like Spider-Man, then this is a great opportunity.', 'products/M1.gif', 1, 3, 'products/M1_oWfvP2l.gif', '', '', '');
INSERT INTO `s_products` VALUES (22, 0, '2021-05-20 12:20:35.085084', '2021-05-20 12:20:35.085084', 'GVK T-shirt', 'T-shirt', 20.00, NULL, 211, 106, 'This is UNIQLO\'s Godzilla vs. King Kong joint T-shirt. It must be cool to wear it to the cinema.', 'products/GVK00.png', 1, 3, 'products/GVK.jpg', '', '', '');
INSERT INTO `s_products` VALUES (23, 0, '2021-05-20 12:27:19.152509', '2021-05-20 12:27:19.152509', 'Demon Slayer T-shirt', 'T-shirt', 25.00, NULL, 611, 177, 'This is a Uniqlo Demon Slayer  joint T-shirt. If you are interested in Demon Slayer, then this dress is definitely for you.', 'products/DS1_tqOEjKR.jpg', 1, 3, 'products/DS1_8DLKjJr.jpg', '', '', '');
INSERT INTO `s_products` VALUES (24, 0, '2021-05-20 12:37:04.170694', '2021-05-20 12:37:04.170694', 'Devil May Cry5', 'Steam CDK', 30.00, NULL, 100, 37, 'Devil May Cry 5 is a 2019 action-adventure game developed and published by Capcom. It is the sixth installment in the franchise (not counting mobile games) and the fifth installment of the mainline Devil May Cry series. Capcom released it for Microsoft Windows, PlayStation 4, and Xbox One on 8 March 2019.', 'products/DMC0.jpg', 1, 1, 'products/DMC1.jpg', 'products/DMC2.jpg', 'products/DMC3.jpg', 'products/DMC4.jpg');
INSERT INTO `s_products` VALUES (25, 0, '2021-05-20 12:42:51.653622', '2021-05-20 12:42:51.653622', 'Monster Hunter:Rise', 'Switch disc', 30.00, NULL, 200, 132, 'Monster Hunter Rise is an action role-playing game developed and published by Capcom for the Nintendo Switch. Released worldwide on March 26, 2021. A Microsoft Windows version is currently in development and is planned for an early 2022 release.', 'products/MHR000.jpg', 1, 1, 'products/MHR0.jpg', 'products/MHR2.jpg', 'products/MHR3.jpg', 'products/MHR.jpg');
INSERT INTO `s_products` VALUES (26, 0, '2021-05-20 12:48:45.884825', '2021-05-20 13:19:23.742868', '1989 Benz C9', 'Car model', 30.00, NULL, 300, 109, 'This is a 1/24 assembled model of the 1989 Sauber-Mercedes C9. The box contains the assembled model and instructions.', 'products/MB0.jpg', 1, 2, 'products/MB1.jpg', 'products/MB2.jpg', 'products/MB3.jpg', 'products/MB4.jpg');
INSERT INTO `s_products` VALUES (27, 0, '2021-05-20 12:53:10.626563', '2021-05-20 12:55:54.901945', 'Battelship Bismarck', 'Ship Model', 50.00, NULL, 200, 134, 'This is a 1/350 assembled model of the German naval battleship Bismarck. The box contains the assembled model and instructions.', 'products/BSM0.jpg', 1, 2, 'products/BSM1.jpg', 'products/BSM4.png', '', '');
INSERT INTO `s_products` VALUES (28, 0, '2021-05-20 13:01:03.413386', '2021-05-20 13:26:51.196681', 'Mercedes AMG GT3', 'Car model', 40.00, NULL, 298, 203, 'This is the assembled model of Tamiya’s 1/24 Mercedes AMG GT3. The box contains the assembled model and instructions.', 'products/B00.jpg', 1, 2, 'products/B0.jpg', 'products/B1.jpg', 'products/B2.jpg', 'products/B3.jpg');
INSERT INTO `s_products` VALUES (29, 0, '2021-05-20 13:08:59.931739', '2021-05-20 13:08:59.931739', 'F35 fighter', 'Airplane model', 20.00, NULL, 300, 177, 'This is the assembled model of Hasegawa\'s 1/72 American F35 fighter. The box contains the assembled model and instructions.', 'products/F00.jpg', 1, 2, 'products/F1.jpg', 'products/F3.jpg', '', '');
INSERT INTO `s_products` VALUES (30, 0, '2021-05-20 13:17:23.515056', '2021-05-20 13:17:23.515056', 'Tiger I', 'Tank model', 20.00, NULL, 200, 101, 'This is Tamiya’s 1/35 German Panzerkampfwagen VI Ausf. E Tiger I assembled model. The box contains the assembled model and instructions.', 'products/T0.jpg', 1, 2, 'products/a.jpg', 'products/a2.jpg', '', '');

-- ----------------------------
-- Table structure for s_productstype
-- ----------------------------
DROP TABLE IF EXISTS `s_productstype`;
CREATE TABLE `s_productstype`  (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `c_time` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of s_productstype
-- ----------------------------
INSERT INTO `s_productstype` VALUES (1, 'Games', 'typelogo/srchttp___img.pc841.com_2018_0117_20180117064121944.jpgreferhttp___img.pc841_5yn5KiV.jfif', '2021-05-16 14:52:13.953759');
INSERT INTO `s_productstype` VALUES (2, 'Model', 'typelogo/Model_gCoToV8.jfif', '2021-05-16 14:56:22.692444');
INSERT INTO `s_productstype` VALUES (3, 'Wear', 'typelogo/wear_hZ5FWVx.jfif', '2021-05-16 14:56:30.550242');

-- ----------------------------
-- Table structure for s_user_account
-- ----------------------------
DROP TABLE IF EXISTS `s_user_account`;
CREATE TABLE `s_user_account`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of s_user_account
-- ----------------------------
INSERT INTO `s_user_account` VALUES (1, 0, '2021-05-16 15:00:50.245846', '2021-05-16 15:00:50.246846', 'aaa', '7e240de74fb1ed08fa08d38063f6a6a91462a815', 'aaa@123.com', 0);

-- ----------------------------
-- Table structure for s_user_address
-- ----------------------------
DROP TABLE IF EXISTS `s_user_address`;
CREATE TABLE `s_user_address`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NULL DEFAULT NULL,
  `update_time` datetime(6) NULL DEFAULT NULL,
  `recipient_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `recipient_addr` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `zip_code` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `recipient_phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `passport_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `s_user_address_passport_id_18acf96e_fk_s_user_account_id`(`passport_id`) USING BTREE,
  CONSTRAINT `s_user_address_passport_id_18acf96e_fk_s_user_account_id` FOREIGN KEY (`passport_id`) REFERENCES `s_user_account` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of s_user_address
-- ----------------------------
INSERT INTO `s_user_address` VALUES (1, 0, '2021-05-16 15:01:58.415405', '2021-05-16 15:01:58.415405', 'aaa', 'China Ningbo', '315700', '123456789', 1, 1);

SET FOREIGN_KEY_CHECKS = 1;

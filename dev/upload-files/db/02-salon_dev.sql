/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80033 (8.0.33)
 Source Host           : localhost:3306
 Source Schema         : salon_dev

 Target Server Type    : MySQL
 Target Server Version : 80033 (8.0.33)
 File Encoding         : 65001

 Date: 18/11/2024 12:15:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

USE salon_dev;

-- ----------------------------
-- Table structure for booking
-- ----------------------------
DROP TABLE IF EXISTS `booking`;
CREATE TABLE `booking` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `user_id` int unsigned NOT NULL,
  `service_version_id` int unsigned NOT NULL,
  `service_man_id` int unsigned NOT NULL,
  `payment_id` int unsigned DEFAULT NULL,
  `coupon_id` int unsigned DEFAULT NULL,
  `booking_status` enum('pending','confirmed','in_progress','completed','cancelled','no_show') DEFAULT 'pending',
  `booking_date` datetime NOT NULL,
  `duration` int unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `discounted_price` decimal(10,2) DEFAULT NULL,
  `discount_amount` decimal(10,2) DEFAULT NULL,
  `notes` text,
  `cancellation_reason` text,
  `cancelled_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `cancelled_by_id` int unsigned DEFAULT NULL,
  `confirmed_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_booking_payment_id` (`payment_id`),
  KEY `idx_booking_coupon_id` (`coupon_id`),
  KEY `idx_booking_user_id` (`user_id`),
  KEY `idx_booking_service_version_id` (`service_version_id`),
  KEY `idx_booking_service_man_id` (`service_man_id`),
  KEY `idx_booking_cancelled_by_id` (`cancelled_by_id`),
  CONSTRAINT `fk_booking_cancelled_by` FOREIGN KEY (`cancelled_by_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_booking_service_man` FOREIGN KEY (`service_man_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_booking_service_version` FOREIGN KEY (`service_version_id`) REFERENCES `service_version` (`id`),
  CONSTRAINT `fk_booking_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_coupon_bookings` FOREIGN KEY (`coupon_id`) REFERENCES `coupon` (`id`),
  CONSTRAINT `fk_payment_booking` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of booking
-- ----------------------------
BEGIN;
INSERT INTO `booking` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_version_id`, `service_man_id`, `payment_id`, `coupon_id`, `booking_status`, `booking_date`, `duration`, `price`, `discounted_price`, `discount_amount`, `notes`, `cancellation_reason`, `cancelled_at`, `completed_at`, `cancelled_by_id`, `confirmed_date`) VALUES (5, 'active', '2024-11-13 06:19:03.539', '2024-11-13 09:16:20.922', 19, 5, 2, NULL, NULL, 'completed', '2024-11-14 14:30:00', 0, 170000.00, NULL, 0.00, 'Special instructions for the service', '', NULL, '2024-11-13 09:16:21', NULL, '2024-11-13 06:37:04');
INSERT INTO `booking` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_version_id`, `service_man_id`, `payment_id`, `coupon_id`, `booking_status`, `booking_date`, `duration`, `price`, `discounted_price`, `discount_amount`, `notes`, `cancellation_reason`, `cancelled_at`, `completed_at`, `cancelled_by_id`, `confirmed_date`) VALUES (6, 'active', '2024-11-14 12:43:51.392', '2024-11-14 12:43:51.392', 19, 5, 2, 1, NULL, 'pending', '2024-11-14 14:30:00', 0, 170000.00, NULL, 0.00, 'Special instructions for the service', '', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(100) NOT NULL,
  `description` longtext,
  `image` varchar(255) NOT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_category_code` (`code`),
  KEY `idx_parent_id` (`parent_id`),
  CONSTRAINT `fk_category_parent` FOREIGN KEY (`parent_id`) REFERENCES `category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_category_sub_categories` FOREIGN KEY (`parent_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of category
-- ----------------------------
BEGIN;
INSERT INTO `category` (`id`, `status`, `created_at`, `updated_at`, `name`, `code`, `description`, `image`, `parent_id`) VALUES (13, 'active', '2024-10-20 16:04:33.151', '2024-10-22 16:49:39.208', 'Gắn Móng', 'NAIL', 'Gắn móng giả', 'category/image/3srLErYxdoMerk_28951445.png.png', 16);
INSERT INTO `category` (`id`, `status`, `created_at`, `updated_at`, `name`, `code`, `description`, `image`, `parent_id`) VALUES (14, 'active', '2024-10-20 16:35:25.351', '2024-10-24 02:40:47.956', 'Trang Điểm', 'MAKE_UP', 'Trang điểm tiệc cưới, party, đặt biệt và theo yêu cầu', 'category/image/3stY2xCQzCPRye_img-test1.avif.avif', NULL);
INSERT INTO `category` (`id`, `status`, `created_at`, `updated_at`, `name`, `code`, `description`, `image`, `parent_id`) VALUES (16, 'active', '2024-10-22 11:40:03.516', '2024-10-22 11:41:44.742', 'Làm Móng', 'LAM_MONG', 'Làm Móng', 'category/image/3w5rMLKLTUiANS_fujinet.png.png', NULL);
COMMIT;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `service_id` int unsigned DEFAULT NULL,
  `content` text,
  `rate` decimal(2,1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_comment_user_id` (`user_id`),
  KEY `idx_comment_service_id` (`service_id`),
  CONSTRAINT `fk_service_comments` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`),
  CONSTRAINT `fk_user_comments` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of comment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `code` varchar(20) NOT NULL,
  `description` text,
  `discount_type` enum('percentage','fixed_price') NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `min_spend` decimal(10,2) DEFAULT NULL,
  `max_discount` decimal(10,2) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `usage_limit` bigint DEFAULT NULL,
  `usage_count` bigint DEFAULT '0',
  `creator_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_coupon_code` (`code`),
  KEY `idx_coupon_creator_id` (`creator_id`),
  CONSTRAINT `fk_coupon_creator` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of coupon
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for enrollment
-- ----------------------------
DROP TABLE IF EXISTS `enrollment`;
CREATE TABLE `enrollment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `service_version_id` int unsigned DEFAULT NULL,
  `payment_id` int unsigned DEFAULT NULL,
  `enrolled_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_enrollment_user_id` (`user_id`),
  KEY `idx_enrollment_service_version_id` (`service_version_id`),
  KEY `idx_enrollment_payment_id` (`payment_id`),
  CONSTRAINT `fk_enrollment_payment` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_payment_enrollments` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`),
  CONSTRAINT `fk_service_version_enrollments` FOREIGN KEY (`service_version_id`) REFERENCES `service_version` (`id`),
  CONSTRAINT `fk_user_enrollments` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of enrollment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `service_id` int unsigned DEFAULT NULL,
  `url` text,
  PRIMARY KEY (`id`),
  KEY `idx_image_user_id` (`user_id`),
  KEY `idx_image_service_id` (`service_id`),
  CONSTRAINT `fk_image_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_service_images` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of image
-- ----------------------------
BEGIN;
INSERT INTO `image` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_id`, `url`) VALUES (1, 'active', '2024-10-26 16:43:09.558', '2024-10-26 16:43:09.558', 2, 19, 'service/3zL5mcALDXwVn8/image/3zL5mcALDXwVn8_img-test-2.avif.avif');
INSERT INTO `image` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_id`, `url`) VALUES (2, 'active', '2024-10-27 17:24:00.941', '2024-10-27 17:24:00.941', 2, 5, 'service/3mKb6MVZRt6cdi/image/3mKb6MVZRt6cdi_img-test1.avif.avif');
INSERT INTO `image` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_id`, `url`) VALUES (3, 'active', '2024-11-04 02:51:25.692', '2024-11-04 02:51:25.692', 2, 5, 'service/3mKb6MVZRt6cdi/image/3mKb6MVZRt6cdi_img-test-2.avif.avif');
COMMIT;

-- ----------------------------
-- Table structure for otp
-- ----------------------------
DROP TABLE IF EXISTS `otp`;
CREATE TABLE `otp` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `user_id` int unsigned NOT NULL,
  `otp` varchar(6) DEFAULT NULL,
  `ttl` smallint NOT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `passed_at` timestamp NULL DEFAULT NULL,
  `uuid` varchar(50) DEFAULT NULL,
  `esmsid` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_otp_otp` (`otp`),
  UNIQUE KEY `idx_otp_uuid` (`uuid`),
  KEY `idx_otp_user_id` (`user_id`),
  CONSTRAINT `fk_user_ot_ps` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of otp
-- ----------------------------
BEGIN;
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (17, 'active', '2024-11-09 17:23:33.928', '2024-11-09 17:24:40.831', 19, '419430', 0, '2024-11-09 17:28:34', '2024-11-09 17:24:41', '7698cf26-f7a4-4037-9351-4a4e3a806d7c', 'e36a7723d3eb4e01983669382d5492fa198');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (18, 'active', '2024-11-10 12:32:50.122', '2024-11-10 12:33:39.806', 19, '886184', 5, '2024-11-10 12:37:50', '2024-11-10 12:33:40', '5c15e82a-951c-4a35-97c7-ed7aa761c3d9', '619a827c795849fda02f0b83e70aa072199');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (19, 'active', '2024-11-12 05:25:44.572', '2024-11-12 05:26:10.573', 19, '218059', 5, '2024-11-12 05:30:45', '2024-11-12 05:26:11', 'd8b843f3-80fe-4746-9978-514d335ba8e4', 'fbc2b0f1ef0b47ac82c2712bf053c428213');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (21, 'active', '2024-11-13 06:07:29.299', '2024-11-13 06:08:18.379', 22, '022958', 5, '2024-11-13 06:12:29', '2024-11-13 06:08:18', 'd29a041b-89e3-4bbc-86a8-db4ce51f2de0', '117f2ea1af804b39a7f451b6ea69ce38219');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (22, 'active', '2024-11-13 06:14:47.123', '2024-11-13 06:15:28.058', 19, '674198', 5, '2024-11-13 06:19:47', '2024-11-13 06:15:28', 'e9d53cbb-1d59-4588-956d-04d3341c4055', '797ad95d2c314027af2ef40810ad91ec174');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (23, 'active', '2024-11-13 06:28:35.622', '2024-11-13 06:31:16.011', 19, '132108', 5, '2024-11-13 06:33:36', '2024-11-13 06:31:16', '14fb2718-ff1d-4a55-89df-3379c2de40b2', '91abeee140a04de79b9384eb94a7c6b5126');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (24, 'active', '2024-11-13 06:41:15.647', '2024-11-13 06:41:40.863', 19, '204017', 5, '2024-11-13 06:46:16', '2024-11-13 06:41:41', '64ddc648-8435-4f15-9577-9acb4001cac1', '1e5dc8c4f76941d1a0ca4a11aca5c4da227');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (25, 'active', '2024-11-14 07:29:17.912', '2024-11-14 07:29:37.145', 19, '587062', 5, '2024-11-14 07:34:18', '2024-11-14 07:29:37', 'ffafc6b8-a543-4ed8-81de-0bd111fa2918', 'f8b8f107cf034bbdab1d2dce25e41a5d292');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (26, 'active', '2024-11-14 12:42:23.658', '2024-11-14 12:43:26.155', 19, '773073', 5, '2024-11-14 12:47:24', '2024-11-14 12:43:26', '273fa54e-8b2c-404e-9ae5-0fb081512d1e', 'b3483512914b4387ae3622be57e2f866137');
COMMIT;

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `user_id` int unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(3) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `transaction_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_payment_transaction_id` (`transaction_id`),
  KEY `fk_payment_user` (`user_id`),
  CONSTRAINT `fk_payment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of payment
-- ----------------------------
BEGIN;
INSERT INTO `payment` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `amount`, `currency`, `payment_method`, `transaction_id`, `transaction_status`) VALUES (1, 'active', '2024-11-14 12:43:51.390', '2024-11-14 12:43:51.390', 19, 170000.00, 'VND', 'cash', '', 'pending');
COMMIT;

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `code` varchar(50) NOT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_permission_name` (`name`),
  UNIQUE KEY `idx_permission_code` (`code`),
  UNIQUE KEY `uni_permission_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of permission
-- ----------------------------
BEGIN;
INSERT INTO `permission` (`id`, `status`, `created_at`, `updated_at`, `name`, `code`, `description`) VALUES (1, 'active', '2024-10-20 16:11:57.144', '2024-10-20 16:11:57.144', 'Manage Roles', 'MANAGE_ROLE', '');
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `code` varchar(50) NOT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_role_name` (`name`),
  UNIQUE KEY `idx_role_code` (`code`),
  UNIQUE KEY `uni_role_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` (`id`, `status`, `created_at`, `updated_at`, `name`, `code`, `description`) VALUES (1, 'active', NULL, NULL, 'User', 'USER', NULL);
INSERT INTO `role` (`id`, `status`, `created_at`, `updated_at`, `name`, `code`, `description`) VALUES (2, 'active', NULL, '2024-10-22 17:07:56.851', 'Super Admin', 'SUPER_ADMIN', NULL);
INSERT INTO `role` (`id`, `status`, `created_at`, `updated_at`, `name`, `code`, `description`) VALUES (4, 'active', '2024-10-23 09:12:07.467', '2024-10-23 09:12:07.467', 'Provider', 'PROVIDER', '');
COMMIT;

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `role_id` int unsigned NOT NULL,
  `permission_id` int unsigned NOT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `create_permission` tinyint(1) DEFAULT '0',
  `read_permission` tinyint(1) DEFAULT '0',
  `write_permission` tinyint(1) DEFAULT '0',
  `delete_permission` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `fk_role_permission_permission` (`permission_id`),
  CONSTRAINT `fk_permission_role_permission` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`),
  CONSTRAINT `fk_role_permission_permission` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`),
  CONSTRAINT `fk_role_permission_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `fk_role_role_permission` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
BEGIN;
INSERT INTO `role_permission` (`role_id`, `permission_id`, `created_at`, `updated_at`, `create_permission`, `read_permission`, `write_permission`, `delete_permission`) VALUES (2, 1, '2024-10-22 17:07:56.854', '2024-10-22 17:07:56.854', 0, 0, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for service
-- ----------------------------
DROP TABLE IF EXISTS `service`;
CREATE TABLE `service` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `creator_id` int unsigned DEFAULT NULL,
  `service_version_id` int unsigned DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `rating_count` int unsigned DEFAULT NULL,
  `review_info` json DEFAULT NULL,
  `avg_rating` decimal(3,1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_service_creator_id` (`creator_id`),
  KEY `fk_service_service_version` (`service_version_id`),
  CONSTRAINT `fk_service_service_version` FOREIGN KEY (`service_version_id`) REFERENCES `service_version` (`id`),
  CONSTRAINT `fk_user_created_services` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of service
-- ----------------------------
BEGIN;
INSERT INTO `service` (`id`, `status`, `created_at`, `updated_at`, `creator_id`, `service_version_id`, `slug`, `rating_count`, `review_info`, `avg_rating`) VALUES (5, 'active', '2024-10-26 03:42:34.958', '2024-11-05 16:15:19.563', 2, 5, 'dan-mong-hinh-buom-3d', 0, 'null', 0.0);
INSERT INTO `service` (`id`, `status`, `created_at`, `updated_at`, `creator_id`, `service_version_id`, `slug`, `rating_count`, `review_info`, `avg_rating`) VALUES (18, 'inactive', '2024-10-26 16:42:12.471', '2024-10-26 16:42:12.485', 2, 3, 'asd', 0, 'null', 0.0);
INSERT INTO `service` (`id`, `status`, `created_at`, `updated_at`, `creator_id`, `service_version_id`, `slug`, `rating_count`, `review_info`, `avg_rating`) VALUES (19, 'inactive', '2024-10-26 16:43:08.902', '2024-10-28 03:13:10.419', 2, 4, 'asd', 0, 'null', 0.0);
COMMIT;

-- ----------------------------
-- Table structure for service_version
-- ----------------------------
DROP TABLE IF EXISTS `service_version`;
CREATE TABLE `service_version` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `service_id` int unsigned NOT NULL,
  `intro_video_id` int unsigned DEFAULT NULL,
  `category_id` int unsigned DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `thumbnail` text,
  `price` decimal(10,2) NOT NULL,
  `discounted_price` decimal(10,2) DEFAULT NULL,
  `sub_category_id` int unsigned DEFAULT NULL,
  `duration` int unsigned NOT NULL,
  `published_date` datetime DEFAULT NULL,
  `main_image_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_service_version_service_id` (`service_id`),
  KEY `idx_service_version_intro_video_id` (`intro_video_id`),
  KEY `idx_service_version_category_id` (`category_id`),
  KEY `idx_service_version_sub_category_id` (`sub_category_id`),
  KEY `idx_service_version_main_image_id` (`main_image_id`),
  CONSTRAINT `fk_category_service_versions` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `fk_service_version_main_image` FOREIGN KEY (`main_image_id`) REFERENCES `image` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_service_version_sub_category` FOREIGN KEY (`sub_category_id`) REFERENCES `category` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_service_versions` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`),
  CONSTRAINT `fk_video_service_version` FOREIGN KEY (`intro_video_id`) REFERENCES `video` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of service_version
-- ----------------------------
BEGIN;
INSERT INTO `service_version` (`id`, `status`, `created_at`, `updated_at`, `service_id`, `intro_video_id`, `category_id`, `title`, `description`, `thumbnail`, `price`, `discounted_price`, `sub_category_id`, `duration`, `published_date`, `main_image_id`) VALUES (2, 'inactive', '2024-10-26 03:42:34.969', '2024-11-07 06:34:04.527', 5, NULL, 16, 'Dán móng hình bướm 3D 123', '<p>Dán móng giả hình bướm 3D</p>', '', 250000.00, 170000.00, 13, 900, NULL, 2);
INSERT INTO `service_version` (`id`, `status`, `created_at`, `updated_at`, `service_id`, `intro_video_id`, `category_id`, `title`, `description`, `thumbnail`, `price`, `discounted_price`, `sub_category_id`, `duration`, `published_date`, `main_image_id`) VALUES (3, 'inactive', '2024-10-26 16:42:12.478', '2024-10-26 16:42:12.478', 18, NULL, 16, 'asd', '<p>123</p>', '', 123.00, 111.00, 13, 900, NULL, NULL);
INSERT INTO `service_version` (`id`, `status`, `created_at`, `updated_at`, `service_id`, `intro_video_id`, `category_id`, `title`, `description`, `thumbnail`, `price`, `discounted_price`, `sub_category_id`, `duration`, `published_date`, `main_image_id`) VALUES (4, 'inactive', '2024-10-26 16:43:08.908', '2024-10-28 03:13:10.419', 19, NULL, 16, 'Test service 2', '<p>123</p>', '', 123.00, 111.00, 13, 900, NULL, NULL);
INSERT INTO `service_version` (`id`, `status`, `created_at`, `updated_at`, `service_id`, `intro_video_id`, `category_id`, `title`, `description`, `thumbnail`, `price`, `discounted_price`, `sub_category_id`, `duration`, `published_date`, `main_image_id`) VALUES (5, 'active', '2024-10-28 16:35:51.440', '2024-11-05 16:15:19.567', 5, NULL, 16, 'Dán móng hình bướm 3D', '<p>Dán móng giả hình bướm 3D</p>', '', 300000.00, 170000.00, 13, 900, '2024-11-01 13:43:07', NULL);
COMMIT;

-- ----------------------------
-- Table structure for service_version_images
-- ----------------------------
DROP TABLE IF EXISTS `service_version_images`;
CREATE TABLE `service_version_images` (
  `service_version_id` int unsigned NOT NULL,
  `image_id` int unsigned NOT NULL,
  `order` int unsigned DEFAULT NULL,
  PRIMARY KEY (`service_version_id`,`image_id`),
  KEY `idx_service_version_images_service_version_id` (`service_version_id`),
  KEY `idx_service_version_images_image_id` (`image_id`),
  KEY `idx_service_version_images_order` (`order`),
  CONSTRAINT `fk_service_version_images_image` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_service_version_images_service_version` FOREIGN KEY (`service_version_id`) REFERENCES `service_version` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of service_version_images
-- ----------------------------
BEGIN;
INSERT INTO `service_version_images` (`service_version_id`, `image_id`, `order`) VALUES (2, 2, NULL);
INSERT INTO `service_version_images` (`service_version_id`, `image_id`, `order`) VALUES (2, 3, NULL);
COMMIT;

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `tag_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `idx_tags_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tags
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `lastname` longtext,
  `firstname` longtext,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `salt` longtext,
  `password` longtext,
  `phone_number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_email` (`email`),
  UNIQUE KEY `idx_user_phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `status`, `created_at`, `updated_at`, `lastname`, `firstname`, `email`, `salt`, `password`, `phone_number`) VALUES (2, 'active', '2024-10-19 06:27:01.372', '2024-10-23 14:25:57.096', 'Bui', 'Bruce', 'abcd123@gmail.com', 'ZxAZlxFcegSamEAwYboJmXUAxcCstCnPvOFXsQpCBQEXBZVaGF', '6bce0b89fc1ee3276c95946396a1acd6', NULL);
INSERT INTO `user` (`id`, `status`, `created_at`, `updated_at`, `lastname`, `firstname`, `email`, `salt`, `password`, `phone_number`) VALUES (3, 'active', '2024-10-23 09:06:30.820', '2024-10-23 09:12:17.966', 'One', 'Customer', 'customer1@gmail.com', 'ABkwAUMyWNYkxBGyhuNGcUOkDTxzPxcyAxNMtRYqqlQSRrAdFC', 'aa167effd0123cfcb39daf6ffd3e1829', NULL);
INSERT INTO `user` (`id`, `status`, `created_at`, `updated_at`, `lastname`, `firstname`, `email`, `salt`, `password`, `phone_number`) VALUES (19, 'active', '2024-11-09 17:23:33.927', '2024-11-09 17:24:40.829', 'PhoneNumber', 'Customer', '', '', '', '0358921740');
INSERT INTO `user` (`id`, `status`, `created_at`, `updated_at`, `lastname`, `firstname`, `email`, `salt`, `password`, `phone_number`) VALUES (22, 'active', '2024-11-13 06:07:29.295', '2024-11-13 06:08:18.378', 'PhoneNumber', 'Provider', '01234567890', '', '', '01234567890');
COMMIT;

-- ----------------------------
-- Table structure for user_auth
-- ----------------------------
DROP TABLE IF EXISTS `user_auth`;
CREATE TABLE `user_auth` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `auth_type` varchar(20) NOT NULL,
  `auth_provider_id` varchar(255) DEFAULT NULL,
  `auth_provider_token` longtext,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `phone_number_verify_status` enum('verified','unverified') NOT NULL DEFAULT 'unverified',
  PRIMARY KEY (`id`),
  KEY `idx_user_auth_user_id` (`user_id`),
  CONSTRAINT `fk_user_auths` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_auth
-- ----------------------------
BEGIN;
INSERT INTO `user_auth` (`id`, `user_id`, `auth_type`, `auth_provider_id`, `auth_provider_token`, `status`, `created_at`, `updated_at`, `phone_number_verify_status`) VALUES (2, 2, 'password', '', '', 'active', NULL, NULL, 'unverified');
INSERT INTO `user_auth` (`id`, `user_id`, `auth_type`, `auth_provider_id`, `auth_provider_token`, `status`, `created_at`, `updated_at`, `phone_number_verify_status`) VALUES (3, 3, 'password', '', '', 'active', NULL, NULL, 'unverified');
INSERT INTO `user_auth` (`id`, `user_id`, `auth_type`, `auth_provider_id`, `auth_provider_token`, `status`, `created_at`, `updated_at`, `phone_number_verify_status`) VALUES (19, 19, 'phone_number', '', '', 'active', '2024-11-09 17:23:33.927', '2024-11-09 17:23:33.927', 'unverified');
INSERT INTO `user_auth` (`id`, `user_id`, `auth_type`, `auth_provider_id`, `auth_provider_token`, `status`, `created_at`, `updated_at`, `phone_number_verify_status`) VALUES (21, 22, 'phone_number', '', '', 'active', '2024-11-13 06:07:29.296', '2024-11-13 06:07:29.296', 'unverified');
COMMIT;

-- ----------------------------
-- Table structure for user_profile
-- ----------------------------
DROP TABLE IF EXISTS `user_profile`;
CREATE TABLE `user_profile` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `profile_picture_url` varchar(255) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `biography` text,
  `linkedin` varchar(255) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `instagram` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_profile_user_id` (`user_id`),
  CONSTRAINT `fk_user_user_profile` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_profile
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_id` int unsigned NOT NULL,
  `role_id` int unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `fk_user_role_role` (`role_id`),
  CONSTRAINT `fk_user_role_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `fk_user_role_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_role
-- ----------------------------
BEGIN;
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (19, 1);
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (2, 2);
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (2, 4);
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (3, 4);
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (22, 4);
COMMIT;

-- ----------------------------
-- Table structure for user_service
-- ----------------------------
DROP TABLE IF EXISTS `user_service`;
CREATE TABLE `user_service` (
  `service_version_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  PRIMARY KEY (`service_version_id`,`user_id`),
  KEY `fk_user_service_user` (`user_id`),
  CONSTRAINT `fk_user_service_service_version` FOREIGN KEY (`service_version_id`) REFERENCES `service_version` (`id`),
  CONSTRAINT `fk_user_service_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_service
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for video
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `service_version_id` int unsigned DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext,
  `video_url` varchar(255) NOT NULL,
  `raw_video_url` varchar(255) NOT NULL,
  `thumbnail_url` varchar(255) NOT NULL,
  `duration` bigint DEFAULT NULL,
  `order` bigint DEFAULT NULL,
  `allow_preview` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_video_service_version_id` (`service_version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of video
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for video_process_info
-- ----------------------------
DROP TABLE IF EXISTS `video_process_info`;
CREATE TABLE `video_process_info` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `video_id` int unsigned NOT NULL,
  `process_resolution` enum('360p','480p','720p','1080p') DEFAULT NULL,
  `process_state` enum('pending','inqueue','processing','done','error') DEFAULT 'pending',
  `process_error` text,
  `process_retry` smallint unsigned DEFAULT '0',
  `process_progress` smallint unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_video_process_info_video_id` (`video_id`),
  CONSTRAINT `fk_video_process_infos` FOREIGN KEY (`video_id`) REFERENCES `video` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of video_process_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for video_tags
-- ----------------------------
DROP TABLE IF EXISTS `video_tags`;
CREATE TABLE `video_tags` (
  `tag_tag_id` bigint unsigned NOT NULL,
  `video_id` int unsigned NOT NULL,
  PRIMARY KEY (`tag_tag_id`,`video_id`),
  KEY `fk_video_tags_video` (`video_id`),
  CONSTRAINT `fk_video_tags_tag` FOREIGN KEY (`tag_tag_id`) REFERENCES `tags` (`tag_id`),
  CONSTRAINT `fk_video_tags_video` FOREIGN KEY (`video_id`) REFERENCES `video` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of video_tags
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

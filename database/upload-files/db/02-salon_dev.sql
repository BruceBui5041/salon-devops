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

 Date: 05/02/2025 16:55:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
  `commission_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_booking_payment_id` (`payment_id`),
  KEY `idx_booking_coupon_id` (`coupon_id`),
  KEY `idx_booking_user_id` (`user_id`),
  KEY `idx_booking_service_man_id` (`service_man_id`),
  KEY `idx_booking_cancelled_by_id` (`cancelled_by_id`),
  KEY `idx_booking_commission_id` (`commission_id`),
  CONSTRAINT `fk_booking_cancelled_by` FOREIGN KEY (`cancelled_by_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_booking_commission` FOREIGN KEY (`commission_id`) REFERENCES `commission` (`id`),
  CONSTRAINT `fk_booking_service_man` FOREIGN KEY (`service_man_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_booking_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_coupon_bookings` FOREIGN KEY (`coupon_id`) REFERENCES `coupon` (`id`),
  CONSTRAINT `fk_payment_booking` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of booking
-- ----------------------------
BEGIN;
INSERT INTO `booking` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_man_id`, `payment_id`, `coupon_id`, `booking_status`, `booking_date`, `duration`, `price`, `discounted_price`, `discount_amount`, `notes`, `cancellation_reason`, `cancelled_at`, `completed_at`, `cancelled_by_id`, `confirmed_date`, `commission_id`) VALUES (21, 'active', '2025-01-11 09:06:57.219', '2025-01-11 09:12:16.263', 19, 2, 20, NULL, 'completed', '2025-01-14 14:30:00', 900, 300000.00, 170000.00, 0.00, 'Special instructions for the service', '', NULL, '2025-01-11 09:12:16', NULL, '2025-01-11 09:07:33', NULL);
INSERT INTO `booking` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_man_id`, `payment_id`, `coupon_id`, `booking_status`, `booking_date`, `duration`, `price`, `discounted_price`, `discount_amount`, `notes`, `cancellation_reason`, `cancelled_at`, `completed_at`, `cancelled_by_id`, `confirmed_date`, `commission_id`) VALUES (22, 'active', '2025-01-11 09:12:37.939', '2025-01-11 09:12:56.041', 19, 2, 21, NULL, 'cancelled', '2025-01-14 14:30:00', 900, 300000.00, 170000.00, 0.00, 'Special instructions for the service', 'abcdef', '2025-01-11 09:12:56', NULL, 19, NULL, NULL);
INSERT INTO `booking` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_man_id`, `payment_id`, `coupon_id`, `booking_status`, `booking_date`, `duration`, `price`, `discounted_price`, `discount_amount`, `notes`, `cancellation_reason`, `cancelled_at`, `completed_at`, `cancelled_by_id`, `confirmed_date`, `commission_id`) VALUES (23, 'active', '2025-01-11 10:15:57.029', '2025-01-26 17:08:54.843', 19, 2, 22, NULL, 'completed', '2025-01-14 14:30:00', 900, 300000.00, 170000.00, 0.00, 'Special instructions for the service', '', NULL, '2025-01-26 17:08:55', NULL, '2025-01-11 10:20:58', NULL);
INSERT INTO `booking` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_man_id`, `payment_id`, `coupon_id`, `booking_status`, `booking_date`, `duration`, `price`, `discounted_price`, `discount_amount`, `notes`, `cancellation_reason`, `cancelled_at`, `completed_at`, `cancelled_by_id`, `confirmed_date`, `commission_id`) VALUES (24, 'active', '2025-01-26 17:09:03.410', '2025-01-26 17:10:47.848', 19, 2, 23, NULL, 'cancelled', '2025-01-30 14:30:00', 900, 300000.00, 170000.00, 0.00, 'Special instructions for the service', 'abcdef', '2025-01-26 17:10:48', NULL, 19, NULL, NULL);
INSERT INTO `booking` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_man_id`, `payment_id`, `coupon_id`, `booking_status`, `booking_date`, `duration`, `price`, `discounted_price`, `discount_amount`, `notes`, `cancellation_reason`, `cancelled_at`, `completed_at`, `cancelled_by_id`, `confirmed_date`, `commission_id`) VALUES (25, 'active', '2025-01-26 17:14:38.320', '2025-01-26 17:16:51.022', 19, 2, 24, 1, 'cancelled', '2025-01-30 14:30:00', 900, 300000.00, 169985.00, 15.00, 'Special instructions for the service', 'abcdef', '2025-01-26 17:16:51', NULL, 19, NULL, NULL);
INSERT INTO `booking` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_man_id`, `payment_id`, `coupon_id`, `booking_status`, `booking_date`, `duration`, `price`, `discounted_price`, `discount_amount`, `notes`, `cancellation_reason`, `cancelled_at`, `completed_at`, `cancelled_by_id`, `confirmed_date`, `commission_id`) VALUES (26, 'active', '2025-01-26 17:19:23.091', '2025-01-26 17:24:47.487', 19, 2, 25, 1, 'cancelled', '2025-01-30 14:30:00', 900, 300000.00, 169985.00, 15.00, 'Special instructions for the service', 'abcdef', '2025-01-26 17:24:47', NULL, 19, NULL, NULL);
INSERT INTO `booking` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_man_id`, `payment_id`, `coupon_id`, `booking_status`, `booking_date`, `duration`, `price`, `discounted_price`, `discount_amount`, `notes`, `cancellation_reason`, `cancelled_at`, `completed_at`, `cancelled_by_id`, `confirmed_date`, `commission_id`) VALUES (27, 'active', '2025-01-26 17:25:03.609', '2025-01-26 17:35:16.301', 19, 2, 26, 1, 'cancelled', '2025-01-30 14:30:00', 900, 300000.00, 125000.00, 45000.00, 'Special instructions for the service', 'abcdef', '2025-01-26 17:35:16', NULL, 19, NULL, NULL);
INSERT INTO `booking` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_man_id`, `payment_id`, `coupon_id`, `booking_status`, `booking_date`, `duration`, `price`, `discounted_price`, `discount_amount`, `notes`, `cancellation_reason`, `cancelled_at`, `completed_at`, `cancelled_by_id`, `confirmed_date`, `commission_id`) VALUES (28, 'active', '2025-01-26 17:35:27.502', '2025-01-26 17:39:15.420', 19, 2, 27, 1, 'cancelled', '2025-01-30 14:30:00', 900, 300000.00, 399500.00, 70500.00, 'Special instructions for the service', 'abcdef', '2025-01-26 17:39:15', NULL, 19, NULL, NULL);
INSERT INTO `booking` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_man_id`, `payment_id`, `coupon_id`, `booking_status`, `booking_date`, `duration`, `price`, `discounted_price`, `discount_amount`, `notes`, `cancellation_reason`, `cancelled_at`, `completed_at`, `cancelled_by_id`, `confirmed_date`, `commission_id`) VALUES (29, 'active', '2025-01-26 17:39:20.950', '2025-01-26 17:43:14.967', 19, 2, 28, 1, 'cancelled', '2025-01-30 14:30:00', 900, 300000.00, 144500.00, 25500.00, 'Special instructions for the service', 'abcdef', '2025-01-26 17:43:15', NULL, 19, NULL, NULL);
INSERT INTO `booking` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_man_id`, `payment_id`, `coupon_id`, `booking_status`, `booking_date`, `duration`, `price`, `discounted_price`, `discount_amount`, `notes`, `cancellation_reason`, `cancelled_at`, `completed_at`, `cancelled_by_id`, `confirmed_date`, `commission_id`) VALUES (30, 'active', '2025-01-26 17:43:33.438', '2025-01-26 17:44:46.488', 19, 2, 29, 1, 'cancelled', '2025-01-30 14:30:00', 900, 300000.00, 169985.00, 15.00, 'Special instructions for the service', 'abcdef', '2025-01-26 17:44:46', NULL, 19, NULL, NULL);
INSERT INTO `booking` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_man_id`, `payment_id`, `coupon_id`, `booking_status`, `booking_date`, `duration`, `price`, `discounted_price`, `discount_amount`, `notes`, `cancellation_reason`, `cancelled_at`, `completed_at`, `cancelled_by_id`, `confirmed_date`, `commission_id`) VALUES (31, 'active', '2025-01-26 17:44:49.454', '2025-01-27 05:56:21.980', 19, 2, 30, 1, 'cancelled', '2025-01-30 14:30:00', 900, 300000.00, 127500.00, 42500.00, 'Special instructions for the service', 'abcdef', '2025-01-27 05:56:22', NULL, 19, NULL, NULL);
INSERT INTO `booking` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_man_id`, `payment_id`, `coupon_id`, `booking_status`, `booking_date`, `duration`, `price`, `discounted_price`, `discount_amount`, `notes`, `cancellation_reason`, `cancelled_at`, `completed_at`, `cancelled_by_id`, `confirmed_date`, `commission_id`) VALUES (32, 'active', '2025-01-27 05:59:57.556', '2025-01-27 06:00:50.168', 19, 2, 31, 1, 'cancelled', '2025-01-30 14:30:00', 900, 300000.00, 127500.00, 42500.00, 'Special instructions for the service', 'abcdef', '2025-01-27 06:00:50', NULL, 19, NULL, NULL);
INSERT INTO `booking` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_man_id`, `payment_id`, `coupon_id`, `booking_status`, `booking_date`, `duration`, `price`, `discounted_price`, `discount_amount`, `notes`, `cancellation_reason`, `cancelled_at`, `completed_at`, `cancelled_by_id`, `confirmed_date`, `commission_id`) VALUES (33, 'active', '2025-01-27 06:01:17.108', '2025-01-27 06:27:50.698', 19, 2, 32, 1, 'completed', '2025-01-30 14:30:00', 900, 300000.00, 127500.00, 42500.00, 'Special instructions for the service', '', NULL, '2025-01-27 06:27:51', NULL, '2025-01-27 06:27:46', 8);
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
INSERT INTO `category` (`id`, `status`, `created_at`, `updated_at`, `name`, `code`, `description`, `image`, `parent_id`) VALUES (16, 'active', '2024-10-22 11:40:03.516', '2025-01-22 05:55:10.284', 'Làm Móng', 'LAM_MONG', 'Làm Móng 13', 'category/image/3w5rMLKLTUiANS_fujinet.png.png', NULL);
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
-- Table structure for commission
-- ----------------------------
DROP TABLE IF EXISTS `commission`;
CREATE TABLE `commission` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `role_id` int unsigned NOT NULL,
  `percentage` double NOT NULL,
  `min_amount` double DEFAULT NULL,
  `max_amount` double DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `published_at` date DEFAULT NULL,
  `creator_id` int unsigned NOT NULL,
  `updater_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_commission_code` (`code`),
  KEY `fk_role_commission` (`role_id`),
  KEY `fk_commission_creator` (`creator_id`),
  KEY `fk_commission_updater` (`updater_id`),
  CONSTRAINT `fk_commission_creator` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_commission_updater` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_role_commission` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of commission
-- ----------------------------
BEGIN;
INSERT INTO `commission` (`id`, `status`, `created_at`, `updated_at`, `role_id`, `percentage`, `min_amount`, `max_amount`, `code`, `published_at`, `creator_id`, `updater_id`) VALUES (8, 'active', '2025-01-25 09:35:30.318', '2025-01-26 11:18:53.068', 4, 15, NULL, NULL, 'COMM_1', '2025-01-26', 2, 2);
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
  `image_id` int unsigned DEFAULT NULL,
  `category_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_coupon_code` (`code`),
  KEY `idx_coupon_creator_id` (`creator_id`),
  KEY `fk_image_coupons` (`image_id`),
  KEY `fk_category_coupons` (`category_id`),
  CONSTRAINT `fk_category_coupons` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `fk_coupon_creator` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_image_coupons` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of coupon
-- ----------------------------
BEGIN;
INSERT INTO `coupon` (`id`, `status`, `created_at`, `updated_at`, `code`, `description`, `discount_type`, `discount_value`, `min_spend`, `max_discount`, `start_date`, `end_date`, `usage_limit`, `usage_count`, `creator_id`, `image_id`, `category_id`) VALUES (1, 'active', '2025-01-24 05:01:19.449', '2025-01-26 12:14:59.732', '25off', '1233', 'percentage', 25.00, 100000.00, 50000.00, '2025-01-23 17:00:00', '2025-01-29 17:00:00', 0, 0, 2, NULL, 13);
INSERT INTO `coupon` (`id`, `status`, `created_at`, `updated_at`, `code`, `description`, `discount_type`, `discount_value`, `min_spend`, `max_discount`, `start_date`, `end_date`, `usage_limit`, `usage_count`, `creator_id`, `image_id`, `category_id`) VALUES (2, 'inactive', '2025-01-24 06:33:36.168', '2025-01-24 09:05:10.207', '15kOFF', 'Fixed amount off on the total amount 123', 'fixed_price', 15.00, 100.00, 15.00, '2025-01-23 17:00:00', '2025-01-29 17:00:00', 0, 0, 2, NULL, 13);
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
  `type` varchar(50) DEFAULT NULL,
  `coupon_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_image_user_id` (`user_id`),
  KEY `idx_image_service_id` (`service_id`),
  KEY `idx_image_type` (`type`),
  KEY `idx_image_coupon_id` (`coupon_id`),
  CONSTRAINT `fk_image_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_service_images` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of image
-- ----------------------------
BEGIN;
INSERT INTO `image` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_id`, `url`, `type`, `coupon_id`) VALUES (1, 'active', '2024-10-26 16:43:09.558', '2024-10-26 16:43:09.558', 2, 19, 'service/3zL5mcALDXwVn8/image/3zL5mcALDXwVn8_img-test-2.avif.avif', NULL, NULL);
INSERT INTO `image` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_id`, `url`, `type`, `coupon_id`) VALUES (2, 'active', '2024-10-27 17:24:00.941', '2024-10-27 17:24:00.941', 2, 5, 'service/3mKb6MVZRt6cdi/image/3mKb6MVZRt6cdi_img-test1.avif.avif', NULL, NULL);
INSERT INTO `image` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_id`, `url`, `type`, `coupon_id`) VALUES (3, 'active', '2024-11-04 02:51:25.692', '2024-11-04 02:51:25.692', 2, 5, 'service/3mKb6MVZRt6cdi/image/3mKb6MVZRt6cdi_img-test-2.avif.avif', NULL, NULL);
INSERT INTO `image` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `service_id`, `url`, `type`, `coupon_id`) VALUES (4, 'active', '2024-12-28 17:13:39.573', '2024-12-28 17:13:39.573', 2, 5, 'service/3mKb6MVZRt6cdi/image/3mKb6MVZRt6cdi_20240714_070803.jpg.jpg', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for m2mbooking_service_version
-- ----------------------------
DROP TABLE IF EXISTS `m2mbooking_service_version`;
CREATE TABLE `m2mbooking_service_version` (
  `booking_id` int unsigned NOT NULL,
  `service_version_id` int unsigned NOT NULL,
  PRIMARY KEY (`booking_id`,`service_version_id`),
  KEY `fk_m2mbooking_service_version_service_version` (`service_version_id`),
  CONSTRAINT `fk_m2mbooking_service_version_booking` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`),
  CONSTRAINT `fk_m2mbooking_service_version_service_version` FOREIGN KEY (`service_version_id`) REFERENCES `service_version` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of m2mbooking_service_version
-- ----------------------------
BEGIN;
INSERT INTO `m2mbooking_service_version` (`booking_id`, `service_version_id`) VALUES (21, 5);
INSERT INTO `m2mbooking_service_version` (`booking_id`, `service_version_id`) VALUES (22, 5);
INSERT INTO `m2mbooking_service_version` (`booking_id`, `service_version_id`) VALUES (23, 5);
INSERT INTO `m2mbooking_service_version` (`booking_id`, `service_version_id`) VALUES (24, 5);
INSERT INTO `m2mbooking_service_version` (`booking_id`, `service_version_id`) VALUES (25, 5);
INSERT INTO `m2mbooking_service_version` (`booking_id`, `service_version_id`) VALUES (26, 5);
INSERT INTO `m2mbooking_service_version` (`booking_id`, `service_version_id`) VALUES (27, 5);
INSERT INTO `m2mbooking_service_version` (`booking_id`, `service_version_id`) VALUES (28, 5);
INSERT INTO `m2mbooking_service_version` (`booking_id`, `service_version_id`) VALUES (29, 5);
INSERT INTO `m2mbooking_service_version` (`booking_id`, `service_version_id`) VALUES (30, 5);
INSERT INTO `m2mbooking_service_version` (`booking_id`, `service_version_id`) VALUES (31, 5);
INSERT INTO `m2mbooking_service_version` (`booking_id`, `service_version_id`) VALUES (32, 5);
INSERT INTO `m2mbooking_service_version` (`booking_id`, `service_version_id`) VALUES (33, 5);
COMMIT;

-- ----------------------------
-- Table structure for notification_details
-- ----------------------------
DROP TABLE IF EXISTS `notification_details`;
CREATE TABLE `notification_details` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `notification_id` int unsigned DEFAULT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `state` enum('pending','sent','error') DEFAULT 'pending',
  `sent_at` datetime(3) DEFAULT NULL,
  `error` text,
  `read_at` datetime(3) DEFAULT NULL,
  `message_id` longtext,
  PRIMARY KEY (`id`),
  KEY `idx_notification_details_notification_id` (`notification_id`),
  KEY `idx_notification_details_user_id` (`user_id`),
  CONSTRAINT `fk_notification_details_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_notifications_details` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of notification_details
-- ----------------------------
BEGIN;
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (9, 'active', '2025-01-11 09:06:57.237', '2025-01-11 09:06:57.237', 20, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (10, 'active', '2025-01-11 09:06:57.237', '2025-01-11 09:06:57.237', 20, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (11, 'active', '2025-01-11 09:07:33.494', '2025-01-11 09:07:33.494', 21, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (12, 'active', '2025-01-11 09:07:33.494', '2025-01-11 09:07:33.494', 21, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (13, 'active', '2025-01-11 09:12:16.274', '2025-01-11 09:12:16.274', 22, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (14, 'active', '2025-01-11 09:12:16.274', '2025-01-11 09:12:16.274', 22, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (15, 'active', '2025-01-11 09:12:37.950', '2025-01-11 09:12:37.950', 23, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (16, 'active', '2025-01-11 09:12:37.950', '2025-01-11 09:12:37.950', 23, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (17, 'active', '2025-01-11 09:12:56.049', '2025-01-11 09:12:56.049', 24, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (18, 'active', '2025-01-11 09:12:56.049', '2025-01-11 09:12:56.049', 24, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (19, 'active', '2025-01-11 10:15:57.067', '2025-01-11 10:15:57.067', 25, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (20, 'active', '2025-01-11 10:15:57.067', '2025-01-11 10:15:57.067', 25, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (21, 'active', '2025-01-11 10:20:57.538', '2025-01-11 10:20:57.538', 26, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (22, 'active', '2025-01-11 10:20:57.538', '2025-01-11 10:20:57.538', 26, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (23, 'active', '2025-01-26 17:08:54.864', '2025-01-26 17:08:54.864', 27, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (24, 'active', '2025-01-26 17:08:54.864', '2025-01-26 17:08:54.864', 27, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (25, 'active', '2025-01-26 17:09:03.420', '2025-01-26 17:09:03.420', 28, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (26, 'active', '2025-01-26 17:09:03.420', '2025-01-26 17:09:03.420', 28, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (27, 'active', '2025-01-26 17:10:47.865', '2025-01-26 17:10:47.865', 29, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (28, 'active', '2025-01-26 17:10:47.865', '2025-01-26 17:10:47.865', 29, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (29, 'active', '2025-01-26 17:14:38.335', '2025-01-26 17:14:38.335', 30, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (30, 'active', '2025-01-26 17:14:38.335', '2025-01-26 17:14:38.335', 30, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (31, 'active', '2025-01-26 17:16:51.035', '2025-01-26 17:16:51.035', 31, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (32, 'active', '2025-01-26 17:16:51.035', '2025-01-26 17:16:51.035', 31, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (33, 'active', '2025-01-26 17:19:23.103', '2025-01-26 17:19:23.103', 32, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (34, 'active', '2025-01-26 17:19:23.103', '2025-01-26 17:19:23.103', 32, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (35, 'active', '2025-01-26 17:24:47.503', '2025-01-26 17:24:47.503', 33, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (36, 'active', '2025-01-26 17:24:47.503', '2025-01-26 17:24:47.503', 33, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (37, 'active', '2025-01-26 17:25:03.615', '2025-01-26 17:25:03.615', 34, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (38, 'active', '2025-01-26 17:25:03.615', '2025-01-26 17:25:03.615', 34, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (39, 'active', '2025-01-26 17:35:16.314', '2025-01-26 17:35:16.314', 35, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (40, 'active', '2025-01-26 17:35:16.314', '2025-01-26 17:35:16.314', 35, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (41, 'active', '2025-01-26 17:35:27.516', '2025-01-26 17:35:27.516', 36, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (42, 'active', '2025-01-26 17:35:27.516', '2025-01-26 17:35:27.516', 36, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (43, 'active', '2025-01-26 17:39:15.432', '2025-01-26 17:39:15.432', 37, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (44, 'active', '2025-01-26 17:39:15.432', '2025-01-26 17:39:15.432', 37, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (45, 'active', '2025-01-26 17:39:20.956', '2025-01-26 17:39:20.956', 38, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (46, 'active', '2025-01-26 17:39:20.956', '2025-01-26 17:39:20.956', 38, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (47, 'active', '2025-01-26 17:43:14.980', '2025-01-26 17:43:14.980', 39, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (48, 'active', '2025-01-26 17:43:14.980', '2025-01-26 17:43:14.980', 39, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (49, 'active', '2025-01-26 17:43:33.445', '2025-01-26 17:43:33.445', 40, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (50, 'active', '2025-01-26 17:43:33.445', '2025-01-26 17:43:33.445', 40, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (51, 'active', '2025-01-26 17:44:46.498', '2025-01-26 17:44:46.498', 41, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (52, 'active', '2025-01-26 17:44:46.498', '2025-01-26 17:44:46.498', 41, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (53, 'active', '2025-01-26 17:44:49.460', '2025-01-26 17:44:49.460', 42, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (54, 'active', '2025-01-26 17:44:49.460', '2025-01-26 17:44:49.460', 42, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (55, 'active', '2025-01-27 05:56:22.002', '2025-01-27 05:56:22.002', 43, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (56, 'active', '2025-01-27 05:56:22.002', '2025-01-27 05:56:22.002', 43, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (57, 'active', '2025-01-27 05:59:57.571', '2025-01-27 05:59:57.571', 44, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (58, 'active', '2025-01-27 05:59:57.571', '2025-01-27 05:59:57.571', 44, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (59, 'active', '2025-01-27 06:00:50.176', '2025-01-27 06:00:50.176', 45, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (60, 'active', '2025-01-27 06:00:50.176', '2025-01-27 06:00:50.176', 45, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (61, 'active', '2025-01-27 06:01:17.124', '2025-01-27 06:01:17.124', 46, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (62, 'active', '2025-01-27 06:01:17.124', '2025-01-27 06:01:17.124', 46, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (63, 'active', '2025-01-27 06:27:45.680', '2025-01-27 06:27:45.680', 47, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (64, 'active', '2025-01-27 06:27:45.680', '2025-01-27 06:27:45.680', 47, 19, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (65, 'active', '2025-01-27 06:27:50.704', '2025-01-27 06:27:50.704', 48, 2, 'pending', NULL, '', NULL, '');
INSERT INTO `notification_details` (`id`, `status`, `created_at`, `updated_at`, `notification_id`, `user_id`, `state`, `sent_at`, `error`, `read_at`, `message_id`) VALUES (66, 'active', '2025-01-27 06:27:50.704', '2025-01-27 06:27:50.704', 48, 19, 'pending', NULL, '', NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `scheduled` datetime DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `booking_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_notifications_type` (`type`),
  KEY `idx_notifications_booking_id` (`booking_id`),
  CONSTRAINT `fk_booking_notifications` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`),
  CONSTRAINT `fk_notifications_booking` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of notifications
-- ----------------------------
BEGIN;
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (20, 'active', '2025-01-11 09:06:57.232', '2025-01-11 09:06:57.232', 'booking', '2025-01-11 09:06:57', '{\"event\": \"booking_created\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"3zPnY1qCUHYKrU\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 21);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (21, 'active', '2025-01-11 09:07:33.493', '2025-01-11 09:07:33.493', 'booking', '2025-01-11 09:07:33', '{\"event\": \"booking_accepted\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"3zPnY1qCUHYKrU\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 21);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (22, 'active', '2025-01-11 09:12:16.273', '2025-01-11 09:12:16.273', 'booking', '2025-01-11 09:12:16', '{\"event\": \"booking_completed\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"3zPnY1qCUHYKrU\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 21);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (23, 'active', '2025-01-11 09:12:37.949', '2025-01-11 09:12:37.949', 'booking', '2025-01-11 09:12:38', '{\"event\": \"booking_created\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"3zRzVSAPAwcQRE\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 22);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (24, 'active', '2025-01-11 09:12:56.048', '2025-01-11 09:12:56.048', 'booking', '2025-01-11 09:12:56', '{\"event\": \"booking_cancelled\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"3zRzVSAPAwcQRE\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 22);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (25, 'active', '2025-01-11 10:15:57.062', '2025-01-11 10:15:57.062', 'booking', '2025-01-11 10:15:57', '{\"event\": \"booking_created\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"43b6h5FuqXCz3g\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 23);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (26, 'active', '2025-01-11 10:20:57.537', '2025-01-11 10:20:57.537', 'booking', '2025-01-11 10:20:58', '{\"event\": \"booking_accepted\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"43b6h5FuqXCz3g\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 23);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (27, 'active', '2025-01-26 17:08:54.859', '2025-01-26 17:08:54.859', 'booking', '2025-01-26 17:08:55', '{\"event\": \"booking_completed\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"43b6h5FuqXCz3g\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 23);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (28, 'active', '2025-01-26 17:09:03.419', '2025-01-26 17:09:03.419', 'booking', '2025-01-26 17:09:03', '{\"event\": \"booking_created\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"43dJeTV5FCQtJe\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 24);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (29, 'active', '2025-01-26 17:10:47.864', '2025-01-26 17:10:47.864', 'booking', '2025-01-26 17:10:48', '{\"event\": \"booking_cancelled\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"43dJeTV5FCQtJe\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 24);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (30, 'active', '2025-01-26 17:14:38.334', '2025-01-26 17:14:38.334', 'booking', '2025-01-26 17:14:38', '{\"event\": \"booking_created\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"43fWbspG49CEqn\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 25);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (31, 'active', '2025-01-26 17:16:51.034', '2025-01-26 17:16:51.034', 'booking', '2025-01-26 17:16:51', '{\"event\": \"booking_cancelled\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"43fWbspG49CEqn\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 25);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (32, 'active', '2025-01-26 17:19:23.102', '2025-01-26 17:19:23.102', 'booking', '2025-01-26 17:19:23', '{\"event\": \"booking_created\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"43h1QkZX8eJguS\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 26);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (33, 'active', '2025-01-26 17:24:47.501', '2025-01-26 17:24:47.501', 'booking', '2025-01-26 17:24:48', '{\"event\": \"booking_cancelled\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"43h1QkZX8eJguS\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 26);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (34, 'active', '2025-01-26 17:25:03.615', '2025-01-26 17:25:03.615', 'booking', '2025-01-26 17:25:04', '{\"event\": \"booking_created\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"46rpvFwfHAHAQg\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 27);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (35, 'active', '2025-01-26 17:35:16.313', '2025-01-26 17:35:16.313', 'booking', '2025-01-26 17:35:16', '{\"event\": \"booking_cancelled\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"46rpvFwfHAHAQg\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 27);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (36, 'active', '2025-01-26 17:35:27.515', '2025-01-26 17:35:27.515', 'booking', '2025-01-26 17:35:28', '{\"event\": \"booking_created\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"46u2seALw6jCDL\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 28);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (37, 'active', '2025-01-26 17:39:15.431', '2025-01-26 17:39:15.431', 'booking', '2025-01-26 17:39:15', '{\"event\": \"booking_cancelled\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"46u2seALw6jCDL\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 28);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (38, 'active', '2025-01-26 17:39:20.955', '2025-01-26 17:39:20.955', 'booking', '2025-01-26 17:39:21', '{\"event\": \"booking_created\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"46vXXEKu4awCZ8\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 29);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (39, 'active', '2025-01-26 17:43:14.978', '2025-01-26 17:43:14.978', 'booking', '2025-01-26 17:43:15', '{\"event\": \"booking_cancelled\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"46vXXEKu4awCZ8\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 29);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (40, 'active', '2025-01-26 17:43:33.445', '2025-01-26 17:43:33.445', 'booking', '2025-01-26 17:43:33', '{\"event\": \"booking_created\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"4A6M2hbYAPHdJG\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 30);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (41, 'active', '2025-01-26 17:44:46.497', '2025-01-26 17:44:46.497', 'booking', '2025-01-26 17:44:46', '{\"event\": \"booking_cancelled\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"4A6M2hbYAPHdJG\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 30);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (42, 'active', '2025-01-26 17:44:49.459', '2025-01-26 17:44:49.459', 'booking', '2025-01-26 17:44:49', '{\"event\": \"booking_created\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"4A8Yz5pDpJJhzL\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 31);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (43, 'active', '2025-01-27 05:56:22.000', '2025-01-27 05:56:22.000', 'booking', '2025-01-27 05:56:22', '{\"event\": \"booking_cancelled\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"4A8Yz5pDpJJhzL\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 31);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (44, 'active', '2025-01-27 05:59:57.571', '2025-01-27 05:59:57.571', 'booking', '2025-01-27 05:59:58', '{\"event\": \"booking_created\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"4AA3nzfz3qB7FW\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 32);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (45, 'active', '2025-01-27 06:00:50.175', '2025-01-27 06:00:50.175', 'booking', '2025-01-27 06:00:50', '{\"event\": \"booking_cancelled\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"4AA3nzfz3qB7FW\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 32);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (46, 'active', '2025-01-27 06:01:17.123', '2025-01-27 06:01:17.123', 'booking', '2025-01-27 06:01:17', '{\"event\": \"booking_created\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"4ACFkNu9TUxNyC\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 33);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (47, 'active', '2025-01-27 06:27:45.679', '2025-01-27 06:27:45.679', 'booking', '2025-01-27 06:27:46', '{\"event\": \"booking_accepted\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"4ACFkNu9TUxNyC\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 33);
INSERT INTO `notifications` (`id`, `status`, `created_at`, `updated_at`, `type`, `scheduled`, `metadata`, `booking_id`) VALUES (48, 'active', '2025-01-27 06:27:50.703', '2025-01-27 06:27:50.703', 'booking', '2025-01-27 06:27:51', '{\"event\": \"booking_completed\", \"user_id\": \"3zL5mc7qaUYRRz\", \"booking_id\": \"4ACFkNu9TUxNyC\", \"service_ids\": [\"3mKb6KJ4zi7t8Q\"], \"service_man_id\": \"gGzTFTGJB8Wk\", \"service_version_ids\": [\"3mKb6KJ4zi7t8Q\"]}', 33);
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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (27, 'active', '2024-11-19 07:03:35.849', '2024-11-19 07:05:46.962', 22, '352397', 5, '2024-11-19 07:08:36', '2024-11-19 07:05:47', 'f7381e3e-9cc4-4477-b5d8-493b0e564f24', '32611f3bb7e049668ce2cb42d0b73aba73');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (28, 'active', '2024-11-19 07:36:28.740', '2024-11-19 07:36:50.236', 19, '243038', 5, '2024-11-19 07:41:29', '2024-11-19 07:36:50', '543aea2c-a58d-448a-b724-3a7a99c9d44f', '4fad8a3f92f14225986194d2af2e18f5175');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (29, 'active', '2025-01-02 16:08:46.681', '2025-01-02 16:09:01.641', 22, '719786', 5, '2025-01-02 16:13:47', '2025-01-02 16:09:02', 'bc48dcf0-c67b-413f-99e9-ada4227571ef', 'acba8ba45a5d4d8bbb6b2d9c2981a7db189');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (30, 'active', '2025-01-04 15:23:45.798', '2025-01-04 15:24:04.785', 22, '254952', 5, '2025-01-04 15:28:46', '2025-01-04 15:24:05', 'f2417de0-6205-4122-b191-a33ca1e8d25f', '978aabc8739c4dc89ea87d382d6b448b225');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (31, 'active', '2025-01-05 16:27:18.853', '2025-01-05 16:27:57.771', 19, '998026', 5, '2025-01-05 16:32:19', '2025-01-05 16:27:58', 'd84b4865-58e2-4c6c-bd0b-a138ce34bd71', '9cf77c2126564efeae93449025e6ea78194');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (32, 'active', '2025-01-06 16:44:46.080', '2025-01-06 16:45:05.426', 19, '572411', 5, '2025-01-06 16:49:46', '2025-01-06 16:45:05', 'b99fdaad-480a-4a6e-9fe5-bac4c6932439', 'fbaacc02f3514454a63f82b6acd222d4106');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (33, 'active', '2025-01-07 04:16:00.355', '2025-01-07 04:16:12.325', 19, '077475', 5, '2025-01-07 04:21:00', '2025-01-07 04:16:12', 'f67c6aa6-5bde-43e4-9429-1ff9b437ce5c', 'b2cb46ff02194ff7aca61563db0955e7303');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (34, 'active', '2025-01-07 04:17:27.387', '2025-01-07 04:17:40.451', 22, '248889', 5, '2025-01-07 04:22:27', '2025-01-07 04:17:40', '10ab1982-fc5b-4fe0-8b41-ccee56200c7c', '1b30f9f42b204e2ab092e4f7eca89fe5221');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (35, 'active', '2025-01-07 15:55:28.643', '2025-01-07 15:55:41.115', 19, '361615', 5, '2025-01-07 16:00:29', '2025-01-07 15:55:41', 'cfa2577b-907c-4240-a680-1ef2b8343815', 'cb3c39cf469b4b44a8a665cf14e95f2b259');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (36, 'active', '2025-01-10 09:33:57.606', '2025-01-10 09:34:14.930', 19, '065070', 5, '2025-01-10 09:38:58', '2025-01-10 09:34:15', 'ab181078-0b20-4bf2-be20-616ba3c82155', '949db52c391b4ad4a1b25112683c5660256');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (37, 'active', '2025-01-11 05:03:31.912', '2025-01-11 05:03:56.223', 19, '904815', 5, '2025-01-11 05:08:32', '2025-01-11 05:03:56', 'b193a559-9974-4070-9b35-dec67e53c7d4', '3429405d2ac74a8fa3ecc383a7e77395160');
INSERT INTO `otp` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `otp`, `ttl`, `expires_at`, `passed_at`, `uuid`, `esmsid`) VALUES (38, 'active', '2025-01-26 17:06:34.371', '2025-01-26 17:07:01.110', 19, '449232', 5, '2025-01-26 17:11:34', '2025-01-26 17:07:01', 'c36ab355-8980-455e-8dfd-5694c5664f66', '7665a4b4d298481c8c63ddbfffdea295182');
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of payment
-- ----------------------------
BEGIN;
INSERT INTO `payment` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `amount`, `currency`, `payment_method`, `transaction_id`, `transaction_status`) VALUES (20, 'active', '2025-01-11 09:06:57.210', '2025-01-11 09:12:16.255', 19, 170000.00, 'VND', 'cash', '7603fe58-24b0-4f3d-8ee4-f0f57810c2cc', 'completed');
INSERT INTO `payment` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `amount`, `currency`, `payment_method`, `transaction_id`, `transaction_status`) VALUES (21, 'active', '2025-01-11 09:12:37.933', '2025-01-11 09:12:56.042', 19, 170000.00, 'VND', 'cash', '148311ed-17c2-47b3-9fa1-0c2d5bf12de4', 'cancelled');
INSERT INTO `payment` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `amount`, `currency`, `payment_method`, `transaction_id`, `transaction_status`) VALUES (22, 'active', '2025-01-11 10:15:56.994', '2025-01-26 17:08:54.840', 19, 170000.00, 'VND', 'cash', '77464ddf-c9f3-4c2d-8c21-617325ec5899', 'completed');
INSERT INTO `payment` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `amount`, `currency`, `payment_method`, `transaction_id`, `transaction_status`) VALUES (23, 'active', '2025-01-26 17:09:03.404', '2025-01-26 17:10:47.850', 19, 170000.00, 'VND', 'cash', '2cea86bd-67a7-4b77-aa39-5e7a24ed1bbd', 'cancelled');
INSERT INTO `payment` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `amount`, `currency`, `payment_method`, `transaction_id`, `transaction_status`) VALUES (24, 'active', '2025-01-26 17:14:38.300', '2025-01-26 17:16:51.024', 19, 169985.00, 'VND', 'cash', '985022aa-30fb-45b8-8108-2d71eab43e07', 'cancelled');
INSERT INTO `payment` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `amount`, `currency`, `payment_method`, `transaction_id`, `transaction_status`) VALUES (25, 'active', '2025-01-26 17:19:13.042', '2025-01-26 17:24:47.488', 19, 169985.00, 'VND', 'cash', 'c48fc8d8-7f79-4d1c-9ce6-9254fee0b236', 'cancelled');
INSERT INTO `payment` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `amount`, `currency`, `payment_method`, `transaction_id`, `transaction_status`) VALUES (26, 'active', '2025-01-26 17:25:03.604', '2025-01-26 17:35:16.303', 19, 125000.00, 'VND', 'cash', '6c499bc8-bafe-48f5-901c-4ecaf63d5fe1', 'cancelled');
INSERT INTO `payment` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `amount`, `currency`, `payment_method`, `transaction_id`, `transaction_status`) VALUES (27, 'active', '2025-01-26 17:35:27.494', '2025-01-26 17:39:15.422', 19, 399500.00, 'VND', 'cash', 'a8d776ff-e79f-4e8c-9d11-a6819f4f21d5', 'cancelled');
INSERT INTO `payment` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `amount`, `currency`, `payment_method`, `transaction_id`, `transaction_status`) VALUES (28, 'active', '2025-01-26 17:39:20.946', '2025-01-26 17:43:14.969', 19, 144500.00, 'VND', 'cash', 'ef706388-fac7-4f41-a119-4b22557bb403', 'cancelled');
INSERT INTO `payment` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `amount`, `currency`, `payment_method`, `transaction_id`, `transaction_status`) VALUES (29, 'active', '2025-01-26 17:43:33.432', '2025-01-26 17:44:46.489', 19, 169985.00, 'VND', 'cash', '7c236f40-f7ce-4e04-b3a3-736c3bb23ca9', 'cancelled');
INSERT INTO `payment` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `amount`, `currency`, `payment_method`, `transaction_id`, `transaction_status`) VALUES (30, 'active', '2025-01-26 17:44:49.449', '2025-01-27 05:56:21.983', 19, 127500.00, 'VND', 'cash', '82af55ea-77b9-44e8-a426-7baed20cec87', 'cancelled');
INSERT INTO `payment` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `amount`, `currency`, `payment_method`, `transaction_id`, `transaction_status`) VALUES (31, 'active', '2025-01-27 05:57:40.235', '2025-01-27 06:00:50.168', 19, 127500.00, 'VND', 'cash', '16b5c2e1-3760-4f72-a2f8-ede0ff301c49', 'cancelled');
INSERT INTO `payment` (`id`, `status`, `created_at`, `updated_at`, `user_id`, `amount`, `currency`, `payment_method`, `transaction_id`, `transaction_status`) VALUES (32, 'active', '2025-01-27 06:00:53.792', '2025-01-27 06:27:50.697', 19, 127500.00, 'VND', 'cash', '6f7f93f3-45df-4a5e-9c7b-7f1f7fbb685e', 'completed');
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
INSERT INTO `service` (`id`, `status`, `created_at`, `updated_at`, `creator_id`, `service_version_id`, `slug`, `rating_count`, `review_info`, `avg_rating`) VALUES (5, 'active', '2024-10-26 03:42:34.958', '2025-01-28 17:29:11.426', 2, 2, 'dan-mong-hinh-buom-3d', 0, 'null', 0.0);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of service_version
-- ----------------------------
BEGIN;
INSERT INTO `service_version` (`id`, `status`, `created_at`, `updated_at`, `service_id`, `intro_video_id`, `category_id`, `title`, `description`, `thumbnail`, `price`, `discounted_price`, `sub_category_id`, `duration`, `published_date`, `main_image_id`) VALUES (2, 'active', '2024-10-26 03:42:34.969', '2025-01-28 17:29:11.442', 5, NULL, 16, 'Dán móng hình bướm 3D 123', '<p>Dán móng giả hình bướm 3D</p>', '', 250000.00, 170000.00, 13, 900, '2024-12-28 16:56:21', 2);
INSERT INTO `service_version` (`id`, `status`, `created_at`, `updated_at`, `service_id`, `intro_video_id`, `category_id`, `title`, `description`, `thumbnail`, `price`, `discounted_price`, `sub_category_id`, `duration`, `published_date`, `main_image_id`) VALUES (3, 'inactive', '2024-10-26 16:42:12.478', '2024-10-26 16:42:12.478', 18, NULL, 16, 'asd', '<p>123</p>', '', 123.00, 111.00, 13, 900, NULL, NULL);
INSERT INTO `service_version` (`id`, `status`, `created_at`, `updated_at`, `service_id`, `intro_video_id`, `category_id`, `title`, `description`, `thumbnail`, `price`, `discounted_price`, `sub_category_id`, `duration`, `published_date`, `main_image_id`) VALUES (4, 'inactive', '2024-10-26 16:43:08.908', '2024-10-28 03:13:10.419', 19, NULL, 16, 'Test service 2', '<p>123</p>', '', 123.00, 111.00, 13, 900, NULL, NULL);
INSERT INTO `service_version` (`id`, `status`, `created_at`, `updated_at`, `service_id`, `intro_video_id`, `category_id`, `title`, `description`, `thumbnail`, `price`, `discounted_price`, `sub_category_id`, `duration`, `published_date`, `main_image_id`) VALUES (5, 'inactive', '2024-10-28 16:35:51.440', '2025-01-28 17:29:11.444', 5, NULL, 16, 'Dán móng hình bướm 3D', '<p>Dán móng giả hình bướm 3D</p>', '', 300000.00, 170000.00, 13, 900, '2024-11-01 13:43:07', NULL);
INSERT INTO `service_version` (`id`, `status`, `created_at`, `updated_at`, `service_id`, `intro_video_id`, `category_id`, `title`, `description`, `thumbnail`, `price`, `discounted_price`, `sub_category_id`, `duration`, `published_date`, `main_image_id`) VALUES (6, 'inactive', '2025-01-28 18:55:52.654', '2025-01-28 18:56:22.608', 5, NULL, 16, 'Dán móng hình bướm 3D ABC', '<p>Dán móng giả hình bướm 3D</p>', '', 250000.00, 170000.00, 13, 900, NULL, 2);
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
INSERT INTO `service_version_images` (`service_version_id`, `image_id`, `order`) VALUES (6, 2, NULL);
INSERT INTO `service_version_images` (`service_version_id`, `image_id`, `order`) VALUES (6, 3, NULL);
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
-- Table structure for user_device
-- ----------------------------
DROP TABLE IF EXISTS `user_device`;
CREATE TABLE `user_device` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `fcm_token` varchar(250) DEFAULT NULL,
  `platform` longtext,
  `user_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_device_fcm_token` (`fcm_token`),
  KEY `idx_user_device_user_id` (`user_id`),
  CONSTRAINT `fk_user_user_device` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_device
-- ----------------------------
BEGIN;
INSERT INTO `user_device` (`id`, `status`, `created_at`, `updated_at`, `fcm_token`, `platform`, `user_id`) VALUES (3, 'active', '2025-01-04 15:25:34.720', '2025-01-04 15:25:34.720', '1234566', 'mobile', 22);
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

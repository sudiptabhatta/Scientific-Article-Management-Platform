-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 23, 2022 at 11:25 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `scientific-article-management-platform`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(2, 'admin'),
(1, 'researcher');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add category', 1, 'add_category'),
(2, 'Can change category', 1, 'change_category'),
(3, 'Can delete category', 1, 'delete_category'),
(4, 'Can view category', 1, 'view_category'),
(5, 'Can add comment', 2, 'add_comment'),
(6, 'Can change comment', 2, 'change_comment'),
(7, 'Can delete comment', 2, 'delete_comment'),
(8, 'Can view comment', 2, 'view_comment'),
(9, 'Can add post', 3, 'add_post'),
(10, 'Can change post', 3, 'change_post'),
(11, 'Can delete post', 3, 'delete_post'),
(12, 'Can view post', 3, 'view_post'),
(13, 'Can add user', 4, 'add_customuser'),
(14, 'Can change user', 4, 'change_customuser'),
(15, 'Can delete user', 4, 'delete_customuser'),
(16, 'Can view user', 4, 'view_customuser'),
(17, 'Can add log entry', 5, 'add_logentry'),
(18, 'Can change log entry', 5, 'change_logentry'),
(19, 'Can delete log entry', 5, 'delete_logentry'),
(20, 'Can view log entry', 5, 'view_logentry'),
(21, 'Can add permission', 6, 'add_permission'),
(22, 'Can change permission', 6, 'change_permission'),
(23, 'Can delete permission', 6, 'delete_permission'),
(24, 'Can view permission', 6, 'view_permission'),
(25, 'Can add group', 7, 'add_group'),
(26, 'Can change group', 7, 'change_group'),
(27, 'Can delete group', 7, 'delete_group'),
(28, 'Can view group', 7, 'view_group'),
(29, 'Can add content type', 8, 'add_contenttype'),
(30, 'Can change content type', 8, 'change_contenttype'),
(31, 'Can delete content type', 8, 'delete_contenttype'),
(32, 'Can view content type', 8, 'view_contenttype'),
(33, 'Can add session', 9, 'add_session'),
(34, 'Can change session', 9, 'change_session'),
(35, 'Can delete session', 9, 'delete_session'),
(36, 'Can view session', 9, 'view_session');

-- --------------------------------------------------------

--
-- Table structure for table `blog_category`
--

CREATE TABLE `blog_category` (
  `cid` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blog_category`
--

INSERT INTO `blog_category` (`cid`, `category_name`) VALUES
(1, 'Technology'),
(2, 'Business'),
(3, 'Science'),
(4, 'Medicine'),
(5, 'Engineering');

-- --------------------------------------------------------

--
-- Table structure for table `blog_comment`
--

CREATE TABLE `blog_comment` (
  `commentid` int(11) NOT NULL,
  `comment` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `aid_id` int(11) NOT NULL,
  `author_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blog_comment`
--

INSERT INTO `blog_comment` (`commentid`, `comment`, `created`, `aid_id`, `author_id`) VALUES
(1, 'Good article', '2022-12-20 15:16:06.658607', 1, 5),
(2, 'Thanks. ', '2022-12-20 15:20:02.062738', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `blog_post`
--

CREATE TABLE `blog_post` (
  `aid` int(11) NOT NULL,
  `image` varchar(100) NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `approved` tinyint(1) NOT NULL,
  `author_id` bigint(20) NOT NULL,
  `cid_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blog_post`
--

INSERT INTO `blog_post` (`aid`, `image`, `title`, `content`, `created`, `approved`, `author_id`, `cid_id`) VALUES
(1, 'blog-default.png', 'Researchers use classical music to make protein songs more pleasant to listen to', '<p>In recent years, <strong>scientists</strong> have created music based on the structure of proteins as a creative way to better popularize science to the general public, but the resulting songs haven&#39;t always been pleasant to the ear. In a study appearing September 29 in the journal&nbsp;<em>Heliyon</em>, researchers use the style of existing music genres to guide the structure of protein song to make it more musical. Using the style of Fr&eacute;d&eacute;ric Chopin&#39;s&nbsp;<em>Fantaisie-Impromptu</em>&nbsp;and other classical pieces as a guide, the researchers succeeded in converting proteins into song with greater musicality.&nbsp;<img alt=\"wink\" src=\"http://localhost:8000/static/ckeditor/ckeditor/plugins/smiley/images/wink_smile.png\" style=\"height:23px; width:23px\" title=\"wink\" /></p>', '2022-12-20 14:47:27.000000', 1, 2, 3),
(2, 'images/employee-attrition.png', 'Employee Atrrition Prediction', '<p>Employee attrition for any organization is a serious problem. The rate of quitting employees&#39; jobs may cause the loss of talented employees and the loss of time and money to any organization. The insurgence in machine learning can assist the organizations and decision-makers to minimize employee attrition before the HR department finds a new replacement. In this paper, we attempt to build a model based on the &quot;IBM HR Analytics Employee Attrition&quot; dataset to predict employee attrition. Firstly, the dataset was preprocessed and applied min-max normalization. Secondly, multiple classifiers such as zeroR, Decision Tree classifier, K-nearest neighbor classifier (KNN), Support vector machine classifier (SVM), Random Forest classifier were applied. Hyperparameter optimization was applied to further improve the results. Our best model leveraging an ensemble technique with a Voting classifier demonstrates that the employee attrition model can achieve high AUC (Area Under ROC Curve) score 0.89, including competitive metrics on other measures like precision, recall, F-measure, and accuracy.</p>', '2022-12-20 14:56:44.000000', 1, 3, 1),
(3, 'blog-default.png', 'Performance evaluation of microbial fuel cell using novel anode design and with low-cost components', '<p>Microbial fuel cells (MFCs) have proven to be an effective technology for treatment of waste water with the additional advantage of electricity generation. Although the power density obtained has increased manyfold over the past decade, the cost of treatment and cost of electricity generation need to be brought down to make the process feasible. In the present research, an attempt was made to use locally available, low-cost and effective materials for the construction of an MFC using novel anode architecture. The MFC was made using multiple membranes in a single cell. The special design of the anode proved to be very effective in obtaining a higher power density. A volumetric power density of 2002&thinsp;mW/m3&nbsp;could be achieved without the use of any chemical catholyte. The corresponding coulombic efficiency obtained was 13.17%. When a chemical catholyte was used, the power density increased to 5201&thinsp;mW/m3, an increase by more than 2.5 times. The corresponding coulombic efficiency of the MFC also increased to 29.16%. Such novel anode architecture could take this technology a step forward for practical implementation to harvest carbon dioxide neutral electricity from waste water. The performance of the MFC in the removal of chemical oxygen demand (COD) from waste water was found to be 93.9&ndash;97.75%, which is highly satisfactory. The removal efficiency was found to be independent of the initial COD of the substrate.</p>', '2022-12-20 15:15:44.000000', 1, 5, 3),
(4, 'blog-default.png', 'Knowledge Distillation', '<p>Pneumonia is the leading cause of death for infectious<br />\r\ndisease worldwide for children. The most common medical<br />\r\ndiagnosis for it is chest X-rays and early detection can save<br />\r\nmany lives. With the advancement in deep learning the detection<br />\r\nof Pneumonia from chest X-rays are starting to lay a strong<br />\r\nfoundation in the medical domain. The large neural networks<br />\r\nwith good accuracy do come with a computational cost that limit<br />\r\ntheir development. We propose a knowledge distillation approach<br />\r\non Pneumonia detection to boost lightweight models to achieve<br />\r\ngreater performance. We used both logit and feature based<br />\r\nknowledge distillation methods and then proposed a merged<br />\r\nknowledge distillation technique that equips both feature and<br />\r\nlogit level distillation. We ran our experiments on the publicly<br />\r\navailable dataset RSNA Pneumonia Detection Challenge and<br />\r\nshow that the student models have an improvement of 0.92%<br />\r\nand 1.82% in F1-score using our KD technique and achieves<br />\r\ngreater performance than the teacher models in both F1-score<br />\r\nand Sensitivity</p>', '2022-12-23 13:03:43.242489', 0, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `blog_post_like`
--

CREATE TABLE `blog_post_like` (
  `id` bigint(20) NOT NULL,
  `post_id` int(11) NOT NULL,
  `customuser_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blog_post_like`
--

INSERT INTO `blog_post_like` (`id`, `post_id`, `customuser_id`) VALUES
(1, 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2022-12-20 14:40:02.173536', '1', 'Technology', 1, '[{\"added\": {}}]', 1, 1),
(2, '2022-12-20 14:40:09.319293', '2', 'Business', 1, '[{\"added\": {}}]', 1, 1),
(3, '2022-12-20 14:40:17.345809', '3', 'Science', 1, '[{\"added\": {}}]', 1, 1),
(4, '2022-12-20 14:40:43.312086', '4', 'Medicine', 1, '[{\"added\": {}}]', 1, 1),
(5, '2022-12-20 14:57:39.921013', '2', 'Employee Atrrition Prediction', 2, '[{\"changed\": {\"fields\": [\"Approved\"]}}]', 3, 1),
(6, '2022-12-20 14:57:47.357119', '1', 'Researchers use classical music to make protein songs more pleasant to listen to', 2, '[{\"changed\": {\"fields\": [\"Approved\"]}}]', 3, 1),
(7, '2022-12-20 15:17:05.703178', '3', 'Popular science', 2, '[{\"changed\": {\"fields\": [\"Approved\"]}}]', 3, 1),
(8, '2022-12-23 14:56:20.107182', '1', 'sudiptabhatta', 2, '[{\"changed\": {\"fields\": [\"User permissions\"]}}]', 4, 1),
(9, '2022-12-23 16:43:40.999656', '1', 'researcher', 1, '[{\"added\": {}}]', 7, 1),
(10, '2022-12-23 16:43:50.904748', '2', 'admin', 1, '[{\"added\": {}}]', 7, 1),
(11, '2022-12-23 16:45:31.520779', '1', 'sudiptabhatta', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(12, '2022-12-23 16:46:04.744039', '5', 'ron99', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(13, '2022-12-23 16:46:10.768315', '4', 'aishwariabhatta', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(14, '2022-12-23 16:46:18.113468', '3', 'harmoine', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1),
(15, '2022-12-23 16:46:33.754428', '2', 'harrypotter', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(5, 'admin', 'logentry'),
(7, 'auth', 'group'),
(6, 'auth', 'permission'),
(1, 'blog', 'category'),
(2, 'blog', 'comment'),
(3, 'blog', 'post'),
(8, 'contenttypes', 'contenttype'),
(9, 'sessions', 'session'),
(4, 'users', 'customuser');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'blog', '0001_initial', '2022-12-20 14:38:41.957751'),
(2, 'contenttypes', '0001_initial', '2022-12-20 14:38:41.990406'),
(3, 'contenttypes', '0002_remove_content_type_name', '2022-12-20 14:38:42.040311'),
(4, 'auth', '0001_initial', '2022-12-20 14:38:42.230294'),
(5, 'auth', '0002_alter_permission_name_max_length', '2022-12-20 14:38:42.280326'),
(6, 'auth', '0003_alter_user_email_max_length', '2022-12-20 14:38:42.290298'),
(7, 'auth', '0004_alter_user_username_opts', '2022-12-20 14:38:42.300297'),
(8, 'auth', '0005_alter_user_last_login_null', '2022-12-20 14:38:42.310293'),
(9, 'auth', '0006_require_contenttypes_0002', '2022-12-20 14:38:42.320295'),
(10, 'auth', '0007_alter_validators_add_error_messages', '2022-12-20 14:38:42.330312'),
(11, 'auth', '0008_alter_user_username_max_length', '2022-12-20 14:38:42.330312'),
(12, 'auth', '0009_alter_user_last_name_max_length', '2022-12-20 14:38:42.340297'),
(13, 'auth', '0010_alter_group_name_max_length', '2022-12-20 14:38:42.360294'),
(14, 'auth', '0011_update_proxy_permissions', '2022-12-20 14:38:42.370297'),
(15, 'auth', '0012_alter_user_first_name_max_length', '2022-12-20 14:38:42.380293'),
(16, 'users', '0001_initial', '2022-12-20 14:38:42.649057'),
(17, 'admin', '0001_initial', '2022-12-20 14:38:42.739783'),
(18, 'admin', '0002_logentry_remove_auto_add', '2022-12-20 14:38:42.759787'),
(19, 'admin', '0003_logentry_add_action_flag_choices', '2022-12-20 14:38:42.769785'),
(20, 'blog', '0002_initial', '2022-12-20 14:38:43.065834'),
(21, 'sessions', '0001_initial', '2022-12-20 14:38:43.097545');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('jvjqvl6d6oqe8xbofvpabcihh5jr1hkw', '.eJxVjMEOwiAQRP-FsyEuhQIevfsNZJddpGrapLQn47_bJj3obTLvzbxVwnWpaW0yp4HVRYE6_XaE-SnjDviB433SeRqXeSC9K_qgTd8mltf1cP8OKra6rXsoDkKOPkM8I4dIhTOb6KV3AOKCFBu2yCTEbBGQDFvTceiAvSP1-QLv_Dhp:1p8gvF:G0GXhPjapPe-9ib9rI9s9UAF3aGUZE9xphEQrG5IR8g', '2023-01-06 12:13:09.600575');

-- --------------------------------------------------------

--
-- Table structure for table `users_customuser`
--

CREATE TABLE `users_customuser` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `profile_pic` varchar(100) NOT NULL,
  `cid_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users_customuser`
--

INSERT INTO `users_customuser` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `profile_pic`, `cid_id`) VALUES
(1, 'pbkdf2_sha256$390000$49lcSt3I9tL8M0bMvVyMOx$6/fJb8zu79Xnj+4CjpOzVodhZ5hCH4sa0RbGlHCUlvs=', '2022-12-23 22:11:03.146542', 1, 'sudiptabhatta', '', '', 'sudiptabhatta05@gmail.com', 1, 1, '2022-12-20 14:39:10.000000', 'default_person.jpg', NULL),
(2, 'pbkdf2_sha256$390000$tiGpmO0ozkbMX1KiXvoNqW$qJcesqYrdB7hJkbnCsuFiHhDNorUqZ4YvXX8lDsfF8s=', '2022-12-23 21:58:15.047721', 0, 'harrypotter', '', '', 'harrypotter@yahoo.com', 0, 1, '2022-12-20 14:43:02.000000', 'profile_pics/harry.jpg', 3),
(3, 'pbkdf2_sha256$390000$Sis4jAqLSwK9wWfU2zDWM1$n7t4yYQBXf8rqcKhUxoHP1jpMR7Jy0tsus6bMUgYvfs=', '2022-12-23 21:58:42.198811', 0, 'harmoine', '', '', 'harmoine@yahoo.com', 0, 1, '2022-12-20 14:49:41.000000', 'profile_pics/person2.jpg', 1),
(4, 'pbkdf2_sha256$390000$PqaWUdGoLVXnqMqsDERrx2$VZ1TdfOfraHifMkUM80Bd9a5BJewmVB5EaSxXADGhs8=', '2022-12-23 18:29:44.406545', 0, 'aishwariabhatta', '', '', 'aishwariabhatta@gmail.com', 0, 1, '2022-12-20 14:50:28.000000', 'default_person.jpg', 4),
(5, 'pbkdf2_sha256$390000$UlGgFe1rh65pdLN6pNaqZ3$6rfTzKuPnZmYPPad24EEigxKtVWFrO6Us2kSxntO6t8=', '2022-12-23 21:58:58.025999', 0, 'ron99', '', '', 'ron@gmail.com', 0, 1, '2022-12-20 15:13:47.000000', 'default_person.jpg', 3),
(6, 'pbkdf2_sha256$390000$6ib8bu4pFL5Tv0qPF42zUE$VIlhkYa2h20c+hLq/8XkOXh+Q30AKBnnfLA70Ex7Lxs=', NULL, 0, 'hagrid9', '', '', 'hagrid@gmail.com', 0, 1, '2022-12-23 17:38:48.066179', 'default_person.jpg', 2);

-- --------------------------------------------------------

--
-- Table structure for table `users_customuser_groups`
--

CREATE TABLE `users_customuser_groups` (
  `id` bigint(20) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users_customuser_groups`
--

INSERT INTO `users_customuser_groups` (`id`, `customuser_id`, `group_id`) VALUES
(1, 1, 2),
(5, 2, 1),
(4, 3, 1),
(3, 4, 1),
(2, 5, 1),
(6, 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users_customuser_user_permissions`
--

CREATE TABLE `users_customuser_user_permissions` (
  `id` bigint(20) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users_customuser_user_permissions`
--

INSERT INTO `users_customuser_user_permissions` (`id`, `customuser_id`, `permission_id`) VALUES
(1, 1, 11);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `blog_category`
--
ALTER TABLE `blog_category`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `blog_comment`
--
ALTER TABLE `blog_comment`
  ADD PRIMARY KEY (`commentid`),
  ADD KEY `blog_comment_aid_id_13f359d1_fk_blog_post_aid` (`aid_id`),
  ADD KEY `blog_comment_author_id_4f11e2e0_fk_users_customuser_id` (`author_id`);

--
-- Indexes for table `blog_post`
--
ALTER TABLE `blog_post`
  ADD PRIMARY KEY (`aid`),
  ADD KEY `blog_post_author_id_dd7a8485_fk_users_customuser_id` (`author_id`),
  ADD KEY `blog_post_cid_id_10c12cac_fk_blog_category_cid` (`cid_id`);

--
-- Indexes for table `blog_post_like`
--
ALTER TABLE `blog_post_like`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `blog_post_like_post_id_customuser_id_31dc8dd7_uniq` (`post_id`,`customuser_id`),
  ADD KEY `blog_post_like_customuser_id_b0cf4b4d_fk_users_customuser_id` (`customuser_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_users_customuser_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `users_customuser`
--
ALTER TABLE `users_customuser`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `users_customuser_cid_id_54438835_fk_blog_category_cid` (`cid_id`);

--
-- Indexes for table `users_customuser_groups`
--
ALTER TABLE `users_customuser_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_customuser_groups_customuser_id_group_id_76b619e3_uniq` (`customuser_id`,`group_id`),
  ADD KEY `users_customuser_groups_group_id_01390b14_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `users_customuser_user_permissions`
--
ALTER TABLE `users_customuser_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_customuser_user_pe_customuser_id_permission_7a7debf6_uniq` (`customuser_id`,`permission_id`),
  ADD KEY `users_customuser_use_permission_id_baaa2f74_fk_auth_perm` (`permission_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `blog_category`
--
ALTER TABLE `blog_category`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `blog_comment`
--
ALTER TABLE `blog_comment`
  MODIFY `commentid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `blog_post`
--
ALTER TABLE `blog_post`
  MODIFY `aid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `blog_post_like`
--
ALTER TABLE `blog_post_like`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `users_customuser`
--
ALTER TABLE `users_customuser`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users_customuser_groups`
--
ALTER TABLE `users_customuser_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users_customuser_user_permissions`
--
ALTER TABLE `users_customuser_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `blog_comment`
--
ALTER TABLE `blog_comment`
  ADD CONSTRAINT `blog_comment_aid_id_13f359d1_fk_blog_post_aid` FOREIGN KEY (`aid_id`) REFERENCES `blog_post` (`aid`),
  ADD CONSTRAINT `blog_comment_author_id_4f11e2e0_fk_users_customuser_id` FOREIGN KEY (`author_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `blog_post`
--
ALTER TABLE `blog_post`
  ADD CONSTRAINT `blog_post_author_id_dd7a8485_fk_users_customuser_id` FOREIGN KEY (`author_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `blog_post_cid_id_10c12cac_fk_blog_category_cid` FOREIGN KEY (`cid_id`) REFERENCES `blog_category` (`cid`);

--
-- Constraints for table `blog_post_like`
--
ALTER TABLE `blog_post_like`
  ADD CONSTRAINT `blog_post_like_customuser_id_b0cf4b4d_fk_users_customuser_id` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `blog_post_like_post_id_037242b6_fk_blog_post_aid` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`aid`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_users_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`);

--
-- Constraints for table `users_customuser`
--
ALTER TABLE `users_customuser`
  ADD CONSTRAINT `users_customuser_cid_id_54438835_fk_blog_category_cid` FOREIGN KEY (`cid_id`) REFERENCES `blog_category` (`cid`);

--
-- Constraints for table `users_customuser_groups`
--
ALTER TABLE `users_customuser_groups`
  ADD CONSTRAINT `users_customuser_gro_customuser_id_958147bf_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `users_customuser_groups_group_id_01390b14_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `users_customuser_user_permissions`
--
ALTER TABLE `users_customuser_user_permissions`
  ADD CONSTRAINT `users_customuser_use_customuser_id_5771478b_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  ADD CONSTRAINT `users_customuser_use_permission_id_baaa2f74_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

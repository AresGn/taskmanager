-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 29 avr. 2025 à 09:01
-- Version du serveur : 8.2.0
-- Version de PHP : 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gestion_taches2`
--

-- --------------------------------------------------------

--
-- Structure de la table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `checklist_items`
--

DROP TABLE IF EXISTS `checklist_items`;
CREATE TABLE IF NOT EXISTS `checklist_items` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `task_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `checklist_items_task_id_foreign` (`task_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `checklist_items`
--

INSERT INTO `checklist_items` (`id`, `task_id`, `name`, `completed`, `created_at`, `updated_at`) VALUES
(1, 1, 'Créer le logo', 0, '2025-04-26 03:38:34', '2025-04-26 03:38:34'),
(2, 1, 'Préparer les bannières', 0, '2025-04-26 03:38:34', '2025-04-26 03:38:34'),
(3, 1, 'Créer les visuels Instagram', 0, '2025-04-26 03:38:34', '2025-04-26 03:38:34'),
(4, 2, 'Rédiger l\'introduction', 1, '2025-04-26 03:38:34', '2025-04-26 03:38:34'),
(5, 2, 'Rédiger les descriptions de produits', 0, '2025-04-26 03:38:34', '2025-04-26 03:38:34'),
(6, 2, 'Rédiger les témoignages', 0, '2025-04-26 03:38:34', '2025-04-26 03:38:34'),
(7, 4, 'Wireframe', 1, '2025-04-26 03:38:34', '2025-04-26 03:38:34'),
(8, 4, 'Maquette desktop', 0, '2025-04-26 03:38:34', '2025-04-26 03:38:34'),
(9, 4, 'Maquette mobile', 0, '2025-04-26 03:38:34', '2025-04-26 03:38:34');

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `files`
--

DROP TABLE IF EXISTS `files`;
CREATE TABLE IF NOT EXISTS `files` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `files_user_id_foreign` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2024_05_21_195304create_projects_table', 1),
(5, '2024_05_21_195305_create_tasks_table', 1),
(6, '2024_05_21_195441_create_routines_table', 1),
(7, '2024_05_21_195502_create_reminders_table', 1),
(8, '2024_05_21_195601_create_notes_table', 1),
(9, '2024_05_22_204822_create_files_table', 1),
(10, '2024_05_24_115740_create_checklist_items_table', 1),
(11, '2024_08_04_151245_create_project_teams_table', 1),
(12, '2025_04_25_222131_add_completed_at_to_tasks_table', 2),
(13, '2025_04_25_222152_add_workdays_only_to_routines_table', 2),
(14, '2025_04_25_222157_add_workdays_only_to_routines_table', 2),
(15, '2025_04_25_222216_add_email_sent_to_reminders_table', 2),
(16, '2025_04_26_160419_update_due_date_column_to_datetime', 3);

-- --------------------------------------------------------

--
-- Structure de la table `notes`
--

DROP TABLE IF EXISTS `notes`;
CREATE TABLE IF NOT EXISTS `notes` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notes_user_id_foreign` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `projects`
--

DROP TABLE IF EXISTS `projects`;
CREATE TABLE IF NOT EXISTS `projects` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('not_started','in_progress','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'not_started',
  `budget` decimal(15,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projects_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `projects`
--

INSERT INTO `projects` (`id`, `user_id`, `name`, `description`, `start_date`, `end_date`, `status`, `budget`, `created_at`, `updated_at`) VALUES
(1, 2, 'Projet Marketing Digital', 'Campagne publicitaire pour le lancement du nouveau produit', '2024-08-01', '2024-10-30', 'in_progress', 5000.00, '2025-04-26 03:37:57', '2025-04-26 03:37:57'),
(2, 2, 'Refonte Site Web', 'Mise à jour complète du site corporate', '2024-12-25', '2025-04-28', 'in_progress', 8000.00, '2025-04-26 03:37:57', '2025-04-26 03:37:57'),
(3, 2, 'Analyse de données', 'Analyse des KPIs du dernier trimestre', '2024-09-01', '2024-09-30', 'not_started', 2000.00, '2025-04-26 03:37:57', '2025-04-26 03:37:57');

-- --------------------------------------------------------

--
-- Structure de la table `project_teams`
--

DROP TABLE IF EXISTS `project_teams`;
CREATE TABLE IF NOT EXISTS `project_teams` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `project_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `role` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'member',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_teams_project_id_foreign` (`project_id`),
  KEY `project_teams_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `project_teams`
--

INSERT INTO `project_teams` (`id`, `project_id`, `user_id`, `role`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'owner', '2025-04-26 03:39:40', '2025-04-26 03:39:40'),
(2, 2, 1, 'owner', '2025-04-26 03:39:40', '2025-04-26 03:39:40'),
(3, 3, 1, 'owner', '2025-04-26 03:39:40', '2025-04-26 03:39:40');

-- --------------------------------------------------------

--
-- Structure de la table `reminders`
--

DROP TABLE IF EXISTS `reminders`;
CREATE TABLE IF NOT EXISTS `reminders` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `email_sent` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `reminders_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `reminders`
--

INSERT INTO `reminders` (`id`, `title`, `description`, `date`, `time`, `user_id`, `created_at`, `updated_at`, `email_sent`) VALUES
(1, 'Réunion de projet', 'Réunion avec l\'équipe marketing', '2025-04-26', '06:39', 2, '2025-04-26 03:39:01', '2025-04-26 03:39:01', 0),
(2, 'Appel client', 'Appel avec le client pour le projet de refonte', '2025-04-27', '10:00', 2, '2025-04-26 03:39:01', '2025-04-26 03:39:01', 0),
(3, 'Validation des visuels', 'Rappel pour valider les visuels de la campagne', '2025-04-25', '14:00', 2, '2025-04-26 03:39:01', '2025-04-26 03:39:01', 1);

-- --------------------------------------------------------

--
-- Structure de la table `routines`
--

DROP TABLE IF EXISTS `routines`;
CREATE TABLE IF NOT EXISTS `routines` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `frequency` enum('daily','weekly','monthly') COLLATE utf8mb4_unicode_ci NOT NULL,
  `days` json DEFAULT NULL,
  `weeks` json DEFAULT NULL,
  `months` json DEFAULT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `workdays_only` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `routines_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `routines`
--

INSERT INTO `routines` (`id`, `user_id`, `title`, `description`, `frequency`, `days`, `weeks`, `months`, `start_time`, `end_time`, `created_at`, `updated_at`, `workdays_only`) VALUES
(1, 2, 'Vérification des emails', 'Consulter et répondre aux emails importants', 'daily', '[\"monday\", \"tuesday\", \"wednesday\", \"thursday\", \"friday\"]', NULL, NULL, '09:00:00', '09:30:00', '2025-04-26 04:05:21', '2025-04-26 04:05:21', 0),
(2, 2, 'Réunion d\'équipe', 'Réunion hebdomadaire pour discuter de l\'avancement du projet', 'weekly', '[\"monday\"]', NULL, NULL, '10:00:00', '11:00:00', '2025-04-26 04:05:21', '2025-04-26 04:05:21', 0),
(3, 2, 'Rapport mensuel', 'Préparation du rapport mensuel d\'activité', 'monthly', NULL, '[1]', '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]', '14:00:00', '16:00:00', '2025-04-26 04:05:21', '2025-04-26 04:05:21', 0);

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE IF NOT EXISTS `tasks` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `project_id` bigint UNSIGNED NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `due_date` datetime DEFAULT NULL,
  `priority` enum('low','medium','high') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('to_do','in_progress','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'to_do',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tasks_user_id_foreign` (`user_id`),
  KEY `tasks_project_id_foreign` (`project_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `tasks`
--

INSERT INTO `tasks` (`id`, `user_id`, `project_id`, `title`, `description`, `due_date`, `priority`, `status`, `created_at`, `updated_at`, `completed_at`) VALUES
(2, 2, 1, 'Rédaction du contenu', 'Rédiger le contenu pour la landing page', '2025-05-01 00:00:00', 'medium', 'in_progress', '2025-04-26 03:38:10', '2025-04-28 10:57:27', NULL),
(4, 2, 2, 'Design de la page d\'accueil', 'Maquette de la nouvelle page d\'accueil', '2025-04-25 00:00:00', 'high', 'to_do', '2025-04-26 03:38:11', '2025-04-27 04:43:08', NULL),
(5, 2, 3, 'Collecte des données', 'Extraire les données des différentes sources', '2025-05-16 00:00:00', 'medium', 'completed', '2025-04-26 03:38:11', '2025-04-28 10:57:51', NULL),
(6, 2, 1, 'Tâche avec rappel imminent', 'Cette tâche devrait déclencher un email de rappel 30 minutes après sa date d\'échéance', '2025-04-26 00:00:00', 'high', 'to_do', '2025-04-26 04:06:51', '2025-04-26 04:06:51', NULL),
(7, 2, 1, 'Tâche non validée', 'Cette tâche n\'a pas été validée 30 minutes après l\'échéance et devrait déclencher un email', '2025-04-26 00:00:00', 'high', 'completed', '2025-04-26 04:06:51', '2025-04-26 16:57:39', NULL),
(8, 2, 2, 'Tâche test pour email de retard', 'Cette tâche est créée spécifiquement pour tester l\'envoi d\'email de rappel après 30 minutes', '2025-04-26 00:00:00', 'high', 'completed', '2025-04-26 15:57:21', '2025-04-26 16:57:41', NULL),
(9, 2, 1, 'Tâche test avec heure précise', 'Cette tâche est configurée pour déclencher un email maintenant', '2025-04-26 00:00:00', 'high', 'in_progress', '2025-04-26 16:01:28', '2025-04-26 16:57:43', NULL),
(10, 2, 1, 'Tâche test avec datetime', 'Cette tâche utilise le nouveau format datetime pour déclencher un email de rappel', '2025-04-26 16:41:13', 'high', 'to_do', '2025-04-26 16:13:13', '2025-04-26 16:13:13', NULL),
(13, 2, 1, 'Tâche avec fuseau horaire Bénin', 'Cette tâche est configurée avec le fuseau horaire Africa/Porto-Novo', '2025-04-26 17:00:33', 'high', 'to_do', '2025-04-26 16:32:33', '2025-04-26 16:32:33', NULL),
(14, 2, 3, 'Tâche  pour tester que ça marche ', 'Cette tâche est configurée avec le fuseau horaire Africa/Porto-Novo', '2025-04-28 11:23:25', 'high', 'in_progress', '2025-04-28 10:55:25', '2025-04-28 10:57:53', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Arafat Hossain', 'admin@example.com', '2025-04-25 19:43:31', '$2y$12$YQdfiOBmaggQw0qIirekB.mHj4Fxd7BR1gQbXDCwN4o9I6LD9qMjK', 'jH9smpc2Hp4PUqG4KF8tDcmUrj6gJXv2q5rUqwQgShtCZo2i3U1u2VJ3V53Y', '2025-04-25 19:43:32', '2025-04-25 19:43:32'),
(2, 'GNIMAGNON Ares', 'aresgnimagnon0@gmail.com', NULL, '$2y$12$QxMAbEV13cCqOIA4ycB5WOI97AvDbB9xONH.YzYUJ2kzuPKlEOFFa', NULL, '2025-04-26 02:29:37', '2025-04-26 02:29:37'),
(3, 'Billions', 'ares0@gmail.com', '2025-04-29 03:15:41', '$2y$12$qENZ7ixbvdGOjWgtHj/P4uIDJw4Yj4r55EF3teVkWbCb2Omwo/c2.', 'zThrQ3Ox4jOdLKlvDVYqCecX60zvAta8CVAPSaRLeZcho1i6DAMb6wnLPzjR', '2025-04-29 03:14:37', '2025-04-29 03:26:54');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

CREATE TABLE IF NOT EXISTS season_foods_navi.foods (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `base_food` INT(11) DEFAULT NULL,
  `picture` VARCHAR(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `months` VARCHAR(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pref_id` INT(11) DEFAULT NULL,
  `post` TINYINT(1) DEFAULT 1,

  PRIMARY KEY (`id`),
  KEY `pref_id` (`pref_id`),
  CONSTRAINT `foods_ibfk_1` FOREIGN KEY (`pref_id`) REFERENCES `prefecture` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS season_foods_navi.recipes (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `picture` VARCHAR(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `foods` LONGTEXT COLLATE utf8_unicode_ci DEFAULT NULL,
  `pref_id` INT(11) DEFAULT NULL,
  `howto` LONGTEXT COLLATE utf8_unicode_ci DEFAULT NULL,
  `post` TINYINT(1) DEFAULT 1,

  PRIMARY KEY (`id`),
  KEY `pref_id` (`pref_id`),
  CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`pref_id`) REFERENCES `prefecture` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS season_foods_navi.prefecture (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(255) COLLATE utf8_unicode_ci DEFAULT NULL,

  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

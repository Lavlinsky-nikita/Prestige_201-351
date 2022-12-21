-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Хост: std-mysql
-- Время создания: Дек 21 2022 г., 18:58
-- Версия сервера: 5.7.26-0ubuntu0.16.04.1
-- Версия PHP: 8.0.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `std_1689_prestige`
--
CREATE DATABASE IF NOT EXISTS `prestige_test_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `prestige_test_db`;


-- --------------------------------------------------------

--
-- Структура таблицы `alembic_version`
--

CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `alembic_version`
--

INSERT INTO `alembic_version` (`version_num`) VALUES
('c72e5d0f5942');

-- --------------------------------------------------------

--
-- Структура таблицы `buildings`
--

CREATE TABLE `buildings` (
  `building_id` int(11) NOT NULL,
  `departament_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `buildings`
--

INSERT INTO `buildings` (`building_id`, `departament_id`, `name`) VALUES
(1, 1, 'Корпус А'),
(2, 1, 'Корпус А');

-- --------------------------------------------------------

--
-- Структура таблицы `departaments`
--

CREATE TABLE `departaments` (
  `departament_id` int(11) NOT NULL,
  `departament_type_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `departaments`
--

INSERT INTO `departaments` (`departament_id`, `departament_type_id`, `name`) VALUES
(1, 1, 'Факультет Информационных технологий'),
(2, 1, 'факультет машиностроения');

-- --------------------------------------------------------

--
-- Структура таблицы `departament_types`
--

CREATE TABLE `departament_types` (
  `departament_type_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `departament_types`
--

INSERT INTO `departament_types` (`departament_type_id`, `name`) VALUES
(1, '1 Тип департамента'),
(2, '2 тип департамента');

-- --------------------------------------------------------

--
-- Структура таблицы `placements`
--

CREATE TABLE `placements` (
  `placement_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `floor` int(11) NOT NULL,
  `number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `placements`
--

INSERT INTO `placements` (`placement_id`, `name`, `floor`, `number`) VALUES
(1, 'Расположение', 2, 204);

-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `role_description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `rooms`
--

CREATE TABLE `rooms` (
  `room_id` int(11) NOT NULL,
  `building_id` int(11) DEFAULT NULL,
  `room_type_id` int(11) DEFAULT NULL,
  `room_height_type_id` int(11) DEFAULT NULL,
  `placement_id` int(11) DEFAULT NULL,
  `width` int(11) NOT NULL,
  `length` int(11) NOT NULL,
  `height` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `rooms`
--

INSERT INTO `rooms` (`room_id`, `building_id`, `room_type_id`, `room_height_type_id`, `placement_id`, `width`, `length`, `height`) VALUES
(1, 1, 1, 1, 1, 4, 6, 3),
(2, 1, 1, 1, 1, 13, 5, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `room_height_type`
--

CREATE TABLE `room_height_type` (
  `room_height_type_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `room_height_type`
--

INSERT INTO `room_height_type` (`room_height_type_id`, `name`) VALUES
(1, 'Высота типа помещения');

-- --------------------------------------------------------

--
-- Структура таблицы `room_type`
--

CREATE TABLE `room_type` (
  `room_type_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `room_type`
--

INSERT INTO `room_type` (`room_type_id`, `name`) VALUES
(1, 'Тип комнаты');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `login` varchar(100) NOT NULL,
  `password_hash` varchar(200) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `alembic_version`
--
ALTER TABLE `alembic_version`
  ADD PRIMARY KEY (`version_num`);

--
-- Индексы таблицы `buildings`
--
ALTER TABLE `buildings`
  ADD PRIMARY KEY (`building_id`),
  ADD KEY `fk_buildings_departament_id_departaments` (`departament_id`);

--
-- Индексы таблицы `departaments`
--
ALTER TABLE `departaments`
  ADD PRIMARY KEY (`departament_id`),
  ADD KEY `fk_departaments_departament_type_id_departament_types` (`departament_type_id`);

--
-- Индексы таблицы `departament_types`
--
ALTER TABLE `departament_types`
  ADD PRIMARY KEY (`departament_type_id`);

--
-- Индексы таблицы `placements`
--
ALTER TABLE `placements`
  ADD PRIMARY KEY (`placement_id`);

--
-- Индексы таблицы `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`room_id`),
  ADD KEY `fk_rooms_building_id_buildings` (`building_id`),
  ADD KEY `fk_rooms_placement_id_placements` (`placement_id`),
  ADD KEY `fk_rooms_room_height_type_id_room_height_type` (`room_height_type_id`),
  ADD KEY `fk_rooms_room_type_id_room_type` (`room_type_id`);

--
-- Индексы таблицы `room_height_type`
--
ALTER TABLE `room_height_type`
  ADD PRIMARY KEY (`room_height_type_id`);

--
-- Индексы таблицы `room_type`
--
ALTER TABLE `room_type`
  ADD PRIMARY KEY (`room_type_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_users_login` (`login`),
  ADD KEY `fk_users_role_id_roles` (`role_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `buildings`
--
ALTER TABLE `buildings`
  MODIFY `building_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `departaments`
--
ALTER TABLE `departaments`
  MODIFY `departament_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `departament_types`
--
ALTER TABLE `departament_types`
  MODIFY `departament_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `placements`
--
ALTER TABLE `placements`
  MODIFY `placement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `room_height_type`
--
ALTER TABLE `room_height_type`
  MODIFY `room_height_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `room_type`
--
ALTER TABLE `room_type`
  MODIFY `room_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `buildings`
--
ALTER TABLE `buildings`
  ADD CONSTRAINT `fk_buildings_departament_id_departaments` FOREIGN KEY (`departament_id`) REFERENCES `departaments` (`departament_id`);

--
-- Ограничения внешнего ключа таблицы `departaments`
--
ALTER TABLE `departaments`
  ADD CONSTRAINT `fk_departaments_departament_type_id_departament_types` FOREIGN KEY (`departament_type_id`) REFERENCES `departament_types` (`departament_type_id`);

--
-- Ограничения внешнего ключа таблицы `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `fk_rooms_building_id_buildings` FOREIGN KEY (`building_id`) REFERENCES `buildings` (`building_id`),
  ADD CONSTRAINT `fk_rooms_placement_id_placements` FOREIGN KEY (`placement_id`) REFERENCES `placements` (`placement_id`),
  ADD CONSTRAINT `fk_rooms_room_height_type_id_room_height_type` FOREIGN KEY (`room_height_type_id`) REFERENCES `room_height_type` (`room_height_type_id`),
  ADD CONSTRAINT `fk_rooms_room_type_id_room_type` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`room_type_id`);

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_role_id_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Сен 08 2019 г., 18:32
-- Версия сервера: 8.0.17
-- Версия PHP: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- База данных: `forum`
--

-- --------------------------------------------------------

--
-- Структура таблицы `hierarhy`
--

CREATE TABLE `hierarhy` (
                            `id` int(8) NOT NULL,
                            `parentId` int(8) DEFAULT NULL,
                            `linkName` varchar(255) DEFAULT NULL,
                            `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `hierarhy`
--

INSERT INTO `hierarhy` (`id`, `parentId`, `linkName`, `name`) VALUES
(1, 5, 'razdel1', 'Раздел 1'),
(2, 5, 'razdel2', 'раздел 2'),
(3, 1, 'subrazdel1-1', 'Подраздел 1 Раздела 1'),
(4, 1, 'subrazdel1-2', 'Подраздел 2 Раздела 1'),
(5, NULL, '0', 'forum');

-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

CREATE TABLE `posts` (
                         `id` int(8) NOT NULL,
                         `parentId` int(11) DEFAULT NULL,
                         `dateCreate` datetime NOT NULL,
                         `hierarhyId` int(8) DEFAULT NULL,
                         `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
                         `text` text NOT NULL,
                         `author` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `posts`
--

INSERT INTO `posts` (`id`, `parentId`, `dateCreate`, `hierarhyId`, `title`, `text`, `author`) VALUES
(4, NULL, '2019-09-08 10:53:48', 1, 'Тема 1. Нужна помощь с компом', 'Друзья. подскажите Как собрать компьютер', 'Коля'),
(5, NULL, '2019-09-08 10:55:11', 1, 'Тема 2', '', 'Петя'),
(6, NULL, '2019-09-08 10:56:07', 1, 'Тема 3', '1234', '123'),
(7, 4, '2019-09-08 18:24:56', NULL, '', 'Ответ 1 в теме 1', 'Иван'),
(8, 4, '2019-09-08 18:24:50', NULL, '', 'ответ 2 в теме 1', 'Петр'),
(9, 6, '2019-09-08 18:26:33', NULL, '', 'Ответ 1 тема 3', 'Сергей'),
(10, NULL, '2019-09-08 21:20:01', 2, 'тема в раздел 2', 'Привет. проверка связи в разделе 2', 'коля');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `hierarhy`
--
ALTER TABLE `hierarhy`
    ADD PRIMARY KEY (`id`),
    ADD KEY `parentId` (`parentId`),
    ADD KEY `linkName` (`linkName`);

--
-- Индексы таблицы `posts`
--
ALTER TABLE `posts`
    ADD PRIMARY KEY (`id`),
    ADD KEY `parentId` (`parentId`),
    ADD KEY `dateCreate` (`dateCreate`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `hierarhy`
--
ALTER TABLE `hierarhy`
    MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `posts`
--
ALTER TABLE `posts`
    MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
COMMIT;

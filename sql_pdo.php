<?php
$dsn = "mysql:dbname=forum;host=localhost";
$sql_user = "root";
$sql_password = "21302130";

try {
	$pdo = new PDO($dsn, $sql_user, $sql_password, array(
		PDO::MYSQL_ATTR_LOCAL_INFILE => true,
		PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8",
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
	));
} catch (PDOException $e) {
	echo("Can't connect to MySql - " . $e->getMessage());
}


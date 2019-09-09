<?php
/**
 * Created by PhpStorm.
 * User: shornikov
 * Date: 22.10.2018
 * Time: 20:38
 */


class BasePage
{
	function __construct()
	{
	}



	function Error($text = "Page not found", $code = 404)
	{
		if ($code == 404) {
			header("HTTP/1.0 404 Not Found");
		}
		print ("Error. $text");
	}

	function breadcrumb($id)
	{
		//todo быбрасывать средне-начальные при большом количестве элементов

		global $pdo;
		$query = "select * from sections where id=:id";
		$stmt = $pdo->prepare($query);
		$stmt->bindParam(":id", $id);
		$stmt->execute();

		if ($stmt->errorCode() != PDO::ERR_NONE) {
			print_r($stmt->errorInfo());
		}
		$result = $stmt->fetch();

		$levels = [];
		array_push($levels, $result);

		while ($result['parentId'] != null) {
			$query = "select * from sections where id=:id";
			$stmt = $pdo->prepare($query);
			$stmt->bindParam(":id", $result['parentId']);
			$stmt->execute();

			if ($stmt->errorCode() != PDO::ERR_NONE) {
				print_r($stmt->errorInfo());
			}
			$result = $stmt->fetch();
			array_push($levels, $result);
		}
		$levels = array_reverse($levels);
		return $levels;
	}
}


<?php
/**
 * Created by PhpStorm.
 * User: shornikov
 * Date: 22.10.2018
 * Time: 20:38
 */


class Topic extends BasePage
{

	function draw($topic)
	{
		global $pdo;
		//стартовый пост
		$query = "select * from posts where id = :topic and parentId is null";
		$stmt = $pdo->prepare($query);
		$stmt->bindParam(":topic", $topic);
		$stmt->execute();

		if ($stmt->errorCode() != PDO::ERR_NONE) {
			print_r($stmt->errorInfo());
		}

		if ($stmt->rowCount() == 0) {
			$this->Error();
			die();
		}

		$data = $stmt->fetch();
		//print_r($data);

		$levels = $this->breadcrumb($data['hierarhyId']);

		foreach ($levels as $key => $level) {
			$data['breadcrumb'][$key]['name'] = $level['name'];
			$data['breadcrumb'][$key]['link'] = "/" . $level['linkName'];
		}

		//ответы
		$query = "select text,author,dateCreate from posts where parentId = :topic order by dateCreate";
		$stmt = $pdo->prepare($query);
		$stmt->bindParam(":topic", $data['id']);
		$stmt->execute();

		if ($stmt->errorCode() != PDO::ERR_NONE) {
			print_r($stmt->errorInfo());
		}
		$data['topics'] = $stmt->fetchAll();

		//собираем xml
		$xml_data = new array2xml('root');
		$xml_data->createNode($data);
//		echo $xml_data;


		$xslt = new xsltProcessor();
		$xsl = new DomDocument();

		$xsl->load('topic.xsl');
		$xslt->importStyleSheet($xsl);
		echo $xslt->transformToXML($xml_data);
	}

	/**
	 * Запись в базу новой темы
	 */
	function addTopic()
	{
		global $pdo;
		$query = "select * from hierarhy where linkName = :razdel order by id";
		$stmt = $pdo->prepare($query);
		$stmt->bindParam(":razdel", $_POST['razdel']);
		$stmt->execute();

		if ($stmt->errorCode() != PDO::ERR_NONE) {
			print_r($stmt->errorInfo());
		}

		$razdel = $stmt->fetch();

		$query = "insert into posts set
                    	dateCreate=now(),
                      parentId = null,
                      title=:title,
                      hierarhyId=:razdel,
                      text=:text,
                      author=:author
                      ";
		$stmt = $pdo->prepare($query);
		$_POST['text'] = strip_tags($_POST['text']) ?? "";
		$_POST['title'] = strip_tags($_POST['title']) ?? "";
		$_POST['author'] = strip_tags($_POST['author']) ?? "";
		$stmt->bindParam(":razdel", $razdel['id']);
		$stmt->bindParam(":text", $_POST['text']);
		$stmt->bindParam(":title", $_POST['title']);
		$stmt->bindParam(":author", $_POST['author']);
		$stmt->execute();

		if ($stmt->errorCode() != PDO::ERR_NONE) {
			print_r($stmt->errorInfo());
		}
		if ($pdo->lastInsertId() > 0) {
			header("Location: /" . $razdel['linkName']);
		}
	}

	/**
	 * запись ответов
	 */
	function addPost()
	{
		global $pdo;

		$query = "insert into posts set
                      dateCreate=now(),
                      parentId = :id,
                      hierarhyId=:razdel,
                      text=:text,
                      author=:author
                      ";
		$stmt = $pdo->prepare($query);
		$_POST['text'] = strip_tags($_POST['text']) ?? "";
		$_POST['author'] = strip_tags($_POST['author']) ?? "";
		$stmt->bindParam(":razdel", $_POST['razdel']);
		$stmt->bindParam(":id", $_POST['parentId']);
		$stmt->bindParam(":text", $_POST['text']);
		$stmt->bindParam(":author", $_POST['author']);
		$stmt->execute();

		if ($stmt->errorCode() != PDO::ERR_NONE) {
			print_r($stmt->errorInfo());
		}
		if ($pdo->lastInsertId() > 0) {
			header("Location: /topic/" . $_POST['parentId']);
		}
	}


}


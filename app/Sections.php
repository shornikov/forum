<?php
/**
 * Created by PhpStorm.
 * User: shornikov
 * Date: 22.10.2018
 * Time: 20:38
 */


class Sections extends BasePage
{
	function draw($razdel = 0)
	{
		global $pdo;

		$query = "select * from hierarhy where linkName = :razdel order by id";
		$stmt = $pdo->prepare($query);
		$stmt->bindParam(":razdel", $razdel);
		$stmt->execute();

		if ($stmt->errorCode() != PDO::ERR_NONE) {
			print_r($stmt->errorInfo());
		}

		$data = $stmt->fetch();

		$levels = $this->breadcrumb($data['id']);

		foreach ($levels as $key => $level) {
			$data['breadcrumb'][$key]['name'] = $level['name'];
			$data['breadcrumb'][$key]['link'] = "/" . $level['linkName'];
		}

		$query = "select * from hierarhy where parentId = :parentId order by id";
		$stmt = $pdo->prepare($query);
		$stmt->bindParam(":parentId", $data['id']);
		$stmt->execute();

		if ($stmt->errorCode() != PDO::ERR_NONE) {
			print_r($stmt->errorInfo());
		}

		$data['subSections'] = $stmt->fetchAll();


		$data['topics'] = $this->getTopics($data['id']);


		//собираем xml
		$xml_data = new array2xml('root');
		$xml_data->createNode($data);
//		echo $xml_data;


		$xslt = new xsltProcessor();
		$xsl = new DomDocument();

		$xsl->load('sections.xsl');
		$xslt->importStyleSheet($xsl);
		echo $xslt->transformToXML($xml_data);
	}

	function getTopics($id)
	{
		global $pdo;
		$query = "select id,dateCreate,title,author from posts where parentId is null and hierarhyId=:id";
		$stmt = $pdo->prepare($query);
		$stmt->bindParam(":id", $id);
		$stmt->execute();

		if ($stmt->errorCode() != PDO::ERR_NONE) {
			print_r($stmt->errorInfo());
		}
		$result = $stmt->fetchAll();
		return $result;

	}
}



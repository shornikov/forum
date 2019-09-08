<?php
require __DIR__ . '/vendor/autoload.php';
require __DIR__ . '/sql_pdo.php';


$dispatcher = FastRoute\simpleDispatcher(function (FastRoute\RouteCollector $r) {


	$r->addRoute("GET", "/", "Sections/draw");
	$r->addRoute("POST", "/addtopic", "Topic/addtopic");
	$r->addRoute("POST", "/addpost", "Topic/addpost");

	$r->addRoute("GET", "/{razdel}", "Sections/draw");
	$r->addRoute("GET", "/topic/{topic}", "Topic/draw");
});

$httpMethod = $_SERVER['REQUEST_METHOD'];
$uri = $_SERVER['REQUEST_URI'];

// Strip query string (?foo=bar) and decode URI
if (false !== $pos = strpos($uri, '?')) {
	$uri = substr($uri, 0, $pos);
}
$uri = rawurldecode($uri);
//$uri = rawurldecode(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));

$routeInfo = $dispatcher->dispatch($httpMethod, $uri);

$basePage = new BasePage();
switch ($routeInfo[0]) {
	case FastRoute\Dispatcher::NOT_FOUND:
		$basePage->Error();
		break;
	case FastRoute\Dispatcher::METHOD_NOT_ALLOWED:
		$allowedMethods = $routeInfo[1];
		print_r($allowedMethods);
		$basePage->Error("Software error", 501);
// ... 405 Method Not Allowed
		break;
	case FastRoute\Dispatcher::FOUND:
		$handler = $routeInfo[1];
		$vars = $routeInfo[2];
		list($class, $method) = explode("/", $handler, 2);
		call_user_func_array(array(new $class, $method), $vars);
		break;
}

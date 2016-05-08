<?php 

include_once('data.php');


//get and verify the request object
isset($_REQUEST['request']) or die('Go Away!');
$req = json_decode($_REQUEST['request'], true);  //decode to associative arrays
isset($req['function']) or die('Go Away!');
isset($req['params']) or die('Go Away!');

switch($req['function']) {
  case 'deleteCourse':
    $res = deleteCourse($req['params']['courseID'], $req['params']['userID']);
    break;

  case 'createCourse':
    $res = createCourse($req['params']['name'], $req['params']['code'], $req['params']['prospectus'], $req['params']['userID']);
    break;

  case 'deleteDomain':
    $res = deleteDomain($req['params']['domainID'], $req['params']['userID']);
    break;
  
  case 'createDomain':
    $res = createDomain($req['params']['title'], $req['params']['dept'], $req['params']['userID']);
    break; 
}

echo json_encode($res);

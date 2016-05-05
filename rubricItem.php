<?php

include_once('includes/coreDB.php');
//TODO: Make sure they have permissions

if(isset($_REQUEST['mode'])) {

  if($_REQUEST['mode'] == 'update') {
    $rubricInfo = getRubricItemInfo($_REQUEST['rID']);
  } else if($_REQUEST['mode'] == 'create') {
    $valid = true;

  }
}

$pageTitle = "Rubric Item";
$content = "rubricItem.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "current", "courses" => "", "stats" => "");

include_once('pages/master.php');

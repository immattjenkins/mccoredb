<?php

include_once('includes/coreDB.php');
include_once('includes/protect.php');
//TODO: Messages

if(isset($_REQUEST['submit_score'])) {
  $valid = true;

  if($_REQUEST['score_level'] == "") {
    $valid = false;
    //msg
  }

  if($_REQUEST['explanation'] == "" ) {
    $valid = false;
    //msg
  }
 
  if($_REQUEST['score_num'] == "") {
    $valid = false;
    //msg
  }
   
  if($valid) { 
    $res = createItemRubricDescription($_REQUEST['score_num'], $_REQUEST['score_level'], $_REQUEST['explanation'], $_REQUEST['rubricItemID']);
    include_once('prospectus.php'); die();
  }
}

$pageTitle = "Managing Score Level";
$content = "createScoreLevel.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "current", "courses" => "", "stats" => "");

include_once('pages/master.php');

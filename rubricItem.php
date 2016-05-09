<?php

include_once('includes/coreDB.php');
include_once('includes/protect.php');

if(isset($_REQUEST['rubric_delete'])) {
  $deleteRID = isset($_REQUEST['rubricItemID'])? $_REQUEST['rubricItemID'] : $_REQUEST['rubricID'];
  deleteRubricItem($deleteRID);
  include_once('rubric.php'); die();
}

if(isset($_REQUEST['rubric_submit'])) {
  
  // Keeps track of the type of request
  $submitType = $_REQUEST['rubric_submit'];
  $valid = true;
  
  if($_REQUEST['rubric_title'] == "") {
    $valid = false;
    // msg
  }

  if($_REQUEST['rubric_question'] == "") {
    $valid = false;
    // msg 
  }

  // Update or create based on what type of request it is
  if($valid && $submitType == 'create') {
    createNewRubricItem($_REQUEST['rubric_title'], $_REQUEST['rubric_question'], $_REQUEST['rubricID']);
  } else if($valid && $submitType == 'update') {
    updateRubricItem($_REQUEST['rubric_title'], $_REQUEST['rubric_question'], $_REQUEST['rubricID']);
  }

  if($valid) {
   include_once('rubric.php'); die();
  }
}

if($_REQUEST['mode'] == 'update') {
  if(isset($_REQUEST['rubricItemID'])) {
    $rubricInfo = getRubricItemInfo($_REQUEST['rubricItemID']);
    $rubricItem = getRubricItemInfoByID($_REQUEST['rubricItemID']);
  } else {
    $rubricInfo = getRubricItemInfo($_REQUEST['rubricID']);
    $rubricItem = getRubricItemInfoByID($_REQUEST['rubricID']);
  }
}


$pageTitle = "Rubric Item";
$content = "rubricItem.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "current", "courses" => "", "stats" => "");

include_once('pages/master.php');

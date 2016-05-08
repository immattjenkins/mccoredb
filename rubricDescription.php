<?php

include_once('includes/coreDB.php');
//TODO: Make sure they have permissions

if(isset($_REQUEST['deleteDesc'])) {
  deleteRubricItemDescription($_REQUEST['deleteDesc']);
  include_once('prospectus.php'); die();
}
 
$rubricItemDesc = getRubricItemDescriptionInfo($_REQUEST['RID']);

$pageTitle = "Rubric Description";
$content = "rubricDescription.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "current", "courses" => "", "stats" => "");

include_once('pages/master.php');

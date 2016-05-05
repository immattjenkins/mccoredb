<?php

include_once('includes/coreDB.php');
//TODO: Make sure they have permissions

$prospectus = getProspectusInfo($_REQUEST['prospectusID'], $_SESSION['userID']);
$rubricID = getRubricInfo($_REQUEST['prospectusID']);
$rubricItems = getRubricItemList($_REQUEST['prospectusID']);

$pageTitle = "Rubric";
$content = "rubric.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "current", "courses" => "", "stats" => "");

include_once('pages/master.php');

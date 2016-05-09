<?php

include_once('includes/coreDB.php');
include_once('includes/protect.php');

$prospectus = getProspectusInfo($_REQUEST['id'], $_SESSION['userID']);

$pageTitle = "View Prospectus";
$content = "viewProspectus.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "current", "courses" => "", "stats" => "");

include_once('pages/master.php');

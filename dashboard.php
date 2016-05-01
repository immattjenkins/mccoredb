<?php

include_once('includes/coreDB.php');
//TODO: Make sure they have permissions

$pageTitle = "MC CoreDB Dashboard";
$content = "dashboard.php";
$linkHighlights = array("home" => "current", "domain" => "", "prospectus" => "", "courses" => "", "stats" => "");

include_once('pages/master.php');

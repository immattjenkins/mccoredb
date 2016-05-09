<?php

include_once('includes/coreDB.php');
include_once('includes/protect.php');

$pageTitle = "MC CoreDB Dashboard";
$content = "dashboard.php";
$linkHighlights = array("home" => "current", "domain" => "", "prospectus" => "", "courses" => "", "stats" => "");

include_once('pages/master.php');

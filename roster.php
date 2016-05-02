<?php

include_once('includes/coreDB.php');
//TODO: Make sure they have permissions

$pageTitle = "Roster";
$content = "roster.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "", "courses" => "current", "stats" => "");

include_once('pages/master.php');

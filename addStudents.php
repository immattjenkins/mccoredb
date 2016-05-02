<?php
include_once('includes/coreDB.php');
//TODO: Make sure they have permissions
//TODO: Only allow user 1 to do this (will be admin)

if(isset($_REQUEST['submit_students'])) {
  addStudents($_REQUEST['add_students'], $_SESSION['userID']);
}

$pageTitle = "Add New Students";
$content = "addStudents.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "", "courses" => "current", "stats" => "");

include_once('pages/master.php');

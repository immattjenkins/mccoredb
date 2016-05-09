<?php
include_once('includes/coreDB.php');
include_once('includes/protect.php');

// Only user 1 can access this
if($_SESSION['userID'] != 1) {
  include_once('index.php'); die();
}

if(isset($_REQUEST['submit_students'])) {
  addStudents($_REQUEST['add_students'], $_SESSION['userID']);
}

$pageTitle = "Add New Students";
$content = "addStudents.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "", "courses" => "current", "stats" => "");

include_once('pages/master.php');

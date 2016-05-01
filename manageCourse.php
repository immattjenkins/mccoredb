<?php

include_once('includes/coreDB.php');
if(!isset($_REQUEST['id'])) {
  die("No Domain To Edit");
}

$course = getCourseInfo($_REQUEST['id'], $_SESSION['userID']);

//TODO: Make sure they have permissions

$pageTitle = "Managing " . $course['Name'];
$content = "manageCourse.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "", "courses" => "current", "stats" => "");

include_once('pages/master.php');

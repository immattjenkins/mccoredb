<?php

include_once('includes/coreDB.php');
include_once('includes/protect.php');

if(isset($_REQUEST['deleteID'])) {
  deleteCourse($_REQUEST['deleteID'], $_SESSION['userID']);
}

if(isset($_REQUEST['submit_create'])) {
  $valid = true;

  if($_REQUEST['course_name'] == "") {
   $valid = false;
  }

  if($_REQUEST['course_code'] == "") {
   $valid = false;
  }

  if($valid) {
    $res = createCourse($_REQUEST['course_name'], $_REQUEST['course_code'], $_REQUEST['prospectus'], $_SESSION['userID']);
  }
}
//TODO: Make sure they have permissions

$prospectusList = getProspectusList($_SESSION['userID']);
$courseList = getCourseList($_SESSION['userID']);

$pageTitle = "Your Courses";
$content = "courses.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "", "courses" => "current", "stats" => "");

include_once('pages/master.php');

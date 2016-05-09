<?php

include_once('includes/coreDB.php');
include_once('includes/protect.php');

if(!isset($_REQUEST['id'])) {
  die("No Domain To Edit");
}

if(isset($_REQUEST['edit_course_name'])) {
  updateCourseInfo($_REQUEST['edit_course_name'], $_REQUEST['edit_course_code'], $_REQUEST['id'], $_SESSION['userID']);
}

if(isset($_REQUEST['create_section_submit'])) {
  createSection($_REQUEST['section_number'], $_REQUEST['id']);
}

$course = getCourseInfo($_REQUEST['id'], $_SESSION['userID']);

//TODO: Make sure they have permissions

$pageTitle = "Managing " . $course['Name'];
$content = "manageCourse.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "", "courses" => "current", "stats" => "");

include_once('pages/master.php');

<?php

include_once('includes/coreDB.php');
include_once('includes/protect.php');

$prospectusList = getProspectusList($_SESSION['userID']);

if(isset($_REQUEST['submit_sBSID'])) {
  $res = reportByStudentID($_REQUEST['selectByStudentID']);
  $student = getStudentInfo($_REQUEST['selectByStudentID']);
  $who = $student['First Name'] . ' ' . $student['Last Name'];
}

if(isset($_REQUEST['submit_sBCC'])) {
  $res = reportByCourseCode($_REQUEST['selectByCourseCode']);
  $who = $_REQUEST['selectByCourseCode'];
}

$pageTitle = "Statistics";
$content = "stats.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "", "courses" => "", "stats" => "current");

include_once('pages/master.php');

<?php

include_once('includes/coreDB.php');
//TODO: Make sure they have permissions

if(isset($_REQUEST['add_section_submit'])) {
  createSection($_REQUEST['section_number'], $_REQUEST['courseID']); 
}

$sections = getCourseSections($_REQUEST['courseID']);

$pageTitle = "Course Sections";
$content = "sections.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "", "courses" => "current", "stats" => "");

include_once('pages/master.php');

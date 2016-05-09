<?php

include_once('includes/coreDB.php');
include_once('includes/protect.php');

if(isset($_REQUEST['add_section_submit'])) {
  $valid = true;

  if($_REQUEST['section_number'] == "" || !is_numeric($_REQUEST['section_number'])) {
    $valid = false;
    $messages[] = array('class' => 'failure', 'text' => 'No section number specified'); 
  }

  if($_REQUEST['section_term'] == "") {
    $valid = false;
    $messages[] = array('class' => 'failure', 'text' => 'No term selected.'); 
  }
  if($valid) {
    $res = createSection($_REQUEST['section_number'], $_REQUEST['courseID'], $_REQUEST['section_term']); 
  }
}

$sections = getCourseSections($_REQUEST['courseID']);

$pageTitle = "Course Sections";
$content = "sections.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "", "courses" => "current", "stats" => "");

include_once('pages/master.php');

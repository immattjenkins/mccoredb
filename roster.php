<?php

include_once('includes/coreDB.php');
//TODO: Make sure they have permissions

if(isset($_REQUEST['student_submit'])) {
  $valid = true;

  if($_REQUEST['student_id'] == "") {
    $valid = false;
    $messages[] = array('class' => 'failure', 'text' => 'Student ID not entered.');
  }
  
  if($valid) {  
    $res = addStudentToRoster($_REQUEST['student_id'], $_REQUEST['sectionID']);
  }  

  if($valid && (is_null($res) || $res['ID'] == -1)) {
    $messages[] = array('class' => 'failure', 'text' => 'Either a student with that ID does not exist or they\'ve been added to your roster.');
  }
}

else if(isset($_REQUEST['deleteID'])) {
  $res = removeStudentFromRoster($_REQUEST['sectionID'], $_REQUEST['deleteID']);
}

$roster = getStudentsInRoster($_REQUEST['sectionID'], $_SESSION['userID']);

$pageTitle = "Roster";
$content = "roster.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "", "courses" => "current", "stats" => "");

include_once('pages/master.php');

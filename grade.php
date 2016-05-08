<?php

include_once('includes/coreDB.php');

//TODO: Make sure they have permissions

//Get student info
$student = getStudentInfo($_REQUEST['studentID']);

// Get rubric ID
$rubricInfo = getRubricBySection($_REQUEST['sectionID']);

// Get Rubric Items by ID 
$rubricItems = getRubricItemsByID($rubricInfo['RubricID']);

// Checks to see if a user already has a grade
$gradeType = checkGrades($_REQUEST['studentID'], $rubricItems[0]['ID']); 

// If type is update
// loop through each item
// add it to the array somehow?
// $rubricItems['0']['Reply'] = "TEST";
// We would attempt to create or update here

if($gradeType['Type'] == 'update' ) {
  $count = 0;
  foreach($rubricItems as $item) {
    $rubricItems[$count]['Grade'] = getStudentGrade($_REQUEST['studentID'], $item['ID']);
    $count++;
  }
}

if(isset($_REQUEST['grade_student_submit'])) {
  $valid = true;
  foreach($_REQUEST as $item) {
    if($item == "") {
      $valid = false;
      // add msg
    }
  }

  if($valid) { 
    foreach($rubricItems as $item) {
      $score = $_REQUEST['score-' . $item['ID']];
      $explanation = $_REQUEST['explanation-' . $item['ID']];
      
      if($gradeType['Type'] == 'create') {
        $res = gradeStudent($score, $explanation, $student['ID'], $item['ID']);
      } else if($gradeType['Type'] == 'update') {
        $res = updateGrade($item['Grade']['ID'], $explanation, $score);
      }
    }
  } 
}

// Get Rubric Descriptions by RubricItemID
$rubricDesc = array();
foreach($rubricItems as $item) {
  $rubricDesc[$item['ID']] = getRubricItemDesc($item['ID']);
}

// Download the update before display
if($gradeType['Type'] == 'update' ) { 
  $count = 0;
  foreach($rubricItems as $item) {
    $rubricItems[$count]['Grade'] = getStudentGrade($_REQUEST['studentID'], $item['ID']);
    $count++;
  }
}


$pageTitle = "Grading " . $student['First Name'] . " " . $student['Last Name'];
$content = "grade.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "", "courses" => "current", "stats" => "");

include_once('pages/master.php');

<?php

include_once('includes/coreDB.php');

//TODO: Make sure they have permissions

if(isset($_REQUEST['submit_prospectus'])) {
  $name = $_REQUEST['prospectus_name'];
  $year = $_REQUEST['prospectus_year'];
  $edGoals = $_REQUEST['educationalGoals'];
  $learnOutcomes = $_REQUEST['learningOutcome'];
  $desc = $_REQUEST['desc'];
  $domainGoals = $_REQUEST['domainGoals'];
  $requiredContent = $_REQUEST['requiredContent'];

  if($_REQUEST['mode'] == "create") {
    echo "CREATE THIS ... LATER";
  } else if($_REQUEST['mode'] == "update") {
    echo "UPDATE THIS ... LATER";
  }
	
} else if($_REQUEST['mode'] == "create") {
  echo "BLANK CREATE";
} else if($_REQUEST['mode'] == "update") {
  echo "FILLED IN UPDATE";
}
$pageTitle = "Create A Prospectus";
$content = "manageProspectus.php";

include_once('pages/master.php');

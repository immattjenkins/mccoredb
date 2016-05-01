<?php

include_once('includes/coreDB.php');

//TODO: Make sure they have permissions

if(isset($_REQUEST['submit_prospectus'])) {
  $name = $_REQUEST['prospectus_name'];
  $edGoals = $_REQUEST['educationalGoals'];
  $learnOutcomes = $_REQUEST['learningOutcome'];
  $desc = $_REQUEST['desc'];
  $domainGoals = $_REQUEST['domainGoals'];
  $requiredContent = $_REQUEST['requiredContent'];
  
  $valid = true;

  if($name == "") {
    $messages[] = array('class' => 'failure', 'text' => 'No name for prospectus given.');
    $valid = false;
  }

  if($edGoals == "") {
    $messages[] = array('class' => 'failure', 'text' => 'No educational goals given.');
    $valid = false;
  }

  if($learnOutcomes == "") {
    $messages[] = array('class' => 'failure', 'text' => 'No learning outcomes given.');
    $valid = false;
  } 

  if($desc == "") {
    $messages[] = array('class' => 'failure', 'text' => 'No description given.');
    $valid = false;
  } 

  if($domainGoals == "") {
    $messages[] = array('class' => 'failure', 'text' => 'No domain goals given.');
    $valid = false;
  }

  if($requiredContent == "") {
    $messages[] = array('class' => 'failure', 'text' => 'No required content given.');
    $valid = false;
  }

  if($valid) {
    if($_REQUEST['mode'] == "create") {
      $res = createProspectus($_REQUEST['id'], $name, $edGoals, $learnOutcomes, $desc, $domainGoals, $requiredContent);
    } else if($_REQUEST['mode'] == "update") {
      $res = updateProspectus($_REQUEST['id'], $name, $edGoals, $learnOutcomes, $desc, $domainGoals, $requiredContent);
    }
      include_once('prospectus.php'); die();
  }	
} else if($_REQUEST['mode'] == "update") {
  $prospectus = getProspectusInfo($_REQUEST['id'], $_SESSION['userID']);
}

$pageTitle = "Create A Prospectus";
$content = "manageProspectus.php";
$linkHighlights = array("home" => "", "domain" => "", "prospectus" => "current", "courses" => "", "stats" => "");

include_once('pages/master.php');

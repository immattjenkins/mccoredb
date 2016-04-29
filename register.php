<?php

include_once('includes/coreDB.php');

$messages = array();

if(isset($_REQUEST['createaccount'])) {
  $username = $_REQUEST['registerUsername'];
  $password = $_REQUEST['registerPassword'];
  $confirmPassword = $_REQUEST['confirmPassword'];
  $email = $_REQUEST['registerEmail'];
  $firstName = $_REQUEST['registerFirstName'];
  $lastName = $_REQUEST['registerLastName'];

  if(isset($_REQUEST['registerDepartment'])) {
    $dept = $_REQUEST['registerDepartment'];
  } else {
    $dept = "Unset";
  }

  $valid = true;

  // Check username availability
  // Check that emails are not in use yet / availability

  if($password == "" || $password != $confirmPassword) {
    $valid = false;
    $messages[] = array('class' => 'failure', 'text' => 'Passwords do not match');
  }

  if($firstName == "") {
    $valid = false;
    $messages[] = array('class' => 'failure', 'text' => 'First name field left blank');
  }

  if($lastName == "") {
    $valid = false;
    $messages[] = array('class' => 'failure', 'text' => 'Last name field left blank');
  }

  if($dept == "Unset") {
    $valid = false;
    $messages[] = array('class' => 'failure', 'text' => 'Department field not set');
  }

  if($valid) {
    $results = createUser($username, $password, $email, $firstName, $lastName, $dept);
    
    if($results['userID'] < 0) {
      $messages[] = array('class' => 'failure', 'text' => "User creation failed.");
    } else {
      $_SESSION['userID'] = $results['userID'];
      $_SESSION['username'] = $username;
      $_SESSION['canCreate'] = 0;
      include_once('dashboard.php'); die();
    } 
  }
}

//TODO: Make sure they have permissions

$pageTitle = "Register";
$content = "register.php";

include_once('pages/master.php');

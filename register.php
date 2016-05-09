<?php

include_once('includes/coreDB.php');

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
  
  $userCheck = checkUsername($username); 
  if($userCheck['Available'] == 0 || $username == "") {
    $messages[] = array('class' => 'failure', 'text' => "Username {$username} is not available.");
    $valid = false;
  }  
 
  $emailCheck = checkEmail($email);
  if($emailCheck['Available'] == 0|| $email == "") {
    $messages[] = array('class' => 'failure', 'text' => "Email {$email} is not available.");
    $valid = false;
  }    
  
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
$linkHighlights = array("home" => "current", "domain" => "", "prospectus" => "", "courses" => "", "stats" => "");

include_once('pages/master.php');

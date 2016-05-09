<?php

include_once('includes/coreDB.php');
include_once('includes/protect.php');

if(isset($_REQUEST['submit_password_update'])) {

  $valid = true;

  $pass = $_REQUEST['password'];
  $confirmPass = $_REQUEST['confirm_password'];

  if($pass == "" || $pass != $confirmPass) {
    $valid = false;
    $messages[] = array('class' => 'failure', 'text' => 'Error with passwords either not being filled in or not matching.');
  }

  if($valid) {
    $res = changePassword($_SESSION['userID'], $pass);
  }
}

if(isset($_REQUEST['promote_faculty'])) {
  $res = promoteFaculty($_REQUEST['promoteFaculty']);
  var_dump($res);
}

if(isset($_REQUEST['demote_faculty'])) {
  $res = demoteFaculty($_REQUEST['demoteFaculty']);
  var_dump($res);
}


$privFaculty = getPrivFaculty();
$regularFaculty = getRegularFaculty();

$pageTitle = "Manage Account";
$content = "account.php";
$linkHighlights = array("home" => "current", "domain" => "", "prospectus" => "", "courses" => "", "stats" => "");

include_once('pages/master.php');

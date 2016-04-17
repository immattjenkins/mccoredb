<?php

// Include DB credentials
include_once('conf.php');

// Create a connection to DB
$mysqli = new mysqli($dbhost, $dbuser, $dbpass, $dbname);
if(mysqli_connect_errno()) {
  die("MC CoreDB cannot establish connection.");
}

// Logs a user in
function logUserIn($user, $pass) {
  
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL LogFacultyIn(?, ?)");
  $stmt->bind_param("ss", $user, $pass);

  // Run statement and fetch results
  $res = array();
  $stmt->execute();
  $stmt->bind_result($res['userID'], $res['messsage']);
  $stmt->fetch();
  $stmt->close();

  return $res;

}



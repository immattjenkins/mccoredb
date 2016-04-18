<?php

// Include DB credentials
include_once('conf.php');

// Create a connection to DB
$mysqli = new mysqli($dbhost, $dbuser, $dbpass, $dbname);
if(mysqli_connect_errno()) {
  die("MC CoreDB cannot establish connection.");
}

function singleRowStatement($stmt) 
{
  //run the statement and fetch the result
  $stmt->execute();
  $res = $stmt->get_result();
  if(!$res) {
    return null;
  }
  $result = $res->fetch_assoc();

  return $result;
}

function multipleRowStatement($stmt) 
{
  //get the results
  $stmt->execute();
  $res = $stmt->get_result();

  $results = array();
  while($row = $res->fetch_assoc()) {
    //append the row to the result set
    $results[] = $row;    
  }

  return $results;
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
  $stmt->bind_result($res['userID'], $res['create'], $res['message']);
  $stmt->fetch();
  $stmt->close();

  return $res;

}

function createDomain($name, $userID) {
  
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `CreateDomain`(?, ?)");
  $stmt->bind_param("si", $name, $userID);

  // Run statement and fetch results
  $res = array();
  $stmt->execute();
  $stmt->bind_result($res['ID'], $res['messsage']);
  $stmt->fetch();
  $stmt->close();

  return $res;

}

function getAllDomains($userID) {

  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `ListAllDomains`(?)");
  $stmt->bind_param("i", $userID);

  // Fetch results 
  $res = multipleRowStatement($stmt);
  $stmt->close();

  return $res;

}

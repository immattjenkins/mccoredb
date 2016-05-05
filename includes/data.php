<?php

// Include DB credentials
include_once('conf.php');

// Create a connection to DB
$mysqli = new mysqli($dbhost, $dbuser, $dbpass, $dbname);
if(mysqli_connect_errno()) {
  die("MC CoreDB cannot establish connection.");
}

//List of Departments
$departments = array("Behavioral Sciences", "Education", "Fine Arts", "Humanities", "Languages and Literature", "Mathematics and Computer Science", "Natural Sciences", "Social Sciences");

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
  $stmt->bind_result($res['userID'], $res['create'], $res['dept'], $res['message']);
  $stmt->fetch();
  $stmt->close();

  return $res;

}

function createUser($user, $pass, $email, $firstName, $lastName, $dept) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $create = 0;
  $stmt = $mysqli->prepare("CALL CreateFaculty(?, ?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("sssisss", $user, $pass, $email, $create, $firstName, $lastName, $dept);

  // Run statement and fetch results
  $res = array();
  $stmt->execute();
  $stmt->bind_result($res['userID'], $res['username'], $res['message']);
  $stmt->fetch();
  $stmt->close();

  return $res;


}

function createDomain($name, $dept, $userID) {
  
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `CreateDomain`(?, ?, ?)");
  $stmt->bind_param("ssi", $name, $dept, $userID);

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

function getAllDomainsByDept($dept) {

  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `ListDomainsByDept`(?)");
  $stmt->bind_param("s", $dept);

  // Fetch results 
  $res = multipleRowStatement($stmt);
  $stmt->close();

  return $res;

}


function getDomainInfo($domainID, $userID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `GetDomainInfo`(?, ?)");
  $stmt->bind_param("ii", $domainID, $userID);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function updateDomainInfo($domainID, $domainTitle, $userID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `UpdateDomainInfo`(?, ?, ?)");
  $stmt->bind_param("isi", $domainID, $domainTitle, $userID);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function deleteDomain($domainID, $userID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `DeleteDomain`(?, ?)");
  $stmt->bind_param("ii", $domainID, $userID);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function getProspectusList($userID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `GetProspectusList`(?)");
  $stmt->bind_param("i", $userID);

  // Fetch results 
  $res = multipleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function getProspectusInfo($prospectusID, $userID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `GetProspectusInfo`(?, ?)");
  $stmt->bind_param("ii", $prospectusID, $userID);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function createProspectus($id, $name, $edGoals, $learnOutcomes, $desc, $domainGoals, $requiredContent) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `CreateProspectus`(?, ?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("sssssss", $name, $edGoals, $learnOutcomes, $desc, $domainGoals, $requiredContent, $id);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function updateProspectus($id, $name, $edGoals, $learnOutcomes, $desc, $domainGoals, $requiredContent) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `UpdateProspectus`(?, ?, ?, ?, ?, ?, ?)");
  $stmt->bind_param("sssssss", $name, $edGoals, $learnOutcomes, $desc, $domainGoals, $requiredContent, $id);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function deleteProspectus($prospectusID, $userID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `deleteProspectus`(?, ?)");
  $stmt->bind_param("ii", $prospectusID, $userID);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function createCourse($name, $code, $prospectusID, $userID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `CreateCourse`(?, ?, ?, ?)");
  $stmt->bind_param("ssii", $name, $code, $prospectusID, $userID);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function deleteCourse($courseID, $userID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `DeleteCourse`(?, ?)");
  $stmt->bind_param("ii", $courseID, $userID);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function getCourseList($userID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `GetCourseList`(?)");
  $stmt->bind_param("i", $userID);

  // Fetch results 
  $res = multipleRowStatement($stmt);
  $stmt->close();

  return $res;
}


function getCourseInfo($courseID, $userID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `GetCourseInfo`(?, ?)");
  $stmt->bind_param("ii", $courseID, $userID);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function updateCourseInfo($name, $code, $courseID, $userID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `UpdateCourseInfo`(?, ?, ?, ?)");
  $stmt->bind_param("ssii", $name, $code, $courseID, $userID);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function addStudents($str, $userID) {
  
  // If not the root admin, fail.
  if($userID != 1) { 
   return false;
  }

  // Strip TinyMCE formatting
  $str = strip_tags($str); 

  // Create array that will contain each line
  $csv = array();

  // Explode into lines and add to array 
  // (thanks to batigolix from stackoverflow for this idea)
  $lines = explode("\n", $str);
  foreach($lines as $line) {
    $csv[] = str_getcsv($line);
  }

  // Grab global var mysqli
  global $mysqli;  
  foreach($csv as $person) {

    // Set up prepared statement
    $stmt = $mysqli->prepare("CALL `CreateStudent`(?, ?, ?)");
    $stmt->bind_param("sss", $person[0], $person[1], $person[2]);

    // Fetch results 
    $res = singleRowStatement($stmt);
    $stmt->close();
  
  }
  return $res; 

}

function getCourseSections($courseID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `ListSectionByCourse`(?)");
  $stmt->bind_param("i", $courseID);

  // Fetch results 
  $res = multipleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function createSection($number, $courseID, $term) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `CreateSection`(?, ?, ?)");
  $stmt->bind_param("iis", $number, $courseID, $term);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function getStudentsInRoster($sectionID, $userID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `ListStudentsInRoster`(?, ?)");
  $stmt->bind_param("ii", $sectionID, $userID);

  // Fetch results 
  $res = multipleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function addStudentToRoster($studentID, $sectionID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `AddStudentToRoster`(?, ?)");
  $stmt->bind_param("ii", $studentID, $sectionID);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function removeStudentFromRoster($studentID, $sectionID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `RemoveStudentFromRoster`(?, ?)");
  $stmt->bind_param("ii", $studentID, $sectionID);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function getRubricItemList($prospectusID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `GetRubricItemList`(?)");
  $stmt->bind_param("i", $prospectusID);

  // Fetch results 
  $res = multipleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function getRubricInfo($prospectusID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `GetRubricInfo`(?)");
  $stmt->bind_param("i", $prospectusID);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function getRubricItemInfo($rubricItemID) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `GetRubricItemInfo`(?)");
  $stmt->bind_param("i", $rubricItemID);

  // Fetch results 
  $res = multipleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function createNewRubricItem($title, $question, $id) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `CreateRubricItem`(?, ?, ?)");
  $stmt->bind_param("ssi", $title, $question, $id);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res; 
}

function updateRubricItem($title, $question, $id) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `UpdateRubricItem`(?, ?, ?)");
  $stmt->bind_param("ssi", $title, $question, $id);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res;
}

function getRubricItemInfoByID($id) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `GetRubricItemInfoByID`(?)");
  $stmt->bind_param("i", $id);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res; 
}

function deleteRubricItem($id) {
  // Grab global var mysqli
  global $mysqli;

  // Set up prepared statement
  $stmt = $mysqli->prepare("CALL `DeleteRubricItem`(?)");
  $stmt->bind_param("i", $id);

  // Fetch results 
  $res = singleRowStatement($stmt);
  $stmt->close();

  return $res; 
}


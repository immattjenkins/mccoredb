<?php

include_once('includes/coreDB.php');

//TODO: Make sure they have permissions
if(isset($_REQUEST['create_domain'])) {
  
  $valid = true;

  if($_REQUEST['domain_name'] == "") {
   $messages[] = array('class' => 'failure', 'text' => 'No name for prospectus given.');
   $valid = false;
  }

  if($valid) { 
    $res = createDomain($_REQUEST['domain_name'], $_SESSION['dept'], $_SESSION['userID']);
  }
}

if(isset($_REQUEST['deleteID'])) {
  deleteDomain($_REQUEST['deleteID'], $_SESSION['userID']);
}

$domainList = getAllDomains($_SESSION['userID']);

$pageTitle = "Domains";
$content = "domains.php";
$linkHighlights = array("home" => "", "domain" => "current", "prospectus" => "", "courses" => "", "stats" => "");

include_once('pages/master.php');

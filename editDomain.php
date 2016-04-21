<?php

include_once('includes/coreDB.php');
if(!isset($_REQUEST['id'])) {
  die("No Domain To Edit");
}

if(isset($_REQUEST['edit_domain_submit'])) {
  updateDomainInfo($_REQUEST['id'], $_REQUEST['edit_domain_name'], $_SESSION['userID']);
  Header('Location: domains.php');
}

$domainInfo = getDomainInfo($_REQUEST['id'], $_SESSION['userID']); 

//TODO: Make sure they have permissions

$pageTitle = "Editing " . $domainInfo['Title'];
$content = "editDomain.php";

include_once('pages/master.php');

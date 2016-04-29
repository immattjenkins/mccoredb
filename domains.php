<?php

include_once('includes/coreDB.php');

//TODO: Make sure they have permissions
if(isset($_REQUEST['create_domain'])) {
  $res = createDomain($_REQUEST['domain_name'], $_SESSION['dept'], $_SESSION['userID']);
}

if(isset($_REQUEST['deleteID'])) {
  deleteDomain($_REQUEST['deleteID'], $_SESSION['userID']);
}

$domainList = getAllDomains($_SESSION['userID']);
$pageTitle = "Domains";
$content = "domains.php";

include_once('pages/master.php');

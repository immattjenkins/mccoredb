<?php

include_once('includes/coreDB.php');

//TODO: Make sure they have permissions
if(isset($_REQUEST['create_domain'])) {
  createDomain($_REQUEST['domain_name'], $_SESSION['userID']);
}

$domainList = getAllDomains($_SESSION['userID']);
$pageTitle = "Domains";
$content = "domains.php";

include_once('pages/master.php');

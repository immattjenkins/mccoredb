<?php

include_once('includes/coreDB.php');

// Delete if the request is there
if(isset($_REQUEST['mode']) && $_REQUEST['mode'] == "delete") {
  deleteProspectus($_REQUEST['id'], $_SESSION['userID']);
}

//TODO: Make sure they have permissions

// Get domain and prospectus list
$domainList = getAllDomainsByDept($_SESSION['dept']);
$prospectusList = getProspectusList($_SESSION['userID']);

$pageTitle = "Prospectus";
$content = "prospectus.php";

include_once('pages/master.php');

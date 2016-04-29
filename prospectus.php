<?php

include_once('includes/coreDB.php');

//TODO: Make sure they have permissions
$domainList = getAllDomainsByDept($_SESSION['dept']);
$prospectusList = getProspectusList($_SESSION['userID']);

$pageTitle = "Prospectus";
$content = "prospectus.php";

include_once('pages/master.php');

<?php

include_once('includes/coreDB.php');

if(isset($_REQUEST['createaccount'])) {
 createUser($_REQUEST['registerUsername'], $_REQUEST['registerPassword'], $_REQUEST['registerEmail'], $_REQUEST['registerFirstName'], $_REQUEST['registerLastName'], $_REQUEST['registerDepartment']);
}

//TODO: Make sure they have permissions

$pageTitle = "Register";
$content = "register.php";

include_once('pages/master.php');

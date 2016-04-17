<?php

// Includes all files needed for MC CoreDB to function
include_once('conf.php');
include_once('data.php');

// Start us a new session, kind sir!
session_start();

if(!isset($_SESSION["userID"])) {
	$_SESSION["userID"] = -1;
}

//include_once('login.php');

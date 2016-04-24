<?php

include_once("includes/coreDB.php");
include_once("includes/login.php");

// If someone is logged in, redirect them to DB instead of index
if(isset($_SESSION['userID']) && $_SESSION['userID'] > -1) {
  header("Location: dashboard.php"); 
  exit;
}

?>

<!doctype html>
<html>
<head>
  <title>MC CoreDB Login</title>
  <link rel="stylesheet" type="text/css" href="css/style.css"  />
</head>
<body>
  <div id="wrapper">
    <div id="login_wrapper">
      <img class="login_logo" src="img/logo_white.svg" alt="MC CoreDB" />
      <form id="user_login_form" method="POST">
        <input id="username" class="login_input" name="username" type="text" placeholder="Username" />
        <input id="password" class="login_input" name="password" type="password" placeholder="Password"/>
        <div id="buttons" class="center">
        <a href="register.php" class="button secondary_button">Register</a>  
	<button id="submit_login" class="button orange_button login_button" name="submit_login" value="login">Login</button>
        </div>
      </form>
    </div>
  </div>
</body>
<html>

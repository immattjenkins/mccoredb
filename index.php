<?php
  session_start();
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
      <form id="user_login_form">
        <input id="username" class="login_input" name="username" type="text" placeholder="Username" />
        <input id="password" class="login_input" name="password" type="password" placeholder="Password"/>
        <div id="buttons" class="center">
          <button id="create_user" class="button secondary_button" name="create_user">Register</button>
          <button id="submit_login" class="button orange_button login_button" name="submit_login">Logindc</button>
        </div>
      </form>
    </div>
  </div>
</body>
<html>

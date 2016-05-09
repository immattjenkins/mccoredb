<?php 

if($_SESSION['userID'] < 0) {
  include_once('index.php'); die();
}

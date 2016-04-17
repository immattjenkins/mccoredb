<!doctype html>
<html>
<head>
  <title><?php echo $pageTitle; ?></title>
  <link rel="stylesheet" type="text/css" href="css/style.css"  />
</head>
<body>
  <div id="wrapper">

    <div id="contentWrapper">
      <div id="navBar" class="nav">
        <div id="logo">
          <img src="img/logo.svg" alt="M.C. CoreDB" />
        </div>
        <div id="menu">
          <ul class="menu-links">
              <a href="#l1"><li class="current">HOME</li></a>
              <a href="#l2"><li>CLASSES</li></a>
              <a href="#l3"><li>STATS</li></a>
              <a href="index.php?logout=true"><li>LOGOUT</li></a>
          </ul>
        </div>
      </div>
    </div>

    <div id="content">
	<?php include_once('pages/' . $content);?>
    </div>

  </div>
</body>
<html>

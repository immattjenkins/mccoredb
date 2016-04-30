<!doctype html>
<html>
<head>
  <title><?php echo $pageTitle; ?></title>
  <link rel="stylesheet" type="text/css" href="css/style.css"  />
  <script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
  <script>tinymce.init({ selector:'textarea' });</script>
</head>
<body>
  <div id="wrapper">

    <div id="contentWrapper">
      <div id="navBar" class="nav">
        <div id="logo">
          <img src="img/logo.svg" alt="M.C. CoreDB" />
        </div>
        <div id="menu">
	  <?php if(isset($_SESSION['userID']) && $_SESSION['userID'] > 0): ?>
          <ul class="menu-links">
              <a href="dashboard.php"><li class="current">HOME</li></a>
	      <?php if($_SESSION['canCreate'] == 1): ?> 
	        <a href="domains.php"><li>DOMAIN</li></a>
	      <?php endif;?>
	      <a href="prospectus.php"><li>PROSPECTUS</li></a>
              <a href="courses.php"><li>COURSES</li></a>
              <a href="stats.php"><li>STATS</li></a>
              <a href="index.php?logout=true"><li>LOGOUT</li></a>
          </ul>
	  <?php endif;?>
        </div>
      </div>
    </div>

    <div id="content">
	<?php if(isset($messages)): ?>
	<div id="messages">
		<h2>Hold up! There's some errors:</h2>
                <ul>
			<?php foreach($messages as $msg): ?>
				<li class="<?php echo $msg['class']; ?>"><?php echo $msg['text']; ?></li>
			<?php endforeach; ?>
		</ul>
	</div>	
	<?php endif; ?>
	<?php include_once('pages/' . $content);?>
    </div>

  </div>
</body>
<html>

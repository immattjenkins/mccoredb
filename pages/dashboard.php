<h1>Dashboard</h1>

<p>Welcome back, <?php echo $_SESSION['username'];?>. You can manage your account <a href="account.php">here</a>.</p>

<?php if($_SESSION['userID'] == 1): ?>
<p>If you need to add students, you may do so <a href="addStudents.php">here</a>.</p>
<?php endif; ?>

<h1>Roster</h1>

<h2>Students</h2>
<ul>
<?php foreach($roster as $student): ?>
  <li>
      <?php echo $student['FirstName'] . ' ' . $student['LastName']?> 
      <a href="roster.php?sectionID=<?php echo $_REQUEST['sectionID'] ?>&deleteID=<?php echo $student['ID']; ?>">(delete)</a>
  </li>
<?php endforeach; ?>
</ul>

<h2>Add Student</h2>
<form id="add_student" method="POST">
  <input id="student_id" name="student_id" type="text" placeholder="Enter 11-digit student ID" />
  <button id="student_submit" name="student_submit" value="add" class="orange_button button">Add Student</button> 
</form>

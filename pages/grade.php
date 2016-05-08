<h1>Grading <?php echo $student['First Name'] . ' ' . $student['Last Name']; ?></h1>

<h2>Rubric for Grading</h2>
<table>
  <tbody>
    <?php foreach($rubricItems as $item): ?>
      <tr>
        <td>
        <span class="title"><?php echo $item['Title']; ?></span>
	<?php echo $item['Question']; ?></td>
        <?php foreach($rubricDesc[$item['ID']] as $desc): ?>
        <td>
          <?php echo $desc['ScoreNum']; ?>
          <?php echo $desc['ScoreLevel']; ?>
          <?php echo $desc['Explanation']; ?>
        </td>
        <?php endforeach; ?>
      </tr>
    <?php endforeach; ?>
  </tbody>
</table>

<h2>Grade Student</h2> 
<form method="POST">
  <input hidden name="reqType" value="<?php echo $gradeType['Type']; ?>">
  <input hidden name="studentID" value="<?php echo $_REQUEST['studentID']; ?>" />
  <input hidden name="sectionID" value="<?php echo $_REQUEST['sectionID']; ?>" />
  <?php foreach($rubricItems as $item): ?>
    <label for="score-<?php echo $item['ID']; ?>"><?php echo $item['Title'] ?></label>
    <input id="score-<?php echo $item['ID']; ?>" name="score-<?php echo $item['ID']; ?>" value="<?php if(isset($item['Grade']['Score'])) echo $item['Grade']['Score']; ?>" placeholder="Enter number value" />
    <textarea name="explanation-<?php echo $item['ID']; ?>"><?php if(isset($item['Grade']['Comment'])) echo $item['Grade']['Comment']; ?></textarea>
  <?php endforeach; ?>
  <button name="grade_student_submit" class="orange_button button block" value="grade">Submit</button>
</form>

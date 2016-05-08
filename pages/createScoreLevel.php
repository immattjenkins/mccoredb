<h1>Managing Score Level</h1>

<form id="manage_scoring" method="POST">
  <input id="rubricItemID" name="rubricItemID" value="<?php echo $_REQUEST['rubricItemID']; ?>" />
  <label for="score_num">Enter Score Number:</label>
  <input id="score_num" name="score_num" type="text" placeholder="Enter number (0, 1, 2, 3, 4, 5)" />
  <label for="score_level">Enter Score Level (0 - 5):</label>
  <input id="score_level" name="score_level" type="text" placeholder="Enter number" />
  <label for=explanation">Explanation for why a student deserves this grade:<label>
  <textarea id="explanation" name="explanation" type="text"></textarea>
  <button name="submit_score" class="orange_button button" value="create">Create New Score Level</button>
</form>

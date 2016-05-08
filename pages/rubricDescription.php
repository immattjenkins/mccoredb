<h1><?php echo $rubricItemDesc['ScoreLevel'] ?> (<?php echo $rubricItemDesc['ScoreNum']; ?>)</h1>

<h2>Explanation</h2>
<p><?php echo $rubricItemDesc['Explanation'] ?></p>

<form method="POST">
  <button name="deleteDesc" class="orange_button button" value="<?php echo $rubricItemDesc['ID']; ?>">Delete</button>
</form>

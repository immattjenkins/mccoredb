<h1>Rubric Item Management</h1>

<form id="rubric_submission" method="POST"> 
  <input hidden id="rubricID" name="rubricID" value="<?php echo (isset($_REQUEST['rubricItemID']))? $_REQUEST['rubricItemID'] : $_REQUEST['rubricID'];?>" />
  <input hidden id="prospectusID" name="prospectusID" value="<?php echo $_REQUEST['prospectusID']; ?>" />
  <input hidden id="mode" name="mode" value="<?php echo ($_REQUEST['mode'] == 'create')? 'create' : 'update'; ?>">
  <label for="rubric_title">Rubric Category Title</label>
  <input id="rubric_title" name="rubric_title" type="text" value="<?php if(isset($rubricItem)) echo $rubricItem['Title']; ?>"/>
  <label for="rubric_question">Rubric Category Question</label>
  <textarea id="rubric_question" name="rubric_question"><?php if(isset($rubricItem)) echo $rubricItem['Question']; ?></textarea>
  <div class="block tinyButtonFix">
    <button name="rubric_submit" class="orange_button button" value="<?php echo ($_REQUEST['mode'] == 'create')? 'create' : 'update'; ?>">Submit</button>
    <?php if(isset($rubricInfo)): ?> <button name="rubric_delete" class="orange_button button" value="delete">Delete</button> <?php endif; ?>
  </div>
</form>

<?php if(isset($rubricInfo)): ?>
<h2>Scoring Levels</h2>
<ul>
<?php foreach($rubricInfo as $rubricDesc): ?>
  <li><a href="rubricDescription.php?RID=<?php echo $rubricDesc['RID']; ?>"><?php echo $rubricDesc['ScoreLevel']?></a></li>
<?php endforeach; ?>
</ul>

<a href="createScoreLevel.php?rubricItemID=<?php echo $_REQUEST['rubricItemID']; ?>">Create New Score Level</a>
<?php endif; ?>


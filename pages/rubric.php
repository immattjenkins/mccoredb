<h1>Rubric for <?php echo $prospectus['Name']; ?></h1>

<h2>Categories</h2>
<ul>
  <?php foreach($rubricItems as $item): ?>
    <li>
      <a href="rubricItem.php?mode=update&rubricItemID=<?php echo $item['ID']; ?>&prospectusID=<?php echo $_REQUEST['prospectusID']; ?>"><?php echo $item['Title']; ?></a>
    </li>
  <?php endforeach; ?>
</ul>

<a class="orange_button button" href="rubricItem.php?mode=create&rubricID=<?php echo $rubricID['ID']; ?>&prospectusID=<?php echo $_REQUEST['prospectusID']; ?>">Create New Category</a>

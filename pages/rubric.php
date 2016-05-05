<h1>Rubric for <?php echo $prospectus['Name']; ?></h1>

<h2>Categories</h2>
<ul>
  <?php foreach($rubricItems as $item): ?>
    <li>
      <a href="rubricItem.php?mode=update&rID=<?php echo $item['ID']; ?>"><?php echo $item['Title']; ?></a>
      <a href="rubric.php?deleteRID=<?php echo $item['ID']; ?>">(delete)</a>
    </li>
  <?php endforeach; ?>
</ul>

<a class="orange_button button" href="rubricItem.php?mode=create&rubricID=<?php echo $rubricID['ID']; ?>">Create New Category</a>

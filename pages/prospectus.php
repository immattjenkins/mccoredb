<h1>Prospectus</h1>
<p>Add, create, and delete prospectuses for your division based on pre-existing domains.</p>

<h2>Create a New Prospectus</h2>

<p>Creating a new prospectus is done on a per-domain basis. Select the domain that you wish to add a new prospectus to in order to begin.</p>

<ul>   
  <?php foreach($domainList as $domain): ?>
    <li><a href="manageProspectus.php?id=<?php echo $domain['ID'] ?>&mode=create"><?php echo $domain['Title'] ?></a></li>
  <?php endforeach; ?>
</ul>

<h2>Manage Existing Prospectus</h2>

<ul>   
  <?php foreach($prospectusList as $prospectus): ?>
    <li>
        <a href="manageProspectus.php?id=<?php echo $prospectus['ID'] ?>&mode=update"><?php echo $prospectus['Name'] ?></a>
        <a href="viewProspectus.php?id=<?php echo $prospectus['ID'] ?>"><img src="img/view.png" alt="(View)" /></a> 
	<a href="rubric.php?prospectusID=<?php echo $prospectus['ID']; ?>" title="Rubric"><img src="img/rubric.png" alt="(Rubric)" /></a>
        <a href="prospectus.php?id=<?php echo $prospectus['ID'] ?>&mode=delete" title="Delete"><img src="img/delete.png" alt="(Delete)" /></a>
    </li>
  <?php endforeach; ?>
</ul> 

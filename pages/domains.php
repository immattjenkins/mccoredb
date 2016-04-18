<h1>Domains</h1>

<p>Create and delete domains.</p>

<h2>Create a Domain</h2>
<form id="create_domain_form" method="POST">
  <input id="domain_name" name="domain_name" type="text" placeholder="Enter domain name"/>
  <button name="create_domain" class="orange_button button" value="create_domain">Create</button>
</form>

<h2>Manage Your Domains</h2>
  <ul>
    <?php foreach($domainList as $domain): ?>
    <a href="editDomain.php?id=<?php echo $domain['FacultyID']?>"><li><?php echo $domain['Title']; ?></li></a>
    <?php endforeach; ?>
  </ul>

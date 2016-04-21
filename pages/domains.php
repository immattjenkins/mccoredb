<h1>Domains</h1>

<p>Create, manage, and delete domains that you are considered to be the owner of as the one in charge of your division's domain and prospectus.</p>

<h2>Create a Domain</h2>
<form id="create_domain_form" method="POST">
  <input id="domain_name" name="domain_name" type="text" placeholder="Enter domain name"/>
  <button name="create_domain" class="orange_button button" value="create_domain">Create</button>
</form>

<h2>Manage Your Domains</h2>
  <ul>
    <?php foreach($domainList as $domain): ?>
    <li><a href="editDomain.php?id=<?php echo $domain['ID']?>"><?php echo $domain['Title']; ?></a> <a href="domains.php?deleteID=<?php echo $domain['ID']?>">(delete)</a></li>
    <?php endforeach; ?>
  </ul>

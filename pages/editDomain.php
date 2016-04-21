<h1><?php echo $pageTitle ?></h1>

<form id="edit_domain" method="POST" action="editDomain.php?id=<?php echo $domainInfo['ID']?>">
  <input id="edit_domain_name" name="edit_domain_name" type="text" value="<?php echo $domainInfo['Title'] ?>" />
  <button id="edit_domain_submit" name="edit_domain_submit" value="edit" class="orange_button button">Edit</button>
</form>



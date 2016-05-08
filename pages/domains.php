<h1>Domains</h1>

<p>Create, manage, and delete domains that you are considered to be the owner of as the one in charge of your division's domain and prospectus.</p>

<h2>Manage Your Domains</h2>
  <ul id="domainList">
    <?php foreach($domainList as $domain): ?>
    <li><a href="editDomain.php?id=<?php echo $domain['ID']?>"><?php echo $domain['Title']; ?></a> <a class="deleteDomain" href="domains.php?deleteID=<?php echo $domain['ID']?>" data-ID="<?php echo $domain['ID']; ?>"><img src="img/delete.png" /></a></li>
    <?php endforeach; ?>
  </ul>

<h2>Create a Domain</h2>
<form id="create_domain_form" method="POST">
  <input hidden id="jqueryUserID" name="userID" value="<?php echo $_SESSION['userID']; ?>"/>
  <input hidden id="jqueryDept" name="deptID" value="<?php echo $_SESSION['dept']; ?>" />
  <input id="domain_name" name="domain_name" type="text" placeholder="Enter domain name"/>
  <button id="submit_create" name="create_domain" class="orange_button button" value="create_domain">Create</button>
</form>

<script>
    $(function() {
      $('.deleteDomain').click(function(e) {
        var request = {function: 'deleteDomain',
                       params: {domainID: $(this).attr('data-id'), userID: $('#jqueryUserID').val()}};
        var listItem = $(this);
        e.preventDefault();
        $.post("includes/ajax.php", {request: JSON.stringify(request)}, function(d) {
          listItem.parent().slideUp();
        });
      });
      
      $('#submit_create').click(function(e) {
        var request = {function: 'createDomain',
                       params: {title: $('#domain_name').val(), dept: $('#jqueryDept').val(), userID: $('#jqueryUserID').val()}};  

        e.preventDefault();
        $.post("includes/ajax.php", {request: JSON.stringify(request)}, function(d) {
             var json = $.parseJSON(d);
             var str = '<li class="hidden_item"><a href="editDomain.php?id=' + json.ID + '">' + $('#domain_name').val() + '</a> <a href="domains.php?deleteID=' + json.ID + '" class="deleteDomain" title="Delete" data-ID="' + json.ID + '"><img src="img/delete.png" alt="(Delete)" /></a></li>';
             $('#domainList').append(str);
             $('.hidden_item').removeClass('hidden_item').hide().slideDown();
        });
              
      }); 
    });
</script>

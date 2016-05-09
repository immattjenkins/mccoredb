<h1>Account Management</h1>

<h2>Change Your Password</h2>

<form id="password_update" method="POST">
  <label for="password">Enter New Password</label>
  <input id="password" name="password" type="password" placeholder="Enter new password" /> 
  <label for="confirm_password">Confirm New Password</label>
  <input id="confirm_password" name="confirm_password" type="password" placeholder="Confirm new password" />
  <button value="change" class="orange_button button block" name="submit_password_update">Update Password</button>
</form>

<?php if($_SESSION['userID'] == 1): ?>
<h2>Promote Faculty</h2>
<form>
  <label for="promoteFaculty">Give Faculty Ability to Create Domains</label>
  <select name="promoteFaculty">
    <?php foreach($regularFaculty as $fac): ?>
      <option value="<?php echo $fac['ID']; ?>"><?php echo $fac['FirstName'] . ' ' .  $fac['LastName']; ?></option>
    <?php endforeach; ?>
  </select>
  <button class="orange_button button block" name="promote_faculty" value="promote">Promote</button>
</form>

<h2>Demote Faculty</h2>
<form>
  <label for="demoteFaculty">Remove Faculty's Ability to Create Domains</label>
  <select name="demoteFaculty">
    <?php foreach($privFaculty as $fac): ?>
      <option value="<?php echo $fac['ID']; ?>"><?php echo $fac['FirstName'] . ' ' .  $fac['LastName']; ?></option>
    <?php endforeach; ?>
  </select>
  <button class="orange_button button block" name="demote_faculty" value="demote">Demote</button>
</form>
<?php endif; ?>
 

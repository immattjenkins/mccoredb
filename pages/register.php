<h1>Register Your Account</h1>

<form id="registeraccount" name="registeraccount" method="POST">

  <label for="registerUsername">Username</label>
  <input id="registerUsername" name="registerUsername" type="text" placeholder="Enter Username" />

  <label for="registerFirstName">First Name</label>
  <input id="registerFirstName" name="registerFirstName" type="text" placeholder="Enter your first name" />

  <label for="registerLastName">Last Name</label>
  <input id="registerLastName" name="registerLastName" type="text" placeholder="Enter your last name" />
 
  <label for="registerEmail">E-mail</label>
  <input id="registerEmail" name="registerEmail" type="email" placeholder="Enter E-mail Adddress" />

  <label for="registerDepartment">Department</label>
  <select id="registerDepartment" name="registerDepartment">
    <option value="" disabled selected hidden>Please choose your department</option>

    <?php foreach($departments as $department): ?>
      <option value="<?php echo $department ?>"><?php echo $department ?></option>
    <?php endforeach; ?>

  </select>

  <label for="registerPassword">Password</label>
  <input id="registerPassword" name="registerPassword" type="password" placeholder="Enter a password" />

  <label for="confirmPassword">Confirm Password</label>
  <input id="confirmPassword" name="confirmPassword" type="password" placeholder="Confirm your password" />

  <button id="createaccount" name="createaccount" value="create" class="button orange_button block">Create My Account</button>
</form>

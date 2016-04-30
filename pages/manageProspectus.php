<h1>Prospectus</h1>

<form id="manage_prospectus" name="manage_prospectus" method="POST">

  <h2>Information</h2>
  <p>Enter the name and year of the prospectus. This has no bearing on the prospectus itself, but is just used for easy identification.</p>
  <input id="prospectus_name" name="prospectus_name" type="text" placeholder="Enter prospectus name" value="<?php if(isset($prospectus)) echo $prospectus['Name']; ?>" />

  <h2>Educational Goals</h2>
  <p>Enter educational goals.</p>
  <textarea id="educationalGoals" name="educationalGoals">
    <?php if(isset($prospectus)) echo $prospectus['Educational Goal']; ?>
  </textarea>

  <h2>Learning Outcome</h2>
  <textarea id="learningOutcome" name="learningOutcome">
    <?php if(isset($prospectus)) echo $prospectus['Learning Outcome']; ?>
  </textarea>

  <h2>Description</h2>
  <textarea id="desc" name="desc">
    <?php if(isset($prospectus)) echo $prospectus['Description']; ?>
  </textarea>

  <h2>Domain Goals</h2>
  <textarea id="domainGoals" name="domainGoals">
    <?php if(isset($prospectus)) echo $prospectus['Domain Goals']; ?>
  </textarea>

  <h2>Required Content</h2>
  <textarea id="requiredContent" name="requiredContent">
   <?php if(isset($prospectus)) echo $prospectus['Required Content']; ?>
  </textarea>

  <button id="submit_prospectus" name="submit_prospectus" class="orange_button button" value="submit">Submit</button>

</form>

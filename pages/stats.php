<h1>Statistics</h1>

<h2>Reports by Student ID</h2>
<form>
  <input id="selectByStudentID" name="selectByStudentID" placeholder="Enter Student ID" />
  <button id="submit_sBSID" name="submit_sBSID" value="SBSID" class="orange_button button">Submit</button>
</form>

<h2>Reports by Course Code</h2>
<form>
  <input id="selectByCourseCode" name="selectByCourseCode" placeholder="Enter Course Code" />
  <button id="submit_sBCC" name="submit_sBCC" value="SBCC" class="orange_button button">Submit</button>
</form>

<?php if(isset($res)): ?>
<h2>Report Results for <?php echo $who ?></h2>
  <ul>
    <?php foreach($res as $result): ?>
    <li>
      <?php echo $result['Title']; ?>
      <?php if(isset($result['Name'])) echo " (" . $result['Name'] . ")"; ?>
      <?php echo ': ' . $result['Score']; ?>
    </li>
    <?php endforeach;?>
  </ul>
<?php endif; ?>

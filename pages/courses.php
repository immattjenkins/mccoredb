<h1>Your Classes</h1>

<p>This is the control panel for your classes. You can create, manage, and delete coures you teach here.</p>

<h2>Create New Class</h2>
<form id="create_course">
  <input id="course_name" name="course_name" type="text" placeholder="Enter Course Name"/>
  <select id="prospectus" name="prospectus">
      <?php foreach($prospectusList as $prospectus): ?>
        <option value="<?php echo $prospectus['ID']?>"><?php echo $prospectus['Name'] ?></option>
      <?php endforeach; ?>
  </select>
  <button id="submit_create" class="orange_button button" name="submit_create" type="submit">Create</button>
</form>

<h2>Manage Your Classes</h2>
  <ul>
    <?php foreach($courseList as $course): ?>
      <li><a href="manageCourse.php?id=<?php echo $course['ID']; ?>"><?php echo $course['Name']; ?></a> <a href="courses.php?deleteID=<?php echo $course['ID'] ?>">(delete)</a></li>
    <?php endforeach; ?>
  </ul>


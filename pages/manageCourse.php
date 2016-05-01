<h1><?php echo $pageTitle ?></h1>

<h2>Manage Course Title</h2>
<form id="edit_course" method="POST" action="manageCourse.php?id=<?php echo $course['ID'] ?>">
  <input id="edit_course_name" name="edit_course_name" type="text" value="<?php echo $course['Name']; ?>" />
  <button id="edit_domain_submit" name="edit_domain_submit" value="edit" class="orange_button button">Edit</button>
</form>

<h2>Manage Sections</h2>

<form id="create_section" method="POST" action="manageCourse.php?id=<?php echo $course['ID'] ?>">
  <label for="section_number">Section Number</label>
  <input id="section_number" name="section_number" type="text" placeholder="Section Number" />
  <button id="create_section_submit" name="create_section_submit" value="create" class="orange_button button block">Add</button>
</form>

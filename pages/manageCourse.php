<h1><?php echo $pageTitle ?></h1>

<form id="edit_course" method="POST" action="manageCourse.php?id=<?php echo $course['ID'] ?>">
  <label for="edit_course_name">Update Course Name</label>
  <input id="edit_course_name" name="edit_course_name" type="text" value="<?php echo $course['Name']; ?>" />
  <label for="edit_course_code">Update Course Code</label>
  <input id="edit_course_code" name="edit_course_code" type="text" value="<?php echo $course['CourseCode'] ?>" />
  <button id="edit_domain_submit" name="edit_domain_submit" value="edit" class="orange_button button block">Edit</button>
</form>


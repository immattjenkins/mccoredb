<h1>Your Classes</h1>

<p>This is the control panel for your classes. You can create, manage, and delete coures you teach here.</p>

<h2>Manage Your Classes</h2>
  <ul id="courseList">
    <?php foreach($courseList as $course): ?>
      <li><a href="manageCourse.php?id=<?php echo $course['ID']; ?>"><?php echo $course['Name']; ?></a> <a href="sections.php?courseID=<?php echo $course['ID'] ?>" title="Sections"><img src="img/view.png" alt="Sections" /></a> <a href="courses.php?deleteID=<?php echo $course['ID'] ?>" class="deleteCourse" title="Delete" data-ID="<?php echo $course['ID']; ?>"><img src="img/delete.png" alt="(Delete)" /></a></li>
    <?php endforeach; ?>
  </ul>

<h2>Create New Class</h2>
<form id="create_course">
  <input hidden id="jqueryUserID" value="<?php echo $_SESSION['userID']; ?>"/>
  <label for="course_name" class="block">Course Name</label>
  <input id="course_name" name="course_name" type="text" placeholder="Enter Course Name"/>
  <label for="prospectus" class="block">Prospectus Name</label>
  <select id="prospectus" name="prospectus">
      <?php foreach($prospectusList as $prospectus): ?>
        <option value="<?php echo $prospectus['ID']?>"><?php echo $prospectus['Name'] ?></option>
      <?php endforeach; ?>
  </select>
  <label for="course_code" class="block">Course Code</label>
  <input id="course_code" name="course_code" type="text" placeholder="EXM101" />
  <button id="submit_create" class="orange_button button block" name="submit_create" type="submit">Create</button>
</form>

<script>
    $(function() {
      $('.deleteCourse').click(function(e) {
        var request = {function: 'deleteCourse',
                       params: {courseID: $(this).attr('data-id'), userID: $('#jqueryUserID').val()}};
	var listItem = $(this);
        e.preventDefault();
        $.post("includes/ajax.php", {request: JSON.stringify(request)}, function(d) {
	  listItem.parent().slideUp();
	});
      });
      
      $('#submit_create').click(function(e) {
        var request = {function: 'createCourse',
                       params: {name: $('#course_name').val(), code: $('#course_code').val(), prospectus: $('#prospectus').val(), userID: $('#jqueryUserID').val()}};  

	e.preventDefault();
        $.post("includes/ajax.php", {request: JSON.stringify(request)}, function(d) {
 	     console.log(d); 
             var json = $.parseJSON(d); console.log("A" + json.ID);
	     var str = '<li class="hidden_item"><a href="manageCourse.php?id=' + json.ID + '">' + $('#course_name').val() + '</a> <a href="sections.php?courseID=' + json.ID + '"><img src="img/view.png" alt="Sections" /></a> <a href="courses.php?deleteID=' + json.ID + '" class="deleteCourse" title="Delete" data-ID="' + json.ID + '"><img src="img/delete.png" alt="(Delete)" /></a></li>';
	     console.log(str);
	     $('#courseList').append(str);
	     $('.hidden_item').removeClass('hidden_item').hide().slideDown();
        });
	      
      }); 
    });
</script>

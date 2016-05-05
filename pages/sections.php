<h1>Course Sections</h1>

<ul>
<?php foreach($sections as $section): ?>
  <li><a href="roster.php?sectionID=<?php echo $section['ID']; ?>"><?php echo $section['Number'] . " " . $section['Term'] . " " . $section['AcademicYear']; ?></a></li>
<?php endforeach; ?>
</ul>


<form id="add_new_section">
  <label for="section_number">Section Number</label>
  <input id="section_number" name="section_number" placeholder="#"/>
  <label for="section_term">Term</label>
  <select id="section_term" name="section_term">
   <option value="Fall">Fall</option>
   <option value="Spring">Spring</option>
   <option value="J-Term">J-Term</option>
   <option value="Summer">Summer</option>
  </select>
  <input hidden name="courseID" value="<?php echo $_REQUEST['courseID']; ?>" />
  <button id="add_section_submit" name="add_section_submit" class="orange_button button block">Create</button>
</form>

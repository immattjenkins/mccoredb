-- Generation Script for DB Project
-- WILL DROP EVERY TABLE BEFORE CREATION

--
-- Delete tables if currently existing
--

DROP TABLE IF EXISTS `RubricItemResponse`;
DROP TABLE IF EXISTS `RubricItem`;
DROP TABLE IF EXISTS `Rubric`;
DROP TABLE IF EXISTS `Roster`;
DROP TABLE IF EXISTS `Section`;
DROP TABLE IF EXISTS `Course`;
DROP TABLE IF EXISTS `Prospectus`;
DROP TABLE IF EXISTS `Student`;
DROP TABLE IF EXISTS `Domain`;
DROP TABLE IF EXISTS `Faculty`;

--
-- Table Definitions
--

CREATE TABLE `Faculty` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
	`Username` VARCHAR(255) NOT NULL,
  	`Password` VARCHAR(255) NOT NULL,
	`Email` VARCHAR(255) NOT NULL,
	`CanCreateDomain` BIT NOT NULL,
	`FirstName` VARCHAR(255) NOT NULL,
	`LastName` VARCHAR(255) NOT NULL,
	`Department` VARCHAR(255) NOT NULL,
	`CreatedOn` DATETIME NOT NULL
);

CREATE TABLE `Domain` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
	`Title` VARCHAR(255) NOT NULL,
	`Department` VARCHAR(255) NOT NULL,
	`FacultyID` INT NOT NULL,
	CONSTRAINT `fkFacultyDomainID` FOREIGN KEY (`FacultyID`) REFERENCES `Faculty`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE	
);
-- Contains CreateDomain, DeleteDomain procedures

CREATE TABLE `Prospectus` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
	`Name` VARCHAR(255) NOT NULL,
	`EducationalGoal` LONGTEXT NOT NULL,
	`LearningOutcome` LONGTEXT NOT NULL,
	`Description` LONGTEXT NOT NULL,
	`DomainGoals` LONGTEXT NOT NULL,
	`RequiredContent` LONGTEXT NOT NULL,
        `Year` YEAR NOT NULL,
	`DomainID` INT NOT NULL,
	CONSTRAINT `fkDomain` FOREIGN KEY (`DomainID`) REFERENCES `Domain`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Student` (
	`ID` VARCHAR(50) PRIMARY KEY,
	`FirstName` VARCHAR(255) NOT NULL,
	`LastName` VARCHAR(255) NOT NULL
);

CREATE TABLE `Course` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
	`Name` VARCHAR(255) NOT NULL,
	`ProspectusID` INT NOT NULL,
	`FacultyID` INT NOT NULL,
	CONSTRAINT `fkProspectusCourse` FOREIGN KEY (`ProspectusID`) REFERENCES `Prospectus`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `fkFaculty` FOREIGN KEY (`FacultyID`) REFERENCES `Faculty`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Section` (
	`ID` INT AUTO_INCREMENT,
	`AcademicYear` YEAR NOT NULL,
	`Number` INT NOT NULL,
	`CourseID` INT NOT NULL,
	PRIMARY KEY `pk_Section` (`ID`, `AcademicYear`),
	CONSTRAINT `fkCourse` FOREIGN KEY (`CourseID`) REFERENCES `Course`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Roster` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
	`StudentID` VARCHAR(50) NOT NULL,
	`SectionID` INT NOT NULL,
	INDEX `idx_RosterFK` (`StudentID`, `SectionID`),
	CONSTRAINT `fkRosterStudentID` FOREIGN KEY (`StudentID`) REFERENCES `Student`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `fkRosterSectionID` FOREIGN KEY (`SectionID`) REFERENCES `Section`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Rubric` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
	`CreatedOn` DATETIME NOT NULL,
	`ProspectusID` INT NOT NULL,
	CONSTRAINT `fk_RubricProspectus` FOREIGN KEY (`ProspectusID`) REFERENCES `Prospectus`(`ID`)
);

CREATE TABLE `RubricItem` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
	`Question` TEXT NOT NULL,
	`RubricID` INT NOT NULL,
	`CourseID` INT NOT NULL,
	INDEX `idx_RubricItemFK` (`RubricID`, `CourseID`),
	CONSTRAINT `fk_RubricCourseID` FOREIGN KEY (`CourseID`) REFERENCES `Course`(`ID`),
	CONSTRAINT `fk_RubricRubricID` FOREIGN KEY (`RubricID`) REFERENCES `Rubric`(`ID`)
);

CREATE TABLE `RubricItemResponse` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
	`Score` VARCHAR(3) NOT NULL,
	`Comment` TEXT NULL,
	`StudentID` VARCHAR(50) NOT NULL,
	`RubricItemID` INT NOT NULL,
	INDEX `idx_RubricItemResponseFK` (`StudentID`, `RubricItemID`),
	CONSTRAINT `fk_RIRStudentID` FOREIGN KEY (`StudentID`) REFERENCES `Student`(`ID`),
	CONSTRAINT `fk_RIRRubricItemID` FOREIGN KEY (`RubricItemID`) REFERENCES `RubricItem`(`ID`)
);

--
-- Procedures
--

--
-- Domain
--

-- CreateDomain
DROP PROCEDURE IF EXISTS `CreateDomain`;
DELIMITER //
CREATE PROCEDURE `CreateDomain`(`title` VARCHAR(255), `dept` VARCHAR(255), `facID` INT)
BEGIN
	-- Attempt insertion
	INSERT IGNORE INTO `Domain`(`Title`, `Department`, `FacultyID`) VALUES (`title`, `dept`, `facID`);

	-- Report results
	IF ROW_COUNT() > 0 THEN
		SELECT LAST_INSERT_ID() AS `ID`, 'Success' AS `Message`;
	ELSE
		SELECT -1 AS `ID`, 'Failure' AS `Message`;
	END IF;
END;//
DELIMITER ;

-- DeleteDomain
DROP PROCEDURE IF EXISTS `DeleteDomain`;
DELIMITER //
CREATE PROCEDURE `DeleteDomain`(`domainID` INT, `facID` INT)
BEGIN
        -- Attempt deletion
        DELETE FROM `Domain` WHERE `ID`=`domainID` AND `FacultyID`=`facID`;
END;//
DELIMITER ;

-- GetDomainInfo
DROP PROCEDURE IF EXISTS `GetDomainInfo`;
DELIMITER //
CREATE PROCEDURE `GetDomainInfo`(`domainID` INT, `facID` INT)
BEGIN
	SELECT `ID`, `Title`
		FROM `Domain`
		WHERE `ID` = `domainID`
			AND `FacultyID` = `facID`;
	
END;//
DELIMITER ;

-- GetAllDomains
DROP PROCEDURE IF EXISTS `ListAllDomains`;
DELIMITER //
CREATE PROCEDURE `ListAllDomains`(`facID` INT)
BEGIN
	SELECT `ID`, `Title`
		FROM `Domain`
		WHERE `FacultyID` = `facID`;
END;//
DELIMITER ;

-- GetDomainsByDepartment
DROP PROCEDURE IF EXISTS `ListDomainsByDept`;
DELIMITER //
CREATE PROCEDURE `ListDomainsByDept`(`dept` VARCHAR(255)) 
BEGIN
	SELECT `ID`, `Title`
		FROM `Domain`
		WHERE `Department` = `dept`;
END;//
DELIMITER ;
-- UpdateDomainInfo
DROP PROCEDURE IF EXISTS `UpdateDomainInfo`;
DELIMITER //
CREATE PROCEDURE `UpdateDomainInfo`(`domainID` INT, `domainTitle` VARCHAR(255), `facID` INT)
BEGIN
	UPDATE `Domain` 
		SET `Title` = `domainTitle`
		WHERE `ID` = `domainID`
			AND `FacultyID` = `facID`;
END;//
DELIMITER ;

--
-- Prospectus Procedures
--

-- CreateProspectus
DROP PROCEDURE IF EXISTS `CreateProspectus`;
DELIMITER //
CREATE PROCEDURE `CreateProspectus`(`title` VARCHAR(255), `educationalGoal` LONGTEXT,
																	 `learningOutcome` LONGTEXT,
																 	 `desc` LONGTEXT,
																 	 `domainGoals` LONGTEXT,
																 	 `requiredContent` LONGTEXT,
																 	 `domainID` INT)
BEGIN
	INSERT IGNORE INTO `Prospectus`(`Name`, `EducationalGoal`, `LearningOutcome`, `Description`, `DomainGoals`, `RequiredContent`, `DomainID`, `Year`)
								VALUES(`title`, `educationalGoal`, `learningOutcome`, `desc`, `domainGoals`, `requiredContent`, `domainID`, YEAR(NOW()));

	IF ROW_COUNT() > 0 THEN
		SELECT LAST_INSERT_ID() AS `ID`, 'Prospectus Created' AS `Message`;
	ELSE
		SELECT -1 AS `ID`, 'Prospectus Creation Failed' AS `Message`;
	END IF;
END;//
DELIMITER ;

-- DeleteProspectus
DROP PROCEDURE IF EXISTS `DeleteProspectus`;
DELIMITER //
CREATE PROCEDURE `DeleteProspectus`(`prospectusID` INT)
BEGIN
	DELETE FROM `Prospectus` WHERE `ID` = `prospectusID`;
END;//
DELIMITER ;

-- GetProspectusInfo
DROP PROCEDURE IF EXISTS `GetProspectusInfo`;
DELIMITER //
CREATE PROCEDURE `GetProspectusInfo`(`prospectusID` INT)
BEGIN
	SELECT `ID`, `Name` AS `Name`, `EducationalGoal` AS `Educational Goal`, `LearningOutcome` AS `Learning Outcome`,
			`Desription`, `DomainGoals` AS `Domain Goals`, `RequiredContent` AS `Required Content`
		FROM `Prospectus`
		WHERE `ID` = `prospectusID`;
END;//
DELIMITER ;

DROP PROCEDURE IF EXISTS `GetProspectusList`;
DELIMITER //
CREATE PROCEDURE `GetProspectusList`(`facID` INT)
BEGIN
	SELECT `Prospectus`.`ID`, `Name`
		FROM `Prospectus`
		INNER JOIN `Faculty` ON `Faculty`.`ID` = `facID`
		INNER JOIN `Domain` ON `Prospectus`.`DomainID` = `Domain`.`ID`
		WHERE `Domain`.`Department` = `Faculty`.`Department`;
END;//
DELIMITER ;
--
-- Student Procedures
--

-- CreateStudent
DROP PROCEDURE IF EXISTS `CreateStudent`;
DELIMITER //
CREATE PROCEDURE `CreateStudent`(`collegeID` VARCHAR(50), `firstName` VARCHAR(255),
				 `lastName` VARCHAR(255))
BEGIN
	-- Attempt insertion
	INSERT IGNORE INTO `Student`(`ID`, `FirstName`, `LastName`) VALUES (`collegeID`, `firstName`, `lastName`);

	-- Report results
	IF ROW_COUNT() > 0 THEN
		SELECT LAST_INSERT_ID() AS `ID`, 'Success' AS `Message`;
	ELSE
		SELECT -1 AS `ID`, 'Failure' AS `Message`;
	END IF;
END;//
DELIMITER ;

-- DeleteStudent
DROP PROCEDURE IF EXISTS `DeleteStudent`;
DELIMITER //
CREATE PROCEDURE `DeleteStudent`(`studentID` VARCHAR(50))
BEGIN
	-- Attempt deletion
	DELETE FROM `Student` WHERE `ID`=`studentID`;
END;//
DELIMITER ;

-- GetStudentInfo
DROP PROCEDURE IF EXISTS `GetStudentInfo`;
DELIMITER //
CREATE PROCEDURE `GetStudentInfo`(`studentID` VARCHAR(50))
BEGIN
	SELECT `ID`, `FirstName` AS `First Name`, `LastName` AS `Last Name`
		FROM `Student`
		WHERE `ID` = `studentID`;
END;//
DELIMITER ;

-- GetAllStudents
DROP PROCEDURE IF EXISTS `GetAllStudents`;
DELIMITER //
CREATE PROCEDURE `GetAllStudents`()
BEGIN
	SELECT `ID`, `FirstName` AS `First Name`, `LastName` AS `Last Name`
		FROM `Student`;
END;//
DELIMITER ;

--
-- Faculty Procedures
--

-- CreateFaculty
DROP PROCEDURE IF EXISTS `CreateFaculty`;
DELIMITER //
CREATE PROCEDURE `CreateFaculty`(`username` VARCHAR(255),
				 `password` VARCHAR(255),
				 `email` VARCHAR(255),
				 `creation` BIT,
				 `firstName` VARCHAR(255),
				 `lastName` VARCHAR(255),
				 `dept` VARCHAR(255))
BEGIN
	-- Attempt insertion
	INSERT IGNORE INTO `Faculty`(`Username`, `Password`, `Email`, `CanCreateDomain`, `FirstName`, `LastName`, `Department`, `CreatedOn`)
	       VALUES(`username`, PASSWORD(`password`), `email`, `creation`, `firstName`, `lastName`, `dept`, NOW());

	IF ROW_COUNT() > 0 THEN
		SELECT LAST_INSERT_ID() AS `UserID`, `username` AS `Username`, 'Success' AS `Message`;
	ELSE
		SELECT -1 AS `UserID`, 'Failure' AS `Message`;
	END IF;
END;//
DELIMITER ;

-- DeleteFaculty
DROP PROCEDURE IF EXISTS `DeleteFaculty`;
DELIMITER //
CREATE PROCEDURE `DeleteFaculty`(`facultyID` INT)
BEGIN
	-- Attempt deletion
	DELETE FROM `Faculty` WHERE `ID`=`facultyID`;
END;//
DELIMITER ;

-- PromoteFaculty
DROP PROCEDURE IF EXISTS `PromoteFaculty`;
DELIMITER //
CREATE PROCEDURE `PromoteFaculty`(`facultyID` INT)
BEGIN
	UPDATE IGNORE `Faculty` SET `CanCreateDomain` = 1 WHERE `ID` = `facultyID`;

	IF ROW_COUNT() > 0 THEN
		SELECT `facultyID` AS `ID`, 'Promotion Successful' AS `Message`;
	ELSE
		SELECT -1 AS `ID`, 'Promotion Failed' AS `Message`;
		END IF;
END;//
DELIMITER ;

-- DemoteFaculty
DROP PROCEDURE IF EXISTS `DemoteFaculty`;
DELIMITER //
CREATE PROCEDURE `DemoteFaculty`(`facultyID` INT)
BEGIN
	UPDATE IGNORE `Faculty` SET `CanCreateDomain` = 0 WHERE `ID`  = `facultyID`;

	IF ROW_COUNT() > 0 THEN
		SELECT `facultyID` AS `ID`, 'Demotion Successful' AS `Message`;
	ELSE
		SELECT -1 AS `ID`, 'Demotion Failed' AS `Message`;
	END IF;
END;//
DELIMITER ;

-- ChangeFacultyPassword
DROP PROCEDURE IF EXISTS `ChangeFacultyPassword`;
DELIMITER //
CREATE PROCEDURE `ChangeFacultyPassword`(`facultyID` INT, `newPassword` VARCHAR(255))
BEGIN
	UPDATE IGNORE `Faculty` SET `Password` = PASSWORD(`newPassword`) WHERE `ID` = `facultyID`;

	IF ROW_COUNT() > 0 THEN
		SELECT `facultyID` AS `ID`, 'Password changed successfully' as `Message`;
	ELSE
		SELECT -1 AS `ID`, 'Password change failed.' AS `Message`;
	END IF;
END;//
DELIMITER ;


-- LogFacultyIn
DROP PROCEDURE IF EXISTS `LogFacultyIn`;
DELIMITER //
CREATE PROCEDURE `LogFacultyIn`(`uname` VARCHAR(255), `pass` VARCHAR(255))
BEGIN
	DECLARE userID INT DEFAULT -1;
	DECLARE userCanCreate INT DEFAULT -1;
	DECLARE dept VARCHAR(255) DEFAULT NULL;
	SELECT `ID`, `CanCreateDomain`, `Department`
		FROM `Faculty`
		WHERE `Username` = `uname` AND `Password` = PASSWORD(`pass`)
		INTO userID, userCanCreate, dept;

		-- Handle success and Failure
		IF userID > 0 THEN
			SELECT userID AS `ID`, userCanCreate AS `Create`, dept AS `Department`, 'Login Successful' AS `Message`;
		ELSE
			SELECT -1 AS `ID`, 0 AS `Create`, dept AS `Department`, 'Login Failed' AS `Message`;
		END IF;
END;//
DELIMITER ;

--
-- Course
--

-- CreateCourse
DROP PROCEDURE IF EXISTS `CreateCourse`;
DELIMITER //
CREATE PROCEDURE `CreateCourse`(`name` VARCHAR(255), `prospectusID` INT, `facultyID` INT)
BEGIN
	INSERT IGNORE INTO `Course`(`Name`, `ProspectusID`, `FacultyID`) VALUES(`name`, `prospectusID`, `facultyID`);

	IF ROW_COUNT() > 0 THEN
		SELECT LAST_INSERT_ID() AS `ID`, 'Course created' AS `Message`;
	ELSE
		SELECT -1 AS `ID`, `Course creation failed` AS `Message`;
	END IF;
END;//
DELIMITER ;

-- DeleteCourse
DROP PROCEDURE IF EXISTS `DeleteCourse`;
DELIMITER //
CREATE PROCEDURE `DeleteCourse`(`courseID` INT)
BEGIN
	DELETE FROM `Course` WHERE `ID` = `courseID`;
END;//
DELIMITER ;

--
-- Section
--

-- CreateSection
DROP PROCEDURE IF EXISTS `CreateSection`;
DELIMITER //
CREATE PROCEDURE `CreateSection`(`academicYear` YEAR, `num` INT, `courseID` INT)
BEGIN
	INSERT IGNORE INTO `Section`(`AcademicYear`, `Number`, `CourseID`) VALUES(`academicYear`, `num`, `couresID`);

	IF ROW_COUNT() > 0 THEN
		SELECT LAST_INSERT_ID() AS `ID`, 'Section created' AS `Message`;
	ELSE
		SELECT -1 AS `ID`, 'Section creation failed' AS `Message`;
	END IF;
END;//
DELIMITER ;

-- DeleteSection
DROP PROCEDURE IF EXISTS `DeleteSection`;
DELIMITER //
CREATE PROCEDURE `DeleteSection`(`sectionID` INT)
BEGIN
	DELETE FROM `Section` WHERE `ID` = `sectionID`;
END;//
DELIMITER ;

-- ChangeSectionNumber
DROP PROCEDURE IF EXISTS `ChangeSectionNumber`;
DELIMITER //
CREATE PROCEDURE `ChangeSectionNumber`(`sectionID` INT, `num` INT)
BEGIN
	UPDATE IGNORE `Section` SET `Number` = `num` WHERE `ID` = `sectionID`;

	IF ROW_COUNT() > 0 THEN
		SELECT `sectionID` AS `ID`, 'Section number updated' AS `Message`;
	ELSE
		SELECT -1 AS `ID`, 'Section number update failed.' AS `Message`;
		END IF;
END;//
DELIMITER ;

--
-- Roster
--

-- AddStudentToRoster
DROP PROCEDURE IF EXISTS `AddStudentToRoster`;
DELIMITER //
CREATE PROCEDURE `AddStudentToRoster`(`studentID` VARCHAR(50), `secID` INT, `secYear` YEAR)
BEGIN
	INSERT INTO `Roster`(`StudentID`, `SectionID`, `SectionAcademicYear`) VALUES(`studentID`, `sectionID`, `sectionAcademicYear`);

	IF ROW_COUNT() > 0 THEN
		SELECT LAST_INSERT_ID() AS `ID`, 'Student added successfully' AS `Message`;
	ELSE
		SELECT -1 AS `ID`, 'Adding student to roster failed' AS `Message`;
	END IF;
END;//
DELIMITER ;

-- RemoveStudentFromRoster
DROP PROCEDURE IF EXISTS `RemoveStudentFromRoster`;
DELIMITER //
CREATE PROCEDURE `RemoveStudentFromRoster`(`rosterID` INT)
BEGIN
	DELETE FROM `Roster` WHERE `ID` = `rosterID`;
END;//
DELIMITER ;

--
-- Rubric
--

-- CreateRubric
DROP PROCEDURE IF EXISTS `CreateRubric`;
DELIMITER //
CREATE PROCEDURE `CreateRubric`(`createdOn` DATETIME, `prospectusID` INT)
BEGIN
	INSERT INTO `Rubric`(`CreatedOn`, `ProspectusID`) VALUES(`createdOn`, `prospectusID`);

	IF ROW_COUNT() > 0 THEN
		SELECT LAST_INSERT_ID() AS `ID`, 'Rubric created successfully' AS `Message`;
	ELSE
		SELECT -1 AS `ID`, 'Creating Rubic failed' AS `Message`;
	END IF;
END;//
DELIMITER ;

-- DeleteRubric
DROP PROCEDURE IF EXISTS `DeleteRubric`;
DELIMITER //
CREATE PROCEDURE `DeleteRubric`(`rubricID` INT)
BEGIN
	DELETE FROM `Rubric` WHERE `ID` = `rubricID`;
END;//
DELIMITER ;

--
-- RubricItem
--

-- CreateRubricItem
DROP PROCEDURE IF EXISTS `CreateRubricItem`;
DELIMITER //
CREATE PROCEDURE `CreateRubricItem`(`question` TEXT, `rubricID` INT, `courseID` INT)
BEGIN
	INSERT INTO `RubricItem`(`Question`, `RubricID`, `CourseID`) VALUES(`question`, `rubricID`, `courseID`);

	IF ROW_COUNT() > 0 THEN
		SELECT LAST_INSERT_ID() AS `ID`, 'Rubric item created successfully' AS `Message`;
	ELSE
		SELECT -1 AS `ID`, 'Creating Rubic item failed' AS `Message`;
	END IF;
END;//
DELIMITER ;

-- DeleteRubricItem
DROP PROCEDURE IF EXISTS `DeleteRubricItem`;
DELIMITER //
CREATE PROCEDURE `DeleteRubricItem`(`rubricID` INT)
BEGIN
	DELETE FROM `RubricItem` WHERE `ID` = `rubricID`;
END;//
DELIMITER ;

--
-- RubricItemResponse
--

-- CreateRubricItemResponse
DROP PROCEDURE IF EXISTS `CreateRubricItemResponse`;
DELIMITER //
CREATE PROCEDURE `CreateRubricItemResponse`(`score` INT, `comment` TEXT, `studentID` VARCHAR(50), `rubricItemID` INT)
BEGIN

	INSERT INTO `RubricItemResponse`(`Score`, `Comment`, `StudentID`, `RubricItemID`) VALUES(`score`, `comment`, `studentID`, `rubricItemID`);

	IF ROW_COUNT() > 0 THEN
		SELECT LAST_INSERT_ID() AS `ID`, 'Response recorded successfully' AS `Message`;
	ELSE
		SELECT -1 AS `ID`, 'Response recording failed' AS `Message`;
	END IF;
END;//
DELIMITER ;

-- DeleteRubricItemResponse
DROP PROCEDURE IF EXISTS `DeleteRubricItemResponse`;
DELIMITER //
CREATE PROCEDURE `DeleteRubricItemResponse`(`rubricID` INT)
BEGIN
	DELETE FROM `RubricItemResponse` WHERE `ID` = `rubricID`;
END;//
DELIMITER ;

-- UpdateRIRComment
DROP PROCEDURE IF EXISTS `UpdateRIRComment`;
DELIMITER //
CREATE PROCEDURE `UpdateRIRComment`(`rirID` INT, `comment` TEXT)
BEGIN
	UPDATE IGNORE `RubricItemResponse` SET `Comment` = `comment` WHERE `ID` = `rirID`;
	IF ROW_COUNT() > 0 THEN
		SELECT `rirID` AS `ID`, 'Comment updated successfully' AS `Message`;
	ELSE
		SELECT -1 AS `ID`, 'Comment update failed' AS `Message`;
	END IF;
END;//
DELIMITER ;

-- UpdateRIRScore
DROP PROCEDURE IF EXISTS `UpdateRIRScore`;
DELIMITER //
CREATE PROCEDURE `UpdateRIRScore`(`rirID` INT, `score` TEXT)
BEGIN
	UPDATE IGNORE `RubricItemResponse` SET `Score` = `score` WHERE `ID` = `rirID`;
	IF ROW_COUNT() > 0 THEN
		SELECT `rirID` AS `ID`, 'Score updated successfully' AS `Message`;
	ELSE
		SELECT -1 AS `ID`, 'Score update failed' AS `Message`;
	END IF;
END;//
DELIMITER ;


-- Create a test user
CALL `CreateFaculty`("admin", "changeme", "m@mj.me", 1, "Matt", "Jenkins", "CSC");
CALL `CreateFaculty`("admin2", "changeme", "m@mj.me", 0, "Matt", "Jenkins", "MTH");

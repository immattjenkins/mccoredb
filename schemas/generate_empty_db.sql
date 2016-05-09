-- Generation Script for DB Project
-- WILL DROP EVERY TABLE BEFORE CREATION

--
-- Delete tables if currently existing
--

DROP TABLE IF EXISTS `RubricItemDescription`;
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
	`CourseCode` VARCHAR(255) NOT NULL,
	`ProspectusID` INT NOT NULL,
	`FacultyID` INT NOT NULL,
	CONSTRAINT `fkProspectusCourse` FOREIGN KEY (`ProspectusID`) REFERENCES `Prospectus`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `fkFaculty` FOREIGN KEY (`FacultyID`) REFERENCES `Faculty`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Section` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
	`AcademicYear` YEAR NOT NULL,
        `Term` VARCHAR(255) NOT NULL,
	`Number` INT NOT NULL,
	`CourseID` INT NOT NULL,
	CONSTRAINT `fkCourse` FOREIGN KEY (`CourseID`) REFERENCES `Course`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Roster` (
	`StudentID` VARCHAR(50) NOT NULL,
	`SectionID` INT NOT NULL,
        PRIMARY KEY (`StudentID`, `SectionID`),
	INDEX `idx_RosterFK` (`StudentID`, `SectionID`),
	CONSTRAINT `fkRosterStudentID` FOREIGN KEY (`StudentID`) REFERENCES `Student`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `fkRosterSectionID` FOREIGN KEY (`SectionID`) REFERENCES `Section`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Rubric` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
	`CreatedOn` TIMESTAMP DEFAULT NOW(),
	`ProspectusID` INT NOT NULL,
	CONSTRAINT `fk_RubricProspectus` FOREIGN KEY (`ProspectusID`) REFERENCES `Prospectus`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `RubricItem` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
        `Title` TEXT NOT NULL,
	`Question` TEXT NOT NULL,
	`RubricID` INT NOT NULL,
	INDEX `idx_RubricItemFK` (`RubricID`),
	CONSTRAINT `fk_RubricRubricID` FOREIGN KEY (`RubricID`) REFERENCES `Rubric`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `RubricItemDescription` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
	`ScoreNum` INT NOT NULL,
	`ScoreLevel` VARCHAR(255) NOT NULL,
	`Explanation` TEXT NOT NULL,
	`RubricItemID` INT NOT NULL,
	INDEX `idx_RubricItemDescFK` (`RubricItemID`),
	CONSTRAINT `fk_RubricItemID` FOREIGN KEY (`RubricItemID`) REFERENCES `RubricItem`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `RubricItemResponse` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
	`Score` INT NOT NULL,
	`Comment` TEXT NULL,
	`StudentID` VARCHAR(50) NOT NULL,
	`RubricItemID` INT NOT NULL,
	INDEX `idx_RubricItemResponseFK` (`StudentID`, `RubricItemID`),
	CONSTRAINT `fk_RIRStudentID` FOREIGN KEY (`StudentID`) REFERENCES `Student`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `fk_RIRRubricItemID` FOREIGN KEY (`RubricItemID`) REFERENCES `RubricItem`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE
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

-- UpdateProspectus
DROP PROCEDURE IF EXISTS `UpdateProspectus`;
DELIMITER //
CREATE PROCEDURE `UpdateProspectus`(`title` VARCHAR(255), `educationalGoal` LONGTEXT,
                                                                                                                                         `learningOutcome` LONGTEXT,
                                                                                                                                         `desc` LONGTEXT,
                                                                                                                                         `domainGoals` LONGTEXT,
                                                                                                                                         `requiredContent` LONGTEXT,
                                                                                                                                         `prospectusID` INT)
BEGIN

	UPDATE `Prospectus`
		SET `EducationalGoal` = `educationalGoal`,
			`Name` = `title`,
			`LearningOutcome` = `learningOutcome`,
			`Description` = `desc`,
			`DomainGoals` = `domainGoals`,
			`RequiredContent` = `requiredContent`
		WHERE `ID` = `prospectusID`;

        IF ROW_COUNT() > 0 THEN
                SELECT LAST_INSERT_ID() AS `ID`, 'Prospectus Updated' AS `Message`;
        ELSE
                SELECT -1 AS `ID`, 'Prospectus Update Failed' AS `Message`;
        END IF; 
END;//
DELIMITER ;

-- DeleteProspectus
DROP PROCEDURE IF EXISTS `DeleteProspectus`;
DELIMITER //
CREATE PROCEDURE `DeleteProspectus`(`prospectusID` INT, `facID` INT)
BEGIN
	DELETE P FROM `Prospectus` P 
                INNER JOIN `Faculty` ON `Faculty`.`ID` = `facID`
                INNER JOIN `Domain` ON `P`.`DomainID` = `Domain`.`ID`
                WHERE `P`.`ID` = `prospectusID` AND `Domain`.`Department` = `Faculty`.`Department`;
END;//
DELIMITER ;

-- GetProspectusInfo
DROP PROCEDURE IF EXISTS `GetProspectusInfo`;
DELIMITER //
CREATE PROCEDURE `GetProspectusInfo`(`prospectusID` INT, `facID` INT)
BEGIN
	SELECT `Prospectus`.`ID`, `Name` AS `Name`, `EducationalGoal` AS `Educational Goal`, `LearningOutcome` AS `Learning Outcome`,
			`Description`, `DomainGoals` AS `Domain Goals`, `RequiredContent` AS `Required Content`, `Year`
		FROM `Prospectus`
                INNER JOIN `Faculty` ON `Faculty`.`ID` = `facID`
                INNER JOIN `Domain` ON `Prospectus`.`DomainID` = `Domain`.`ID`
                WHERE `Prospectus`.`ID` = `prospectusID` AND `Domain`.`Department` = `Faculty`.`Department`;
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
CREATE PROCEDURE `CreateCourse`(`name` VARCHAR(255), `courseCode` VARCHAR(255), `prospectusID` INT, `facultyID` INT)
BEGIN
	INSERT IGNORE INTO `Course`(`Name`, `CourseCode`, `ProspectusID`, `FacultyID`) VALUES(`name`, `courseCode`, `prospectusID`, `facultyID`);

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
CREATE PROCEDURE `DeleteCourse`(`courseID` INT, `facID` INT)
BEGIN
	DELETE FROM `Course` WHERE `ID` = `courseID` AND `FacultyID` = `facID`;
END;//
DELIMITER ;

-- GetCourseList
DROP PROCEDURE IF EXISTS `GetCourseList`;
DELIMITER //
CREATE PROCEDURE `GetCourseList`(`facID` INT)
BEGIN
	SELECT `ID`, `Name`, `CourseCode`, `ProspectusID` FROM `Course` WHERE `FacultyID` = `facID`;
END;//
DELIMITER ;

-- GetCourseInfo
DROP PROCEDURE IF EXISTS `GetCourseInfo`;
DELIMITER //
CREATE PROCEDURE `GetCourseInfo`(`courseID` INT, `facID` INT)
BEGIN
	SELECT `ID`, `Name`, `CourseCode`, `ProspectusID` FROM `Course` WHERE `FacultyID` = `facID` AND `ID` = `courseID`;
END;//
DELIMITER ;

-- UpdateCourseInfo
DROP PROCEDURE IF EXISTS `UpdateCourseInfo`;
DELIMITER //
CREATE PROCEDURE `UpdateCourseInfo`(`courseName` VARCHAR(255), `courseCode` VARCHAR(255), `courseID` INT, `facID` INT)
BEGIN
	UPDATE `Course` SET `Name` = `courseName`, `CourseCode` = `courseCode` 
		WHERE `ID` = `courseID` AND `FacultyID` = `facID`;
END;//
DELIMITER ;

--
-- Section
--

-- CreateSection
DROP PROCEDURE IF EXISTS `CreateSection`;
DELIMITER //
CREATE PROCEDURE `CreateSection`(`num` INT, `courseID` INT, `term` VARCHAR(255))
BEGIN
	INSERT IGNORE INTO `Section`(`AcademicYear`, `Number`, `CourseID`, `Term`) VALUES(YEAR(NOW()), `num`, `courseID`, `term`);

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

-- ListSectionByCourse
DROP PROCEDURE IF EXISTS `ListSectionByCourse`;
DELIMITER //
CREATE PROCEDURE `ListSectionByCourse`(`cID` INT)
BEGIN
        SELECT `ID`, `AcademicYear`, `Number`, `Term` FROM `Section` WHERE `CourseID` = `cID`;
END;//
DELIMITER ;

--
-- Roster
--

-- AddStudentToRoster
DROP PROCEDURE IF EXISTS `AddStudentToRoster`;
DELIMITER //
CREATE PROCEDURE `AddStudentToRoster`(`studentID` VARCHAR(50), `secID` INT)
BEGIN
	INSERT INTO `Roster`(`StudentID`, `SectionID`) VALUES(`studentID`, `secID`);

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
CREATE PROCEDURE `RemoveStudentFromRoster`(`secID` INT, `sID` INT)
BEGIN
	DELETE FROM `Roster` WHERE `SectionID` = `secID` AND `StudentID` = `sID`;
END;//
DELIMITER ;

-- ListStudentsInRoster
DROP PROCEDURE IF EXISTS `ListStudentsInRoster`;
DELIMITER //
CREATE PROCEDURE `ListStudentsInRoster`(`sID` INT, `userID` INT) 
BEGIN
      SELECT `FirstName`, `LastName`, `Student`.`ID`
	FROM `Roster`
	INNER JOIN `Student` ON `Student`.`ID` = `Roster`.`StudentID`
        WHERE `SectionID` = `sID`;
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

-- GetRubricInfo
DROP PROCEDURE IF EXISTS `GetRubricInfo`;
DELIMITER //
CREATE PROCEDURE `GetRubricInfo`(`prosID` INT)
BEGIN
	SELECT `ID` FROM `Rubric` WHERE `ProspectusID` = `prosID`;
END;//
DELIMITER ;

--
-- RubricItem
--

-- CreateRubricItem
DROP PROCEDURE IF EXISTS `CreateRubricItem`;
DELIMITER //
CREATE PROCEDURE `CreateRubricItem`(`title` TEXT, `question` TEXT, `rubricID` INT)
BEGIN
	INSERT INTO `RubricItem`(`Title`, `Question`, `RubricID`) VALUES(`title`, `question`, `rubricID`);

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

-- UpdateRubricItem
DROP PROCEDURE IF EXISTS `UpdateRubricItem`;
DELIMITER //
CREATE PROCEDURE `UpdateRubricItem`(`title` TEXT, `question` TEXT, `upID` INT)
BEGIN
	UPDATE `RubricItem` SET `Title` = `title`, `Question` = `question` WHERE `ID` = `upID`;
END;//
DELIMITER ;

-- GetRubricItemList
DROP PROCEDURE IF EXISTS `GetRubricItemList`;
DELIMITER //
CREATE PROCEDURE `GetRubricItemList`(`prosID` INT)
BEGIN
	SELECT `RubricItem`.`ID`, `RubricItem`.`Title`
		FROM `RubricItem`
		INNER JOIN `Rubric` ON `Rubric`.`ID` = `RubricItem`.`RubricID`
		INNER JOIN `Prospectus` ON `Prospectus`.`ID` = `Rubric`.`ProspectusID`
		WHERE `Rubric`.`ProspectusID` = `prosID`;
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
DROP PROCEDURE IF EXISTS `UpdateRIR`;
DELIMITER //
CREATE PROCEDURE `UpdateRIR`(`rirID` INT, `comment` TEXT, `num` INT)
BEGIN
	UPDATE IGNORE `RubricItemResponse` SET `Comment` = `comment`, `Score` = `num` WHERE `ID` = `rirID`;
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

-- GetRubricItemInfo
DROP PROCEDURE IF EXISTS `GetRubricItemInfo`;
DELIMITER //
CREATE PROCEDURE `GetRubricItemInfo`(`rID` INT)
BEGIN
	SELECT `RubricItem`.`Title`, `RubricItem`.`Question`, `RubricItemDescription`.`ID` AS `RID`, `ScoreLevel`, `Explanation`
		FROM `RubricItem`
		INNER JOIN `RubricItemDescription` ON `RubricItemDescription`.`RubricItemID` = `RubricItem`.`ID`
		WHERE `RubricItem`.`ID` = `rID`;
END;//
DELIMITER ;

-- GetRubricItemInfoByID
DROP PROCEDURE IF EXISTS `GetRubricItemInfoByID`;
DELIMITER //
CREATE PROCEDURE `GetRubricItemInfoByID`(`rID` INT)
BEGIN
	SELECT `ID`, `Title`, `Question` 
                FROM `RubricItem`
                WHERE `RubricItem`.`ID` = `rID`;
END;//
DELIMITER ;

-- CreateRubricItemDescription
DROP PROCEDURE IF EXISTS `CreateRubricItemDescription`;
DELIMITER //
CREATE PROCEDURE `CreateRubricItemDescription`(`num` INT, `score` VARCHAR(255), `explanation` TEXT, `rIID` INT)
BEGIN
	INSERT INTO `RubricItemDescription`(`ScoreNum`, `ScoreLevel`, `Explanation`, `RubricItemID`) VALUES(`num`, `score`, `explanation`, `rIID`);

        IF ROW_COUNT() > 0 THEN
                SELECT LAST_INSERT_ID() AS `ID`, 'Score updated successfully' AS `Message`;
        ELSE
                SELECT -1 AS `ID`, 'Score update failed' AS `Message`;
        END IF; 
END;//
DELIMITER ;

-- GetRubricItemDescriptionInfo
DROP PROCEDURE IF EXISTS `GetRubricItemDescriptionInfo`;
DELIMITER //
CREATE PROCEDURE `GetRubricItemDescriptionInfo`(`descID` INT)
BEGIN
	SELECT `ID`, `ScoreNum`, `ScoreLevel`, `Explanation`
		FROM `RubricItemDescription`
		WHERE `ID` = `descID`;
END;//
DELIMITER ;

-- DeleteRubricItemDescription
DROP PROCEDURE IF EXISTS `DeleteRubricItemDescription`;
DELIMITER //
CREATE PROCEDURE `DeleteRubricItemDescription`(`descID` INT)
BEGIN
	DELETE FROM `RubricItemDescription` WHERE `ID` = `descID`;
END;//
DELIMITER ;

-- GetRubricBySection
DROP PROCEDURE IF EXISTS `GetRubricBySection`;
DELIMITER //
CREATE PROCEDURE `GetRubricBySection`(`secID` INT) 
BEGIN
	SELECT `Rubric`.`ID` AS `RubricID`
		FROM `Section`
		INNER JOIN `Course` ON `Course`.`ID` = `Section`.`CourseID`
		INNER JOIN `Prospectus` ON `Prospectus`.`ID` = `Course`.`ProspectusID`
		INNER JOIN `Rubric` ON `Rubric`.`ProspectusID` = `Prospectus`.`ID`
		WHERE `Section`.`ID` = `secID`;
	
END;//
DELIMITER ;

-- GetRubricItemsByID
DROP PROCEDURE IF EXISTS `GetRubricItemsByID`;
DELIMITER //
CREATE PROCEDURE `GetRubricItemsByID`(`rubID` INT)
BEGIN
	SELECT `ID`, `Title`, `Question`
		FROM `RubricItem`
		WHERE `RubricItem`.`RubricID` = `rubID`
		ORDER BY `ID` ASC;
END;//
DELIMITER ;

-- GetRubricItemDesc
DROP PROCEDURE IF EXISTS `GetRubricItemDesc`;
DELIMITER //
CREATE PROCEDURE `GetRubricItemDesc`(`itemID` INT)
BEGIN
	SELECT *
		FROM `RubricItemDescription`
		WHERE `RubricItemID` = `itemID`
		ORDER BY `ScoreNum` DESC;
END;//
DELIMITER ;

-- CheckIfStudentHasGrades
DROP PROCEDURE IF EXISTS `CheckIfStudentHasGrades`;
DELIMITER //
CREATE PROCEDURE `CheckIfStudentHasGrades`(`studID` INT, `itemID` INT)
BEGIN
	DECLARE gradeExists INT DEFAULT -1; 
	SELECT `ID`
		FROM `RubricItemResponse`
		WHERE `StudentID` = `studID` AND `RubricItemID` = `itemID`
		INTO gradeExists;
	IF gradeExists > 0 THEN
		SELECT 'update' AS `Type`;
	ELSE
		SELECT 'create' AS `Type`;
	END IF;	
	
END;//
DELIMITER ;

-- GetStudentGrade
DROP PROCEDURE IF EXISTS `GetStudentGrade`;
DELIMITER //
CREATE PROCEDURE `GetStudentGrade`(`studID` INT, `itemID` INT)
BEGIN
        SELECT `ID`, `Score`, `Comment`
                FROM `RubricItemResponse`
                WHERE `StudentID` = `studID` AND `RubricItemID` = `itemID`;
END;//
DELIMITER ;

-- ReportByStudentID
DROP PROCEDURE IF EXISTS `ReportByStudentID`;
DELIMITER //
CREATE PROCEDURE `ReportByStudentID`(`student` VARCHAR(255))
BEGIN
	SELECT `RubricItem`.`Title`, `Score`, `Prospectus`.`Name`
		FROM `RubricItemResponse` 
		INNER JOIN `RubricItem` ON `RubricItemResponse`.`RubricItemID` = `RubricItem`.`ID`
		INNER JOIN `Rubric` ON `Rubric`.`ID` = `RubricItem`.`RubricID`
		INNER JOIN `Prospectus` ON `Prospectus`.`ID` = `Rubric`.`ProspectusID`
		WHERE `StudentID` = `student`
		GROUP BY `RubricItemID`;
END;//
DELIMITER ;

-- ReportByCourseCode
DROP PROCEDURE IF EXISTS `ReportByCourseCode`;
DELIMITER //
CREATE PROCEDURE `ReportByCourseCode`(`cCode` VARCHAR(255))
BEGIN
	SELECT `RubricItem`.`Title`, SUM(`Score`)/COUNT(`Score`) AS `Score`
		FROM `RubricItemResponse` 
		INNER JOIN `RubricItem` ON `RubricItem`.`ID` = `RubricItemResponse`.`RubricItemID`
		INNER JOIN `Rubric` ON `Rubric`.`ID` = `RubricItem`.`RubricID`
		INNER JOIN `Course` ON `Course`.`ProspectusID` = `Rubric`.`ProspectusID`
		WHERE `CourseCode` = `cCode`
		GROUP BY `RubricItemID`;
END;//
DELIMITER ;

-- GetPrivFaculty
DROP PROCEDURE IF EXISTS `GetPrivFaculty`;
DELIMITER //
CREATE PROCEDURE `GetPrivFaculty`()
BEGIN
	SELECT `ID`, `FirstName`, `LastName`
		FROM `Faculty`
		WHERE `CanCreateDomain` = 1;
END;//
DELIMITER ;

-- GetRegularFaculty
DROP PROCEDURE IF EXISTS `GetRegularFaculty`;
DELIMITER //
CREATE PROCEDURE `GetRegularFaculty`()
BEGIN
        SELECT `ID`, `FirstName`, `LastName`
                FROM `Faculty`
                WHERE `CanCreateDomain` = 0;
END;//
DELIMITER ;

--    CheckUsername
DROP PROCEDURE IF EXISTS `CheckUsername`;
DELIMITER //
CREATE PROCEDURE `CheckUsername`(`un` VARCHAR(255))
BEGIN
  DECLARE userId INT DEFAULT -1; 
  SELECT `ID` FROM `Faculty` WHERE `Username` = un INTO userId;
  IF userId = -1 THEN
     SELECT 1 AS `Available`;
  ELSE
     SELECT 0 AS `Available`;
  END IF; 
END;//
DELIMITER ;

--    CheckEmail
DROP PROCEDURE IF EXISTS `CheckEmail`;
DELIMITER //
CREATE PROCEDURE `CheckEmail`(`un` VARCHAR(255))
BEGIN
  DECLARE userId INT DEFAULT -1; 
  SELECT `ID` FROM `Faculty` WHERE `Email` = un INTO userId;
  IF userId = -1 THEN
     SELECT 1 AS `Available`;
  ELSE
     SELECT 0 AS `Available`;
  END IF; 
END;//
DELIMITER ;

--
-- Triggers
--

DROP TRIGGER IF EXISTS `CreateRubricAfterProspectus`;
DELIMITER //
CREATE TRIGGER `CreateRubricAfterProspectus` AFTER INSERT ON `Prospectus`
FOR EACH ROW
BEGIN
  INSERT INTO `Rubric`(`ProspectusID`) VALUES(NEW.ID);
END;//
DELIMITER ;

-- Create a test user
CALL `CreateFaculty`("admin", "changeme", "INFOTECH", 1, "MaryvilleCollege", "IT", "IT");
CALL `CreateFaculty`("testUser", "changeme", "test@email.com", 0, "Test", "User", "Education");

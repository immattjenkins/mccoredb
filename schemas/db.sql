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
	`CanCreateDomain` VARCHAR(255) NOT NULL,
	`FirstName` VARCHAR(255) NOT NULL,
	`LastName` VARCHAR(255) NOT NULL,
	`Department` VARCHAR(255) NOT NULL,
	`CreatedOn` DATETIME NOT NULL
);

CREATE TABLE `Domain` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
	`Title` VARCHAR(255) NOT NULL
);
-- Contains CreateDomain, DeleteDomain procedures

CREATE TABLE `Prospectus` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
	`EducationalGoal` LONGTEXT NOT NULL,
	`LearningOutcome` LONGTEXT NOT NULL,
	`Description` LONGTEXT NOT NULL,
	`DomainGoals` LONGTEXT NOT NULL,
	`RequiredContent` LONGTEXT NOT NULL,
	`DomainID` INT NOT NULL,
	CONSTRAINT `fkDomain` FOREIGN KEY (`DomainID`) REFERENCES `Domain`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Student` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
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
	`CourseID` INT NOT NULL,
	PRIMARY KEY `pk_Section` (`ID`, `AcademicYear`),
	CONSTRAINT `fkCourse` FOREIGN KEY (`CourseID`) REFERENCES `Course`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Roster` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
	`StudentID` INT NOT NULL,
	`SectionID` INT NOT NULL,
	INDEX `idx_RosterFK` (`StudentID`, `SectionID`),
	CONSTRAINT `fkRosterStudentID` FOREIGN KEY (`StudentID`) REFERENCES `Student`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `fkRosterSectionID` FOREIGN KEY (`SectionID`) REFERENCES `Section`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Rubric` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
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
	`StudentID` INT NOT NULL,
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

DROP PROCEDURE IF EXISTS `CreateDomain`;
DELIMITER //
CREATE PROCEDURE `CreateDomain`(`title` VARCHAR(255))
BEGIN
	-- Attempt insertion
	INSERT IGNORE INTO `Student`(`Title`) VALUES (`title`);

	-- Report results
	IF ROW_COUNT() > 0 THEN
		SELECT LAST_INSERT_ID() AS `ID`, 'Success' AS `Message`;
	ELSE
		SELECT -1 AS `ID`, 'Failure' AS `Message`;
	END IF;
END;//
DELIMITER ;

DROP PROCEDURE IF EXISTS `DeleteDomain`;
DELIMITER //
CREATE PROCEDURE `DeleteDomain`(`domainID` INT)
BEGIN
        -- Attempt deletion
        DELETE FROM `Student` WHERE `ID`=`domainID`;
END;//
DELIMITER ;

--
-- Student Procedures
--

-- CreateStudent
DROP PROCEDURE IF EXISTS `CreateStudent`;
DELIMITER //
CREATE PROCEDURE `CreateStudent`(`firstName` VARCHAR(255),
				 `lastName` VARCHAR(255))
BEGIN
	-- Attempt insertion
	INSERT IGNORE INTO `Student`(`FirstName`, `LastName`) VALUES (`firstName`, `lastName`);

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
CREATE PROCEDURE `DeleteStudent`(`studentID` INT)
BEGIN
	-- Attempt deletion
	DELETE FROM `Student` WHERE `ID`=`studentID`;
END;//
DELIMITER ;

-- GetStudentInfo
DROP PROCEDURE IF EXISTS `GetStudentInfo`;
DELIMITER //
CREATE PROCEDURE `GetStudentInfo`(`studentID` INT)
BEGIN
	SELECT `ID` AS `ID`, `FirstName` AS `First Name`, `LastName` AS `Last Name`
		FROM `Student`
		WHERE `ID` = `studentID`;
END;//
DELIMITER ;

-- GetAllStudents
DROP PROCEDURE IF EXISTS `GetAllStudents`;
DELIMITER //
CREATE PROCEDURE `GetAllStudents`()
BEGIN
	SELECT `ID` AS `ID`, `FirstName` AS `First Name`, `LastName` AS `Last Name`
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
CREATE PROCEDURE `LogFacultyIn`(`username` VARCHAR(255), `password` VARCHAR(255))
BEGIN
	DECLARE FacID INT DEFAULT -1;
	SELECT `ID`
		FROM `Faculty`
		WHERE `Username` = `username` AND `Password` = PASSWORD(`password`)
		INTO FacID;

		-- Handle success and Failure
		IF FacID > 0 THEN
			SELECT FacID AS `ID`, 'Login Successful' AS `Message`;
		ELSE
			SELECT -1 AS `ID`, 'Login Failed' AS `Message`;
		END IF;
END;//
DELIMITER ;

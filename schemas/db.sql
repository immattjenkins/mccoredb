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
        `Role` ENUM('Inactive', 'Professor', 'Chair') NOT NULL,
	`FirstName` VARCHAR(255) NOT NULL,
	`LastName` VARCHAR(255) NOT NULL,
	`Department` VARCHAR(255) NOT NULL
);

CREATE TABLE `Domain` (
	`ID` INT AUTO_INCREMENT PRIMARY KEY,
	`Title` VARCHAR(255) NOT NULL
);

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
-- Student Procedures
--

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
		SELECT -1 AS `ID`, `Failure` AS `Message`;
	END IF;
END;//
DELIMITER ;

DROP PROCEDURE IF EXISTS `DeleteStudent`;
DELIMITER //
CREATE PROCEDURE `DeleteStudent`(`studentID` INT)
BEGIN
	-- Attempt deletion
	DELETE FROM `Student` WHERE `ID`=`studentID`;
END;//
DELIMITER ;


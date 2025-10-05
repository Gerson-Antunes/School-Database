sql

-- -----------------------------------------------------
-- Table `00122744`.`school`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `00122744`.`school` (
  `SchoolName` VARCHAR(60) NOT NULL,
  `Address` VARCHAR(80) NOT NULL,
  `PhoneNumber` VARCHAR(15) NOT NULL,
  `Email` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`SchoolName`))
ENGINE = InnoDB;

-- Insert data into school
INSERT INTO school (SchoolName, Address, PhoneNumber, Email)
VALUES
('TechBridge Academy', '123 Learning Lane', '0400123456', 'admin@techbridge.edu.au');

SELECT * FROM school;


-- -----------------------------------------------------
-- Table `00122744`.`teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `00122744`.`teacher` (
  `TeacherID` INT NOT NULL,
  `FirstName` VARCHAR(25) NOT NULL,
  `MiddleNameInitial` VARCHAR(4) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(60) NOT NULL,
  `PhoneNumber` VARCHAR(15) NOT NULL,
  `school_SchoolName` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`TeacherID`),
  INDEX `fk_teacher_school1_idx` (`school_SchoolName` ASC),
  CONSTRAINT `fk_teacher_school1`
    FOREIGN KEY (`school_SchoolName`)
    REFERENCES `00122744`.`school` (`SchoolName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insert data into teacher
INSERT INTO teacher (TeacherID, FirstName, MiddleNameInitial, LastName, Email, PhoneNumber, School_SchoolName)
VALUES
(1, 'Emily', 'J', 'Stone', 'estone@techbridge.edu.au', '0400000001', 'TechBridge Academy'),
(2, 'David', 'L', 'Chan', 'dchan@techbridge.edu.au', '0400000002', 'TechBridge Academy'),
(3, 'Sandra', 'K', 'Lee', 'slee@techbridge.edu.au', '0400000003', 'TechBridge Academy'),
(4, 'Mark', 'P', 'Taylor', 'mtaylor@techbridge.edu.au', '0400000004', 'TechBridge Academy');

SELECT * FROM teacher;



-- -----------------------------------------------------
-- Table `00122744`.`subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `00122744`.`subject` (
  `SubjectName` VARCHAR(10) NOT NULL,
  `SubjectDescription` VARCHAR(150) NOT NULL,
  `CostOfSubject` DECIMAL(10,2) NOT NULL,
  `DurationInHours` INT NOT NULL,
  `NumberOfAssessmentsItems` INT NOT NULL,
  `teacher_TeacherID` INT NOT NULL,
  INDEX `fk_subject_teacher1_idx` (`teacher_TeacherID` ASC),
  PRIMARY KEY (`SubjectName`),
  CONSTRAINT `fk_subject_teacher1`
    FOREIGN KEY (`teacher_TeacherID`)
    REFERENCES `00122744`.`teacher` (`TeacherID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Insert data into subject
INSERT INTO subject (SubjectName, SubjectDescription, CostOfSubject, DurationInHours, NumberOfAssessmentsItems, Teacher_TeacherID)
VALUES
('IT101', 'Introduction to IT', 350.00, 40, 3, 1),
('WD102', 'Web Development Basics', 400.00, 45, 3, 2),
('DB103', 'Database Systems', 375.00, 40, 2, 3),
('CS104', 'Computer Systems', 360.00, 42, 2, 4);

SELECT * FROM subject;

-- -----------------------------------------------------
-- Table `00122744`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `00122744`.`student` (
  `StudentID` INT NOT NULL,
  `FirstName` VARCHAR(25) NOT NULL,
  `MiddleNameInitial` VARCHAR(4) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `PhoneNumber` VARCHAR(15) NOT NULL,
  `ResidentialAddress` VARCHAR(80) NOT NULL,
  `Email` VARCHAR(60) NOT NULL,
  `DateOfBirth` DATE NOT NULL,
  `DateOfEnrolment` DATE NOT NULL,
  `GovernmentSubsidised` CHAR(1) NOT NULL,
  `school_SchoolName` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`StudentID`),
  INDEX `fk_student_school_idx` (`school_SchoolName` ASC),
  CONSTRAINT `fk_student_school`
    FOREIGN KEY (`school_SchoolName`)
    REFERENCES `00122744`.`school` (`SchoolName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- Insert data into student
INSERT INTO student (StudentID, FirstName, MiddleNameInitial, LastName, PhoneNumber, ResidentialAddress, Email, DateOfBirth, DateOfEnrolment, GovernmentSubsidised, School_SchoolName)
VALUES
(101, 'Jason', 'J', 'Willians', '0400111122', '1 Tech Ave', 'jason.willians@email.com', '1993-12-14', '2024-02-01', 'Y', 'TechBridge Academy'),
(102, 'Liam', 'A', 'Smith', '0400222233', '2 Tech Ave', 'liam.smith@example.com', '2001-05-10', '2024-02-01', 'N', 'TechBridge Academy'),
(103, 'Emma', 'B', 'Jones', '0400333344', '3 Tech Ave', 'emma.jones@example.com', '2002-06-12', '2024-02-01', 'Y', 'TechBridge Academy'),
(104, 'Noah', 'C', 'Brown', '0400444455', '4 Tech Ave', 'noah.brown@example.com', '2003-07-18', '2024-02-01', 'N', 'TechBridge Academy'),
(105, 'Olivia', 'D', 'Taylor', '0400555566', '5 Tech Ave', 'olivia.taylor@example.com', '2004-08-20', '2024-02-01', 'Y', 'TechBridge Academy');

SELECT * FROM student;



-- -----------------------------------------------------
-- Table `00122744`.`enrolment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `00122744`.`enrolment` (
  `DateOfEnrolment` DATE NOT NULL,
  `StudentGrade` CHAR(1) NOT NULL,
  `StudentResult` INT NOT NULL,
  `DateOfGradeSubject` DATE NOT NULL,
  `student_StudentID` INT NOT NULL,
  `subject_SubjectName` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`student_StudentID`, `subject_SubjectName`),
  INDEX `fk_enrolment_student1_idx` (`student_StudentID` ASC),
  INDEX `fk_enrolment_subject1_idx` (`subject_SubjectName` ASC),
  CONSTRAINT `fk_enrolment_student1`
    FOREIGN KEY (`student_StudentID`)
    REFERENCES `00122744`.`student` (`StudentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrolment_subject1`
    FOREIGN KEY (`subject_SubjectName`)
    REFERENCES `00122744`.`subject` (`SubjectName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- Insert data into enrolment
INSERT INTO enrolment (DateOfEnrolment, StudentGrade, StudentResult, DateOfGradeSubject, Student_StudentID, Subject_SubjectName)
VALUES
('2024-02-01', 'D', 88, '2024-05-01', 101, 'IT101'),
('2024-02-01', 'C', 79, '2024-05-02', 101, 'WD102'),
('2024-02-01', 'D', 91, '2024-05-03', 101, 'DB103'),
('2024-02-01', 'D', 90, '2024-05-04', 101, 'CS104'),

('2024-02-01', 'C', 75, '2024-05-01', 102, 'IT101'),
('2024-02-01', 'P', 65, '2024-05-02', 102, 'CS104'),
('2024-02-01', 'C', 73, '2024-05-03', 102, 'DB103'),

('2024-02-01', 'D', 95, '2024-05-01', 103, 'WD102'),
('2024-02-01', 'D', 90, '2024-05-02', 103, 'DB103'),
('2024-02-01', 'C', 85, '2024-05-03', 103, 'CS104'),

('2024-02-01', 'P', 60, '2024-05-01', 104, 'IT101'),
('2024-02-01', 'C', 72, '2024-05-02', 104, 'WD102'),
('2024-02-01', 'D', 88, '2024-05-03', 104, 'CS104'),

('2024-02-01', 'C', 78, '2024-05-01', 105, 'IT101'),
('2024-02-01', 'D', 86, '2024-05-02', 105, 'WD102'),
('2024-02-01', 'C', 80, '2024-05-03', 105, 'DB103');

SELECT * FROM enrolment;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

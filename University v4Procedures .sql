use universityprojectv4;
use universityprojectvexam;
/*Viewing all enrolments details including student name, teacher name, course name etc*/

/* ---------------------------- show all rollment --------------------------- */

CREATE PROCEDURE spViewAllEnrolments 
AS
BEGIN
   SELECT STUDENTID as "Student ID" , studentName as "Student Name" from Student 
   SELECT COURSEID  as "Course ID" , courseName as "course Name" from Course
   SELECT  EnrollDate as "Enrollment Date" from Enroll 
   SELECT DName as "Department Name" from Department
   SELECT StaffName  as "Professor Name" from Staff
END

/* --------------------------- update student name -------------------------- */

CREATE PROCEDURE spUpdateStudentName
(
@STUDENTID INT,
@StudentName nvarchar(50)
)
AS
BEGIN
   UPDATE 
         Student
   SET  
         [StudentName] = @StudentName
   WHERE 
         [STUDENTID] = @STUDENTID

   SELECT Student.STUDENTID as "Student ID" , Student.StudentName as "Student Name" from Student 
   where studentID = @studentID
END

/* ------------------------------  adjust grade ----------------------------- */

CREATE PROCEDURE spAppendNewGrade
(
@studentid int,
 @studentCourse nvarchar(20),
 @Grade int,
 @scale nvarchar(20)
)
AS
BEGIN
 
SELECT
   
	Student.STUDENTID as "Student ID" , Student.StudentName as "Student Name",
	Course.CourseName as "Course Name", studentDegree.studDegree,
	studentDegree.GradeScale
	
FROM
	 Student, Course , StudentDegree
where
	Student.STUDENTID = @Studentid AND
	Course.CourseID  = @StudentCourse
	
UPDATE
		StudentDegree
SET
		@Grade = [StudDegree],
		@Scale = [GradeScale]
WHERE
	[STUDENTID] = @studentID AND
	[courseID] = @StudentCourse
END

/* ---------- try to adjust the the grade and show all information ---------- */

EXEC spAppendNewGrade @studentid = 3 , @studentCourse ='1CLL', @Grade = 80, @scale ='very good';

/* ------------------------------------ find teacher by department ----------------------------------- */

CREATE PROC spFindTeacherByDepartment 
@depname nvarchar(50)
AS
BEGIN
SELECT
		Staff.STAFFID as [professor ID],
		Staff.StaffName as [professor Name],
		Staff.StaffEmail as [Email],
		Department.Dname as [Department],
		Faculty.FName as [Faculty]
FROM
	  Staff JOIN Department ON Department.DID = Staff.DID 
				JOIN Faculty ON Faculty.FID = Department.FID 
WHERE
	  @depname = Department.DName 
ORDER BY Staff.STAFFID
END

/* ------------------------ find single student by id ----------------------- */

CREATE PROCEDURE findSingleStudentById @sId INT
AS
BEGIN 
	SELECT DISTINCT STUDENTID, studentName, StudentEmail ,Student.DID as departmentID, DName , FID
	from Student JOIN Department ON Department.DID = Student.DID
	WHERE studentID = @sId
END
Go

/* ----------------------------------- try ---------------------------------- */

EXEC findSingleStudentById @sId = 2 

/* ----------------------------- add new student ---------------------------- */

CREATE PROCEDURE addNewStudent 
@studentName nVARCHAR(50), @studentEmail nVARCHAR(50), @studyLevel nVARCHAR(20), @DID nVARCHAR(20)
AS
BEGIN 
	INSERT INTO Student VALUES (@studentName, @studentEmail, @studyLevel, @DID) 
END
Go

/* ---------------------------------- --try --------------------------------- */

EXEC addNewStudent @studentName ='mo', @studentEmail = 'mo@mail.com', @studyLevel = '5', @DID='DE1'

/* -------------------------------- get grade ------------------------------- */

CREATE PROCEDURE getGrade 
@sId INT , @CourseName nVARCHAR(50)
AS
BEGIN 
	SELECT DISTINCT studentName, courseName, StudDegree, FullDegree
	from Student JOIN Enroll ON Enroll.STUDENTID = Student.STUDENTID
	JOIN studentDegree ON studentDegree.COURSEID = Enroll.COURSEID
	join Course on Course.COURSEID = studentDegree.COURSEID 
	WHERE Student.studentID = @sId and Course.CourseName = @CourseName
END
Go

/* ----------------------------------- try ---------------------------------- */

EXEC getGrade @sId = 3 ,@CourseName = 'concrete'

/* ---------------------------- find single staff --------------------------- */

CREATE PROCEDURE findSingleStaff 
@SId INT
AS
BEGIN 
	SELECT DISTINCT StaffID ,staffName, staffEmail ,staff.DID as departmentId, DName as departmentName ,Department.FID as FacultyId, FName as FacultyName 
	FROM  Staff JOIN Department ON Department.DID = Staff.DID 
				JOIN Faculty ON Faculty.FID = Department.FID 
	WHERE StaffID = @SId
END
Go

/* ----------------------------------- try ---------------------------------- */

EXEC findSingleStaff @SId = 5

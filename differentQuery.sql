use universityprojectv4;
use universityprojectvexam;
/* --- return faculity id by using faculityName -- */
create FUNCTION dbo.returnFacultyId
(@FName VARCHAR(50)) RETURNS INT
AS
BEGIN
return (select FID FROM Faculty where FName=@FName)
END
--try function
select dbo.returnFacultyId('engineering') as FacultyId;

/* ------------------------ using function as a query ----------------------- */
create FUNCTION dbo.returnStudentId
(@SName VARCHAR(50)) RETURNS INT
AS
BEGIN
return (select DISTINCT STUDENTID FROM Student where StudentName=@SName )
END

select dbo.returnStudentId('solim')

/* ------------------------------ try function as a query------------------------------ */
select * from Enroll where STUDENTID=dbo.returnStudentId('khaled')

/* ----------- select courseName and student name when studenid=1 ----------- */
select StudentName ,CourseName from Student
join Course
on STUDENTID=1 AND COURSEID in (select distinct COURSEID from Enroll where STUDENTID=1)

/* -------- select student name where student name start with char s -------- */
select StudentName from Student where StudentName like 's%'
/* -------- select student name where student name end with char s -------- */
select StudentName from Student where StudentName like '%m'
/* -------- select studen name who contain "L" character in his name -------- */
select StudentName from Student where StudentName like '%l%'

/* ----------------- select all course in the list (os,DB) ----------------- */
select * from Course where CourseName in ('os','DB')

/* ------------------- update course name where courseid=1 ------------------ */
update Course set CourseName='machineLearning' where COURSEID='1C'
select * from Course

/* ------------------- insert values into faculity tables ------------------- */
insert into Faculty VALUES  ('Engineering'), ( 'Medicine'), ( 'Arts') ;

/* ----------------- select faculty name when Dname is given ---------------- */
select Fname from Faculty where FID=(
    select FID from Department where Dname='civil engineering'
);

/* ------------------------------- using view ------------------------------- */
create VIEW view1
AS
select * from Course where CourseName='os'

/* ------------------------------- allter view ------------------------------ */

ALTER VIEW view1
AS
select * from Course where CourseName='machinelearning'

/* ------------------------------ to call view ------------------------------ */
select * from view1

/* -------------- 10 name of staff who ahve the highest salary -------------- */
select top 10  StaffName from Staff order by StaffSalary desc;

/* --------------------------- sum of staff salary -------------------------- */
select sum(StaffSalary) from Staff

/* ------------------- show the degree of the studentid=1 ------------------- */
select * from StudentDegree where STUDENTID=1

/* ------------- the name of the staff who teach the courseid=1c ------------- */
select * from Staff where STAFFID=(
    SELECT STAFFID FROM Teaching where COURSEID='1C'
)






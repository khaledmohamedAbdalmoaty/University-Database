use universityprojectv4;
use universityprojectvexam;

/* ------ tirgger to see the DELETE data when you update student table ------ */
create TRIGGER shStudDeletedDatewhenUpdate
on  Student for UPDATE
AS
BEGIN
select * from deleted
end;

/* --- tigger to show the new inserted date when you update student table --- */
create TRIGGER showStudentNewDatewhenUpdate
on  Student for UPDATE
AS
BEGIN
select * from inserted
end;
--try previous tigger
update student set StudentName='solim' WHERE DID='DM1';

/* ---------------show student name , lecuture and section table when student enroll in aparticular course----------------------------------- */
create TRIGGER showLectandSec
on Enroll FOR INSERT
AS
BEGIN
select StudentName from Student where STUDENTID=(select STUDENTID FROM inserted)
select * from Lecture where COURSEID=(select COURSEID FROM inserted )
select * from Section where lectureID = (select lectureID from Lecture where COURSEID=(select COURSEID FROM inserted ) )
END
--try trigger
INSERT into Enroll VALUES(3,'1Cgg','2018-02-25');

/* ------ prevent any person from create,alter,drop table from database ----- */
create trigger trPermissionOnTable
on DATABASE for create_table,alter_table,drop_table
AS
BEGIN
ROLLBACK
print 'You do not have the permission to creat,drop,alter Tables '
END

--try trigger
drop table Lecture;

/* ------------------------------ Alter trigger ----------------------------- */

ALTER TRIGGER showLectandSec
on Enroll FOR INSERT
AS
BEGIN
select * from Lecture where COURSEID=(select COURSEID FROM inserted )
select * from Section where lectureID = (select lectureID from Lecture where COURSEID=(select COURSEID FROM inserted ) )
END
--try trigger
INSERT into Enroll VALUES(4,'1CLL','2017-03-15');
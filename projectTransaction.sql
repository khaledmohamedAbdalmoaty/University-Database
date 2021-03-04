use universityprojectv4;
use universityprojectvexam;


/* ---------------------- TRANSACTION in success state ---------------------- */

Begin TRY
BEGIN TRANSACTION
update Course set CourseName='machineLwerhweijkhj' where COURSEID='1C'

COMMIT
End TRY
BEGIN CATCH
select ERROR_NUMBER()
print 'Error: the transaction is abored'

ROLLBACK
end CATCH

select * from Course

/* ----------------------- TRANSACTION in FALSE state ----------------------- */
Begin TRY
BEGIN TRANSACTION
insert into Student VALUES('khaled','231@feng','level 1',55),('wjlks','231@feng','level 2','D1');
COMMIT
End TRY
BEGIN CATCH
select ERROR_NUMBER()
print 'Error: the transaction is abored'
ROLLBACK
end CATCH
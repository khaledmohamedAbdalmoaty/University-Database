create database universityprojectv4;
create database universityprojectvexam;
use universityprojectvexam;



/* -------------------------------------------------------------------------- */
/*                               creating table                               */
/* -------------------------------------------------------------------------- */

/* ------------------------------ faculty table ----------------------------- */

create table Faculty(
  FID int primary key IDENTITY,
  FName NVARCHAR(50) not NULL
);

insert into Faculty VALUES  ('Engineering'), ( 'Medicine'), ( 'Arts'),('science') ;

select * from Faculty
/* ---------------------------- department table ---------------------------- */
create table Department(
    DID NVARCHAR(20) NOT NULL PRIMARY KEY ,
    DName NVARCHAR(50) not NULL,
    FID int not NULL Foreign KEY REFERENCES Faculty(FID)
);
insert into Department VALUES ('DE1','computer engineering and automatic control',1),('DE2','civil engineering',1),('DA1','history',3),('DM1','anatomy',2),
								('DA2','Chinese', 3),('DS1','Biology',4);

select * from Department
select Fname from Faculty where FID=(
select FID from Department where Dname='civil engineering'
);

/* ------------------------------- staff table ------------------------------ */
create table Staff(
    STAFFID int PRIMARY KEY IDENTITY,
    StaffName NVARCHAR(50) not NULL ,
    StaffEmail NVARCHAR(60) not NULL UNIQUE,
    DID NVARCHAR(20) Foreign KEY REFERENCES Department(DID),
    StaffSalary int not NULL
);
INSERT into Staff VALUES('mohamed wagdy','m123@fEng','DE1',5000),('walid','w123@feng','DE2',4000),('Tamer','T123@farts','DA1',3000),
						('Professor1', 'prof@univ.com', 'DE1',8000), ('dr tamer', 'temer@univ.com','DE2',4500),
						('dr wael', 'wael@univ.com','DM1',6000 ),('dr diaa', 'diaa@univ.com','DS1' ,7000);

select * from Staff;
select Dname from Department where DID=(
    select DID from Staff where STAFFID=3
);


/* ------------------------------ student table ----------------------------- */
create table Student(
    STUDENTID int PRIMARY KEY IDENTITY,
    StudentName NVARCHAR(50) not NULL,
    StudentEmail NVARCHAR(50) not NULL UNIQUE,
    StudentLevel NVARCHAR(50) not NULL,
	DID NVARCHAR(20) Foreign KEY REFERENCES Department(DID)
);
insert into Student VALUES('khaled','K231@univ.com',' undergradu level 1','DS1'),('wjlks','W231@univ.com',' undergradu level 2','DA2'),
							('student1','student@univ.com','1st level','DE1') , ('ahmed','ahmed@univ.com', '2nd level','DE1'),
							('student2','student2@univ.com','3rd level','DE2') , ('Fady Galal','Fady@univ.com', '2nd level','DM1'),
                             ('Amer Mohamed','Amer@univ.com', '4th level','DA1');
select * from Student;
select Dname from Department where DID=(
    select DID from Student where STUDENTID=2
);

/* ------------------------------ course table ------------------------------ */
create table Course(
    COURSEID NVARCHAR(20) PRIMARY KEY,
    CourseName NVARCHAR(50) not NULL,
    CreditHours int not NULL,
	DID NVARCHAR(20) Foreign KEY REFERENCES Department(DID)
);
insert into Course VALUES ('1C', 'course1', 3,'DE1'),('1Cgg', 'Translate', 5,'DA1'),
						  ('1Cff', 'surgery', 4,'DM1'),('1CLL', 'concrete', 6,'DE2') ,
						  ('1CSS','Os',12,'DS1'), ('1CAA','DB',10,'DA2');
select * from Course;
select Dname from Department where DID=(
    select DID from Course where COURSEID='1CAA'
);

/* ------------- Courses may have other Courses as prerequisites ------------ */

CREATE TABLE pre_require( 
	MainCourse NVARCHAR(20) Not Null primary key,
	prereq nvarchar(20) Default null,
	Foreign KEY (MainCourse) references Course(courseID) on update cascade ,
	Foreign KEY (prereq) references Course(courseID)
);

INSERT INTO pre_require VALUES ('1C','1Cgg'), ('1CLL','1Cff')
select * from pre_require;
select  CourseName from Course where COURSEID='1CLL';
/* ----------------------------- teaching table ----------------------------- */
create table Teaching(
    COURSEID NVARCHAR(20) NOT NULL Foreign KEY REFERENCES Course(COURSEID),
    STAFFID int NOT NULL Foreign KEY REFERENCES Staff(STAFFID),
);
insert into Teaching VALUES('1CLL',5),('1C',4);
select * from Teaching;
/* ------------------------------ Enroll table ------------------------------ */
create table Enroll(
    STUDENTID INT not NULL Foreign KEY REFERENCES  Student(STUDENTID),
    COURSEID NVARCHAR(20) not NULL Foreign KEY REFERENCES Course(COURSEID),
    EnrollDate DATETIME,
);
INSERT into Enroll VALUES(1,'1C','2018-07-23'),(3, '1CLL','2019-07-23'),
						  (4, '1Cff','2020-07-23'), (5, '1Cgg','2017-07-23'),(1,'1Cgg','2017-07-23');
select * from Enroll;

/* ----------------------------- lecture table ----------------------------- */
create table Lecture(
    LECTUREID NVARCHAR(20) NOT NULL PRIMARY KEY ,
    LectTitle NVARCHAR(100) not NULL,
    Semester NVARCHAR(60) not NULL,
	STAFFID int NOT NULL Foreign KEY REFERENCES Staff(STAFFID),
	COURSEID NVARCHAR(20) NOT NULL Foreign KEY REFERENCES Course(COURSEID),
	StudyLevel VARCHAR(20) NOT NULL  
);



insert into Lecture VALUES ('1LS','automotion','first semester',4,'1CAA','2nd level'),
						   ('1L', 'lec1','2ndSemester',5,'1CSS','2nd level'), ('1Lg', 'lec1','1stSemester',5, '1Cgg','1st level'),
						   ('1Lf', 'lec1','1stSemester',6, '1Cff','3rd level'),('1LL', 'lec1','2ndSemester',7, '1CLL','4th level');
select * from Lecture

/* ------------------------------ section table ----------------------------- */
create table Section(
	SecTitle NVARCHAR(100) not NULL,
    lectureID NVARCHAR(20) Foreign KEY references Lecture(lectureID),
    STAFFID int NOT NULL Foreign KEY REFERENCES Staff(STAFFID),
    appointment TIME ,
	dayOfWeak VARCHAR(20),
	room VARCHAR(20) DEFAULT NULL,
	Semester NVARCHAR(60) 
);
insert into Section VALUES ('sec1','1LL',1,'00:00:00','saturday','room1', '1stSemester' ),
								('sec2','1L',2,'08:00:00', 'sunday', 'room2', '2nd Semester'),
								('lec1', '1Lf',3, '10:00:00', 'Monday', 'room3', '2nd Semester');
select * from Section;

/* ------------------------------ StudentDegree ----------------------------- */
create table StudentDegree(
        STUDENTID INT not NULL Foreign KEY REFERENCES  Student(STUDENTID),
        COURSEID nvarchar(20)  not NULL Foreign KEY REFERENCES Course(COURSEID),
        StudDegree int not null,
		FullDegree int not null ,
        GradeScale NVARCHAR(20)
);

insert into StudentDegree VALUES(1,'1C',125,150,'Excellent');
insert into StudentDegree VALUES(3,'1CLL',70,100,'Good'),(4, '1Cff',100, 100,'Excellent'),
								(5, '1Cgg',95, 125,'very Good'),(1,'1Cgg',75,150,'pass')

select * from StudentDegree
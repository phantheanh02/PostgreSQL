-- create a view 
create view  student_shortinfos as
select  student_id, first_name, last_name, gender, dob, clazz_id
from student;
grant select on student_shortinfos to postgres; 
-- 1.1 display all records from this view
select * from student_shortinfos;
-- 1.2 insert,update, delete a record 
insert into student_shortinfos values ('20204941','Thế Anh','Phan','M','2002/02/01','20162101');
update student_shortinfos set student_id = '20204949' 
where student_id ='20204941';
delete from student_shortinfos where student_id = '20204949';
-- 1.3 a) A list of student: student id, fullname. gender and class name
select student_id, concat(first_name,' ', last_name) as fullname, gender, c.name as class
from student_shortinfos s , clazz c
where s.clazz_id = c.clazz_id;
-- 1.3 b) A list of class (class id, class name) and the number of students in each class
select  name, count(student_id)  as sl
	from  student_shortinfos s 
	right join clazz c on c.clazz_id = s.clazz_id
	GROUP BY c.clazz_id
	ORDER BY sl DESC;
-- 1.4 Set address attribute of student table to NOT NULL ➔ Can't insert.
insert into student_shortinfos values ('20204941','Thế Anh','Phan','M','2002/02/01','20162101');
-- 1.5 Please change dob of a student 
-- this infos is also updated in student_shortinfos view
update student set dob = '1987/02/01' where dob = '1987/03/18'; 
select * from student_shortinfos
-- 1.6 insert a new record into student table 
-- can see the new student on student_shortinfos view
insert into student values ('20204941','Thế Anh','Phan','2002/02/01','M','Nam Định',null,'20162101');
select * from student_shortinfos;
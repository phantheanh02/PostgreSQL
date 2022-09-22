-- create a view 
create view  student_class_shortinfos as
select  student_id, first_name, last_name, gender, name
from student, clazz;
-- Can't insert/update/delete a record
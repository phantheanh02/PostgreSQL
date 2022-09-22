-- create a view
create view  class_infos as
select c.clazz_id, name, count(student_id)  as number_student
from  student s 
right join clazz c on c.clazz_id = s.clazz_id
GROUP BY c.clazz_id;
-- 3.1 display all records from this view
select * from class_infos
-- 3.2 Try to insert/update/delete a record into/from class_infos
insert into class_infos values ('20162102','CNTT1.01-K61');
-- can't insert
update class_infos set clazz_id = '20162103' where clazz_id = '20162102';
-- can't update
delete from class_infos where clazz_id = '20162102';
-- can't delete

-- trigger 
OLD: clazz_id ='20204941', name ='ABC' 
NEW: clazz_id = '20204941', name ='ABC' 
CREATE TRIGGER tg_instead_of_trigger
INSTEAD OF UPDATE ON class_infos			-- Thay cho hàm update
FOR EACH ROW								-- Cho mỗi bản ghi
EXECUTE FUNCTION fc_tg_instead_of_trigger()	-- Tên function
RETURN TRIGGER AS
$$
BEGIN
	UPDATE clazz 
	SET clazz_id = NEW.clazz_id, 
		name = NEW.name
	WHERE class_id = OLD.clazz_id
END
$$ LANGUAGE pgplsql
--Ví dụ
	create or replace view student_class_shortinfos 
	AS
	select student_id, last_name, first_name, gender, dob, name
	from student s left join clazz c on
	s.clazz_id = c.clazz_id;

	CREATE TRIGGER insert_student_view
	INSTEAD OF INSERT ON student_class_shortinfos
	FOR EACH ROW
	EXECUTE PROCEDURE
	insert_view_student_class_shortinfos();

	CREATE OR REPLACE FUNCTION
	insert_view_student_class_shortinfos() RETURNS
	trigger AS
	$$
	BEGIN
-- insert student
	insert into student (student_id, last_name,
	first_name , gender, dob) values (NEW.student_id,
	NEW.last_name, NEW.first_name, NEW.gender, NEW.dob);
	RETURN NEW;
	END;
	$$ LANGUAGE plpgsql ;
------------------------------------------------------
-- Bài tập 2
-- define a trigger function
	CREATE OR REPLACE FUNCTION tf_af_insert() RETURNS TRIGGER AS 
	$$
	BEGIN
	update clazz
	set number_students = number_students+1
	where clazz_id = NEW.clazz_id;
	RETURN NEW;
	END;
	$$ 
	LANGUAGE plpgsql;
-- define a trigger
	CREATE TRIGGER af_insert
	AFTER INSERT ON student
	FOR EACH ROW
	WHEN (NEW.clazz_id IS NOT NULL)
	EXECUTE PROCEDURE tf_af_insert();
--------------------------------------------------------
-- Exercise
-- when delete  a student
	CREATE TRIGGER af_delete
	AFTER DELETE ON student
	FOR EACH ROW
	WHEN (OLD.clazz_id IS NOT NULL)
	EXECUTE PROCEDURE tf_af_delete();
-- define a trigger function
	CREATE OR REPLACE FUNCTION tf_af_delete() RETURNS TRIGGER AS 
	$$
	BEGIN
	update clazz
	set number_students = number_students - 1
	where clazz_id = OLD.clazz_id;
	RETURN NEW;
	END;
	$$ 
	LANGUAGE plpgsql;
-- Test 
	select * from clazz;
	select * from student;
	insert into student values ('20204942', 'Anh', 'Phan', '2002-02-01', 'M', 'Hai Bà Trưng', null, '20172201');
	delete from student where student_id = '20204942';
	
-- change student class
	-- create function trigger
	CREATE OR REPLACE FUNCTION tf_af_change() RETURNS TRIGGER AS
	$$
	BEGIN
	UPDATE clazz set number_students = number_students - 1
		WHERE clazz_id = OLD.clazz_id;
	UPDATE clazz set number_students = number_students + 1
		WHERE clazz_id = NEW.clazz_id;
	RETURN NEW;
	END;
	$$
	LANGUAGE plpgsql;
	-- create trigger
	CREATE TRIGGER af_change_student
	AFTER UPDATE ON student
	FOR EACH ROW
	WHEN (OLD.clazz_id IS NOT NULL)
	EXECUTE PROCEDURE tf_af_change();
	-- test
	select * from clazz;
	select * from student;
	update student set clazz_id = '20172202' where student_id = '20160002';
	
-- b) Kiểm tra mỗi lớp không vượt quá 200 sinh viên
	-- Create function
	CREATE OR REPLACE FUNCTION tf_bf_check() RETURNS TRIGGER AS
	$$ 
	BEGIN
		IF (select number_students from clazz where clazz_id = NEW.clazz_id) < 200 THEN 
			UPDATE clazz set number_students = number_students + 1
				WHERE clazz_id = NEW.clazz_id;
		ELSE
			RAISE NOTICE 'Class full!!';
		END IF;
	RETURN NEW;
	END;
	$$
	LANGUAGE plpgsql;
	-- create triger
	drop trigger bf_check_insert on student;
	CREATE TRIGGER bf_check_insert
	BEFORE INSERT ON student
	FOR EACH ROW
	WHEN (NEW.clazz_id IS NOT NULL)
	EXECUTE PROCEDURE tf_bf_check();
	-- test
	select * from clazz;
	select * from student;
	update clazz set number_students = 0 where clazz_id = '20162102';
 	insert into student values ('20204949', 'Anh', 'Phan', '2002-02-01', 'M', 'Hai Bà Trưng', null, '20162102');
	delete from student where clazz_id = '20162102'


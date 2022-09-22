-- Calculates the number of students in this class.
-- Cách 1: Input = null --> output null
CREATE OR REPLACE FUNCTION number_of_students(IN clazz_id_var character, OUT result1 int4) AS
$$
BEGIN
	SELECT INTO result1
	count(*)
	from student 
	where  clazz_id = clazz_id_var;
END;
$$
LANGUAGE plpgsql;
select number_of_students('20162101');
-- Cách 2: input = null --> số học sinh không được gán vào lớp
CREATE OR REPLACE FUNCTION number_of_students(IN clazz_id_var character, OUT result1 int4) AS
$$
BEGIN
	IF clazz_id_var is null THEN
		SELECT INTO result1
		count(*)
		from student 
		where  clazz_id is null;
	ELSE
		SELECT INTO result1
		count(*)
		from student 
		where  clazz_id = clazz_id_var;
	END IF;
END;
$$	
LANGUAGE plpgsql;
--- Cách 3: sử dụng return
CREATE OR REPLACE FUNCTION number_of_students(IN clazz_id_var char(8)) RETURNS integer AS
$$
DECLARE result1 integer := 0;
BEGIN
	IF clazz_id_var is null THEN
		SELECT INTO result1
		count(*)
		from student 
		where  clazz_id is null;
	ELSE
		SELECT INTO result1
		count(*)
		from student 
		where  clazz_id = clazz_id_var;
	END IF;
	RETURN result1;
END;
$$	
LANGUAGE plpgsql
SECURITY INVOKER;
GRANT EXECUTE ON student TO joe;
REVOKE SELECT ON student FROM joe;

-- Câu 2
-- Cách 1   
CREATE OR REPLACE FUNCTION update_number_students() RETURNS int AS
$$
DECLARE v_clazz_id char(8);
BEGIN
	FOR v_clazz_id IN select clazz_id from clazz 
	LOOP
	update clazz set number_students = number_of_students(v_clazz_id)
	where clazz_id = v_clazz_id;
	END LOOP;
END;
$$
LANGUAGE plpgsql;

-- Cách 2
CREATE OR REPLACE FUNCTION update_number_students() RETURNS int AS
$$
BEGIN
	update clazz set number_students = number_of_students(clazz_id);
	RETURN 1;
END;
$$
LANGUAGE plpgsql;

-- Câu 3
-- Create a new table to store GPA, CPA of student in each semester
CREATE TABLE public.student_results
(
    student_id character(8) NOT NULL,
    semester character(5) NOT NULL,
    "GPA" real,
    "CPA" real,
    PRIMARY KEY (student_id, semester),
    CONSTRAINT fk_student_results_2_student FOREIGN KEY (student_id)
        REFERENCES public.student (student_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);
-- insert datas from semester to student_results
insert into student_results (student_id, semester) 
select DISTINCT  student_id, semester
from   enrollment ;

-- function updateGPA_student
CREATE OR REPLACE FUNCTION updateGPA_student(IN v_studentid char(8), v_semester char(5)) RETURNS int AS
$$
BEGIN
	update student_results set "GPA" = 
	(
	select 	(sum(e.midterm_score * (1 - sj.percentage_final_exam*0.01) +  e.final_score * sj.percentage_final_exam/100) / count(e.student_id)) * 0.4
	from  enrollment e 
	join subject sj on sj.subject_id = e.subject_id
	where e.semester = v_semester
	and e.student_id = v_studentid
	GROUP BY e.student_id
	) where semester = v_semester and student_id = v_studentid;
	RETURN 1;
END;
$$
LANGUAGE plpgsql;

-- create FUNCTION updateGPA
CREATE OR REPLACE FUNCTION updateGPA(IN v_semester char(5)) RETURNS int AS
$$
BEGIN
	update student_results set "GPA" =
	(
		select 	(sum(e.midterm_score * (1 - sj.percentage_final_exam*0.01) +  e.final_score * sj.percentage_final_exam/100) / count(e.student_id)) * 0.4
		from  enrollment e
		join subject sj on sj.subject_id = e.subject_id
		where e.semester = v_semester
		and e.student_id = student_results.student_id
		GROUP BY e.student_id
	) where semester = v_semester;
	RETURN 1;
END;
$$
LANGUAGE plpgsql;

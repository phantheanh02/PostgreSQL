
-- 1 List of subjects having 5 or more credits.
    select DISTINCT name from subject where credit > 5;

-- 2. List of students in the class named "CNTT 2 K58".
    select DISTINCT student.* from student , clazz 
        where upper(clazz.name) = 'CNTT 2 K58' and clazz.clazz_id = student.clazz_id ;

-- 3. List of students in classes whose name contains "CNTT"
    select DISTINCT student.* from student, clazz 
        where  clazz.name ilike '%CNTT%' and clazz.clazz_id = student.clazz_id ;
    
-- 4. Display a list of students who have enrolled in both "Lập trình Java" (Java Programming) and "Lập trình nhúng" (Embedded Programming).
    -- Cách 1
    select  student.*
	from student
    inner join enrollment
    on enrollment.student_id = student.student_id
    inner join subject
    on subject.subject_id = enrollment.subject_id
    where subject.name = 'Cơ sở dữ liệu' 
intersect
    select  student.*
	from student
    inner join enrollment
    on enrollment.student_id = student.student_id
    inner join subject
    on subject.subject_id = enrollment.subject_id
    where subject.name = 'Tin học đại cương'
    
    -- Cách 2
    select  s.*
	from student s
    inner join enrollment e
    on e.student_id = s.student_id
    inner join subject sj
    on sj.subject_id = e.subject_id
    where sj.name = 'Tin học đại cương' 
    and s.student_id IN 
    ( select  e2.student_ID
        from enrollment e2 
	 	join subject sj2
	 	on e2.subject_id = sj2.subject_id
	 	where sj2.name ='Mạng máy tính'
     );

     -- Cách 3
     select  s.*
	from student s
    inner join enrollment e
    on e.student_id = s.student_id
    inner join subject sj
    on sj.subject_id = e.subject_id
    where sj.name = 'Tin học đại cương' 
	and exists (select *
		from enrollment e2 
	 	join subject sj2
	 	on (e2.subject_id = sj2.subject_id)
	 	where sj2.name ='Mạng máy tính' 
		and e2.student_id = s.student_id
	);
-- 5. Display a list of students who have enrolled in "Lập trình Java" (Java Programming) or "Lập trình hướng đối tượng" (Object-oriented Programming).
    -- Cách 1
    select  DISTINCT student.* 
    from student
    inner join enrollment
    on enrollment.student_id = student.student_id
    inner join subject
    on subject.subject_id = enrollment.subject_id
    where subject.name = 'Lập trình Java' 
    or subject.name = 'Lập trình nhúng';

    -- Cách 2
    select  DISTINCT student.first_name , student.last_name 
	from student , subject, enrollment
	where student.student_id = enrollment.student_id
	and subject.subject_id = enrollment.subject_id 
	and subject.name = 'Cơ sở dữ liệu' 
   	or subject.name = 'Tin học đại cương';

    -- Cách 3
    select  student.*
	from student
    inner join enrollment
    on enrollment.student_id = student.student_id
    inner join subject
    on subject.subject_id = enrollment.subject_id
    where subject.name = 'Cơ sở dữ liệu' 
union
    select  student.*
	from student
    inner join enrollment
    on enrollment.student_id = student.student_id
    inner join subject
    on subject.subject_id = enrollment.subject_id
    where subject.name = 'Tin học đại cương'
-- 6. Display subjects that have never been registered by any students
    -- Cách 1
    SELECT name
    FROM subject 
    WHERE NOT EXISTS (
        SELECT *
        FROM enrollment
        WHERE subject.subject_id = enrollment.subject_id
    );

    -- Cách 2
    select subject.name, subject_id from subjects
    EXCEPT
    select subject.name, subject_id from enrollment join subjects using (subject_id);

-- 7. List of subjects (subject name and credit number corresponding) that student "Nguyễn Hoài An" have enrolled in the semester '20171'.
    select  subject.name, subject.credit 
   	FROM subject
	inner join student
	on student.last_name = 'Bùi' 
	and student.first_name = 'Ngọc An'
	inner join enrollment
	on semester = '20171' 
	and student.student_id = enrollment.student_id 
	and subject.subject_id = enrollment.subject_id

-- 8. Show the list of students who enrolled in 'Cơ sở dữ liệu' in semesters = '20172'). This list contains student id, student name, midterm score, final exam score and subject score.
    select  s.student_id, s.last_name||' '|| s.first_name as name, e.midterm_score, e.final_score, 
	        e.midterm_score*(1 - sj.percentage_final_exam*0.01) + e.final_score * sj.percentage_final_exam / 100 as subject_score
    from student s
	inner join enrollment e on s.student_id = e.student_id
    inner join subject sj on e.subject_id = sj.subject_id
    where e.semester = '20172'
    and sj.name = 'Cơ sở dữ liệu'
    order by subject_score DESC;
-- 9. Display IDs of students who failed the subject with code 'IT1110' in semester '20171'. 
    select s.student_id
    from student s
	join enrollment e on s.student_id = e.student_id
    join subject sj on e.subject_id = sj.subject_id
    where e.semester = '20171'
    and sj.subject_id = 'IT1110'
    and ( 
        e.midterm_score*(1 - sj.percentage_final_exam*0.01) + e.final_score * sj.percentage_final_exam < 4
        or e.midterm_score < 3 
        or e.final_score < 3);
-- 10. List of all students with their class name, monitor name
    select DISTINCT s1.student_id, s1.last_name||' '|| s1.first_name as student_name , c.name as Class, 
				s2.last_name||' '|| s2.first_name as monitor_name
    from student s1 
	left join clazz c on s1.clazz_id = c.clazz_id
	left join  student s2 on s2.student_id = c.monitor_id ;

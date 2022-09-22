-- 11. Students aged 25 and above. Given information: student name, age
    -- Cách 1
 SELECT s.last_name||' '|| s.first_name as name,
 		DATE_PART('year', CURRENT_TIMESTAMP::date) - DATE_PART('year', dob::date) as Age
 from student s
 where DATE_PART('year', CURRENT_TIMESTAMP::date) - DATE_PART('year', dob::date) > 25
    -- Cách 2
SELECT s.last_name||' '|| s.first_name as name,
 		DATE_PART('year',age(current_date , dob)) as Age
 from student s
 where  DATE_PART('year',age(current_date , dob))  > 25;
    -- Cách 3
SELECT concat(s.last_name,' ',s.first_name) as name,
 		extract('year' from age(current_date , dob)) as Age
 from student s
 where extract('year' from age(current_date , dob))> 25;
-- 12. Students were born in June 1999.
    -- Cách 1
select s.last_name||' '|| s.first_name as name
from student s
where date_part('month',dob) = 6
and date_part('year',  dob) = 1987;
    -- Cách 2
select s.last_name||' '|| s.first_name as name
from student s
where dob >= '1987/06/01'
and dob <= '1987/06/30'
    -- Cách 3
select s.last_name||' '|| s.first_name as name
from student s
where dob between '1987/06/01' and '1987/06/30'
-- 13. Display class name and number of students corresponding in each class. Sort the result in descending order by the number of students.
    select  name, count(student_id)  as sl
	from student s 
	right join clazz c on c.clazz_id = s.clazz_id
	GROUP BY c.clazz_id
	ORDER BY sl DESC;
-- 14. Display the lowest, highest and average scores on the mid-term test of "Mạng máy tính" in semester '20172'.
    select min(midterm_score), max(midterm_score), avg(midterm_score) 
    from enrollment e
    join subject sj
    on sj.subject_id = e.subject_id
    where sj.name = 'Mạng máy tính'
    and e.semester = '20172';
-- 15. Give number of subjects that each lecturer can teach. List must contain: lecturer id, lecturer's fullname, number of subjects.
    select l.lecturer_id, l.last_name || ' ' || l.first_name as name, count(t.subject_id)
    from lecturer l
    left join teaching t on l.lecturer_id = t.lecturer_id
    group by l.lecturer_id;

-- 16. List of subjects which have at least 2 lecturers in charge.
    select sj.name, count(sj.name)
    from subject sj 
    join teaching t on sj.subject_id = t.subject_id
    GROUP BY sj.subject_id
    HAVING count(sj.name) > 1
-- 17. List of subjects which have less than 2 lecturers in charge.
    select sj.name, count(t.lecturer_id) as so_nguoi_day
    from  teaching t
    right join subject sj on sj.subject_id = t.subject_id
    GROUP BY sj.subject_id
    HAVING count(t.lecturer_id) < 2	
-- 18. List of students who obtained the highest score in subject whose id is 'IT3080', in the semester '20172'.âd
    -- Cách 1
    select 	concat(s.last_name,' ', s.first_name) as name,
            e.midterm_score * (1 - sj.percentage_final_exam*0.01) +  e.final_score * sj.percentage_final_exam/100 as score
    from student s 
    join enrollment e on s.student_id = e.student_id
    join subject sj on sj.subject_id = e.subject_id
    where sj.subject_id = 'IT3080'
    and e.semester = '20172'
    and e.midterm_score * (1 - sj.percentage_final_exam*0.01)  +  e.final_score * sj.percentage_final_exam/100 =
    ( 	select max(e.midterm_score * (1 - sj.percentage_final_exam*0.01)  +  e.final_score * sj.percentage_final_exam/100)
        from enrollment e, subject sj
        where sj.subject_id = e.subject_id
        and  sj.subject_id = 'IT3080'
        and e.semester = '20172'
    )
    -- Cách 2
    with bang_diem as
    (
        select 	concat(s.last_name,' ', s.first_name) as name,
                e.midterm_score * (1 - sj.percentage_final_exam*0.01) +  e.final_score * sj.percentage_final_exam/100 as score
        from student s 
        join enrollment e on s.student_id = e.student_id
        join subject sj on sj.subject_id = e.subject_id
        where sj.subject_id = 'IT3080'
        and e.semester = '20172')
    select   name, score
    from  bang_diem
    where score = (
        select max(score) from bang_diem )

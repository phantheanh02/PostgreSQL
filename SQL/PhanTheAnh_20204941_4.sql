-- create a view
create view best_GPA as
select 	s.student_id, concat(first_name,' ', last_name) as fullname,
		(sum(e.midterm_score * (1 - sj.percentage_final_exam*0.01) +  e.final_score * sj.percentage_final_exam/100) / count(s.student_id)) * 0.4 as GPA
from student s 
join enrollment e on s.student_id = e.student_id
join subject sj on sj.subject_id = e.subject_id
where e.semester = '20172'
GROUP BY s.student_id
HAVING (sum(e.midterm_score * (1 - sj.percentage_final_exam*0.01) +  e.final_score * sj.percentage_final_exam/100) / count(s.student_id)) * 0.4 >= 3.2
ORDER BY GPA DESC;
select * from best_GPA;
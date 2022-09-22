DROP database if exists tinyedu;
create database tinyedu;

\c tinyedu

create table "student" (
"student_id" character(8) NOT NULL, 
"first_name" character varying(30), 
"last_name" character varying(30), 
"dob" date, 
"gender" character varying(10), 
"address" character varying (30), 
"note" character varying (30), 
"class_id" character (8) , 
constraint pk_student primary key ("student_id")
);

create table "class" (
	"class_id" character(8) NOT NULL, 
	"name" character varying(30), 
	"lecturer_id" character(8), 
	"monitor_id" character(8),
	constraint pk_class primary key ("class_id")
);

create table "lecturer" (
	"lecturer_id" character(8) NOT NULL, 
	"first_name" character varying(30), 
	"last_name" character varying(30), 
	"dob" date,
	"gender" character (1), -- F: nữ; M: nam 
	"address" character varying(30), 
	"email" character varying(30), 
	CONSTRAINT pk_lecturer PRIMARY KEY("lecturer_id")
);
alter table "class" 
add constraint fk_class_2_lecturer FOREIGN KEY ("lecturer_id") REFERENCES "lecturer"("lecturer_id");

alter table "class" 
add CONSTRAINT fk_class_2_student FOREIGN KEY ("monitor_id") REFERENCES "student"("student_id");

alter table "student"
add CONSTRAINT fk_student_2_class FOREIGN KEY ("class_id") REFERENCES "class"("class_id");
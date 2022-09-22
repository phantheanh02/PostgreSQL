\c tinyedu
delete from lecturer;
DELETE from student;
delete from class;
insert into "lecturer"  values ('02001','Viet Trung','Tran','1984/02/06','M','147 Linh Dam','trung@gmail.com');
insert into "lecturer"  values ('02002','Tuyet Trinh','Vu','1975/10/01','F',null,'trinhvt@soict.hust.edu.vn');
insert into "lecturer"  values ('02003','Linh','Truong','1976/09/08','F','Ha noi',null);
insert into "lecturer"  values ('02004','Quang Khoai','Than','1982/10/08','M','Ha noi','khoattq@soict.hust.edu.vn');
insert into "lecturer"  values ('02005','Oanh','Nguyen','1978/02/18','F','HBT, HN','oangnt@soict.hust.edu.vn');
insert into "lecturer"  values ('02006','Nhat Quang','Nguyen','1976/04/16','M','HBT,HN','quangnn@soict.hust.edu.vn');
insert into "lecturer"  values ('02007','Hong Phuong','Nguyen','1984/03/12','M','17A Ta Quang Buu,HBT,HN','phuongnh@soict.hust.edu.vn');

insert into "class"     values ('20162101','CNTT1 01-K61','02001',null);
insert into "class"     values ('20162102','CNTT1 02-K61',null,null);
insert into "class"     values ('20172201','CNTT2 01-K62','02002',null);
insert into "class"     values ('20172202','CNTT2 02-K62',null,null);

insert into "student" ("student_id", "first_name" , "last_name", "dob" , "gender" , "address", "class_id")
   values ('20160001','Ngoc An','Bui','1987/03/18','M','15 Luong Dinh Cua','20162101');
insert into "student"  ("student_id", "first_name" , "last_name", "dob" , "gender" , "address", "class_id")
   values ('20160002','Anh','Hoang','1987/05/20','M','514 B8 KTX DHBK','20162101');
insert into "student"  ("student_id", "first_name" , "last_name", "dob" , "gender" , "address", "class_id")
   values ('20160003','Thu Hong','Tran','1987/06/06','F','15 Tran Dai Nghia','20162101');
insert into "student"  ("student_id", "first_name" , "last_name", "dob" , "gender" , "address", "class_id")
   values ('20160004','Minh Anh','Nguyen','1987/05/20','F','513 TT Phuong Mai','20162101');
insert into "student"  ("student_id", "first_name" , "last_name", "dob" , "gender" , "address", "class_id")
   values ('20170001','Nhat Anh','Nguyen','1988/05/15','F','214 B6 KTX DHBK','20172201');

UPDATE class set "monitor_id" = '20160003' WHERE "class_id" = '20162101';
UPDATE class set "monitor_id" = '20170001' WHERE "class_id" = '20172201';


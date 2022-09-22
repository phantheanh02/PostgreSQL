-- 2. Liet ke phong dang thue hien tai
SELECT DISTINCT ON(id_phong)p.*
FROM phong p
	LEFT JOIN phong_thue pt ON (pt.id_phong = p.id_phong)
	LEFT JOIN hop_dong hd ON (pt.id_hopdong = hd.id_hopdong)
WHERE
	hd.id_hopdong IS NOT NULL AND
	(CURRENT_DATE >= ngay_nhan AND CURRENT_DATE <= ngay_tra);
	
-- 4. Liet ke khach cung thong tin trong phong co id A('2022-07-20') vao ngay B(P104)
SELECT kh.*
FROM phong p
	LEFT JOIN phong_thue pt ON (p.id_phong = pt.id_phong)
	LEFT JOIN hop_dong hd ON (hd.id_hopdong = pt.id_hopdong)
	LEFT JOIN khach_hang kh ON (pt.id_khach = kh.id_khach)
WHERE 
	(ngay_nhan <= '2022-07-20' AND ngay_tra >= '2022-07-20') 
	AND p.id_phong = 'P104';
	
-- 6. Tinh doanh thu phong trong thang 7-->!
SELECT SUM(tien_thue_phong) AS doanh_thu_thang7
FROM (SELECT *, ((ngay_tra-ngay_nhan+1)*gia_phong) AS tien_thue_phong
	FROM hop_dong hd
		LEFT JOIN phong_thue pt ON (hd.id_hopdong = pt.id_hopdong)
		LEFT JOIN phong p ON (p.id_phong = pt.id_phong))
	AS thong_tin_thue
WHERE 
	DATE_PART('month', ngay_tao) = 7;
	
-- 7. Liet ke hang hoa da duoc su dung trong ngay hom nay
SELECT DISTINCT ON(id_dichvu) dv.*, so_luong
FROM dich_vu dv 
	LEFT JOIN dichvu_sudung dvsd ON (dv.id_dichvu = dvsd.id_dichvu)
	LEFT JOIN hoa_don hd ON (dvsd.id_hoadon = hd.id_hoadon)
WHERE 
	ngay_tao = CURRENT_DATE AND
	phan_loai = 'Hàng hóa';

-- 10. Dua ra cac dich vu va hang hoa da duoc su dung boi khach hang A
SELECT DISTINCT ON(id_dichvu) ho_ten AS nguoi_su_dung, dv.*
FROM dich_vu dv
	LEFT JOIN dichvu_sudung dvsd ON (dv.id_dichvu = dvsd.id_dichvu)
	LEFT JOIN hoa_don hd ON (dvsd.id_hoadon = hd.id_hoadon)
	LEFT JOIN khach_hang kh ON (hd.id_khach = kh.id_khach)
WHERE
	ho_ten = 'Nguyễn Hải Minh';

-- 12. Dua ra thoi gian dat - tra phong cua khach hang A
SELECT kh.ho_ten, hd.id_hopdong, ngay_tao, ngay_nhan, ngay_tra
FROM khach_hang kh
	LEFT JOIN phong_thue pt ON (kh.id_khach = pt.id_khach)
	LEFT JOIN hop_dong hd ON (pt.id_hopdong = hd.id_hopdong)
WHERE 
	kh.ho_ten = 'Nguyễn Lương Cương'
ORDER BY ngay_tao ASC;
	
-- 13. Dua ra gia ca cac dich vu khach san co
SELECT ten_dv, gia 
FROM dich_vu
WHERE phan_loai = 'Dịch vụ'
ORDER BY gia ASC;

-- 16. Liet ke khach hang nu
SELECT *
FROM khach_hang
WHERE gioi_tinh = 'F';

-- 17. Liet ke khach hang su dung dich vu 'Gọi xe'
SELECT DISTINCT ON (id_khach) kh.*
FROM dich_vu dv
	LEFT JOIN dichvu_sudung dvsd ON (dv.id_dichvu = dvsd.id_dichvu)
	LEFT JOIN hoa_don hd ON (hd.id_hoadon = dvsd.id_hoadon)
	LEFT JOIN khach_hang kh ON (kh.id_khach = hd.id_khach)
WHERE ten_dv = 'Gọi xe';

-- 20. Dua ra tan so su dung dich vu trong thang (tat ca dv)
SELECT dv.*, COUNT(dv.id_dichvu) AS lan_su_dung
FROM dich_vu dv
	LEFT JOIN dichvu_sudung dvsd ON (dv.id_dichvu = dvsd.id_dichvu)
	LEFT JOIN hoa_don hd ON (dvsd.id_hoadon = hd.id_hoadon)
WHERE
	DATE_PART('month', ngay_tao) = 7 AND
	hd.id_hoadon IS NOT NULL AND
	phan_loai = 'Dịch vụ'
GROUP BY dv.id_dichvu
ORDER BY lan_su_dung DESC;


--- Phan Thế Anh - 20204941
-- Câu 1: Liệt kê các phòng trống hiện tại
select phong.id_phong, phong.ten_phong, phong.loai_phong, phong.chat_luong, phong.gia_phong
from phong
left join phong_thue using(id_phong)
join hop_dong using(id_hopdong)
where CURRENT_DATE > ngay_nhan
or ( CURRENT_DATE > ngay_tra 
	and CURRENT_DATE > ngay_nhan
)

-- Câu 3:  Liệt kê các dịch vụ mà khách hàng đã sử dụng
CREATE OR REPLACE FUNCTION dichvu_sudung (var_id_khach char)
RETURNS TABLE(dv varchar) AS $$
    select   dich_vu.ten_dv
	from dich_vu
	join dichvu_sudung using(id_dichvu)
	join hoa_don using(id_hoadon)
	join khach_hang using(id_khach)
	where khach_hang.id_khach = var_id_khach;
$$ LANGUAGE SQL;

-- Câu 5: Liệt kê doanh thu từ dịch vụ theo ngày.


select dich_vu.ten_dv, sum(gia) as Tong_tien
from khach_hang
join hoa_don using(id_khach)
join dichvu_sudung using(id_hoadon)
right join dich_vu using(id_dichvu)
where '2022-07-02' = hoa_don.ngay_tao
GROUP BY dich_vu.ten_dv	

-- Câu 8: 	Liệt kê khách hàng trong tháng 7/2022
select khach_hang.id_khach, khach_hang.ho_ten, khach_hang.ngay_sinh, khach_hang.gioi_tinh, 
		khach_hang.dia_chi, khach_hang.so_cccd, khach_hang.so_dt, khach_hang.phan_loai, ngay_nhan, ngay_tra
from khach_hang
join phong_thue using(id_khach)
join hop_dong using (id_hopdong	) 	
where ngay_nhan >= '2022-07-01'
AND ngay_nhan <= '2022-07-31';

-- Câu 9:	Liệt kê khách hàng chưa sử dụng dịch vụ nào	
select khach_hang.id_khach, khach_hang.ho_ten, khach_hang.ngay_sinh, khach_hang.gioi_tinh, 
		khach_hang.dia_chi, khach_hang.so_cccd, khach_hang.so_dt, khach_hang.phan_loai
from khach_hang
left join hoa_don using(id_khach)
where id_hoadon is null;

-- Câu 11: Tính tổng số tiền khách hàng phải trả 
CREATE OR REPLACE FUNCTION tong_tien(IN var_id_khach char, out result int4) AS
$$ DECLARE so_ngay int4; tien_phong int4;
BEGIN
    result =
	(	select   sum(gia*so_luong)
		from dich_vu
		join dichvu_sudung using(id_dichvu)
		join hoa_don using(id_hoadon)
		join khach_hang using(id_khach)
		where khach_hang.id_khach = var_id_khach
	 )
	 +
	(
		select sum(distinct gia_phong*(ngay_tra - ngay_nhan + 1))
		from khach_hang 
		join hop_dong on khach_hang.id_khach = hop_dong.id_nguoidaidien
		join phong_thue using(id_hopdong)
		join phong using(id_phong)
		where khach_hang.id_khach = var_id_khach
	);

END;
$$
LANGUAGE plpgsql

-- Câu 14.	Đưa ra tổng chi phí hóa đơn dịch vụ
CREATE OR REPLACE FUNCTION tien_dich_vu(IN var_id_khach char, out result int4) AS
$$
BEGIN
    result =
	(	select   sum(gia)
		from dich_vu
		join dichvu_sudung using(id_dichvu)
		join hoa_don using(id_hoadon)
		join khach_hang using(id_khach)
		where khach_hang.id_khach = var_id_khach
	 );
END;
$$
LANGUAGE plpgsql

-- Câu 15.	Đưa ra số lượng khách là nam
select count(id_khach) as Soluong_nam
from khach_hang
where gioi_tinh = 'M';

-- Câu 18.	Đưa ra dịch vụ có số lượng sử dụng nhiều nhất
with dv_sd as
(
	select  dich_vu.id_dichvu, dich_vu.ten_dv, dich_vu.gia, sum(so_luong) as lan_su_dung
	from hoa_don
	join dichvu_sudung using(id_hoadon)
	join dich_vu using (id_dichvu)
	where phan_loai = 'Dịch vụ'
	group by dich_vu.id_dichvu
)
select  dv_sd.id_dichvu, dv_sd.ten_dv, dv_sd.gia, lan_su_dung
from dv_sd
where lan_su_dung = 
(
	select max(lan_su_dung) from dv_sd
)
-- Câu 19.	Đưa ra loại phòng được yêu thích nhất ( nhiều người ở nhất)
with phong_nhieu_nhat as
(
	select phong.id_phong, phong.ten_phong, phong.loai_phong, phong.chat_luong, phong.gia_phong, count(phong.id_phong) as so_nguoi
	from phong_thue
	join phong using(id_phong)
	group by phong.id_phong
)
select *
from phong_nhieu_nhat
where so_nguoi = 
(
	select max(so_nguoi) from phong_nhieu_nhat
)

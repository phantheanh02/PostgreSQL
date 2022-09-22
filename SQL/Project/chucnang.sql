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
	(	select   sum(gia)
		from dich_vu
		join dichvu_sudung using(id_dichvu)
		join hoa_don using(id_hoadon)
		join khach_hang using(id_khach)
		where khach_hang.id_khach = var_id_khach
	 );
	so_ngay =
	(
		select (ngay_tra - ngay_nhan)
		from hop_dong
		join khach_hang on id_nguoidaidien = id_khach
		where id_khach = var_id_khach
	);
	tien_phong = 
	(
		select sum(distinct gia_phong)
		from khach_hang 
		join hop_dong on khach_hang.id_khach = hop_dong.id_nguoidaidien
		join phong_thue using(id_hopdong)
		join phong using(id_phong)
		where khach_hang.id_khach = var_id_khach
	);
	result = result + so_ngay*tien_phong;
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
	select  dich_vu.id_dichvu, dich_vu.ten_dv, dich_vu.gia, count(id_dichvu) as lan_su_dung
	from hoa_don
	join dichvu_sudung using(id_hoadon)
	join dich_vu using (id_dichvu)
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



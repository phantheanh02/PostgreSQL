DROP DATABASE khachsan;
CREATE DATABASE khachsan;
\c khachsan

CREATE TABLE public.khach_hang
(
    id_khach character(6) NOT NULL,
 --   id_daidien character(6) NOT NULL,
    ho_ten character varying(30) NOT NULL,
    ngay_sinh date,
    gioi_tinh character,
    dia_chi character varying(30),
    so_cccd character(12) NOT NULL,
    so_dt character varying(12),
    phan_loai character,
    PRIMARY KEY (id_khach),
    CONSTRAINT kt_gioitinh CHECK (gioi_tinh = 'F' OR gioi_tinh = 'M'),
    CONSTRAINT kt_phanloai CHECK (phan_loai = 'N' OR phan_loai = 'C')
    -- N = nhom - C = ca_nhan
);

CREATE TABLE public.phong
(
    id_phong character(4) NOT NULL,
    ten_phong character varying(30) NOT NULL,
    loai_phong character,
    chat_luong character,
    gia_phong integer NOT NULL,
    CONSTRAINT kt_loaiphong CHECK (loai_phong = '1' OR loai_phong = '2'),
    CONSTRAINT kt_chatluong CHECK (chat_luong = 'C' OR chat_luong = 'T'),
    -- C = chat luong cao
    -- T = chat luong thap
    PRIMARY KEY (id_phong)
);

CREATE TABLE public.hop_dong
(
    id_hopdong character(8) NOT NULL,
    id_nguoidaidien character(6) NOT NULL,
    ngay_tao date NOT NULL,
    ngay_nhan date NOT NULL,
    ngay_tra date NOT NULL,
    PRIMARY KEY (id_hopdong)
);

CREATE TABLE public.dich_vu
(
    id_dichvu character(4) NOT NULL,
    ten_dv character varying(30) NOT NULL,
    phan_loai character varying(30),
    gia integer NOT NULL,
    PRIMARY KEY (id_dichvu)
);

CREATE TABLE public.hoa_don
(
    id_hoadon character(8) NOT NULL,
    id_khach character(6) NOT NULL,
    ngay_tao date NOT NULL,
    CONSTRAINT pk_hoadon PRIMARY KEY (id_hoadon)
);

CREATE TABLE public.phong_thue
(
    id_hopdong character(8) NOT NULL,
    id_phong character(4) NOT NULL,
    id_khach character(6) NOT NULL,
    PRIMARY KEY (id_hopdong, id_phong, id_khach)
);

CREATE TABLE public.dichvu_sudung
(
    id_dichvu character(4) NOT NULL,
    id_hoadon character(8) NOT NULL,
    so_luong integer DEFAULT 1,
    PRIMARY KEY (id_dichvu, id_hoadon)
);

ALTER TABLE hop_dong ADD CONSTRAINT fk_hopdong_khach_hang FOREIGN KEY (id_nguoidaidien) 
	REFERENCES public.khach_hang (id_khach) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
	NOT VALID;
ALTER TABLE hoa_don ADD CONSTRAINT fk_hoadon_khach_hang FOREIGN KEY (id_khach)
	REFERENCES public.khach_hang (id_khach) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
	NOT VALID;
ALTER TABLE phong_thue ADD CONSTRAINT fk_phongthue_hopdong FOREIGN KEY (id_hopdong)
	REFERENCES public.hop_dong (id_hopdong) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
	NOT VALID;
ALTER TABLE phong_thue ADD CONSTRAINT fk_phongthue_phong FOREIGN KEY (id_phong)
	REFERENCES public.phong (id_phong) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
	NOT VALID;
ALTER TABLE dichvu_sudung ADD CONSTRAINT fk_dvsd_dichvu FOREIGN KEY (id_dichvu)
	REFERENCES public.dich_vu (id_dichvu) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
	NOT VALID;
ALTER TABLE dichvu_sudung ADD CONSTRAINT fk_dvsd_hoadon FOREIGN KEY (id_hoadon)
	REFERENCES public.hoa_don (id_hoadon) MATCH SIMPLE
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
	NOT VALID;
ALTER TABLE IF EXISTS public.phong_thue
    	ADD CONSTRAINT fk_phongthue_khachhang FOREIGN KEY (id_khach)
    	REFERENCES public.khach_hang (id_khach) MATCH SIMPLE
    	ON UPDATE NO ACTION
    	ON DELETE NO ACTION
    	NOT VALID;

-- CHEN DU LIEU

-- id, ten, loai, chat luong, gia
INSERT INTO phong
VALUES
('P101', 'Phòng 101', '1', 'C', 300000),
('P102', 'Phòng 102', '1', 'T', 150000),
('P103', 'Phòng 103', '2', 'C', 300000),
('P104', 'Phòng 104', '2', 'T', 250000),
('P201', 'Phòng 201', '1', 'C', 300000),
('P202', 'Phòng 202', '1', 'T', 150000),
('P203', 'Phòng 203', '2', 'C', 400000),
('P204', 'Phòng 204', '2', 'T', 250000),
('P301', 'Phòng 301', '1', 'C', 350000),
('P302', 'Phòng 302', '1', 'C', 350000),
('P303', 'Phòng 303', '2', 'C', 400000),
('P304', 'Phòng 304', '2', 'C', 400000);

-- dich vu: id(4), ten(30), phan_loai(30), gia
INSERT INTO dich_vu
VALUES
('0001','Gọi xe', 'Dịch vụ', 20000),
('0002', 'Giặt quần áo', 'Dịch vụ', 20000),
('0003', 'Bia Hà Nội', 'Đồ uống', 15000),
('0009', 'Bia Sài Gòn', 'Đồ uống', 15000),
('0004', 'Pepsi', 'Đồ uống', 10000),
('0005', 'Cocacola', 'Đồ uống', 10000),
('0006', 'Bàn chải', 'Hàng hóa', 30000),
('0007', 'Khăn mặt', 'Hàng hóa', 20000),
('0008', 'Bữa sáng', 'Dịch vụ', 50000),
('0010', 'Bữa trưa', 'Dịch vụ', 80000),
('0011', 'Bữa tối', 'Dịch vụ', 100000);

-- khách hàng: id_khach(6), ho_ten, ngay_sinh, gioi_tinh(F,M), dia_chi, so_cccd, so_dt, phan_loai(N,C)
INSERT INTO khach_hang
VALUES
('000001', 'Nguyễn Hải Minh', '2000-07-01', 'M', 'Hai Bà Trưng, Hà Nội', '218460218460', '0127386800', 'C'),
('000002', 'Trần Khôi Đàm', '1969-05-31', 'M', '204 Phố Đinh Du Liên', '596361596361', '0939290311', 'C'),
('000003', 'Nguyễn Lương Cương', '1969-07-20', 'M', '204 Phố Đinh Du Liên', '518021518021', '0650594727', 'N'),
('000004', 'Phan Thị Duyên', '1999-03-16', 'F', 'Thanh Xuân, Hà Nội', '537319537319', '0810559345', 'N'),
('000005', 'Trần Bình Minh', '1995-08-17', 'M', 'Hoàn Kiếm, Hà Nội', '012341234445', '0914521456', 'C'),
('000006', 'Lê Đông Sơn', '1990-07-27', 'M', 'Lạc Thủy, Hoà Bình', '129358441234', '0947326819', 'C'),
('000007', 'Nguyễn Khánh Vân', '1988-04-22', 'F', 'Mỹ Đức, Hà Nội', '081234825723', '0993196524', 'C'),
('000008', 'Phan Quỳnh Hoa', '1973-08-14', 'F', 'Thanh Trì, Hà Nội', '001237812934', '0843876021', 'C'),
('000009', 'Nguyễn Thái Thịnh', '1996-09-15', 'M', 'Mễ Trì, Nam Từ Liêm, Hà Nội', '003141244223', '0912383742', 'N'),
('000010', 'Vũ Thị Yến', '1989-05-24', 'F', 'Phúc Thọ, Hà Nội', '000412948123', '0982647214', 'N');

-- hop dong: id_hopdong(8), id_daidien(6), ngay_tao, ngay_nhan, ngay_tra
INSERT INTO hop_dong
VALUES
('2207P001', '000001', '2022-06-30', '2022-07-01', '2022-07-04'),
('2207P002', '000002', '2022-07-15', '2022-07-15', '2022-07-25'),
('2207P003', '000003', '2022-07-19', '2022-07-19', '2022-07-24'),
('2207P004', '000003', '2022-07-01', '2022-07-08', '2022-07-12'),
('2207P005', '000007', '2022-07-13', '2022-07-13', '2022-07-17'),
('2207P010', '000005', '2022-07-27', '2022-07-27', '2022-07-30'),
('2207P012', '000006', '2022-07-20', '2022-07-20', '2022-07-30'),
('2207P013', '000007', '2022-07-22', '2022-07-22', '2022-07-25'),
('2207P014', '000008', '2022-07-23', '2022-07-23', '2022-07-27'),
('2207P015', '000010', '2022-07-26', '2022-07-26', '2022-07-31');

-- phong_thue: id_hopdong(8), id_phong(4), id_khach(6)
INSERT INTO phong_thue
VALUES
('2207P001', 'P101', '000001'),
('2207P002', 'P201', '000002'),
('2207P003', 'P104', '000003'),
('2207P003', 'P104', '000004'),
('2207P004', 'P101', '000003'),
('2207P005', 'P301', '000007'),
('2207P010', 'P301', '000005'),
('2207P012', 'P202', '000006'),
('2207P013', 'P302', '000007'),
('2207P014', 'P101', '000008'),
('2207P015', 'P303', '000009'),
('2207P015', 'P303', '000010');

-- hoa don: id_hoadon(8), id_khach(6), ngay_tao
INSERT INTO hoa_don
VALUES
('2207D001', '000001', '2022-07-02'),
('2207D002', '000001', '2022-07-03'),
('2207D003', '000002', '2022-07-18'),
('2207D004', '000003', '2022-07-20'),
('2207D005', '000004', '2022-07-19'),
('2207D006', '000006', '2022-07-20'),
('2207D007', '000007', '2022-07-24'),
('2207D010', '000005', '2022-07-27'),
('2207D011', '000005', '2022-07-27'),
('2207D012', '000005', '2022-07-28'),
('2207D013', '000009', '2022-07-27'),
('2207D014', '000010', '2022-07-27');

-- dichvu_sudung: id_dichvu(4), id_hoadon(8)
INSERT INTO dichvu_sudung
VALUES
('0001', '2207D001', 1),
('0002', '2207D001', 1),
('0003', '2207D002', 2),
('0005', '2207D002', 1),
('0001', '2207D002', 1),
('0006', '2207D003', 1),
('0007', '2207D003', 1),
('0008', '2207D004', 1),
('0001', '2207D005', 1),
('0006', '2207D006', 1),
('0007', '2207D006', 1),
('0006', '2207D007', 1),
('0007', '2207D007', 1),
('0006', '2207D010', 1),
('0007', '2207D010', 1),
('0009', '2207D011', 3),
('0009', '2207D012', 3),
('0006', '2207D013', 1),
('0007', '2207D013', 1),
('0003', '2207D013', 2),
('0009', '2207D013', 2),
('0005', '2207D013', 2),
('0006', '2207D014', 1),
('0007', '2207D014', 1);
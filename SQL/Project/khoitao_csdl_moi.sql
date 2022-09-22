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
    ten_phong character(4) NOT NULL,
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
    gia integer NOT NULL,
    PRIMARY KEY (id_dichvu)
);

CREATE TABLE public.hoa_don
(
    id_hoadon character(8) NOT NULL,
    id_khach character(6) NOT NULL,
    ngay_tao date NOT NULL,
    noi_su_dung character varying(30),
 --   thanh_toan character NOT NULL,
    CONSTRAINT pk_hoadon PRIMARY KEY (id_hoadon)
 --   CONSTRAINT kt_thanhtoan CHECK (thanh_toan = 'Y' OR thanh_toan = 'N')
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
    so_luong integer NOT NULL,
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


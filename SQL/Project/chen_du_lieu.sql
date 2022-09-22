\c khachsan;

-- id, ten, loai, chat luong, gia
INSERT INTO phong
VALUES
('P101', 'P101', '1', 'C', 300000),
('P102', 'P102', '1', 'T', 150000),
('P103', 'P103', '2', 'C', 500000),
('P104', 'P104', '2', 'T', 250000),
('P201', 'P201', '1', 'C', 300000),
('P202', 'P202', '1', 'T', 150000),
('P203', 'P203', '2', 'C', 500000),
('P204', 'P204', '2', 'T', 250000);

-- dich vu: id(4), ten(30), gia
INSERT INTO dich_vu
VALUES
('0001','Gọi xe', 20000),
('0002', 'Giặt quần áo', 20000),
('0003', 'Bia lon', 15000),
('0004', 'Sting', 10000),
('0005', 'Cocacola', 10000),
('0006', 'Bàn chải', 30000),
('0007', 'Khăn mặt', 20000),
('0008', 'Bữa sáng', 50000);

-- khách hàng: id_khach(6), ho_ten, ngay_sinh, gioi_tinh(F,M), dia_chi, so_cccd, so_dt, phan_loai(N,C)
INSERT INTO khach_hang
VALUES
('000001', 'Nguyễn Hải Minh', '2000-07-01', 'M', 'Hai Bà Trưng, Hà Nội', '218460218460', '
0127386800', 'C'),
('000002', 'Trần Khôi Đàm', '1969-05-31', 'M', '204 Phố Đinh Du Liên', '596361596361', '0939290311', 'C'),
('000003', 'Nguyễn Lương Cương', '1969-07-20', 'M', '204 Phố Đinh Du Liên', '518021518021', '0650594727', 'N'),
('000004', 'Phan Thị Duyên', '1999-03-16', 'F', 'Phố Đới Cương Chi', '537319537319', '0810559345', 'N');

-- hop dong: id_hopdong(8), id_daidien(6), ngay_tao, ngay_nhan, ngay_tra
INSERT INTO hop_dong
VALUES
('2207P001', '000001', '2022-06-30', '2022-07-01', '2022-07-04'),
('2207P002', '000002', '2022-07-15', '2022-07-15', '2022-07-25'),
('2207P003', '000003', '2022-07-19', '2022-07-19', '2022-07-24');

-- phong_thue: id_hopdong(8), id_phong(4), id_khach(6)
INSERT INTO phong_thue
VALUES
('2207P001', 'P101', '000001'),
('2207P002', 'P201', '000002'),
('2207P003', 'P104', '000003'),
('2207P003', 'P104', '000004');

-- hoa don: id_hoadon(8), id_khach(6), ngay_tao, noi_su_dung
INSERT INTO hoa_don
VALUES
('2207D001', '000001', '2022-07-02', NULL),
('2207D002', '000001', '2022-07-03', NULL),
('2207D003', '000002', '2022-07-18', NULL),
('2207D004', '000003', '2022-07-20', NULL),
('2207D005', '000004', '2022-07-19', NULL);

-- dichvu_sudung: id_dichvu(4), id_hoadon(8), so_luong
INSERT INTO dichvu_sudung
VALUES
('0001', '2207D001', 1),
('0002', '2207D001', 1),
('0003', '2207D002', 3),
('0005', '2207D002', 3),
('0001', '2207D002', 1),
('0006', '2207D003', 1),
('0007', '2207D003', 1),
('0008', '2207D004', 1),
('0001', '2207D005', 1);


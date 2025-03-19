-- Ngắt kết nối khỏi cơ sở dữ liệu hiện tại
USE master;
-- Kiểm tra và xóa cơ sở dữ liệu nếu đã tồn tại
DROP DATABASE IF EXISTS QuanLyKho;

-- Tạo cơ sở dữ liệu mới
CREATE DATABASE QuanLyKho;

-- Sử dụng cơ sở dữ liệu vừa tạo
USE QuanLyKho;

-- Kiểm tra và xóa bảng NhaCungCap nếu đã tồn tại
DROP TABLE IF EXISTS NhaCungCap;

-- Tạo bảng NhaCungCap (Nhà cung cấp)
CREATE TABLE NhaCungCap (
    MaNhaCungCap INT IDENTITY(1,1) PRIMARY KEY, -- Mã nhà cung cấp
    TenNhaCungCap VARCHAR(255) NOT NULL,         -- Tên nhà cung cấp
    TenLienHe VARCHAR(255) NOT NULL,             -- Tên người liên hệ
    SoDienThoai VARCHAR(15),                    -- Số điện thoại
    DiaChi TEXT                                  -- Địa chỉ
);

-- Kiểm tra và xóa bảng SanPham nếu đã tồn tại
DROP TABLE IF EXISTS SanPham;

-- Tạo bảng SanPham (Sản phẩm)
CREATE TABLE SanPham (
    MaSanPham INT IDENTITY(1,1) PRIMARY KEY,    -- Mã sản phẩm
    TenSanPham VARCHAR(255) NOT NULL,            -- Tên sản phẩm
    MoTa TEXT,                                   -- Mô tả sản phẩm
    SoLuongTon INT NOT NULL DEFAULT 0,           -- Số lượng trong kho
    Gia DECIMAL(10, 2) NOT NULL,                 -- Giá bán
    MaNhaCungCap INT,                            -- Mã nhà cung cấp (Khóa ngoại)
    FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap(MaNhaCungCap) -- Liên kết với bảng NhaCungCap
);

-- Kiểm tra và xóa bảng KhachHang nếu đã tồn tại
DROP TABLE IF EXISTS KhachHang;

-- Tạo bảng KhachHang (Khách hàng)
CREATE TABLE KhachHang (
    MaKhachHang INT IDENTITY(1,1) PRIMARY KEY,  -- Mã khách hàng
    TenKhachHang VARCHAR(255) NOT NULL,          -- Tên khách hàng
    TenLienHe VARCHAR(255),                      -- Tên người liên hệ
    SoDienThoai VARCHAR(15),                     -- Số điện thoại
    DiaChi TEXT                                   -- Địa chỉ
);

-- Kiểm tra và xóa bảng DonHang nếu đã tồn tại
DROP TABLE IF EXISTS DonHang;

-- Tạo bảng DonHang (Đơn hàng)
CREATE TABLE DonHang (
    MaDonHang INT IDENTITY(1,1) PRIMARY KEY,    -- Mã đơn hàng
    MaKhachHang INT,                             -- Mã khách hàng (Khóa ngoại)
    NgayDatHang DATE NOT NULL,                   -- Ngày đặt hàng
    TongTien DECIMAL(10, 2),                     -- Tổng tiền
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang) -- Liên kết với bảng KhachHang
);

-- Kiểm tra và xóa bảng ChiTietDonHang nếu đã tồn tại
DROP TABLE IF EXISTS ChiTietDonHang;

-- Tạo bảng ChiTietDonHang (Chi tiết đơn hàng)
CREATE TABLE ChiTietDonHang (
    MaChiTietDonHang INT IDENTITY(1,1) PRIMARY KEY, -- Mã chi tiết đơn hàng
    MaDonHang INT,                                   -- Mã đơn hàng (Khóa ngoại)
    MaSanPham INT,                                   -- Mã sản phẩm (Khóa ngoại)
    SoLuong INT NOT NULL,                            -- Số lượng
    GiaUnit DECIMAL(10, 2),                          -- Giá mỗi sản phẩm
    FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang), -- Liên kết với bảng DonHang
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham)  -- Liên kết với bảng SanPham
);

-- Kiểm tra và xóa bảng GiaoDichKho nếu đã tồn tại
DROP TABLE IF EXISTS GiaoDichKho;

-- Tạo bảng GiaoDichKho (Giao dịch kho)
CREATE TABLE GiaoDichKho (
    MaGiaoDich INT IDENTITY(1,1) PRIMARY KEY,     -- Mã giao dịch
    MaSanPham INT,                                 -- Mã sản phẩm (Khóa ngoại)
    NgayGiaoDich DATE NOT NULL,                    -- Ngày giao dịch
    SoLuong INT NOT NULL,                          -- Số lượng thay đổi
    LoaiGiaoDich VARCHAR(50),                      -- Loại giao dịch ("in" cho nhập kho, "out" cho xuất kho)
    MaDonHang INT,                                 -- Mã đơn hàng (nếu có)
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham), -- Liên kết với bảng SanPham
    FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang)  -- Liên kết với bảng DonHang
);

INSERT INTO NhaCungCap (TenNhaCungCap, TenLienHe, SoDienThoai, DiaChi)
VALUES
('Nha Cung Cấp 1', 'Nguyen Thi A', '0123456789', '123 Đường ABC, TP HCM'),
('Nha Cung Cấp 2', 'Tran Thi B', '0123456790', '456 Đường DEF, TP HCM'),
('Nha Cung Cấp 3', 'Le Thi C', '0123456791', '789 Đường GHI, TP HCM'),
('Nha Cung Cấp 4', 'Pham Thi D', '0123456792', '101 Đường JKL, TP HCM'),
('Nha Cung Cấp 5', 'Hoang Thi E', '0123456793', '202 Đường MNO, TP HCM'),
('Nha Cung Cấp 6', 'Nguyen Thi F', '0123456794', '303 Đường PQR, TP HCM'),
('Nha Cung Cấp 7', 'Tran Thi G', '0123456795', '404 Đường STU, TP HCM'),
('Nha Cung Cấp 8', 'Le Thi H', '0123456796', '505 Đường VWX, TP HCM'),
('Nha Cung Cấp 9', 'Pham Thi I', '0123456797', '606 Đường YZA, TP HCM'),
('Nha Cung Cấp 10', 'Hoang Thi J', '0123456798', '707 Đường BCD, TP HCM'),
('Nha Cung Cấp 11', 'Nguyen Thi K', '0123456799', '808 Đường EFG, TP HCM'),
('Nha Cung Cấp 12', 'Tran Thi L', '0123456800', '909 Đường HIJ, TP HCM'),
('Nha Cung Cấp 13', 'Le Thi M', '0123456801', '1010 Đường KLM, TP HCM'),
('Nha Cung Cấp 14', 'Pham Thi N', '0123456802', '1111 Đường NOP, TP HCM'),
('Nha Cung Cấp 15', 'Hoang Thi O', '0123456803', '1212 Đường QRS, TP HCM');



INSERT INTO SanPham (TenSanPham, MoTa, SoLuongTon, Gia, MaNhaCungCap)
VALUES
('Sản phẩm 1', 'Mô tả sản phẩm 1', 100, 50000, 1),
('Sản phẩm 2', 'Mô tả sản phẩm 2', 150, 70000, 2),
('Sản phẩm 3', 'Mô tả sản phẩm 3', 200, 60000, 3),
('Sản phẩm 4', 'Mô tả sản phẩm 4', 120, 75000, 4),
('Sản phẩm 5', 'Mô tả sản phẩm 5', 80, 45000, 5),
('Sản phẩm 6', 'Mô tả sản phẩm 6', 300, 85000, 6),
('Sản phẩm 7', 'Mô tả sản phẩm 7', 90, 55000, 7),
('Sản phẩm 8', 'Mô tả sản phẩm 8', 110, 62000, 8),
('Sản phẩm 9', 'Mô tả sản phẩm 9', 130, 70000, 9),
('Sản phẩm 10', 'Mô tả sản phẩm 10', 140, 77000, 10),
('Sản phẩm 11', 'Mô tả sản phẩm 11', 160, 82000, 11),
('Sản phẩm 12', 'Mô tả sản phẩm 12', 210, 95000, 12),
('Sản phẩm 13', 'Mô tả sản phẩm 13', 190, 67000, 13),
('Sản phẩm 14', 'Mô tả sản phẩm 14', 250, 89000, 14),
('Sản phẩm 15', 'Mô tả sản phẩm 15', 170, 64000, 15);



INSERT INTO KhachHang (TenKhachHang, TenLienHe, SoDienThoai, DiaChi)
VALUES
('Khách hàng 1', 'Nguyen Thi A', '0123456789', '123 Đường ABC, TP HN'),
('Khách hàng 2', 'Tran Thi B', '0123456790', '456 Đường DEF, TP HN'),
('Khách hàng 3', 'Le Thi C', '0123456791', '789 Đường GHI, TP HN'),
('Khách hàng 4', 'Pham Thi D', '0123456792', '101 Đường JKL, TP HN'),
('Khách hàng 5', 'Hoang Thi E', '0123456793', '202 Đường MNO, TP HCM'),
('Khách hàng 6', 'Nguyen Thi F', '0123456794', '303 Đường PQR, TP HN'),
('Khách hàng 7', 'Tran Thi G', '0123456795', '404 Đường STU, TP HCM'),
('Khách hàng 8', 'Le Thi H', '0123456796', '505 Đường VWX, TP HCM'),
('Khách hàng 9', 'Pham Thi I', '0123456797', '606 Đường YZA, TP HCM'),
('Khách hàng 10', 'Hoang Thi J', '0123456798', '707 Đường BCD, TP HCM'),
('Khách hàng 11', 'Nguyen Thi K', '0123456799', '808 Đường EFG, TP HCM'),
('Khách hàng 12', 'Tran Thi L', '0123456800', '909 Đường HIJ, TP HCM'),
('Khách hàng 13', 'Le Thi M', '0123456801', '1010 Đường KLM, TP HCM'),
('Khách hàng 14', 'Pham Thi N', '0123456802', '1111 Đường NOP, TP HCM'),
('Khách hàng 15', 'Hoang Thi O', '0123456803', '1212 Đường QRS, TP HCM');



INSERT INTO DonHang (MaKhachHang, NgayDatHang, TongTien)
VALUES
(1, '2025-03-01', 150000),
(2, '2025-03-02', 200000),
(3, '2025-03-03', 250000),
(4, '2025-03-04', 300000),
(5, '2025-03-05', 120000),
(6, '2025-03-06', 180000),
(7, '2025-03-07', 220000),
(8, '2025-03-08', 270000),
(9, '2025-03-09', 310000),
(10, '2025-03-10', 130000),
(11, '2025-03-11', 190000),
(12, '2025-03-12', 230000),
(13, '2025-03-13', 260000),
(14, '2025-03-14', 280000),
(15, '2025-03-15', 150000);



INSERT INTO ChiTietDonHang (MaDonHang, MaSanPham, SoLuong, GiaUnit)
VALUES
(1, 1, 2, 50000),
(2, 2, 3, 70000),
(3, 3, 4, 60000),
(4, 4, 1, 75000),
(5, 5, 2, 45000),
(6, 6, 5, 85000),
(7, 7, 6, 55000),
(8, 8, 3, 62000),
(9, 9, 4, 70000),
(10, 10, 2, 77000),
(11, 11, 6, 82000),
(12, 12, 3, 95000),
(13, 13, 5, 67000),
(14, 14, 4, 89000),
(15, 15, 3, 64000);


INSERT INTO GiaoDichKho (MaSanPham, NgayGiaoDich, SoLuong, LoaiGiaoDich, MaDonHang)
VALUES
(1, '2025-03-01', 10, 'in', 1),
(2, '2025-03-02', 20, 'out', 2),
(3, '2025-03-03', 30, 'in', 3),
(4, '2025-03-04', 15, 'out', 4),
(5, '2025-03-05', 25, 'in', 5),
(6, '2025-03-06', 35, 'out', 6),
(7, '2025-03-07', 40, 'in', 7),
(8, '2025-03-08', 50, 'out', 8),
(9, '2025-03-09', 60, 'in', 9),
(10, '2025-03-10', 45, 'out', 10),
(11, '2025-03-11', 55, 'in', 11),
(12, '2025-03-12', 65, 'out', 12),
(13, '2025-03-13', 70, 'in', 13),
(14, '2025-03-14', 80, 'out', 14),
(15, '2025-03-15', 90, 'in', 15);


-- Hiển thị dữ liệu từ bảng NhaCungCap
SELECT 'NhaCungCap' AS TableName, * FROM NhaCungCap;

-- Hiển thị dữ liệu từ bảng SanPham
SELECT 'SanPham' AS TableName, * FROM SanPham;

-- Hiển thị dữ liệu từ bảng KhachHang
SELECT 'KhachHang' AS TableName, * FROM KhachHang;

-- Hiển thị dữ liệu từ bảng DonHang
SELECT 'DonHang' AS TableName, * FROM DonHang;

-- Hiển thị dữ liệu từ bảng ChiTietDonHang
SELECT 'ChiTietDonHang' AS TableName, * FROM ChiTietDonHang;

-- Hiển thị dữ liệu từ bảng GiaoDichKho
SELECT 'GiaoDichKho' AS TableName, * FROM GiaoDichKho;

--Chương 4 tạo view
--Câu 1 : Hiển thị vDanhSachSanPham - Danh sách tất cả sản phẩm với thông tin nhà cung cấp
CREATE VIEW vDanhSachSanPham AS
SELECT sp.MaSanPham, sp.TenSanPham, sp.MoTa, sp.SoLuongTon, sp.Gia, nc.TenNhaCungCap
FROM SanPham sp
JOIN NhaCungCap nc ON sp.MaNhaCungCap = nc.MaNhaCungCap;

-- Hiển thị kết quả từ view
SELECT * FROM vDanhSachSanPham;

--Câu 2 :Hiển thị vDanhSachDonHang - Danh sách các đơn hàng và thông tin khách hàng
CREATE VIEW vDanhSachDonHang AS
SELECT dh.MaDonHang, dh.NgayDatHang, dh.TongTien, kh.TenKhachHang, kh.SoDienThoai
FROM DonHang dh
JOIN KhachHang kh ON dh.MaKhachHang = kh.MaKhachHang;
-- hien thi ds
SELECT * FROM vDanhSachDonHang;

--Câu 3:Hiển thị vChiTietDonHang - Chi tiết đơn hàng với thông tin sản phẩm
CREATE VIEW vChiTietDonHang AS
SELECT ctdh.MaChiTietDonHang, ctdh.MaDonHang, ctdh.MaSanPham, ctdh.SoLuong, ctdh.GiaUnit, sp.TenSanPham
FROM ChiTietDonHang ctdh
JOIN SanPham sp ON ctdh.MaSanPham = sp.MaSanPham;
--hien thi danh sach
SELECT * FROM vChiTietDonHang;

--Câu 4 :Hiển thị vThongKeSanPhamTonKho - Thống kê số lượng tồn kho của các sản phẩm
CREATE VIEW vThongKeSanPhamTonKho AS
SELECT sp.MaSanPham, sp.TenSanPham, sp.SoLuongTon
FROM SanPham sp
WHERE sp.SoLuongTon > 0;


SELECT * FROM vThongKeSanPhamTonKho;

--Câu 5 : Hiển thị vGiaoDichKho - Thông tin giao dịch kho theo sản phẩm
CREATE VIEW vGiaoDichKho AS
SELECT gd.MaGiaoDich, gd.MaSanPham, gd.NgayGiaoDich, gd.SoLuong, gd.LoaiGiaoDich, sp.TenSanPham
FROM GiaoDichKho gd
JOIN SanPham sp ON gd.MaSanPham = sp.MaSanPham;

SELECT * FROM vGiaoDichKho;

--Câu 6 : Hiển thị vDanhSachKhachHang - Danh sách khách hàng
CREATE VIEW vDanhSachKhachHang AS
SELECT MaKhachHang, TenKhachHang, SoDienThoai, DiaChi
FROM KhachHang;

SELECT * FROM vDanhSachKhachHang;

--Câu 7 :Hiển thị vThongKeDonHangTheoKhachHang - Thống kê đơn hàng theo khách hàng
CREATE VIEW vThongKeDonHangTheoKhachHang AS
SELECT kh.TenKhachHang, COUNT(dh.MaDonHang) AS SoDonHang, SUM(dh.TongTien) AS TongTien
FROM DonHang dh
JOIN KhachHang kh ON dh.MaKhachHang = kh.MaKhachHang
GROUP BY kh.TenKhachHang;

SELECT * FROM vThongKeDonHangTheoKhachHang;

--Câu 8 :Hiển thị vDanhSachSảnPhẩmCònHàng - Danh sách sản phẩm còn hàng
-- Tạo view
CREATE VIEW vDanhSachSảnPhẩmCònHàng AS
SELECT sp.MaSanPham, sp.TenSanPham, sp.SoLuongTon, sp.Gia
FROM SanPham sp
WHERE sp.SoLuongTon > 0;

-- Hiển thị kết quả từ view
SELECT * FROM vDanhSachSảnPhẩmCònHàng;

--Câu 9: Hiển thị vDanhSachDonHangChuaThanhToan - Danh sách đơn hàng chưa thanh toán
CREATE VIEW vDanhSachDonHangChuaThanhToan AS
SELECT dh.MaDonHang, dh.NgayDatHang, dh.TongTien, kh.TenKhachHang
FROM DonHang dh
JOIN KhachHang kh ON dh.MaKhachHang = kh.MaKhachHang
WHERE dh.TongTien > 0;

SELECT * FROM vDanhSachDonHangChuaThanhToan;


--Câu 10 : Hiển thị vDanhSachGiaoDichTheoLoai - Thống kê giao dịch kho theo loại (nhập/xuất)

CREATE VIEW vDanhSachGiaoDichTheoLoai AS
SELECT gd.MaGiaoDich, gd.MaSanPham, gd.NgayGiaoDich, gd.SoLuong, gd.LoaiGiaoDich, sp.TenSanPham
FROM GiaoDichKho gd
JOIN SanPham sp ON gd.MaSanPham = sp.MaSanPham
WHERE gd.LoaiGiaoDich IN ('in', 'out');

SELECT * FROM vDanhSachGiaoDichTheoLoai;


--Chương 5: Xây dựng các procedure

--Câu 1 :  Procedure spThemNhaCungCap - Thêm nhà cung cấp mới
CREATE PROCEDURE spThemNhaCungCap
    @TenNhaCungCap VARCHAR(255),
    @TenLienHe VARCHAR(255),
    @SoDienThoai VARCHAR(15),
    @DiaChi TEXT
AS

BEGIN
    -- Thêm thông tin nhà cung cấp vào bảng NhaCungCap
    INSERT INTO NhaCungCap (TenNhaCungCap, TenLienHe, SoDienThoai, DiaChi)
    VALUES (@TenNhaCungCap, @TenLienHe, @SoDienThoai, @DiaChi);

    -- Hiển thị thông tin nhà cung cấp vừa được thêm
    SELECT * FROM NhaCungCap WHERE TenNhaCungCap = @TenNhaCungCap;
END;

-- Gọi thủ tục để thêm nhà cung cấp
EXEC spThemNhaCungCap
    @TenNhaCungCap = 'Nha Cung Cấp 16',
    @TenLienHe = 'Nguyen Thi P',
    @SoDienThoai = '0123456804',
    @DiaChi = '1313 Đường XYZ, TP HCM';

-- Hiển thị dữ liệu từ bảng NhaCungCap
SELECT 'NhaCungCap' AS TableName, * FROM NhaCungCap;


--Câu 2 : Procedure spCapNhatSanPham - Cập nhật thông tin sản phẩm
CREATE PROCEDURE spCapNhatSanPham
    @MaSanPham INT,
    @TenSanPham VARCHAR(255),
    @MoTa TEXT,
    @SoLuongTon INT,
    @Gia DECIMAL(10, 2)
AS
BEGIN
    -- Cập nhật thông tin sản phẩm trong bảng SanPham
    UPDATE SanPham
    SET TenSanPham = @TenSanPham,
        MoTa = @MoTa,
        SoLuongTon = @SoLuongTon,
        Gia = @Gia
    WHERE MaSanPham = @MaSanPham;

    -- Hiển thị sản phẩm sau khi cập nhật
    SELECT * FROM SanPham WHERE MaSanPham = @MaSanPham;
END;

-- Gọi thủ tục để cập nhật sản phẩm
EXEC spCapNhatSanPham
    @MaSanPham = 1,
    @TenSanPham = 'Sản phẩm cập nhật',
    @MoTa = 'Mô tả cập nhật',
    @SoLuongTon = 150,
    @Gia = 60000;

-- Hiển thị dữ liệu từ bảng SanPham
SELECT 'SanPham' AS TableName, * FROM SanPham;


--Câu 4 :Procedure spThemDonHang - Thêm đơn hàng mới

CREATE PROCEDURE spThemDonHang
    @MaKhachHang INT,
    @NgayDatHang DATE,
    @TongTien DECIMAL(10, 2)
AS
BEGIN
    -- Thêm một đơn hàng mới vào bảng DonHang
    INSERT INTO DonHang (MaKhachHang, NgayDatHang, TongTien)
    VALUES (@MaKhachHang, @NgayDatHang, @TongTien);

    -- Hiển thị đơn hàng vừa được thêm
    SELECT * FROM DonHang WHERE MaKhachHang = @MaKhachHang;
END;

-- Gọi thủ tục để thêm đơn hàng
EXEC spThemDonHang
    @MaKhachHang = 1,
    @NgayDatHang = '2025-03-01',
    @TongTien = 250000;

-- Hiển thị dữ liệu từ bảng DonHang
SELECT 'DonHang' AS TableName, * FROM DonHang;


--Câu 5:Procedure spCapNhatSoLuongSanPham - Cập nhật số lượng tồn của sản phẩm
CREATE PROCEDURE spCapNhatSoLuongSanPham
    @MaSanPham INT,
    @SoLuong INT
AS
BEGIN
    -- Cập nhật số lượng tồn của sản phẩm
    UPDATE SanPham
    SET SoLuongTon = SoLuongTon + @SoLuong
    WHERE MaSanPham = @MaSanPham;

    -- Hiển thị sản phẩm sau khi cập nhật số lượng
    SELECT * FROM SanPham WHERE MaSanPham = @MaSanPham;
END;

-- Gọi thủ tục để cập nhật số lượng tồn
EXEC spCapNhatSoLuongSanPham
    @MaSanPham = 2,
    @SoLuong = 20;

-- Hiển thị dữ liệu từ bảng SanPham
SELECT 'SanPham' AS TableName, * FROM SanPham;


--Câu 6:Procedure spThemChiTietDonHang - Thêm chi tiết sản phẩm vào đơn hàng
CREATE PROCEDURE spThemChiTietDonHang
    @MaDonHang INT,
    @MaSanPham INT,
    @SoLuong INT,
    @GiaUnit DECIMAL(10, 2)
AS
BEGIN
    -- Thêm chi tiết đơn hàng vào bảng ChiTietDonHang
    INSERT INTO ChiTietDonHang (MaDonHang, MaSanPham, SoLuong, GiaUnit)
    VALUES (@MaDonHang, @MaSanPham, @SoLuong, @GiaUnit);

    -- Hiển thị chi tiết đơn hàng sau khi thêm
    SELECT * FROM ChiTietDonHang WHERE MaDonHang = @MaDonHang;
END;


EXEC spThemChiTietDonHang
    @MaDonHang = 1,
    @MaSanPham = 1,
    @SoLuong = 3,
    @GiaUnit = 60000;


SELECT 'ChiTietDonHang' AS TableName, * FROM ChiTietDonHang;


--Câu 7:Procedure spTinhTongTienDonHang - Tính tổng tiền của một đơn hàng
CREATE PROCEDURE spTinhTongTienDonHang
    @MaDonHang INT
AS
BEGIN
    DECLARE @TongTien DECIMAL(10, 2);

    -- Tính tổng tiền của đơn hàng
    SELECT @TongTien = SUM(ctdh.SoLuong * ctdh.GiaUnit)
    FROM ChiTietDonHang ctdh
    WHERE ctdh.MaDonHang = @MaDonHang;

    -- Cập nhật tổng tiền vào bảng DonHang
    UPDATE DonHang
    SET TongTien = @TongTien
    WHERE MaDonHang = @MaDonHang;

    -- Hiển thị tổng tiền của đơn hàng
    SELECT * FROM DonHang WHERE MaDonHang = @MaDonHang;
END;


EXEC spTinhTongTienDonHang @MaDonHang = 1;

--Câu 8:Procedure spThemGiaoDichKho - Thêm giao dịch kho (nhập hoặc xuất kho)
CREATE PROCEDURE spThemGiaoDichKho
    @MaSanPham INT,
    @NgayGiaoDich DATE,
    @SoLuong INT,
    @LoaiGiaoDich VARCHAR(50),
    @MaDonHang INT
AS
BEGIN
    -- Thêm giao dịch kho vào bảng GiaoDichKho
    INSERT INTO GiaoDichKho (MaSanPham, NgayGiaoDich, SoLuong, LoaiGiaoDich, MaDonHang)
    VALUES (@MaSanPham, @NgayGiaoDich, @SoLuong, @LoaiGiaoDich, @MaDonHang);

    -- Hiển thị giao dịch kho sau khi thêm
    SELECT * FROM GiaoDichKho WHERE MaSanPham = @MaSanPham;
END;

-- Gọi thủ tục để thêm giao dịch kho
EXEC spThemGiaoDichKho
    @MaSanPham = 1,
    @NgayGiaoDich = '2025-03-01',
    @SoLuong = 10,
    @LoaiGiaoDich = 'in',
    @MaDonHang = 1;

SELECT 'GiaoDichKho' AS TableName, * FROM GiaoDichKho;


--Câu 9:Procedure spThongKeSanPhamTonKho - Thống kê số lượng tồn kho lớn hơn 0 của sản phẩm
CREATE PROCEDURE spThongKeSanPhamTonKho
AS
BEGIN
    -- Thống kê và hiển thị sản phẩm có số lượng tồn kho lớn hơn 0
    SELECT sp.MaSanPham, sp.TenSanPham, sp.SoLuongTon
    FROM SanPham sp
    WHERE sp.SoLuongTon > 0;
END;


-- Gọi thủ tục để thống kê sản phẩm tồn kho
EXEC spThongKeSanPhamTonKho;

-- Hiển thị dữ liệu từ bảng SanPham
SELECT 'SanPham' AS TableName, * FROM SanPham WHERE SoLuongTon > 0;

--Câu 10 :cập nhật thông tin khách hàng trong bảng KhachHang.
CREATE PROCEDURE spCapNhatThongTinKhachHang
    @MaKhachHang INT,
    @TenKhachHang VARCHAR(255),
    @TenLienHe VARCHAR(255),
    @SoDienThoai VARCHAR(15),
    @DiaChi TEXT
AS
BEGIN
    -- Cập nhật thông tin khách hàng trong bảng KhachHang
    UPDATE KhachHang
    SET TenKhachHang = @TenKhachHang,
        TenLienHe = @TenLienHe,
        SoDienThoai = @SoDienThoai,
        DiaChi = @DiaChi
    WHERE MaKhachHang = @MaKhachHang;

    -- Hiển thị khách hàng sau khi cập nhật
    SELECT * FROM KhachHang WHERE MaKhachHang = @MaKhachHang;
END;

-- Gọi thủ tục để cập nhật thông tin khách hàng
EXEC spCapNhatThongTinKhachHang
    @MaKhachHang = 1,
    @TenKhachHang = 'Nguyen Thi Q',
    @TenLienHe = 'Nguyen Thi P',
    @SoDienThoai = '0123456800',
    @DiaChi = '2222 Đường XYZ, TP HCM';

-- Hiển thị dữ liệu từ bảng KhachHang
SELECT 'KhachHang' AS TableName, * FROM KhachHang WHERE MaKhachHang = 1;






--Chương 6: Xây dựng các trigge







--Câu 1 :Trigger trgThemNhaCungCap - Trigger tự động cập nhật thời gian thêm nhà cung cấp
CREATE TRIGGER trgThemNhaCungCap
ON NhaCungCap
AFTER INSERT
AS
BEGIN
    DECLARE @MaNhaCungCap INT;
    SELECT @MaNhaCungCap = MaNhaCungCap FROM inserted;
    PRINT 'Nha cung cap moi da duoc them voi ma: ' + CAST(@MaNhaCungCap AS VARCHAR);
END;

-- Gọi trigger và hiển thị kết quả
INSERT INTO NhaCungCap (TenNhaCungCap, TenLienHe, SoDienThoai, DiaChi)
VALUES ('Nha Cung Cấp 16', 'Nguyen Thi P', '0123456804', '1313 Đường XYZ, TP HCM');

-- Hiển thị dữ liệu từ bảng NhaCungCap
SELECT 'NhaCungCap' AS TableName, * FROM NhaCungCap;


--Câu 2 :Trigger trgCapNhatSanPham - Trigger tự động ghi log khi cập nhật sản phẩm
CREATE TRIGGER trgCapNhatSanPham
ON SanPham
AFTER UPDATE
AS
BEGIN
    DECLARE @MaSanPham INT;
    DECLARE @TenSanPham VARCHAR(255);
    SELECT @MaSanPham = MaSanPham, @TenSanPham = TenSanPham FROM inserted;
    
    PRINT 'San pham voi ma: ' + CAST(@MaSanPham AS VARCHAR) + ' da duoc cap nhat: ' + @TenSanPham;
END;

-- Gọi trigger và hiển thị kết quả
UPDATE SanPham
SET TenSanPham = 'Sản phẩm cập nhật'
WHERE MaSanPham = 1;

-- Hiển thị dữ liệu từ bảng SanPham
SELECT 'SanPham' AS TableName, * FROM SanPham WHERE MaSanPham = 1;


--Câu 3 :Tự động in thông báo khi thông tin khách hàng trong bảng KhachHang bị cập nhật.
CREATE TRIGGER trgCapNhatKhachHang
ON KhachHang
AFTER UPDATE
AS
BEGIN
    DECLARE @MaKhachHang INT;
    DECLARE @TenKhachHang VARCHAR(255);
    SELECT @MaKhachHang = MaKhachHang, @TenKhachHang = TenKhachHang FROM inserted;

    PRINT 'Thông tin khách hàng với mã: ' + CAST(@MaKhachHang AS VARCHAR) + ' đã được cập nhật: ' + @TenKhachHang;
END;

-- Gọi trigger và hiển thị kết quả
UPDATE KhachHang
SET TenKhachHang = 'Nguyen Thi Q'
WHERE MaKhachHang = 1;

-- Hiển thị dữ liệu từ bảng KhachHang
SELECT 'KhachHang' AS TableName, * FROM KhachHang WHERE MaKhachHang = 1;


--Câu 4:Trigger trgThemDonHang - Trigger tự động cập nhật thời gian tạo đơn hàng
CREATE TRIGGER trgThemDonHang
ON DonHang
AFTER INSERT
AS
BEGIN
    DECLARE @MaDonHang INT;
    DECLARE @NgayDatHang DATE;
    SELECT @MaDonHang = MaDonHang, @NgayDatHang = NgayDatHang FROM inserted;
    
    PRINT 'Đơn hàng với mã: ' + CAST(@MaDonHang AS VARCHAR) + ' đã được tạo vào ngày: ' + CAST(@NgayDatHang AS VARCHAR);
END;

-- Gọi trigger và hiển thị kết quả
INSERT INTO DonHang (MaKhachHang, NgayDatHang, TongTien)
VALUES (1, '2025-03-10', 250000);

-- Hiển thị dữ liệu từ bảng DonHang
SELECT 'DonHang' AS TableName, * FROM DonHang;


--Câu 5 :Trigger trgCapNhatSoLuongSanPham - Trigger tự động kiểm tra khi số lượng sản phẩm về 0
CREATE TRIGGER trgCapNhatSoLuongSanPham
ON SanPham
AFTER UPDATE
AS
BEGIN
    DECLARE @MaSanPham INT;
    DECLARE @SoLuongTon INT;
    SELECT @MaSanPham = MaSanPham, @SoLuongTon = SoLuongTon FROM inserted;

    IF @SoLuongTon = 0
    BEGIN
        PRINT 'San pham voi ma: ' + CAST(@MaSanPham AS VARCHAR) + ' da het hang!';
    END
END;

-- Gọi trigger và hiển thị kết quả
UPDATE SanPham
SET SoLuongTon = 0
WHERE MaSanPham = 1;

-- Hiển thị dữ liệu từ bảng SanPham
SELECT 'SanPham' AS TableName, * FROM SanPham WHERE MaSanPham = 1;


--Câu 6:Trigger trgThemChiTietDonHang - Trigger tự động cập nhật tổng tiền khi thêm chi tiết đơn hàng
CREATE TRIGGER trgThemChiTietDonHang
ON ChiTietDonHang
AFTER INSERT
AS
BEGIN
    DECLARE @MaDonHang INT;
    DECLARE @SoLuong INT;
    DECLARE @GiaUnit DECIMAL(10, 2);
    SELECT @MaDonHang = MaDonHang, @SoLuong = SoLuong, @GiaUnit = GiaUnit FROM inserted;

    DECLARE @TongTien DECIMAL(10, 2);
    SET @TongTien = @SoLuong * @GiaUnit;

    UPDATE DonHang
    SET TongTien = TongTien + @TongTien
    WHERE MaDonHang = @MaDonHang;

    PRINT 'Đon hang voi ma: ' + CAST(@MaDonHang AS VARCHAR) + ' da duoc cap nhat tong tien!';
END;

-- Gọi trigger và hiển thị kết quả
INSERT INTO ChiTietDonHang (MaDonHang, MaSanPham, SoLuong, GiaUnit)
VALUES (1, 1, 2, 50000);

-- Hiển thị dữ liệu từ bảng DonHang
SELECT 'DonHang' AS TableName, * FROM DonHang WHERE MaDonHang = 1;

--Câu 7: Trigger trgCapNhatTongTienDonHang - Trigger tự động cập nhật tổng tiền khi có thay đổi trong chi tiết đơn hàng
CREATE TRIGGER trgCapNhatTongTienDonHang
ON ChiTietDonHang
AFTER UPDATE
AS
BEGIN
    DECLARE @MaDonHang INT;
    DECLARE @SoLuong INT;
    DECLARE @GiaUnit DECIMAL(10, 2);
    SELECT @MaDonHang = MaDonHang, @SoLuong = SoLuong, @GiaUnit = GiaUnit FROM inserted;

    DECLARE @TongTien DECIMAL(10, 2);
    SET @TongTien = @SoLuong * @GiaUnit;

    UPDATE DonHang
    SET TongTien = TongTien + @TongTien
    WHERE MaDonHang = @MaDonHang;

    PRINT 'Don hang voi ma: ' + CAST(@MaDonHang AS VARCHAR) + ' da duoc cap nhat tong tien!';
END;

-- Gọi trigger và hiển thị kết quả
UPDATE ChiTietDonHang
SET SoLuong = 3, GiaUnit = 60000
WHERE MaChiTietDonHang = 1;

-- Hiển thị dữ liệu từ bảng DonHang
SELECT 'DonHang' AS TableName, * FROM DonHang WHERE MaDonHang = 1;


--Câu 8:Trigger trgSoLuongTonKhoThap - Trigger tự động kiểm tra và cảnh báo khi số lượng tồn kho của một sản phẩm dưới mức yêu cầu
CREATE TRIGGER trgSoLuongTonKhoThap
ON SanPham
AFTER UPDATE
AS
BEGIN
    DECLARE @MaSanPham INT;
    DECLARE @SoLuongTon INT;
    SELECT @MaSanPham = MaSanPham, @SoLuongTon = SoLuongTon FROM inserted;

    -- Kiểm tra nếu số lượng tồn kho nhỏ hơn 10
    IF @SoLuongTon < 10
    BEGIN
        PRINT 'Canh bao: San pham voi ma ' + CAST(@MaSanPham AS VARCHAR) + ' co sa luong ton kho thap: ' + CAST(@SoLuongTon AS VARCHAR);
    END
END;

-- Gọi trigger và hiển thị kết quả
UPDATE SanPham
SET SoLuongTon = 5
WHERE MaSanPham = 1;

-- Hiển thị dữ liệu từ bảng SanPham
SELECT 'SanPham' AS TableName, * FROM SanPham WHERE MaSanPham = 1;

--Câu 9:Trigger trgGiaoDichKho - Trigger tự động cập nhật số lượng tồn khi có giao dịch kho
CREATE TRIGGER trgGiaoDichKho
ON GiaoDichKho
AFTER INSERT
AS
BEGIN
    DECLARE @MaSanPham INT;
    DECLARE @SoLuong INT;
    SELECT @MaSanPham = MaSanPham, @SoLuong = SoLuong FROM inserted;

    UPDATE SanPham
    SET SoLuongTon = SoLuongTon - @SoLuong
    WHERE MaSanPham = @MaSanPham;

    PRINT 'San pham voi ma: ' + CAST(@MaSanPham AS VARCHAR) + ' da duoc cap nhat so luong ton sau giao dịch kho';
END;

-- Gọi trigger và hiển thị kết quả
INSERT INTO GiaoDichKho (MaSanPham, NgayGiaoDich, SoLuong, LoaiGiaoDich)
VALUES (1, '2025-03-01', 5, 'out');

-- Hiển thị dữ liệu từ bảng SanPham
SELECT 'SanPham' AS TableName, * FROM SanPham WHERE MaSanPham = 1;


--Câu 10 : Trigger trgCapNhatThongTinKhachHang - Trigger tự động ghi log khi cập nhật thông tin khách hàng

CREATE TRIGGER trgCapNhatThongTinKhachHang
ON KhachHang
AFTER UPDATE
AS
BEGIN
    DECLARE @MaKhachHang INT;
    DECLARE @TenKhachHang VARCHAR(255);
    SELECT @MaKhachHang = MaKhachHang, @TenKhachHang = TenKhachHang FROM inserted;

    PRINT 'Khach hang voi ma: ' + CAST(@MaKhachHang AS VARCHAR) + ' da duoc cap nhat thong tin: ' + @TenKhachHang;
END;

-- Gọi trigger và hiển thị kết quả
UPDATE KhachHang
SET TenKhachHang = 'Nguyen Thi Q'
WHERE MaKhachHang = 1;

-- Hiển thị dữ liệu từ bảng KhachHang
SELECT 'KhachHang' AS TableName, * FROM KhachHang WHERE MaKhachHang = 1;


--Chương 7: Phân quyền và bảo vệ cơ sở dữ liệu

-- Tạo tài khoản với mật khẩu tuân thủ chính sách bảo mật
CREATE LOGIN NhanVienKho WITH PASSWORD = 'Kho@DTT123!';
CREATE LOGIN QuanLy WITH PASSWORD = 'QL@DTT456!';


ALTER LOGIN QuanLy WITH PASSWORD = 'QL@Secure456!';



-- Chọn database đang làm việc
USE QuanLyKho; 

-- Tạo user cho login vừa tạo
CREATE USER NhanVienKho FOR LOGIN NhanVienKho;
CREATE USER QuanLy FOR LOGIN QuanLy;


-- Quản lý có toàn quyền trên database
ALTER ROLE db_owner ADD MEMBER QuanLy;



-- Nhân viên kho chỉ được phép xem và cập nhật dữ liệu kho hàng
GRANT SELECT, UPDATE ON SanPham TO NhanVienKho;
GRANT SELECT, UPDATE ON GiaoDichKho TO NhanVienKho;



-- Ngăn nhân viên kho xóa dữ liệu sản phẩm
DENY DELETE ON SanPham TO NhanVienKho;

-- Ngăn nhân viên kho thay đổi thông tin khách hàng
DENY UPDATE ON KhachHang TO NhanVienKho;


EXEC sp_helprotect NULL, 'NhanVienKho';
EXEC sp_helprotect NULL, 'QuanLy';

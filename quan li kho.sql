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
    TenNhaCungCap NVARCHAR(255) COLLATE Vietnamese_CI_AS NOT NULL,         -- Tên nhà cung cấp
    TenLienHe VARCHAR(255) COLLATE Vietnamese_CI_AS NOT NULL,             -- Tên người liên hệ
    SoDienThoai NVARCHAR(15) COLLATE Vietnamese_CI_AS,                    -- Số điện thoại
    DiaChi TEXT                                  -- Địa chỉ
);

-- Kiểm tra và xóa bảng SanPham nếu đã tồn tại
DROP TABLE IF EXISTS SanPham;

-- Tạo bảng SanPham (Sản phẩm)
CREATE TABLE SanPham (
    MaSanPham INT IDENTITY(1,1) PRIMARY KEY,    -- Mã sản phẩm
    TenSanPham NVARCHAR(255) COLLATE Vietnamese_CI_AS NOT NULL,            -- Tên sản phẩm
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
    TenKhachHang NVARCHAR(255) COLLATE Vietnamese_CI_AS NOT NULL,          -- Tên khách hàng
    TenLienHe NVARCHAR(255) COLLATE Vietnamese_CI_AS,                      -- Tên người liên hệ
    SoDienThoai NVARCHAR(15) COLLATE Vietnamese_CI_AS,                     -- Số điện thoại
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
    LoaiGiaoDich NVARCHAR(50) COLLATE Vietnamese_CI_AS,                      -- Loại giao dịch ("in" cho nhập kho, "out" cho xuất kho)
    MaDonHang INT,                                 -- Mã đơn hàng (nếu có)
    FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham), -- Liên kết với bảng SanPham
    FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang)  -- Liên kết với bảng DonHang
);

ALTER TABLE NhaCungCap ALTER COLUMN TenNhaCungCap NVARCHAR(255) COLLATE Vietnamese_CI_AS;
ALTER TABLE NhaCungCap ALTER COLUMN TenLienHe NVARCHAR(255) COLLATE Vietnamese_CI_AS;
ALTER TABLE NhaCungCap ALTER COLUMN DiaChi NVARCHAR(255) COLLATE Vietnamese_CI_AS;
INSERT INTO NhaCungCap (TenNhaCungCap, TenLienHe, SoDienThoai, DiaChi)
VALUES
(N'Nhà Cung Cấp 1', N'Nguyễn Thị An', '0123456789', N'123 Đường ABC, TP HCM'),
(N'Nhà Cung Cấp 2', N'Trần Thị Bo', '0123456790', N'456 Đường DEF, TP HCM'),
(N'Nhà Cung Cấp 3', N'Lê Thị Ca', '0123456791', N'789 Đường GHI, TP HCM'),
(N'Nhà Cung Cấp 4', N'Phạm Thị Du', '0123456792', N'101 Đường JKL, TP HCM'),
(N'Nhà Cung Cấp 5', N'Hoàng Thị En', '0123456793', N'202 Đường MNO, TP HCM'),
(N'Nhà Cung Cấp 6', N'Nguyễn Thị Chuyên', '0123456794', N'303 Đường PQR, TP HCM'),
(N'Nhà Cung Cấp 7', N'Trần Thị Hằng', '0123456795', N'404 Đường STU, TP HCM'),
(N'Nhà Cung Cấp 8', N'Lê Thị Hiếu', '0123456796', N'505 Đường VWX, TP HCM'),
(N'Nhà Cung Cấp 9', N'Phạm Thị Hoài', '0123456797', N'606 Đường YZA, TP HCM'),
(N'Nhà Cung Cấp 10', N'Hoàng Thị Trang', '0123456798', N'707 Đường BCD, TP HCM'),
(N'Nhà Cung Cấp 11', N'Nguyễn Thị Khánh', '0123456799', N'808 Đường EFG, TP HCM'),
(N'Nhà Cung Cấp 12', N'Trần Thị Linh', '0123456800', N'909 Đường HIJ, TP HCM'),
(N'Nhà Cung Cấp 13', N'Lê Thị Muộn', '0123456801', N'1010 Đường KLM, TP HCM'),
(N'Nhà Cung Cấp 14', N'Phạm Thị Na', '0123456802', N'1111 Đường NOP, TP HCM'),
(N'Nhà Cung Cấp 15', N'Hoàng Thị Phương', '0123456803', N'1212 Đường QRS, TP HCM');



ALTER TABLE SanPham ALTER COLUMN TenSanPham NVARCHAR(255) COLLATE Vietnamese_CI_AS;
ALTER TABLE SanPham ALTER COLUMN MoTa NVARCHAR(255) COLLATE Vietnamese_CI_AS;

INSERT INTO SanPham (TenSanPham, MoTa, SoLuongTon, Gia, MaNhaCungCap)
VALUES
(N'Sản phẩm 1', N'Mô tả sản phẩm 1', 100, 50000, 1),
(N'Sản phẩm 2', N'Mô tả sản phẩm 2', 150, 70000, 2),
(N'Sản phẩm 3', N'Mô tả sản phẩm 3', 200, 60000, 3),
(N'Sản phẩm 4', N'Mô tả sản phẩm 4', 120, 75000, 4),
(N'Sản phẩm 5', N'Mô tả sản phẩm 5', 80, 45000, 5),
(N'Sản phẩm 6', N'Mô tả sản phẩm 6', 300, 85000, 6),
(N'Sản phẩm 7', N'Mô tả sản phẩm 7', 90, 55000, 7),
(N'Sản phẩm 8', N'Mô tả sản phẩm 8', 110, 62000, 8),
(N'Sản phẩm 9', N'Mô tả sản phẩm 9', 130, 70000, 9),
(N'Sản phẩm 10', N'Mô tả sản phẩm 10', 140, 77000, 10),
(N'Sản phẩm 11', N'Mô tả sản phẩm 11', 160, 82000, 11),
(N'Sản phẩm 12', N'Mô tả sản phẩm 12', 210, 95000, 12),
(N'Sản phẩm 13', N'Mô tả sản phẩm 13', 190, 67000, 13),
(N'Sản phẩm 14', N'Mô tả sản phẩm 14', 250, 89000, 14),
(N'Sản phẩm 15', N'Mô tả sản phẩm 15', 170, 64000, 15);

ALTER TABLE KhachHang ALTER COLUMN TenKhachHang NVARCHAR(255) COLLATE Vietnamese_CI_AS;
ALTER TABLE KhachHang ALTER COLUMN TenLienHe NVARCHAR(255) COLLATE Vietnamese_CI_AS;
ALTER TABLE KhachHang ALTER COLUMN DiaChi NVARCHAR(255) COLLATE Vietnamese_CI_AS;

INSERT INTO KhachHang (TenKhachHang, TenLienHe, SoDienThoai, DiaChi)
VALUES
(N'Khách hàng 1', N'Nguyễn Thị Ánh', '0123456789', N'123 Đường ABC, TP HN'),
(N'Khách hàng 2', N'Trần Thị Bình', '0123456790', N'456 Đường DEF, TP HN'),
(N'Khách hàng 3', N'Lê Thị Chi', '0123456791', N'789 Đường GHI, TP HN'),
(N'Khách hàng 4', N'Phạm Thị Dung', '0123456792', N'101 Đường JKL, TP HN'),
(N'Khách hàng 5', N'Hoàng Thị Em', '0123456793', N'202 Đường MNO, TP HCM'),
(N'Khách hàng 6', N'Nguyễn Thị Phương', '0123456794', N'303 Đường PQR, TP HN'),
(N'Khách hàng 7', N'Trần Thị Giang', '0123456795', N'404 Đường STU, TP HCM'),
(N'Khách hàng 8', N'Lê Thị Hạnh', '0123456796', N'505 Đường VWX, TP HCM'),
(N'Khách hàng 9', N'Phạm Thị Ích', '0123456797', N'606 Đường YZA, TP HCM'),
(N'Khách hàng 10', N'Hoàng Thị Duyên', '0123456798', N'707 Đường BCD, TP HCM'),
(N'Khách hàng 11', N'Nguyễn Thị Khánh', '0123456799', N'808 Đường EFG, TP HCM'),
(N'Khách hàng 12', N'Trần Thị Lan', '0123456800', N'909 Đường HIJ, TP HCM'),
(N'Khách hàng 13', N'Lê Thị Minh', '0123456801', N'1010 Đường KLM, TP HCM'),
(N'Khách hàng 14', N'Phạm Thị Ngọc', '0123456802', N'1111 Đường NOP, TP HCM'),
(N'Khách hàng 15', N'Hoàng Thị Oanh', '0123456803', N'1212 Đường QRS, TP HCM');



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
-- neu can xoa produce dung cau lenh nay
DROP PROCEDURE IF EXISTS spThongKeSanPhamTonKho;
--Câu 1 :  Procedure spThemNhaCungCap - Thêm nhà cung cấp mới
CREATE PROCEDURE spThemNhaCungCap
    @TenNhaCungCap NVARCHAR(255),
    @TenLienHe NVARCHAR(255),
    @SoDienThoai NVARCHAR(15),
    @DiaChi NVARCHAR(255)
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
    @TenNhaCungCap = N'Nha Cung Cấp 19',
    @TenLienHe = N'Nguyễn Thị Hạn',
    @SoDienThoai = '0123456804',
    @DiaChi = N'1313 Đường XYZ, TP HCM';

-- Hiển thị dữ liệu từ bảng NhaCungCap
SELECT 'NhaCungCap' AS TableName, * FROM NhaCungCap;

--Câu 2 : Procedure spCapNhatSanPham - Cập nhật thông tin sản phẩm
CREATE PROCEDURE spCapNhatSanPham
    @MaSanPham INT,
    @TenSanPham NVARCHAR(255),
    @MoTa NVARCHAR(255),
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
    @TenSanPham = N'Sản phẩm cập nhật',
    @MoTa = N'Mô tả cập nhật',
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
    @LoaiGiaoDich NVARCHAR(50),
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
    @TenKhachHang NVARCHAR(255) ,
    @TenLienHe NVARCHAR(255) ,
    @SoDienThoai NVARCHAR(15) ,
    @DiaChi NVARCHAR(255)--
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
    @TenKhachHang = N'Vũ Thi Hoa',
    @TenLienHe = N'Nguyễn Thị Hải',
    @SoDienThoai = '0123456800',
    @DiaChi = N'2222 Đường XYZ, TP HCM';

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
VALUES (N'Nha Cung Cấp 16', 'Nguyen Thi P', '0123456804', '1313 Đường XYZ, TP HCM');

-- Hiển thị dữ liệu từ bảng NhaCungCap
SELECT 'NhaCungCap' AS TableName, * FROM NhaCungCap;


--Câu 2 :Trigger trgCapNhatSanPham - Trigger tự động ghi log khi cập nhật sản phẩm
CREATE TRIGGER trgCapNhatSanPham
ON SanPham
AFTER UPDATE
AS
BEGIN
    DECLARE @MaSanPham INT;
    DECLARE @TenSanPham NVARCHARVARCHAR(255) COLLATE Vietnamese_CI_AS;
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
    DECLARE @TenKhachHang NVARCHARVARCHAR(255) COLLATE Vietnamese_CI_AS;
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
    DECLARE @TenKhachHang NVARCHARVARCHAR(255) COLLATE Vietnamese_CI_AS;
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





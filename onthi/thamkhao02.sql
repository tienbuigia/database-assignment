-- 1a:
select tenKH, DiaChi
FROM KhachHang kh
  JOIN MuaHang mh ON mh.MaKH = kh.MaKH
  JOIN Mathang mhh ON mhh.MaMH = mh.MaMH
  JOIN NhomMatHang nmh ON nmh.MaNhomMH = mhh.MaMH
WHERE NgayMua BETWEEN '2015-05-01' AND '2015-05-30'
  AND nmh.TenNhomMH = N'Hàng điện tử';

-- 1b:
SELECT MaMH, count(SoLuong) as SoLuongBan INTO temp
FROM MuaHang mh
GROUP BY MaMH;

SELECT mhh.MaMH, SoLuongBan*DonGia as doanhthu
FROM Mathang mhh
  JOIN temp ON temp.MaMH = mhh.MaMH;

-- 1c:
SELECT MaNhomMH, count(MaMH) as soluongmathang
FROM NhomMatHang nmh
  JOIN Mathang mhh ON mhh.NhomHang = nmh.MaNhomMH
WHERE TenNhomMH = N'Hàng gia dụng'
GROUP BY MaNhomMH;

-- 1d:
SELECT MaKH, MaMH, count(SoLuong) as SoLuongBan INTO temp
FROM MuaHang mh
WHERE NgayMua BETWEEN '2015-01-01' AND '2015-10-25'
GROUP BY MaMH, MaKH;

SELECT TOP 1 mhh.MaKH, SUM(SoLuongBan*DonGia) as doanhthu
FROM Mathang mhh
  JOIN temp ON temp.MaMH = mhh.MaMH;
GROUP BY mhh.MaKH
ORDER BY SUM(SoLuongBan*DonGia) DESC;

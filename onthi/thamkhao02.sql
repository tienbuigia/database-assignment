-- 1a:
select tenKH, DiaChi
FROM KhachHang kh
  JOIN MuaHang mh ON mh.MaKH = kh.MaKH
  JOIN Mathang mhh ON mhh.MaMH = mh.MaMH
  JOIN NhomMatHang nmh ON nmh.MaNhomMH = mhh.MaMH
WHERE NgayMua BETWEEN '2015-05-01' AND '2015-05-30'
  AND nmh.TenNhomMH = N'Hàng điện tử';

-- 2a:
SELECT MaMH, count(SoLuong) as SoLuongBan INTO temp
FROM MuaHang mh
GROUP BY MaMH;

SELECT mhh.MaMH, SoLuongBan*DonGia as doanhthu
FROM Mathang mhh
  JOIN temp ON temp.MaMH = mhh.MaMH;



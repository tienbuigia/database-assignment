-- 1a:
select * from [Chuyen_bay]
join [San_bay] on maSB = SB_di
where ngay_di = '2014-12-6';

--1b:
SELECT * FROM San_bay
  join Chuyen_bay on SB_di = maSB
  or SB_den = maSB
WHERE ngay_di <> '2014-12-6'
  and ngay_den <> '2014-12-6';

--1c:
select kh.maKH, kh.ten, kh.dia_chi, kh.so_dien_thoai, count(cb.*) as so_chuyen_bay
FROM Khach_hang kh 
  join Dat_cho dc on dc.maKH = kh.maKH
  join Chuyen_bay cb on cb.maCB = dc.maCB
WHERE year(ngay_di) between 2011 and 2014
GROUP BY kh.maKH, kh.ten, kh.dia_chi, kh.so_dien_thoai;

--1d:
select maCB, count(maKH) as so_cho_dat
from Dat_cho
group by maCB;


-- cau 2:
-- vì hash index rất nhanh với so sánh bằng (= hoặc <>)
-- vì B+ tree index phù hợp hơn với so sánh, range, order, group, like...
-- mỗi bảng chỉ có một clustering index -> truy cập đĩa ít hơn non-clustering & và chỉ sử dụng B+ tree index
-- primary key là unique nên hash không hỗ trợ => B+ tree
-- a)
-- clustering index -> maSB
-- non-clustering index hash -> ngay_di & SB_di
-- b)
-- clustering index -> maSB
-- non-clustering index hash -> ngay_di & ngay_den & SB_di & SB_den
-- c)
-- clustering index -> maKH & maCB 
-- non-clustering index B+ tree -> ngay_di <- vi tim kiem trong 1 khoang 2011 - 2014
-- d)
-- clustering index -> maCB

-- cau 3:
-- 1. su dung clustering index tren tat ca primary keys cua cac bang.
-- 2. bang Chuyen_bay: hash tren ngay_di, ngay_den, SB_di, SB_den.

cau 4:
--1b:
SELECT * FROM San_bay
  join Chuyen_bay on SB_di = maSB
  or SB_den = maSB
WHERE ngay_di <> '2014-12-6'
  and ngay_den <> '2014-12-6';

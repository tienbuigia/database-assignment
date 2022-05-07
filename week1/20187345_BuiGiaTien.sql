/***** a, truy van co ban *****/
-- #1
SELECT mact, hoten, so AS "Số áo", vitri, ngaysinh, diachi
FROM cauthu;

-- #2
SELECT * FROM CAUTHU
WHERE SO = 7
	AND VITRI = N'Tiền vệ';

-- #3
SELECT tenhlv, ngaysinh, diachi, dienthoai
FROM huanluyenvien;

-- #4
SELECT * FROM cauthu
WHERE maqg = 'VN';

-- #5
SELECT mact, hoten, ngaysinh, diachi
FROM cauthu
WHERE maclb = 'SDN'
	AND maqg = 'BRA';

-- #6
SELECT mact, hoten, ngaysinh
FROM cauthu
	JOIN caulacbo ON cauthu.maclb = caulacbo.maclb
WHERE masan = 'LA';

-- #7
SELECT t.matran, t.ngaytd, s.tensan, a.tenclb AS tenclb1, b.tenclb AS tenclb2, t.ketqua
FROM trandau t
	JOIN sanvd s ON t.masan = s.masan
	JOIN caulacbo a ON t.maclb1 = a.maclb
	JOIN caulacbo b ON t.maclb2 = b.maclb
WHERE t.nam = '2009'
	AND t.vong = '2';
	
-- #8
SELECT hlv_clb.mahlv, tenhlv, ngaysinh, diachi, clb.tenclb
FROM huanluyenvien
	JOIN hlv_clb ON huanluyenvien.mahlv = hlv_clb.mahlv
	JOIN caulacbo clb ON clb.maclb = hlv_clb.maclb
WHERE maqg = 'VN';

-- #9
SELECT TOP(3) clb.tenclb
FROM caulacbo clb
	JOIN bangxh xh ON xh.maclb = clb.maclb
WHERE xh.vong > 3
ORDER BY xh.diem DESC;

-- #10
SELECT h.mahlv, h.tenhlv, h.ngaysinh, h.diachi, hc.vaitro, c.tenclb
FROM hlv_clb hc
	JOIN huanluyenvien h ON h.mahlv = hc.mahlv
	JOIN caulacbo c ON c.maclb = hc.maclb
WHERE c.matinh = 'BD';

/***** b, cac phep toan tren nhom *****/
-- #1
SELECT maclb, COUNT(*) AS so_luong_cauthu
FROM cauthu
GROUP BY maclb;

-- #2 (quoc tich khac VN)
SELECT COUNT(*) AS so_luong_cau_thu_nuoc_ngoai
FROM cauthu
WHERE maqg != 'VN';

-- #3
WITH n_cau_thu_nuoc_ngoai AS (
	SELECT maclb, COUNT(*) AS soluong
	FROM cauthu
	WHERE maqg != 'VN'
	GROUP BY maclb)
SELECT c.maclb, c.tenclb, s.tensan, t.tentinh, n.soluong AS so_ct_nuoc_ngoai
FROM caulacbo c
	JOIN tinh t ON t.matinh = c.matinh
	JOIN n_cau_thu_nuoc_ngoai n ON c.maclb = n.maclb
	JOIN sanvd s ON c.masan = s.masan
WHERE n.soluong > 2;

-- #4
SELECT t.tentinh, COUNT(ct.mact) AS n_tiendao
FROM caulacbo c
	JOIN cauthu ct ON c.maclb = ct.maclb
	JOIN tinh t ON c.matinh = t.matinh
WHERE ct.vitri = N'Tiền đạo'
GROUP BY t.tentinh;

-- #5
SELECT c.tenclb, t.tentinh
FROM caulacbo c
	JOIN tinh t ON c.matinh = t.matinh
	JOIN bangxh xh ON c.maclb = xh.maclb
WHERE xh.vong = 3
	AND xh.nam = 2009
	AND xh.hang = 1;

/***** c, cac toan tu nang cao *****/
-- #1
SELECT tenhlv
FROM huanluyenvien
WHERE dienthoai IS NULL;

-- #2
SELECT tenhlv
FROM huanluyenvien
WHERE mahlv NOT IN (
	SELECT mahlv FROM hlv_clb)
	AND maqg = 'VN';

-- #2.1
SELECT h.tenhlv
FROM huanluyenvien h
	LEFT JOIN hlv_clb hc ON hc.mahlv = h.mahlv
WHERE maclb IS NULL
	AND maqg = 'VN';

-- #3
SELECT DISTINCT(ct.hoten)
FROM cauthu ct
	JOIN caulacbo c ON c.maclb = ct.maclb
	JOIN bangxh xh ON c.maclb = xh.maclb
WHERE xh.hang < 3 OR xh.hang > 6;

-- #4
WITH clb_top1_hetvong3 AS (
	SELECT TOP(1) maclb
	FROM bangxh
	WHERE vong BETWEEN 1 AND 3
	GROUP BY maclb
	ORDER BY SUM(diem) DESC )
SELECT g.ngaytd, s.tensan, a.tenclb AS tenclb1, b.tenclb AS tenclb2, ketqua
FROM trandau g
	JOIN sanvd s ON s.masan = g.masan
	JOIN caulacbo a ON a.maclb = g.maclb1
	JOIN caulacbo b ON b.maclb = g.maclb2
WHERE a.maclb IN (SELECT maclb FROM clb_top1_hetvong3)
	OR b.maclb IN (SELECT maclb FROM clb_top1_hetvong3);
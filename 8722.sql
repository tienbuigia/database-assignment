﻿CREATE DATABASE QLKhachhang_BuiGiaTien;
go
USE QLKhachhang_BuiGiaTien;

CREATE TABLE KHACHHANG (
	MAKH VARCHAR(10) PRIMARY KEY
	,HOTEN NVARCHAR(50)
	,DCHI NVARCHAR(250)
	,SODT VARCHAR(50)
	,NGSINH DATE
);

CREATE TABLE SANPHAM (
	MASP VARCHAR(50) PRIMARY KEY
	,TENSP NVARCHAR(50)
	,DVT NVARCHAR(50)
	,NUOCSX NVARCHAR(50)
	,DONGIA INT
);

CREATE TABLE HOADON (
	SOHD INT PRIMARY KEY
	,NGAYHD DATE
	,MAKH VARCHAR(10) FOREIGN KEY REFERENCES KHACHHANG(MAKH)
);

CREATE TABLE CTHOADON (
	SOHD INT FOREIGN KEY REFERENCES HOADON(SOHD)
	,MASP VARCHAR(50) FOREIGN KEY REFERENCES SANPHAM(MASP)
	,SL INT
);
go

-- nhap du lieu:
INSERT INTO KHACHHANG 
VALUES (
	'HDG.001'
	,N'Đào Duy Thịnh'
	,N'Võ Nguyên Giáp'
	,'0915962468'
	,'1984-11-13'
);

INSERT INTO SANPHAM
VALUES (
	'RUS.BINHNUOC'
	,N'Bình nước'
	,N'Chiếc'
	,N'NGA'
	,80000
);

INSERT INTO HOADON
VALUES (
	81357
	,'2017-5-18'
	,'HDG.001'
);

INSERT INTO CTHOADON
VALUES (
	81357
	,'RUS.BINHNUOC'
	,5
);
GO

-- câu B
--1:
SELECT KHACHHANG.MAKH, HOTEN, DCHI
FROM KHACHHANG JOIN HOADON ON KHACHHANG.MAKH = HOADON.MAKH
WHERE NGAYHD = '2017-05-18';
--2:
SELECT HD.SOHD, NGAYHD, SUM(SL) AS TONGSOLUONGSP, SL * DONGIA AS TONGTIENHD
FROM KHACHHANG KH
	JOIN HOADON HD ON HD.MAKH = KH.MAKH
	JOIN CTHOADON CH ON CH.SOHD = HD.SOHD
	JOIN SANPHAM SP ON SP.MASP = CH.MASP
WHERE DCHI = N'Láng Hạ'
GROUP BY HD.SOHD, NGAYHD, SL * DONGIA;
--3:
SELECT MAKH, HOTEN, DCHI, SODT, TONGSOLUONGSP * DONGIA AS TONGTIEN
FROM (
	SELECT KH.MAKH, HOTEN, DCHI, SODT, SUM(SL) AS TONGSOLUONGSP, SP.MASP, DONGIA
	FROM KHACHHANG KH
		JOIN HOADON HD ON HD.MAKH = KH.MAKH
		JOIN CTHOADON CH ON CH.SOHD = HD.SOHD
		JOIN SANPHAM SP ON SP.MASP = CH.MASP
	WHERE NGAYHD BETWEEN '2017-06-01' AND '2017-12-31'
	GROUP BY KH.MAKH, HOTEN, DCHI, SODT, SP.MASP, DONGIA
	) HOADON
ORDER BY TONGTIEN DESC;
--4:
SELECT SP.*
FROM SANPHAM SP
	JOIN CTHOADON CT ON CT.MASP = SP.MASP
	JOIN HOADON HD ON HD.SOHD = CT.SOHD
WHERE NGAYHD NOT BETWEEN '2017-06-01' AND '2017-12-31';
--5:
SELECT KH.*
FROM KHACHHANG KH
	JOIN HOADON HD ON HD.MAKH = KH.MAKH
	JOIN CTHOADON CH ON CH.SOHD = HD.SOHD
	JOIN SANPHAM SP ON SP.MASP = CH.MASP
WHERE NUOCSX = N'VIỆT NAM';
--6:
--a:
ALTER TABLE SANPHAM ADD CHECK (DONGIA BETWEEN 200 AND 500000);
--b:
ALTER TABLE KHACHHANG
	ADD CHECK (
		GETDATE() >= NGSINH);

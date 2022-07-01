﻿-- A:
CREATE DATABASE TEST;
GO
USE TEST;
GO

CREATE TABLE NHANVIEN (
	MANV VARCHAR(10) PRIMARY KEY NOT NULL,
	HOTENNV NVARCHAR(50) NOT NULL,
	NGAYSINH DATE,
	DIACHI NVARCHAR(255),
	LUONGCB MONEY);
GO

INSERT INTO NHANVIEN (MANV, HOTENNV, NGAYSINH, DIACHI, LUONGCB)
VALUES ('MPC.001', N'Phạm Thanh Bình', '1985-05-13', N'17, Trần Nguyên Hãn', 70000),
		('MPC.002', N'Nguyễn Thành Duy', '1904-05-12', N'253, Nguyễn Thái Học', 45000);
GO

CREATE TABLE PHICO (
	MAPC VARCHAR(10) NOT NULL PRIMARY KEY,
	TENPHICO NVARCHAR(50) NOT NULL,
	KHOANGCACHBAY INT);
GO

INSERT INTO PHICO (MAPC, TENPHICO, KHOANGCACHBAY)
VALUES ('BL750', 'Airbus B320', 5000),
		('QH228', 'Airbus B321', 1660);
GO

CREATE TABLE CHUYENBAY (
	MACB VARCHAR(10) PRIMARY KEY,
	MAPC VARCHAR(10) FOREIGN KEY REFERENCES PHICO(MAPC),
	NoiXP VARCHAR(20) NOT NULL,
	NoiDen VARCHAR(20) NOT NULL,
	GioXP DATETIME NOT NULL,
	GioDen DATETIME NOT NULL);
GO

INSERT INTO CHUYENBAY
VALUES ('CBND.0001', 'BL750', 'HANOI', 'TPHCM', '2019-10-24 07:00:00', '2019-10-24 10:00:00');
GO

CREATE TABLE CHITIET_CHUYENBAY (
	MACB VARCHAR(10) FOREIGN KEY REFERENCES CHUYENBAY(MACB),
	MANV VARCHAR(10) FOREIGN KEY REFERENCES NHANVIEN(MANV));
GO

INSERT INTO CHITIET_CHUYENBAY VALUES ('CBND.0001', 'MPC.001');
GO

/* B */
-- B1:
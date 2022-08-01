
create database ql_sanbay;
go
USE ql_sanbay;
GO
/*drop table san_bay;
go*/
CREATE TABLE san_bay (
	maSB INT PRIMARY KEY IDENTITY(1,1)
	,ten NVARCHAR(50)
	,thanh_pho NVARCHAR(50)
	,quoc_gia NVARCHAR(50)
);

--drop table chuyen_bay;
--go
CREATE TABLE chuyen_bay (
	maCB INT PRIMARY KEY IDENTITY(1,1)
	,SB_di INT FOREIGN KEY REFERENCES san_bay(maSB)
	,gio_di TIME
	,ngay_di DATE
	,SB_den INT FOREIGN KEY REFERENCES san_bay(maSB)
	,gio_den TIME
	,ngay_den DATE
	,so_cho INT
);

/*drop table khach_hang;
go*/
CREATE TABLE khach_hang (
	maKH int PRIMARY KEY IDENTITY(1,1)
	,ten NVARCHAR(50)
	,dia_chi NVARCHAR(250)
	,so_dien_thoai VARCHAR(50)
);

/*DROP table dat_cho;
go*/
create TABLE dat_cho (
	maCB INT FOREIGN KEY REFERENCES chuyen_bay(maCB)
	,maKH INT FOREIGN KEY REFERENCES khach_hang(maKH)
	,thoigian_dat DATETIME
	,CONSTRAINT pk_dat_cho PRIMARY KEY (maCB,maKH)
);
GO

-- them values
INSERT INTO san_bay VALUES ('sb-noibai', 'hanoi', 'vietnam');
INSERT INTO san_bay VALUES ('sb-saigon', 'HCM', 'vietnam');
INSERT INTO san_bay VALUES ('sb-goodboy', 'good', 'nicepeople');
INSERT INTO san_bay VALUES ('sb-goodgirl', 'good', 'nicepeople');
INSERT INTO san_bay VALUES ('sb-dwm', 'rock', 'suckless');
INSERT INTO san_bay VALUES ('sb-dmenu', 'rock', 'suckless');
INSERT INTO san_bay VALUES ('sb-st', 'rock', 'suckless');

insert into chuyen_bay values (1, '05:00:00', '01-01-2022', 2, '07:30:00', '01-01-2022', 150);
insert into chuyen_bay values (2, '05:00:00', '2010-05-06', 1, '07:30:00', '2010-05-06', 150);
insert into chuyen_bay values (3, '05:00:00', '2011-07-08', 4, '07:30:00', '2011-07-08', 150);
insert into chuyen_bay values (5, '05:00:00', '2013-11-11', 6, '07:30:00', '2013-11-11', 150);
insert into chuyen_bay values (6, '05:00:00', '2014-12-06', 4, '07:30:00', '2014-12-06', 150);

insert into khach_hang values ('Nguyen Xuan Phuc', '100 nguyen xien', '0977700123');
insert into khach_hang values ('Nguyen Xuan Dong', '200 nguyen xien', '0977700123');
insert into khach_hang values ('Nguyen Xuan Manh', '100 abc', '0977700123');
insert into khach_hang values ('Ho Ngoc Hai', '99 thanh xuan', '0987123423');
insert into khach_hang values ('Royal Bui', '24/30/153 phu do', '0161231234');

insert into dat_cho values (5, 1, '2014-12-05 21:05:00');
insert into dat_cho values (5, 2, '2014-12-05 21:05:00');
insert into dat_cho values (5, 3, '2014-12-05 21:05:00');
insert into dat_cho values (1, 4, '2019-12-05 21:05:00');
insert into dat_cho values (1, 5, '2019-12-05 21:05:00');
insert into dat_cho values (1, 2, '2019-12-05 21:05:00');
insert into dat_cho values (2, 1, '2010-04-05 21:05:00');
insert into dat_cho values (2, 3, '2010-04-05 21:05:00');
insert into dat_cho values (2, 4, '2010-04-05 21:05:00');
insert into dat_cho values (3, 5, '2011-06-05 21:05:00');
insert into dat_cho values (3, 4, '2011-06-05 21:05:00');
insert into dat_cho values (3, 1, '2011-06-05 21:05:00');
insert into dat_cho values (4, 3, '2013-06-05 21:05:00');
insert into dat_cho values (4, 2, '2013-06-05 21:05:00');
insert into dat_cho values (4, 1, '2013-06-05 21:05:00');


--1a:
select * from chuyen_bay
	join san_bay on maCB = maSB
where ngay_di = '2014-12-6';

--1b:
SELECT distinct maSB, ten, thanh_pho, quoc_gia 
FROM san_bay
	JOIN chuyen_bay on SB_di = maSB
	or SB_den = maSB
WHERE ngay_den <> '2014-12-6'
	and ngay_di <> '2014-12-6';

SELECT maSB, ten, thanh_pho, quoc_gia
FROM san_bay
	JOIN chuyen_bay on SB_di = maSB
	or SB_den = maSB
WHERE ngay_den <> '2014-12-6'
	and ngay_di <> '2014-12-6';

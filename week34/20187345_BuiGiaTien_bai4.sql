/****STORED PROCEDURE****/
-- #1:
PRINT N'Xin chào';
GO
-- #2:
DECLARE @ten varchar(50)
SET @ten = N'Tiến';
PRINT N'Xin chào ' + @ten;
GO
-- #3:
DECLARE @s1 int = 520,
		@s2 int = 250,
		@tg int;
SET @tg = @s1 + @s2;
PRINT N'tổng là: ' + CAST(@tg AS VARCHAR);
GO
-- #4:
CREATE OR ALTER PROC tinh_tong_printMax
@s1 INT, @s2 INT, @tong INT OUT

AS BEGIN
DECLARE @max INT
SET @tong = @s1 + @s2;
-- PRINT N'tong la: ' + CAST(@tong AS VARCHAR);
IF (@s1 > @s2)
	SET @max = @s1;
ELSE
	SET @max = @s2;
PRINT N'Số lớn nhất của ' + CAST(@s1 AS VARCHAR) + ' và ' + CAST(@s2 AS VARCHAR) + ' là ' + CAST(@tong as varchar); 
END
GO
/* kiem tra */
DECLARE @tong INT;
EXEC tinh_tong_printMax 100, 200, @tong OUT
GO

-- #5:
CREATE OR ALTER PROC findMinMax
@s1 INT, @s2 INT, @min INT OUT, @max INT OUT
AS BEGIN
IF (@s1 > @s2)
	BEGIN
	SET @max = @s1;
	SET @min = @s2;
	END
ELSE
	BEGIN
	SET @max = @s2;
	SET @min = @s1;
	END
END
GO
/* kiem tra */
DECLARE @min INT, @max INT
EXEC findMinMax 500, 456, @min OUTPUT, @max OUTPUT
PRINT N'Min and Max: '+ CAST(@min AS VARCHAR) +'-'+ CAST(@max AS VARCHAR);
GO

-- #6:
CREATE OR ALTER PROC sp_count @n INT
AS BEGIN
	DECLARE @i INT = 1;
	WHILE (@i <= @n)
	BEGIN
		PRINT @i;
		SET @i = @i + 1;
	END
END
GO
/* kiem tra */
EXEC sp_count 10;
GO

-- #7:
CREATE OR ALTER PROC tinh_tong_chan @n INT
AS BEGIN
	DECLARE @i INT = 0,
			@tong INT = 0;
	WHILE (@i < @n)
	BEGIN
		SET @i = @i + 1;
		IF (@i % 2 = 0)
			SET @tong = @tong + @i;
	END
	PRINT N'Tong cac so chan: ' + CAST(@tong AS VARCHAR);
END
GO
/* kiem tra */
EXEC tinh_tong_chan 8;
GO

-- #8:
CREATE OR ALTER PROCEDURE tinhTong_countSoChan @n INT
AS BEGIN
	DECLARE @tong INT = 0,
		@count_sochan INT = 0,
		@i INT = 0;
	WHILE (@i < @n)
	BEGIN
			SET @i = @i + 1;
			IF (@i % 2 = 0)
			BEGIN
				SET @count_sochan = @count_sochan + 1;
				SET @tong = @tong + @i;
			END
	END
	PRINT N'Tong cac so chan: ' + CAST(@tong AS VARCHAR);
	PRINT N'So luong so chan: ' + CAST(@count_sochan AS VARCHAR);
END
GO
/* kiem tra */
EXEC tinhTong_countSoChan 25;
GO

-- #9.1:
CREATE OR ALTER PROCEDURE cauthu_brazil
AS BEGIN
SELECT * FROM CAUTHU
WHERE MAQG = "BRA";
END
GO
-- check
EXEC cauthu_brazil;
GO

-- #9.2:
CREATE OR ALTER PROC KETQUA_VONG3_2009
AS BEGIN
SELECT MATRAN, NGAYTD, S.TENSAN, A.TENCLB AS TENCLB1, B.TENCLB AS TENCLB2, KETQUA
FROM TRANDAU
	JOIN SANVD S ON S.MASAN = TRANDAU.MASAN
	JOIN CAULACBO A ON A.MACLB = TRANDAU.MACLB1
	JOIN CAULACBO B ON B.MACLB = TRANDAU.MACLB2
WHERE VONG = 3 AND NAM = 2009;
END
GO
-- check
EXEC KETQUA_VONG3_2009;
GO

-- #9.3:
CREATE OR ALTER PROC HLV_VIETNAM
AS BEGIN
SELECT H.MAHLV, TENHLV, NGAYSINH, DIACHI, VAITRO, C.TENCLB
FROM HUANLUYENVIEN H
	JOIN HLV_CLB HC ON HC.MAHLV = H.MAHLV
	JOIN CAULACBO C ON C.MACLB = HC.MACLB
WHERE MAQG = 'VN';
END
GO
--check 
EXEC HLV_VIETNAM;
GO

-- #9.4:
CREATE OR ALTER PROC SOLUONG_CAUTHU_NUOCNGOAI
AS BEGIN
SELECT C.MACLB, TENCLB, TENSAN, DIACHI, SOLUONG AS SOLUONG_CAUTHU_NUOCNGOAI
FROM CAULACBO C
	JOIN SANVD S ON S.MASAN = C.MASAN
	WHERE MACLB IN (
		SELECT MACLB, COUNT(*) AS SOLUONG
		FROM CAUTHU
		WHERE MAQG != 'VN'
		GROUP BY MACLB
		HAVING SOLUONG > 2;
	)
END
GO
-- check
EXEC SOLUONG_CAUTHU_NUOCNGOAI;
GO

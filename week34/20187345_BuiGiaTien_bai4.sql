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
PRINT N'tổng là: ' + CAST(@tg AS NVARCHAR(20));
GO
-- #4:
--> tính tổng

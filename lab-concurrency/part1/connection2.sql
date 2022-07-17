-- Connection 2 
USE TestDB;

-- step 5:
BEGIN TRAN;
	UPDATE Test.TestTable SET Col2 = Col2 + 1
	WHERE Col1 = 1;

-- step 9:
COMMIT TRAN;
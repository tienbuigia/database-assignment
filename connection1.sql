-- Connection 1
CREATE DATABASE TestDB;
GO
ALTER DATABASE TestDB SET READ_COMMITTED_SNAPSHOT ON;
GO
USE TestDB;
GO
CREATE SCHEMA Test;
GO
CREATE TABLE Test.TestTable (
	Col1 INT NOT NULL
	,Col2 INT NOT NULL
);
INSERT Test.TestTable (Col1, Col2) VALUES (1,10);
INSERT Test.TestTable (Col1, Col2) VALUES (2,20);
INSERT Test.TestTable (Col1, Col2) VALUES (3,30);
INSERT Test.TestTable (Col1, Col2) VALUES (4,40);
INSERT Test.TestTable (Col1, Col2) VALUES (5,50);
INSERT Test.TestTable (Col1, Col2) VALUES (6,60);

-- step 6
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRAN;
	SELECT * FROM Test.TestTable
	WHERE Col1 = 1;
--> we are reading the value that are committed, and not be blocked because READ_COMMITTED_SNAPSHOT is on.

-- Connection 1
COMMIT TRAN;
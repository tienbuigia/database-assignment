CREATE DATABASE TestDB;
GO
USE TestDB;
GO
CREATE SCHEMA Test;
GO
CREATE TABLE Test.Accounts (
	AccountNumber INT PRIMARY KEY);
CREATE TABLE Test.AccountTransactions (
	TransactionID INT IDENTITY PRIMARY KEY
	,AccountNumber INT NOT NULL REFERENCES Test.Accounts
	,CreatedDateTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
	,Amount DECIMAL(19, 5) NOT NULL
);
GO
CREATE PROC Test.spAccountReset
AS
BEGIN
	SET NOCOUNT ON;
	DELETE Test.AccountTransactions;
	DELETE Test.Accounts;
	INSERT Test.Accounts (AccountNumber) VALUES (1001);
	INSERT Test.AccountTransactions (AccountNumber, Amount)
	VALUES (1001, 100);
	INSERT Test.AccountTransactions (AccountNumber, Amount)
	VALUES (1001, 500);
	INSERT Test.AccountTransactions (AccountNumber, Amount)
	VALUES (1001, 1400);
	SELECT AccountNumber, SUM(Amount) AS Balance
	FROM Test.AccountTransactions
	GROUP BY AccountNumber;
END
-- Connection 1:
USE TestDB
go
EXEC Test.spAccountReset;

-- step 6:
SELECT SUM(Amount) AS BalanceBeforeWithdrawal
FROM Test.AccountTransactions
WHERE AccountNumber = 1001;
GO
EXEC Test.spAccountWithdraw @AccountNumber = 1001, @AmountToWithdraw = 2000;
/* What kind of concurrency problem occurred? 
	it's "phantom reads" */

USE TestDB
go

-- step 6:
SELECT SUM(Amount) AS BalanceBeforeWithdrawal
FROM Test.AccountTransactions
WHERE AccountNumber = 1001;
GO
EXEC Test.spAccountWithdraw @AccountNumber = 1001, @AmountToWithdraw = 2000;
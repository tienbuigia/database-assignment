USE TestDB;
GO
CREATE PROC Test.spAccountWithdraw
@AccountNumber INT
,@AmountToWithdraw DECIMAL(19,5)
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
	BEGIN TRY
		IF (@AmountToWithdraw <= 0)
			RAISERROR('@AmountToWithdraw must be > 0.', 16, 1);
		BEGIN TRAN;
			-- Verify that the account exists
			-- and LOCK the account
			-- that will write to the account or its transactions
			-- SELECT statements against the account still works.
			IF NOT EXISTS(
					SELECT *
					FROM Test.Accounts WITH (UPDLOCK)
					WHERE AccountNumber = @AccountNumber
				)
				RAISERROR('Account not found.', 16, 1);
			-- Verify that the account will not be overdrawn...
			IF (@AmountToWithdraw > (
						SELECT SUM(Amount)
						FROM Test.AccountTransactions
						WHERE AccountNumber = @AccountNumber)
				)
				RAISERROR('Not enough funds in account.', 16, 1);
			-- ** USED TO TEST CONCURRENCY PROBLEMS **
			RAISERROR('Pausing procedure for 10 seconds...', 10, 1)
				WITH NOWAIT;
			WAITFOR DELAY '00:00:30';
			RAISERROR('Procedure continues...', 10, 1) WITH NOWAIT;
			-- Make the withdrawal...
			INSERT Test.AccountTransactions (AccountNumber, Amount)
				VALUES (@AccountNumber, - @AmountToWithdraw);
			-- Return the new balance of the account:
			SELECT SUM(Amount) AS BalanceAfterWithdrawal
			FROM Test.AccountTransactions
			WHERE AccountNumber = @AccountNumber;
		COMMIT TRAN;
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(2047);
		SET @ErrorMessage = ERROR_MESSAGE();
		RAISERROR(@ErrorMessage, 16, 1);
		-- Should also use ERROR_SEVERITY() and ERROR_STATE()...
		IF(XACT_STATE() <> 0)
			ROLLBACK TRAN;
	END CATCH
END
USE BanksDb

GO
CREATE PROCEDURE TransferMoneyFromAccountToCard @AccountNumberFrom VARCHAR(50), @CardNumberTo VARCHAR(16), @moneyToTransfer INT AS
BEGIN

SET TRAN ISOLATION LEVEL REPEATABLE READ
BEGIN TRY
BEGIN TRAN

	DECLARE @accountBalance MONEY
	DECLARE @cardsBalance MONEY
	DECLARE @selectedCardAccountNumber VARCHAR(50)

	SET @selectedCardAccountNumber = (
		SELECT AccountNumber FROM Cards
		WHERE CardNumber = @CardNumberTo)

	IF (@selectedCardAccountNumber != @AccountNumberFrom)
		THROW 51000, 'Selected card doesnt belong to selected account number', 1	

	SET @accountBalance = (
		SELECT Balance FROM Accounts
		WHERE Number = @AccountNumberFrom)

	SET @cardsBalance = (
		SELECT SUM(Cards.Balance) FROM Cards
			JOIN Accounts ON Accounts.Number = AccountNumber
		WHERE Accounts.Number = @AccountNumberFrom)

	IF (@accountBalance - @cardsBalance >= @moneyToTransfer)
		BEGIN
			UPDATE Cards
			SET Balance = Balance + @moneyToTransfer
			FROM Cards
			WHERE AccountNumber = @AccountNumberFrom AND CardNumber = @CardNumberTo
		END
	ELSE
		THROW 51000, 'Not enough money on selected account', 1

END TRY
BEGIN CATCH
	ROLLBACK TRAN
	;THROW	
END CATCH

COMMIT TRAN

END

GO
CREATE PROC ShowChangingData7 @CardNumberTo VARCHAR(16) AS
BEGIN
SELECT
	Accounts.Number AS SelectedAcoountNumber,
	Accounts.Balance AS SelectedAccountBalance,
	Cards.Balance AS SelectedCardBalance
	FROM Cards
		JOIN Accounts ON Accounts.Number = AccountNumber
	WHERE CardNumber = @CardNumberTo
END

GO
DECLARE @from VARCHAR(50) = '40702840000000001221'
DECLARE @to VARCHAR(16) = '3453453453453453'
DECLARE @howMuch MONEY = 10

EXEC ShowChangingData7 @to
EXEC TransferMoneyFromAccountToCard @from, @to, @howMuch
EXEC ShowChangingData7 @to

BEGIN TRY
	EXEC TransferMoneyFromAccountToCard @from, @to, 999999999
END TRY

BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrorNumber,
		   ERROR_MESSAGE() AS ErrorMessage
END CATCH

GO
DROP PROC ShowChangingData7
DROP PROC TransferMoneyFromAccountToCard

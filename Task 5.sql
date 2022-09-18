USE BanksDb

GO
CREATE PROC Add10ToAccountsWithSocialStatus @socialStatusId INT AS
BEGIN
	DECLARE @accountsWithSelectedSocialStatus INT

	SET @accountsWithSelectedSocialStatus = (
	SELECT 
	COUNT(*)
	FROM Accounts
		JOIN Clients ON Clients.Id = Accounts.ClientId
	WHERE SocialStatusId = @SocialStatusId)

	IF @accountsWithSelectedSocialStatus = 0	
		THROW 51000, 'Accounts with selected social status id not found', 1			
	ELSE
		UPDATE Accounts
		SET Balance = Balance + 10
		FROM Accounts
			JOIN Clients ON Clients.Id = Accounts.ClientId
		WHERE SocialStatusId = @socialStatusId
END

GO
CREATE PROC ShowChangingDataTask5 @socialStatusId INT AS
BEGIN
	SELECT
	(Clients.FirstName + ' ' + Clients.LastName) AS FullName,
	StatusName,
	Balance AS AccountBalance
	FROM SocialStatuses
		JOIN Clients ON Clients.SocialStatusId = SocialStatuses.Id
		JOIN Accounts ON Accounts.ClientId = Clients.Id	
	WHERE SocialStatuses.Id = @socialStatusId
END

GO
DECLARE @selectedSocialStatus INT = 4

EXEC ShowChangingDataTask5 @selectedSocialStatus
EXEC Add10ToAccountsWithSocialStatus @selectedSocialStatus
EXEC ShowChangingDataTask5 @selectedSocialStatus

GO
BEGIN TRY
	EXEC Add10ToAccountsWithSocialStatus 999
END TRY

BEGIN CATCH
	SELECT ERROR_NUMBER() AS ErrorNumber,
		   ERROR_MESSAGE() AS ErrorMessage
END CATCH
	
GO
DROP PROC ShowChangingDataTask5
DROP PROC Add10ToAccountsWithSocialStatus





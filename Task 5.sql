USE BanksDb

GO
CREATE PROC Add10ToAccountsWithSocialStatus @SocialStatusId INT
AS
	UPDATE Accounts
	SET Balance = Balance + 10
	FROM Accounts
		JOIN Clients ON Clients.Id = Accounts.ClientId
	WHERE SocialStatusId = @SocialStatusId

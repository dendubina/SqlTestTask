USE BanksDb

SELECT
	(Clients.FirstName + ' ' + Clients.LastName) AS FullName,
	(SELECT SUM(Accounts.Balance)
	 FROM Accounts
	 WHERE Accounts.ClientId = Clients.Id) AS BalanceSum,

	(SELECT ISNULL(SUM(Cards.Balance), 0) 
	 FROM Cards
		JOIN Accounts ON Accounts.ClientId = Clients.Id
	 WHERE Cards.AccountNumber = Accounts.Number) AS CardsSum,

	(SELECT SUM(DISTINCT Accounts.Balance) - ISNULL(SUM(Cards.Balance), 0)
	 FROM Accounts
		LEFT JOIN Cards ON Cards.AccountNumber = Accounts.Number
	 WHERE Accounts.ClientId = Clients.Id) AS MoneyAvailable
FROM Clients

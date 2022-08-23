USE BanksDb

SELECT (Clients.FirstName + ' ' + Clients.LastName) AS FullName, Banks.Name, CardNumber, Cards.Balance FROM Cards
	JOIN Accounts ON Cards.AccountNumber = Accounts.Number
	JOIN Clients ON Accounts.ClientId = Clients.Id
	JOIN Banks ON Accounts.BankId = Banks.Id
	ORDER BY Clients.LastName
	
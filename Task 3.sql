USE BanksDb

SELECT
Number,
Accounts.Balance AS AccountBalance, 
SUM(Cards.Balance) AS CardsBalance,
COUNT(Cards.AccountNumber) AS CardsCount,
ABS(Accounts.Balance - SUM(Cards.Balance)) AS Difference
FROM Accounts
	JOIN Cards ON AccountNumber = Accounts.Number
GROUP BY Number, Accounts.Balance

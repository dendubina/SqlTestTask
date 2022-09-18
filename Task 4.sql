USE BanksDb

SELECT
StatusName,
COUNT(Cards.CardNumber) AS CardsCount
FROM SocialStatuses
	JOIN Clients ON Clients.SocialStatusId = SocialStatuses.Id
	JOIN Accounts ON Accounts.ClientId = Clients.Id
	JOIN Cards ON AccountNumber = Accounts.Number
GROUP BY StatusName
ORDER BY StatusName

SELECT StatusName,
	(SELECT
	COUNT(Cards.CardNumber)
	FROM Cards
		JOIN Clients ON Clients.SocialStatusId = SocialStatuses.Id
		JOIN Accounts ON Accounts.ClientId = Clients.Id
	WHERE Cards.AccountNumber = Accounts.Number) AS CardsCount
FROM SocialStatuses
ORDER BY StatusName



	
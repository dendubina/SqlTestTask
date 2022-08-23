USE BanksDb

SELECT Banks.Name AS BankName, Locations.City
FROM Banks
	JOIN BanksLocations ON Banks.Id = BanksLocations.BankId
	JOIN Locations ON Locations.Id = BanksLocations.LocationId
	WHERE Locations.City = 'Brest'
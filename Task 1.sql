USE BanksDb

SELECT
Banks.Name,
Locations.City
FROM Banks
	JOIN BanksLocations ON Banks.Id = BanksLocations.BankId
	JOIN Locations ON Locations.Id = BanksLocations.LocationId
WHERE Locations.City = 'Minsk'
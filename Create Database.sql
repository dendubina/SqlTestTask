CREATE DATABASE BanksDb;
GO

USE BanksDb

CREATE TABLE Banks
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(50) UNIQUE NOT NULL,
);

CREATE TABLE Locations
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	City VARCHAR(50) NOT NULL,
);

CREATE TABLE BanksLocations
(
	BankId INT REFERENCES Banks(Id),
	LocationId INT REFERENCES Locations(Id),
);

CREATE TABLE SocialStatuses
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	StatusName VARCHAR(50) UNIQUE NOT NULL,
);

CREATE TABLE Clients
(
	Id INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	SocialStatusId INT REFERENCES SocialStatuses(Id) NOT NULL,
);

CREATE TABLE Accounts
(	
	Number VARCHAR(50) PRIMARY KEY,	
	BankId INT REFERENCES Banks(Id) NOT NULL,
	Balance MONEY CHECK (Balance > 0),
	ClientId INT REFERENCES Clients(Id) NOT NULL,	
);

GO
CREATE FUNCTION GetClientAccountsCount(@clientId INT, @bankId INT) RETURNS INT
BEGIN
 DECLARE @Count INT
 SELECT @Count = COUNT(*) FROM Accounts
 WHERE ClientId = @clientId AND BankId = @bankId
 RETURN @Count
END
GO

ALTER TABLE Accounts
ADD CHECK(dbo.GetClientAccountsCount(ClientId, BankId) = 0);

CREATE TABLE Cards
(	
	CardNumber VARCHAR(16) PRIMARY KEY,
	Balance MONEY CHECK (Balance > 0),
	AccountNumber VARCHAR(50) REFERENCES Accounts(Number) NOT NULL,
);

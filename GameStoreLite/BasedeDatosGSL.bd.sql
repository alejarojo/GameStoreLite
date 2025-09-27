DROP DATABASE IF EXISTS GameStoreLite;
CREATE DATABASE GameStoreLite;
USE GameStoreLite;

DROP TABLE IF EXISTS SaleDetails;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Games;
DROP TABLE IF EXISTS Genres;
DROP TABLE IF EXISTS Customers;

DROP PROCEDURE IF EXISTS sp_InsertGenre;
DROP PROCEDURE IF EXISTS sp_UpdateGenre;
DROP PROCEDURE IF EXISTS sp_DeleteGenre;

DROP PROCEDURE IF EXISTS sp_InsertCustomer;
DROP PROCEDURE IF EXISTS sp_UpdateCustomer;
DROP PROCEDURE IF EXISTS sp_DeleteCustomer;

DROP PROCEDURE IF EXISTS sp_InsertGame;
DROP PROCEDURE IF EXISTS sp_UpdateGame;
DROP PROCEDURE IF EXISTS sp_DeleteGame;

DROP PROCEDURE IF EXISTS sp_InsertSale;
DROP PROCEDURE IF EXISTS sp_UpdateSale;
DROP PROCEDURE IF EXISTS sp_DeleteSale;

DROP PROCEDURE IF EXISTS sp_InsertSaleDetail;
DROP PROCEDURE IF EXISTS sp_UpdateSaleDetail;
DROP PROCEDURE IF EXISTS sp_DeleteSaleDetail;

-- ========================================
-- CREAR TABLAS
-- ========================================
START TRANSACTION;

CREATE TABLE Genres (
    GenreID INT PRIMARY KEY AUTO_INCREMENT,
    GenreName VARCHAR(30) NOT NULL,
    Description VARCHAR(255)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(60) NOT NULL,
    Email VARCHAR(50),
    City VARCHAR(25),
    Country VARCHAR(20)
);

CREATE TABLE Games (
    GameID INT PRIMARY KEY AUTO_INCREMENT,
    GameTitle VARCHAR(60) NOT NULL,
    GenreID INT,
    Platform VARCHAR(25),
    Price DECIMAL(8,2),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    SaleDate DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE SaleDetails (
    SaleDetailID INT PRIMARY KEY AUTO_INCREMENT,
    SaleID INT,
    GameID INT,
    Quantity INT,
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (GameID) REFERENCES Games(GameID)
);

COMMIT;

DELIMITER $$


CREATE PROCEDURE sp_InsertGenre(IN p_GenreName VARCHAR(100), IN p_Description TEXT)
BEGIN
    INSERT INTO Genres (GenreName, Description) VALUES (p_GenreName, p_Description);
END$$

CREATE PROCEDURE sp_UpdateGenre(IN p_GenreID INT, IN p_GenreName VARCHAR(100), IN p_Description TEXT)
BEGIN
    UPDATE Genres SET GenreName = p_GenreName, Description = p_Description WHERE GenreID = p_GenreID;
END$$

CREATE PROCEDURE sp_DeleteGenre(IN p_GenreID INT)
BEGIN
    DELETE FROM Genres WHERE GenreID = p_GenreID;
END$$

-- ----- CUSTOMERS -----
CREATE PROCEDURE sp_InsertCustomer(IN p_FullName VARCHAR(60), IN p_Email VARCHAR(50), IN p_City VARCHAR(25), IN p_Country VARCHAR(20))
BEGIN
    INSERT INTO Customers (FullName, Email, City, Country)
    VALUES (p_FullName, p_Email, p_City, p_Country);
END$$

CREATE PROCEDURE sp_UpdateCustomer(IN p_CustomerID INT, IN p_FullName VARCHAR(60), IN p_Email VARCHAR(50), IN p_City VARCHAR(25), IN p_Country VARCHAR(20))
BEGIN
    UPDATE Customers
    SET FullName = p_FullName,
        Email = p_Email,
        City = p_City,
        Country = p_Country
    WHERE CustomerID = p_CustomerID;
END$$

CREATE PROCEDURE sp_DeleteCustomer(IN p_CustomerID INT)
BEGIN
    DELETE FROM Customers WHERE CustomerID = p_CustomerID;
END$$

-- ----- GAMES -----
CREATE PROCEDURE sp_InsertGame(IN p_GameTitle VARCHAR(60), IN p_GenreID INT, IN p_Platform VARCHAR(25), IN p_Price DECIMAL(8,2))
BEGIN
    INSERT INTO Games (GameTitle, GenreID, Platform, Price)
    VALUES (p_GameTitle, p_GenreID, p_Platform, p_Price);
END$$

CREATE PROCEDURE sp_UpdateGame(IN p_GameID INT, IN p_GameTitle VARCHAR(60), IN p_GenreID INT, IN p_Platform VARCHAR(25), IN p_Price DECIMAL(8,2))
BEGIN
    UPDATE Games
    SET GameTitle = p_GameTitle,
        GenreID = p_GenreID,
        Platform = p_Platform,
        Price = p_Price
    WHERE GameID = p_GameID;
END$$

CREATE PROCEDURE sp_DeleteGame(IN p_GameID INT)
BEGIN
    DELETE FROM Games WHERE GameID = p_GameID;
END$$

-- ----- SALES -----
CREATE PROCEDURE sp_InsertSale(IN p_CustomerID INT, IN p_SaleDate DATETIME)
BEGIN
    INSERT INTO Sales (CustomerID, SaleDate) VALUES (p_CustomerID, p_SaleDate);
END$$

CREATE PROCEDURE sp_UpdateSale(IN p_SaleID INT, IN p_CustomerID INT, IN p_SaleDate DATETIME)
BEGIN
    UPDATE Sales SET CustomerID = p_CustomerID, SaleDate = p_SaleDate WHERE SaleID = p_SaleID;
END$$

CREATE PROCEDURE sp_DeleteSale(IN p_SaleID INT)
BEGIN
    DELETE FROM Sales WHERE SaleID = p_SaleID;
END$$

-- ----- SALE DETAILS -----
CREATE PROCEDURE sp_InsertSaleDetail(IN p_SaleID INT, IN p_GameID INT, IN p_Quantity INT)
BEGIN
    INSERT INTO SaleDetails (SaleID, GameID, Quantity)
    VALUES (p_SaleID, p_GameID, p_Quantity);
END$$

CREATE PROCEDURE sp_UpdateSaleDetail(IN p_SaleDetailID INT, IN p_SaleID INT, IN p_GameID INT, IN p_Quantity INT)
BEGIN
    UPDATE SaleDetails
    SET SaleID = p_SaleID,
        GameID = p_GameID,
        Quantity = p_Quantity
    WHERE SaleDetailID = p_SaleDetailID;
END$$

CREATE PROCEDURE sp_DeleteSaleDetail(IN p_SaleDetailID INT)
BEGIN
    DELETE FROM SaleDetails WHERE SaleDetailID = p_SaleDetailID;
END$$

DELIMITER ;

SELECT * FROM genres;
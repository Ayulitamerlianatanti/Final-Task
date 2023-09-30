CREATE DATABASE DWH_Project

use DWH_Project

CREATE TABLE DimCustomer(
	CustomerID int NOT NULL PRIMARY KEY,
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	Age int NOT NULL,
	Gender varchar(50) NOT NULL,
	City varchar(50) NOT NULL,
	NoHp varchar(50) NOT NULL
);

CREATE TABLE DimProduct(
	ProductID int NOT NULL PRIMARY KEY,
	ProductName varchar(255) NOT NULL,
	ProductCategory varchar(255) NOT NULL,
	ProductUnitPrice int NOT NULL
);

CREATE TABLE DimStatusOrder(
	StatusID int NOT NULL PRIMARY KEY,
	StatusOrder varchar(50) NOT NULL,
	StatusOrderDesc varchar(50) NOT NULL
);

CREATE TABLE FactSalesOrder(
	OrderID int NOT NULL,
	CustomerID int NOT NULL,
	ProductID int NOT NULL,
	Quantity int NOT NULL,
	Amount int NOT NULL,
	StatusID int NOT NULL,
	OrderDate date NOT NULL,
	PRIMARY KEY (OrderID),
	CONSTRAINT FK_CustomerOrder FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID),
	CONSTRAINT FK_ProductOrder FOREIGN KEY (ProductID) REFERENCES DimProduct(ProductID),
	CONSTRAINT FK_StatusOrder FOREIGN KEY (StatusID) REFERENCES DimStatusOrder(StatusID)
);
SELECT * FROM DimProduct

CREATE PROCEDURE summary_order_status @StatusID int AS
BEGIN
	SELECT
		fo.OrderID,
		dc.CustomerName,
		dp.ProductName,
		fo.Quantity,
		ds.StatusOrder
	FROM 
		FactSalesOrder fo
	JOIN 
		DimCustomer dc 
			ON fo.CustomerID = dc.CustomerID
	JOIN 
		DimProduct dp 
			ON fo.ProductID = dp.ProductID
	JOIN 
		DimStatusOrder ds 
			ON fo.StatusID = ds.StatusID
	WHERE fo.StatusID = @StatusID
END
;

EXEC summary_order_status @StatusID=2;


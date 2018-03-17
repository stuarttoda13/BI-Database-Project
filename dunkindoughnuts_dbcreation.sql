/*Mild Thamparanon, Stuart Toda, Alastair Ng*/


CREATE DATABASE DunkinDonutsDatabase;
GO

USE DunkinDonutsDatabase;
GO

CREATE TABLE ProductCategory(
ProductCategoryID bigint NOT NULL PRIMARY KEY,
CategoryName varchar (50) NOT NULL);

CREATE TABLE Product(
ProductID bigint NOT NULL PRIMARY KEY,
Name varchar (50) NOT NULL,
ProductCategoryID bigint NOT NULL FOREIGN KEY REFERENCES ProductCategory(ProductCategoryID),
Price integer NOT NULL,
Calories integer NOT NULL);

CREATE TABLE Customer(
CustomerID bigint NOT NULL PRIMARY KEY,
FirstName varchar (50) NOT NULL,
LastName varchar (50) NOT NULL,
CardNumber bigint NOT NULL,
PhoneNumber bigint NOT NULL);

CREATE TABLE Store(
StoreID bigint NOT NULL PRIMARY KEY,
City varchar (50) NOT NULL,
State varchar (50),
Zipcode integer NOT NULL,
Country varchar (15) NOT NULL,
Region varchar (25) NOT NULL);

CREATE TABLE Employee(
EmployeeID bigint NOT NULL PRIMARY KEY,
FirstName varchar (50) NOT NULL,
LastName varchar (50) NOT NULL,
JobTitle varchar (50) NOT NULL,
StoreID bigint NOT NULL);

CREATE TABLE Orders(
OrderID bigint NOT NULL PRIMARY KEY,
ProductID bigint NOT NULL FOREIGN KEY REFERENCES Product(ProductID),
EmployeeID bigint NOT NULL FOREIGN KEY REFERENCES Employee(EmployeeID),
OrderDate date NOT NULL);

CREATE TABLE Inventory(
InventoryID bigint NOT NULL PRIMARY KEY,
ProductID bigint NOT NULL FOREIGN KEY REFERENCES Product(ProductID),
StoreID bigint NOT NULL FOREIGN KEY REFERENCES Store(StoreID),
Cost integer NOT NULL,
Quantity integer NOT NULL);

CREATE TABLE Transactions(
TransactionID bigint NOT NULL PRIMARY KEY,
StoreID bigint NOT NULL FOREIGN KEY REFERENCES Store(StoreID),
OrderID bigint NOT NULL FOREIGN KEY REFERENCES Orders(OrderID),
CustomerID bigint NOT NULL FOREIGN KEY REFERENCES Customer(CustomerID),
EmployeeID bigint NOT NULL FOREIGN KEY REFERENCES Employee(EmployeeID),
TotalSales integer NOT NULL,
OrderQuantity integer NOT NULL);

/*Create the relationship: the FK in Product*/
ALTER TABLE Product ADD CONSTRAINT FK_Product_ProductCategory
FOREIGN KEY (ProductCategoryID) REFERENCES ProductCategory(ProductCategoryID);
GO


/*Create the relationship: the FK in Order*/
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Product
FOREIGN KEY (ProductID) REFERENCES Product(ProductID);
GO

ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Employee
FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID);
GO

/*Create the relationship: the FK in Inventory*/
ALTER TABLE Inventory ADD CONSTRAINT FK_Inventory_Product
FOREIGN KEY (ProductID) REFERENCES Product(ProductID);
GO

ALTER TABLE Inventory ADD CONSTRAINT FK_Inventory_Store
FOREIGN KEY (StoreID) REFERENCES Store(StoreID);
GO

/*Create the relationship: the FK in Transaction*/
ALTER TABLE Transactions ADD CONSTRAINT FK_Transactions_Orders
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
GO

ALTER TABLE Transactions ADD CONSTRAINT FK_Transactions_Store
FOREIGN KEY (StoreID) REFERENCES Store(StoreID);
GO

ALTER TABLE Transactions ADD CONSTRAINT FK_Transactions_Customer
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);
GO

ALTER TABLE Transactions ADD CONSTRAINT FK_Transactions_Employee
FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID);
GO


/*Populate Category*/
INSERT INTO ProductCategory (ProductCategoryID, CategoryName) VALUES
(1, 'Bakery'),
(2, 'All Day Choices'),
(3, 'Coffee'),
(4, 'Beverages');

/*Populate Product*/
INSERT INTO Product (ProductID, Name, ProductCategoryID, Price, Calories) VALUES
(1, 'Egg & Cheese Wake-Up Wrap', 2, 3.99,180),
(2, 'Hash Browns', 2, 1.29, 140),
(3, 'Big N Toasted', 2, 4.49, 570),
(4, 'Glazed Donut', 1, 0.99, 260),
(5, 'Classic Donut', 1, 0.99, 230),
(6, 'Fancy Donut', 1, 1.59, 270),
(7, 'Iced Coffee S', 3, 1.99, 130),
(8, 'Iced Coffee M', 3, 2.29, 200),
(9, 'Coolatta Caramel', 4, 2.59, 420),
(10, 'Coolatta Strawberry', 4, 2.59, 350);


/*Populate Employee:  Assuming that all employee positions can make transactions*/
INSERT INTO Employee (EmployeeID, FirstName, LastName, JobTitle, StoreID) VALUES
(1, 'Mild', 'Thamparanon', 'Manager', 1),
(2, 'Stuart', 'Toda', 'Barista', 2),
(3, 'Alastair', 'Ng', 'Cashier', 3),
(4, 'Brett', 'Bottomley', 'Manager', 4),
(5, 'Naeli', 'Elizalde', 'Barista', 5),
(6, 'Tong', 'Zhi', 'Cashier', 6),
(7, 'Christine', 'Lee', 'Manager', 7),
(8, 'Justin', 'Kang', 'Barista', 8),
(9, 'Cynthia', 'Yong', 'Manager', 9),
(10,'Lauren', 'Mariano', 'Barista', 10);


/*Populate Customer*/
INSERT INTO Customer (CustomerID, FirstName, LastName, CardNumber, PhoneNumber) VALUES
(1, 'Nadira', 'Zahiruddin', 8367213864938386, 8283680449),
(2, 'Jullian', 'Mullins', 5165197538877436, 5106788519),
(3, 'Paul', 'Gao', 5336589152911828, 8015879965),
(4, 'Christian', 'Thompson', 4716051063474670, 7460243551),
(5, 'Anushka', 'Goyal', 4556821051214798, 5050009306),
(6, 'Samuel', 'Gaudet', 5369647575334323, 8440189887),
(7, 'Sang Won', 'Baek', 4539906081533671, 3327683846),
(8, 'Nico', 'Piak', 5422173407986417, 9162485283),
(9, 'Kwang', 'Jitsakula', 5231324561881347, 7898664169),
(10,'Zirui', 'Jiao', 5571581679435674, 2868957713);

/*Populate Store*/
INSERT INTO Store (StoreID, City, State, Zipcode, Country, Region) VALUES
(1, 'Grand Rapids', 'Michigan', 49503, 'US', 'North America'),
(2, 'Columbus', 'Ohio', 43215, 'US', 'North America'),
(3, 'Charlotte', 'North Carolina', 28208, 'US', 'North America'),
(4, 'New York', 'New York', 10016, 'US', 'North America'),
(5, 'Olean', 'Kentucky', 14760, 'US', 'North America'),
(6, 'Hongkong', NULL, 63243, 'HK', 'Asia'),
(7, 'Shanghai', NULL, 49597, 'CH', 'Asia'),
(8, 'Bangkok', NULL, 10260, 'TH', 'Asia'),
(9, 'Nice', NULL, 25703, 'FR', 'Europe'),
(10,'West Palm Beach', 'Florida', 33401, 'US', 'North America');

/*Populate Order*/
INSERT INTO Orders (OrderID, ProductID, EmployeeID, OrderDate) VALUES
(1, 1, 1, '2013-05-23'),
(2, 2, 2, '2012-03-25'),
(3, 3, 3, '2013-07-24'),
(4, 4, 4, '2014-07-26'),
(5, 5, 5, '2015-10-23'),
(6, 6, 6, '2011-09-04'),
(7, 7, 7, '2012-01-23'),
(8, 8, 8, '2013-12-26'),
(9, 9, 9, '2014-02-14'),
(10, 10, 10, '2015-04-14');

/*Populate Transaction: Assuming that all employee positions can make transactions*/
INSERT INTO Transactions (TransactionID, StoreID, OrderID, CustomerID, EmployeeID, TotalSales, OrderQuantity) VALUES
(1, 1, 1, 1, 1, 2.59, 1),
(2, 2, 2, 2, 4, 4.49, 1),
(3, 3, 3, 3, 7, 2.98, 2),
(4, 4, 4, 4, 9, 0.99, 1),
(5, 5, 5, 5, 2, 1.29, 1),
(6, 6, 6, 6, 5, 2.29, 1),
(7, 7, 7, 7, 8, 0.99, 1),
(8, 8, 8, 8, 10, 1.99, 1),
(9, 9, 9, 9, 3, 0.99, 1),
(10, 10, 10, 10, 6, 4.49, 1);

/*Populate Inventory*/
INSERT INTO Inventory (InventoryID, ProductID, StoreID, Cost, Quantity) VALUES
(1, 1, 1, 3.00, 500),
(2, 2, 2, 1.00, 300),
(3, 3, 3, 2.00, 500),
(4, 4, 4, 0.20, 1500),
(5, 5, 5, 0.20, 1000),
(6, 6, 6, 1.00, 1000),
(7, 7, 7, 1.00, 2000),
(8, 8, 8, 2.00, 2000),
(9, 9, 9, 2.00, 200),
(10, 10, 10, 2.00, 350);
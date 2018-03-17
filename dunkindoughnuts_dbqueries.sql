/*Stuart Toda, Mild Thamparanon, Alastair Ng*/

USE DunkinDonutsDatabase;

/*SELECT * Functions */
SELECT *
FROM Customer;

SELECT *
FROM Employee;

SELECT *
FROM Inventory;

SELECT *
FROM Orders;

SELECT *
FROM Product;

SELECT *
FROM ProductCategory;

SELECT *
FROM Store;

SELECT *
FROM Transactions;

/*Find the total sales (dollar amount) per store*/
SELECT S.StoreID, SUM(T.TotalSales) AS 'Total Sales'
FROM Store AS S
INNER Join Transactions AS T
	ON S.StoreID = T.StoreID
GROUP BY S.StoreID;

/*Create an inner join for the inventory and product table to see how much of each product is in inventory*/
SELECT P.Name, SUM(I.Quantity) AS 'Quantity of Product'
FROM Inventory AS I
INNER JOIN Product AS P
	ON I.ProductID = P.ProductID
GROUP BY P.Name;

/* List the Total Sales from each State*/ 
SELECT DISTINCT (S.State), T.TotalSales
FROM Store AS S
Left OUTER JOIN Transactions AS T
	ON S.StoreID = T.StoreID
WHERE S.State IS NOT NULL
GROUP BY S.State,T.TotalSales;

/*List the Product ID, Product Name and Price of products whose price is above the average price of all products*/
SELECT ProductID, Name, Price
FROM Product
WHERE Price >
	(SELECT AVG(Price)
		FROM Product);
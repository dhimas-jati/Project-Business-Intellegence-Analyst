------Create Table Customers------
CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY,
	FirstName VARCHAR,
	LastName VARCHAR,
	CustomerEmail VARCHAR,
	CustomerPhone VARCHAR,
	CustomerAddress VARCHAR,
	CustomerCity VARCHAR,
	CustomerState VARCHAR,
	CustomerZip VARCHAR
) 

----Melakukan cek duplicate----
SELECT customerid, COUNT(*)
FROM Customers
GROUP BY customerid
HAVING COUNT(*) > 1;

----Melakukan cek NULL----
SELECT *
FROM Customers
WHERE customersid IS NULL;

------Create Table Productcategory------
CREATE TABLE ProductCategory (
	CategoryID INT PRIMARY KEY,
	CategoryName VARCHAR,
	CategoryAbbreviation VARCHAR
)
----Melakukan cek duplicate----
SELECT categoryid, COUNT(*)
FROM Productcategory
GROUP BY categoryid
HAVING COUNT(*) > 1;

----Melakukan cek NULL----
SELECT *
FROM Productcategory
WHERE categoryid IS NULL;

------Create Table Products-----
CREATE TABLE Products (
	ProdNumber VARCHAR PRIMARY KEY,
	ProdName VARCHAR,
	Category INT,
	Price NUMERIC,
	FOREIGN KEY (Category) REFERENCES
	ProductCategory(CategoryID)	
)
----Melakukan cek duplicate----
SELECT prodnumber, COUNT(*)
FROM Products
GROUP BY prodnumber
HAVING COUNT(*) > 1;

----Melakukan cek NULL----
SELECT *
FROM Products
WHERE prodnumber IS NULL;

------Create Table Orders-----
CREATE TABLE Orders (
	 OrderID INT PRIMARY KEY,
	 Date DATE,
	 CustomerID INT,
	 ProdNumber VARCHAR,
	 Quantity INT,
	 FOREIGN KEY (CustomerID) REFERENCES
	 Customers (CustomerID),
	 FOREIGN KEY (ProdNumber) REFERENCES
	 Products (ProdNumber)	 
)

----Melakukan cek duplicate----
SELECT orderid, COUNT(*)
FROM orders
GROUP BY orderid
HAVING COUNT(*) > 1;

----Melakukan cek NULL----
SELECT *
FROM orders
WHERE orderid IS NULL;

------Create Tabel Master------
select 
  o.date as order_date,
  pc.categoryname as category_name,
  p.prodname as product_name,
  p.price as product_price,
  o.quantity as order_qty,
  o.quantity * p.price as total_sales,
  c.customeremail as cust_email,
  c.customercity as cust_city
from orders as o
JOIN customers c 
on o.customerid = c.customerid
JOIN products p 
on o.prodnumber = p.prodnumber
JOIN productcategory pc 
on p.category = pc.categoryid
order by order_date
USE master;
DROP DATABASE IF EXISTS business_database
GO
CREATE DATABASE business_database;
GO
USE business_database;
GO

-- DDL Creating tables

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer
(
	CustID		CHAR(10)	NOT NULL,
	CustName	CHAR(50)	NOT NULL,
	CustAddress	CHAR(50)	,
	CustCity	CHAR(50)	,
	CustContact	CHAR(50)	,
	CustPhone	CHAR(15)	,
	CustEmail	CHAR(255)	
);

DROP TABLE IF EXISTS OrderEntry;
CREATE TABLE OrderEntry
(
	OrderID		INTEGER		NOT NULL,
	OrderDate	DATETIME	NOT NULL,
	CustID		CHAR(10)	NOT NULL
);

DROP TABLE IF EXISTS Vendor;
CREATE TABLE Vendor
(
	VendorID		CHAR(10)	NOT NULL,
	VendorName		CHAR(50)	NOT NULL,
	VendorAddress	CHAR(50)	,
	VendorCity		CHAR(50)	,
	VendorPhone		CHAR(15)
);

DROP TABLE IF EXISTS OrderItem;
CREATE TABLE OrderItem
(
	OrderID		INTEGER		NOT NULL,
	OrderItem	INTEGER		NOT NULL,
	ProductID	CHAR(10)	NOT NULL,
	Quantity	INTEGER		NOT NULL,
	ItemPrice	DECIMAL(8,2)NOT NULL
);

DROP TABLE IF EXISTS Product;
CREATE TABLE Product
(
	ProductID		CHAR(10)	NOT NULL,
	VendorID		CHAR(10)	NOT NULL,
	ProductName		CHAR(255)	NOT NULL,
	ProductPrice	DECIMAL(8,2)NOT NULL,
	ProductDesc		VARCHAR(100)		
);
GO

-- DML insert data

INSERT INTO Customer(CustID,CustName,CustAddress,CustCity,CustPhone,CustContact,CustEmail)
VALUES('1000000001','Village Toys','200 Oak Lane','Wellington','09-389-2356','John Smith','sales@villagetoys.co.nz');

INSERT INTO Customer(CustID,CustName,CustAddress,CustCity,CustPhone,CustContact)
VALUES('1000000002','Kids Place','333 Tahunanui Drive','Nelson','03-545-6333','Michelle Green');

INSERT INTO Customer(CustID,CustName,CustAddress,CustCity,CustPhone,CustContact,CustEmail)
VALUES('1000000003','Fun4All','1 Sunny Place','Nelson','03-548-2285','Jim Jones','jjones@fun4all.co.nz');

INSERT INTO Customer(CustID,CustName,CustAddress,CustCity,CustPhone,CustContact,CustEmail)
VALUES('1000000004','Fun4All','829 Queen Street','Auckland','09-368-7894','Denise L. Stephens','dstephens@fun4all.co.nz');

INSERT INTO Customer(CustID,CustName,CustAddress,CustCity,CustPhone,CustContact)
VALUES('1000000005','The Toy Store','50 Papanui Road','Christchurch','04-345-4545','Kim Howard');


INSERT INTO OrderEntry(OrderID,OrderDate,CustID)
VALUES(20005,'1999/5/1','1000000001');

INSERT INTO OrderEntry(OrderID,OrderDate,CustID)
VALUES(20006,'1999/1/12','1000000003');

INSERT INTO OrderEntry(OrderID,OrderDate,CustID)
VALUES(20007,'1999/1/30','1000000004');

INSERT INTO OrderEntry(OrderID,OrderDate,CustID)
VALUES(20008,'1999/2/3','1000000005');

INSERT INTO OrderEntry(OrderID,OrderDate,CustID)
VALUES(20009, '1999/2/8','1000000001');


INSERT INTO Vendor(VendorID, VendorName, VendorAddress, VendorCity, VendorPhone)
VALUES('BRS01','Bears R Us','123 Main Street','Richmond','03-523-8871');

INSERT INTO Vendor(VendorID, VendorName, VendorAddress, VendorCity, VendorPhone)
VALUES('BRE02','Bear Emporium','500 Park Street','Auckland','06-396-8854');

INSERT INTO Vendor(VendorID, VendorName, VendorAddress, VendorCity, VendorPhone)
VALUES('DLL01','Doll House Inc.','555 High Street','Motueka','03-455-7898');

INSERT INTO Vendor(VendorID, VendorName, VendorAddress, VendorCity, VendorPhone)
VALUES('FRB01','Furball Inc.','1 Clifford Avenue','Nelson','03-546-9978');


INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20005,1,'BR01',100,5.49);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20005,2,'BR03',100,10.99);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20006,1,'BR01',20,5.99);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20006,2,'BR02',10,8.99);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20006,3,'BR03',10,11.99);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20007,1,'BR03',50,11.49);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20007,2,'BNBG01',100,2.99);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20007,3,'BNBG02',100,2.99);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20007,4,'BNBG03',100,2.99);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20007,5,'RGAN01',50,4.49);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20008,1,'RGAN01',5,4.99);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20008,2,'BR03',5,11.99);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20008,3,'BNBG01',10,3.49);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20008,4,'BNBG02',10,3.49);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20008,5,'BNBG03',10,3.49);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20009,1,'BNBG01',250,2.49);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20009,2,'BNBG02',250,2.49);

INSERT INTO OrderItem(OrderID,OrderItem,ProductID,Quantity,ItemPrice)
VALUES(20009,3,'BNBG03',250,2.49);


INSERT INTO Product(ProductID, VendorID, ProductName, ProductPrice, ProductDesc)
VALUES('BR01', 'BRS01', '8 inch teddy bear',5.99,'8 inch teddy bear, comes with cap and jacket');

INSERT INTO Product(ProductID, VendorID, ProductName, ProductPrice, ProductDesc)
VALUES('BR02', 'BRS01', '12 inch teddy bear',8.99,'12 inch teddy bear, comes with cap and jacket');

INSERT INTO Product(ProductID, VendorID, ProductName, ProductPrice, ProductDesc)
VALUES('BR03', 'BRS01', '18 inch teddy bear',11.99,'18 inch teddy bear, comes with cap and jacket');

INSERT INTO Product(ProductID, VendorID, ProductName, ProductPrice, ProductDesc)
VALUES('BNBG01', 'DLL01', 'Fish bean bag toy',3.49,'Fish bean bag toy, complete with bean bag worms with which to feed it');

INSERT INTO Product(ProductID, VendorID, ProductName, ProductPrice, ProductDesc)
VALUES('BNBG02', 'DLL01', 'Bird bean bag toy',3.49,'Bird bean bag toy, eggs are not included');

INSERT INTO Product(ProductID, VendorID, ProductName, ProductPrice, ProductDesc)
VALUES('BNBG03', 'DLL01', 'Rabbit bean bag toy',3.49,'Rabbit bean bag toy, comes with bean bag carrots');

INSERT INTO Product(ProductID, VendorID, ProductName, ProductPrice, ProductDesc)
VALUES('RGAN01', 'DLL01', 'Raggedy Ann',4.99,'18 inch Raggedy Ann doll');
GO

-- DDL Relationships and Keys
ALTER TABLE Vendor
	ADD
		CONSTRAINT PK_Vendor
		PRIMARY KEY(VendorID);

ALTER TABLE Product
	ADD
		CONSTRAINT PK_Product
			PRIMARY KEY(ProductID),
		CONSTRAINT FK_Product_Vendor
			FOREIGN KEY(VendorID) REFERENCES Vendor(VendorID);

ALTER TABLE Customer
	ADD
		CONSTRAINT PK_Customer
		PRIMARY KEY(CustID);


ALTER TABLE OrderEntry
	ADD
		CONSTRAINT PK_OrderEntry
			PRIMARY KEY(OrderID),
		CONSTRAINT FK_OrderEntry_Customer
			FOREIGN KEY(CustID) REFERENCES Customer(CustID);

ALTER TABLE OrderItem
	ADD
		CONSTRAINT PK_OrderItem
			PRIMARY KEY(OrderID, OrderItem),
		CONSTRAINT FK_OrderItem_OrderEntry
			FOREIGN KEY(OrderID) REFERENCES OrderEntry(OrderID),
		CONSTRAINT FK_OrderItem_Product
			FOREIGN KEY(ProductID) REFERENCES Product(ProductID);
GO

-- Queries

-- 1.  All products not made by vendor DLL01
SELECT 
	VendorID AS 'Vendor',
	ProductName AS 'Product'
FROM 
	Product
WHERE 
	VendorID != 'DLL01';
GO
	
-- 2.  All products with price between 5 and 10 dollars
SELECT
	ProductName AS 'Product',
	ProductPrice AS 'Price ($)'
FROM
	Product
WHERE
	-- ProductPrice >=5 AND ProductPrice <=10;  -- alternative method
	ProductPrice BETWEEN 5 AND 10;
GO

-- 3.  Products made by DLL01 or BRS01 that cost more than 10 dollars
SELECT
	ProductName AS 'Product',
	ProductPrice AS 'Price ($)'
FROM
	Product
WHERE
	(VendorID = 'DLL01' OR VendorID = 'BRS01') AND ProductPrice > 10;
GO

-- 4.  Average price of all products
SELECT 
	AVG(ProductPrice) AS 'Average Price'
FROM
	Product;
GO

--  5.  Total customers 
SELECT
	COUNT(*) AS 'Total Customers'
FROM
	Customer;
GO

-- 6.  Total customer with emails
SELECT
	COUNT(CustEmail) AS 'Total Customers with Emails'
FROM
	Customer;
GO

-- 7.  Number of product types, min, max, and average product prices.
SELECT
	COUNT(ProductID) AS 'Types of Product',
	MIN(ProductPrice) AS 'Lowest Price',
	MAX(ProductPrice) AS 'Highest Price',
	AVG(ProductPrice) AS 'Average Price'
FROM
	Product;
GO

-- 8.  All products with Vendor name, product price, product name
SELECT
	v.VendorName AS 'Vendor',
	p.ProductName AS 'Product',
	p.ProductPrice AS 'Price ($)'
FROM
	Product p
JOIN
	Vendor v
ON
	p.VendorID = v.VendorID;
GO

-- 9.  Product name, vendor name, product price, and quantity for each item in order 20007
-- This query returns 50 for the qauntity of Raggedy Ann, marking schedule expect 5?  I assume this is a typo as all else is correct.
SELECT
	p.ProductName AS 'Product',
	v.VendorName AS 'Vendor',
	p.ProductPrice AS 'Price ($)',
	o.Quantity
FROM
	OrderItem o

JOIN
	Product p
ON
	o.ProductID = p.ProductID
JOIN
	Vendor v
ON
	p.VendorID = v.VendorID
WHERE
	o.OrderID = '20007';
GO

-- 10.  All customers who ordered RGAN01
SELECT
	CustName AS 'Customer',
	CustContact AS 'Contact person'
FROM 
	Customer
WHERE
	CustID IN 
	(
		SELECT CustID
		FROM OrderEntry
		WHERE OrderID IN
		(
			SELECT OrderID
			FROM OrderItem
			WHERE ProductID = 'RGAN01'
		)
	);
GO

-- 11.  Total orders placed by every customer as well as the customer's city

SELECT
	c.CustName AS 'Customer',
	c.CustCity AS 'City',
	(
		SELECT COUNT(*)
		FROM OrderEntry o
		WHERE o.CustID = c.CustID
	) AS 'Order Count'
FROM
	Customer c
ORDER BY
	c.CustName;
GO

-- 12.  Report on all customers in Nelson and Wellington and all Fun4All locations in alphabetical order by name then contact.

SELECT
	CustName AS 'Customer',
	CustContact AS 'Contact person',
	CustEmail AS 'Email'
FROM
	Customer
WHERE
	CustCity = 'Nelson' OR CustCity = 'Wellington'
UNION
SELECT
	CustName AS 'Customer',
	CustContact AS 'Contact person',
	CustEmail AS 'Email'
FROM
	Customer
WHERE
	CustName = 'Fun4All'
ORDER BY
	CustName, CustContact;
GO

-- 13.  View for all customers who have ordered product RGAN01.

CREATE OR ALTER VIEW vProductCustomer 
(

	Customer,
	Contactperson
)
AS
SELECT
	c.CustName,
	c.CustContact
FROM
	Customer c
JOIN
	OrderEntry e
ON	c.CustID = e.CustID
JOIN
	OrderItem i
ON e.OrderID = i.OrderID
WHERE
	i.ProductID = 'RGAN01';
GO

SELECT 
	*
FROM
	vProductCustomer;
GO

-- 14.  Using a view to format mailing list data

INSERT INTO Customer(CustID,CustName,CustAddress,CustCity,CustPhone,CustContact,CustEmail)
VALUES('1000000006','The Toy Emporium',null,null,'09-546-8552',null,null);
GO

CREATE OR ALTER VIEW vCustomerMailingLabel
(
	Customer,
	Address,
	City,
	Phone
)
AS
SELECT
	CustName,
	CustAddress,
	CustCity,
	CustPhone
FROM
	Customer
WHERE
	CustAddress IS NOT NULL AND CustCity IS NOT NULL;
GO

SELECT
	*
FROM
	vCustomerMailingLabel;
GO
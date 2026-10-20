-- Creating database
CREATE database Shop ;
USE Shop ; 

-- Creating table with customers, setting primary key
CREATE TABLE Customers (
    CustomerId int primary key auto_increment,
    FirstName varchar(50),
    LastName varchar(50),
    Age int,
    City varchar(50)
);

-- Populating Customers table with Customers
INSERT INTO Customers
        (FirstName, LastName, Age, City)
    VALUES 
        ('Alan', 'Mustermann', 37,'Berlin'),
        ('Max', 'Parker', 50, 'London'),
        ('Marina', 'Mueller', 28, 'Dortmund'),
        ('John','Doe', 45,'Bath'),
        ('Vincent', 'Dupont', 21, 'Paris'),
        ('Celine', 'Hermann', 19, 'Berlin'),
        ('Max', 'Motoya', 25, 'Madrid'),
        ('Peter','Robinson', 47, 'New York'),
        ('Max', 'Petterson', 48, 'Notthingham'),
        ('Maxime', 'Durand', 39, 'Nice'),
        ('Robert', 'Sponge', 20, 'Ocean'),
        ('Max', 'McColley', 29, 'Dublin');

-------------CHECKS-----------------

-- Selecting customers naming 'Max' and with a last name starting with 'M...' 
SELECT * 
FROM Customers
WHERE FirstName = 'Max'
AND LastName LIKE 'M%';

-- Updating a customer's age
UPDATE Customers
SET Age = 35 
WHERE FirstName = 'Max'
AND LastName = 'Petterson';

------------------------------------
-- Creating table with brands names
CREATE TABLE Brands (
    BrandId int primary key auto_increment,
    BrandName varchar(50)
);

-- Populating the table Products with products names and prices
INSERT INTO Brands
        (BrandName)
    VALUES
        ('Electra'),
        ('Haro'),
        ('Heller'),
        ('Pure Cycles'),
        ('Ritchey'),
        ('Strider'),
        ('Sun Bicycles'),
        ('Surly'),
        ('Trek');

------------------------------------

-- Creating table with products, setting primary key
CREATE TABLE Products (
    ProductId int primary key auto_increment,
    ProductName varchar(50)
);

-- Addind a column Prices to the Products table
ALTER TABLE Products 
ADD (
Price float,
BrandId int
);

-- Populating the table Products with products names and prices
INSERT INTO Products 
        (ProductName, Price, BrandId)
    VALUES
        ('Trek  - 2016', 379.99, 9),
        ('Ritchey Timberwolf Frameset - 2016', 749.99, 5),
        ('Surly Wednesday Frameset - 2016', 999.99, 8),
        ("Trek Domane SL Frameset Women's - 2018", 6499.99, 9),
        ('Trek Domane SL Frameset - 2018', 6499.99, 9),
        ('Surly Straggler 650b - 2018', 1549, 8),
        ('Electra Townie Original 21D - 2018', 269.99, 1),
        ('Haro Downtown 16 - 2017', 329.99, 2),
        ("Sun Bicycles Lil Kitt'n - 2017", 109.99, 7),
        ('Sun Bicycles Biscayne Tandem CB - 2017', 647.99, 7),
        ('Pure Cycles Vine 8-Speed - 2016', 429, 4);

------------------------------------

-- Creating Orders table, setting primary key
CREATE TABLE Orders(
    OrderId int primary key auto_increment,
    OrderDate Datetime,
    CustomerId int,
    ProductId int
);

-- Setting relations between tables (foreign keys)
ALTER TABLE Orders
ADD FOREIGN KEY (CustomerId) references Customers(CustomerId);

ALTER TABLE Orders
ADD FOREIGN KEY (ProductId) references Products(ProductId);


ALTER TABLE Products
ADD FOREIGN KEY (BrandId) references Brands(BrandId);

-- Populating Orderse with actual date and all Id's (for simplification purpose the number of products per order is limited to 1 )
INSERT INTO Orders
        (OrderDate, CustomerId, ProductId)
    VALUES
    (current_timestamp(), 3, 3),
    (current_timestamp(), 1, 1),
    (current_timestamp(), 1, 2),
    (current_timestamp(), 5, 3),
    (current_timestamp(), 6, 9),
    (current_timestamp(), 1, 150), /*this insert does not work because there is no ProductId = 150 in the Products table*/
    (current_timestamp(), 8, 4),
    (current_timestamp(), 7, 5),
    (current_timestamp(), 2, 3);

-------------CHECKS-----------------
-- Showing orders with Customers, Product and Brand Names
SELECT O.OrderId, O.OrderDate, P.ProductName, P.Price, B.BrandName
FROM Orders O
LEFT JOIN Products P on P.ProductId = O.ProductId
LEFT JOIN Brands B on B.BrandId = P.BrandId ;

-- Restricting the choice to the Orders below EUR500
SELECT O.OrderId, O.OrderDate, P.ProductName, P.Price, B.BrandName
FROM Orders O
LEFT JOIN Products P on P.ProductId = O.ProductId
LEFT JOIN Brands B on B.BrandId = P.BrandId 
WHERE P.Price <= 500;

-- Count the number of Orders per Brands
SELECT B.BrandName, count(*)
FROM Orders O
LEFT JOIN Products P on P.ProductId = O.ProductId
LEFT JOIN Brands B on B.BrandId = P.BrandId 
GROUP BY B.BrandName;

-----------FURTHER ANALYSIS--------------
-- Total overall spent
SELECT CAST(SUM(P.Price) AS DECIMAL (10,2)) AS Total
FROM Orders O
INNER JOIN Products P on O.ProductId = P.ProductId
INNER JOIN Customers C on O.CustomerId = C.CustomerId

-- Amount spent per customers
SELECT C.LastName, C.FirstName, CAST(SUM(P.Price) AS DECIMAL (10,2)) AS Total
FROM Orders O
INNER JOIN Products P on O.ProductId = P.ProductId
INNER JOIN Customers C on O.CustomerId = C.CustomerId
GROUP BY C.LastName, C.FirstName
ORDER BY Total DESC ;

-----------------------------------
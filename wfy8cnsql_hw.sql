-- Part 1
-- world
-- #1
SELECT * FROM `country` WHERE country.Continent = 'South America';
-- #2
SELECT Name, Population from country WHERE country.Name = 'Germany';
-- #3
SELECT * FROM city WHERE city.CountryCode = 'JPN';
-- #4
SELECT * FROM country WHERE country.Continent = 'Africa' ORDER BY country.Population DESC LIMIT 3;
-- #5
SELECT Name, LifeExpectancy FROM country WHERE country.Population<5000000 AND country.Population>1000000;
-- #6
SELECT name FROM country 
JOIN countrylanguage ON country.code = countrylanguage.CountryCode
WHERE countrylanguage.Language = "French" AND countrylanguage.IsOfficial = "T";

-- chinook
-- #7
SELECT title FROM Album
JOIN Artist ON Album.ArtistId = Artist.ArtistId
WHERE Artist.Name = 'AC/DC';
-- #8
SELECT FirstName, LastName, Email from Customer WHERE Customer.Country = 'Brazil';
-- #9
SELECT * from Playlist;
-- #10
SELECT COUNT(*) FROM Track
JOIN Genre ON Genre.GenreId = Track.GenreId
WHERE Genre.Name = 'Rock';
-- #11
SELECT * FROM Employee WHERE Employee.ReportsTo = 2;
-- #12
SELECT CustomerId, SUM(Total) FROM Invoice GROUP BY Invoice.CustomerId;

-- Part 2
-- Create Tables
CREATE TABLE employees(
	EmployeeId INT PRIMARY KEY,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    Salary INT,
    Email VARCHAR(40)
);
CREATE TABLE products(
	ProductId INT PRIMARY KEY,
    Name VARCHAR(50),
    Price INT
);
CREATE TABLE customers(
	CustomerId INT PRIMARY KEY,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    Email VARCHAR(40)
);
CREATE TABLE orders(
	OrderId INT PRIMARY KEY,
    ProductId INT,
    CustomerId INT,
    FOREIGN KEY (ProductId) REFERENCES products(ProductId),
    FOREIGN KEY (CustomerId) REFERENCES customers(CustomerId)
);

-- Add Data
INSERT INTO employees(EmployeeId,FirstName,LastName,Salary,Email) VALUES
(1,'John','Smith',1000000,'a@a.com'),
(2,'Jon','Smith',100,'b@a.com'),
(3,'Jack','Smith',1000,'c@a.com'),
(4,'James','Smith',10000,'d@a.com'),
(5,'John','John',1,'e@a.com');
INSERT INTO products(ProductId,Name,Price) VALUES
(1,'Apple',100),
(2,'Banana',200),
(3,'Cherry',300),
(4,'Date',400),
(5,'Eggplant',500);
INSERT INTO customers(CustomerId,FirstName,LastName,Email) VALUES
(1,'Jeff','Smith','f@a.com'),
(2,'Smith','Jeff','g@a.com'),
(3,'John','Smith','a@a.com'),
(4,'Justin','Smith','i@a.com'),
(5,'Josh','Smith','j@a.com');
INSERT INTO orders(OrderId,ProductId,CustomerId) VALUES
(1,1,1),
(2,2,3),
(3,5,1),
(4,1,4),
(5,1,1);

-- Query Data
-- Get employees with a salary over 100000
SELECT * FROM employees WHERE employees.Salary > 100000;
-- Get a list of Jeff Smith's orders
SELECT products.Name FROM orders
JOIN customers ON customers.CustomerId = orders.CustomerId
JOIN products ON products.ProductId = orders.ProductId
WHERE customers.FirstName = 'Jeff' and customers.LastName = 'Smith';
-- Get the total money Jeff has spent
SELECT customers.FirstName, customers.LastName, SUM(products.Price) from orders
JOIN products ON products.ProductId = orders.ProductId
JOIN customers ON customers.CustomerId = orders.CustomerId
WHERE customers.FirstName = 'Jeff' and customers.LastName = 'Smith';

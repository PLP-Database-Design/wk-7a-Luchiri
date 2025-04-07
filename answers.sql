-- Question 1: Achieving 1NF
--Creating a new table to represent the ProductDetail in 1NF
CREATE TABLE ProductDetail_1NF(
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

--Inserting individual product entries into the new table
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT OrderID, CustomerName, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',' -1)) AS Product 
FROM ProductDetail 
JOIN (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6) n 
WHERE n.n <= (LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) + 1);


--Question 2: Achieving 2NF
--Creating the Orders table to store OrderID and CustomerName
CREATE TABLE Orders(
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

--Creating OrderItems table to store OrderID, Product, and Quantity
CREATE TABLE OrderItems(
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

--Inserting data into the OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;





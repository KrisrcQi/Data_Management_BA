# MGT5492 Data Management and Engineering 26/27
## Lab 4: Aggregation & Computation
## GTA: Kris Ruochen Qi （Ruochen.Qi@glasgow.ac.uk）


# Section 1: Renew Table of Sales
##======================================================##
USE retail; 

-- DROP TABLE sales; # in case your table is mess already, creating a new one. 

CREATE TABLE sales (
	sale_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_name VARCHAR (50),
    prod_name VARCHAR (50),
    qty INT,
    unit_price DECIMAL (10,2),
    sale_date DATE
);

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

INSERT INTO sales (cust_name, prod_name, qty, unit_price, sale_date) VALUES
('Kris Qi', 'Laptop', 2, 800, '2025-09-20'),
('Kris Qi', 'Phone', 1, 500, '2025-09-20'),
('Alex Chen', 'Phone', 1, 500, '2025-09-21'),
('Noah Kim', 'Shoes', 3, 132, '2026-06-01');

SELECT * FROM sales;


# Section 2: Aggregation
##======================================================##

# Query 1 – Total Revenue per Customer: 
SELECT 
	cust_name AS Customers, 
    SUM(qty * unit_price) AS Total_Revenue
FROM sales
GROUP BY cust_name
ORDER BY Total_Revenue;

# Query 2 - Average Order Value Using a Subquery:
SELECT 
	AVG(Total_Revenue) AS AVG_Order_Value
FROM(
    SELECT 
		sale_id,
		(qty * unit_price) AS Total_Revenue
	FROM sales
)AS t;

# Query 3 - Total Quantity Solde per Product
SELECT
	prod_name AS Products,
    SUM(qty) AS Total_units
FROM sales
GROUP BY prod_name;

# Query 4 - Total Revenue per Product
SELECT 
	prod_name, 
    SUM(qty * unit_price) AS total_revenue
FROM sales
GROUP BY prod_name
ORDER BY total_revenue DESC;

# Query 5 - Number of Transactions per Customer:
SELECT 
	cust_name, 
    COUNT(sale_id) AS num_sales
FROM sales
GROUP BY cust_name
ORDER BY num_sales DESC;


# Query 6 - Top 2 Products with Revenue Above £500:
SELECT 
	prod_name, 
    SUM(qty * unit_price) AS revenue
FROM sales
GROUP BY prod_name
HAVING revenue > 500
ORDER BY revenue DESC LIMIT 2;

# Query 7 - Average Selling Price per Product:
SELECT 
	prod_name, 
    AVG(unit_price) AS avg_price
FROM sales
GROUP BY prod_name
ORDER BY avg_price DESC;

# Query 8 - Highest and Lowest Sale Value:
SELECT 
    MAX(qty * unit_price) AS highest_sale,
    MIN(qty * unit_price) AS lowest_sale
FROM sales;


# Section 3: JOIN Practise (Need a purchase table to do the following tasks)
##======================================================##
## Creating a purchases table:
CREATE TABLE IF NOT EXISTS purchases (
	purchase_id INT PRIMARY KEY,
	cust_id INT NOT NULL,
	prod_id INT NOT NULL,
	purchase_date DATE NOT NULL,
	qty INT NOT NULL,
	unit_price DECIMAL(10,2) NOT NULL
);

SELECT * FROM products;

INSERT INTO purchases (purchase_id, cust_id, prod_id, purchase_date, qty,
unit_price) VALUES
(1, 1, 1, '2025-10-20', 1, 800.00), 
(2, 1, 3, '2025-10-20', 2, 132.00), 
(3, 1, 4, '2025-10-22', 1, 22000.00), 
(4, 2, 2, '2025-10-21', 1, 500.00); 


## 3.1. Which customers made the purchases? 
SELECT 
    c.name AS Customers,
    o.order_date AS Date,
    oi.prod_id AS Products,
    oi.qty AS Quantity
FROM customers c
JOIN orders o ON o.cust_id = c.cust_id
JOIN order_items oi ON oi.order_id = o.order_id;
    
 
## 3.2. What was actually sold (who bought what, when, and for how much)? 
-- Hint: INNER JOIN
SELECT 
	pu.purchase_id, pu.purchase_date,
	c.name AS customer, p.name AS product,
	pu.qty, pu.unit_price, pu.qty * pu.unit_price AS line_total
FROM purchases pu
JOIN customers c ON c.cust_id = pu.cust_id
JOIN products  p ON p.prod_id = pu.prod_id
ORDER BY pu.purchase_id;


## 3.3. Show all customers and their latest purchase date (include never-bought). 
-- Hint: LEFT JOIN from customers
SELECT c.cust_id, c.name,
	MAX(pu.purchase_date) AS last_purchase
FROM customers c
LEFT JOIN purchases pu ON pu.cust_id = c.cust_id
GROUP BY c.cust_id, c.name
ORDER BY c.cust_id;


## 3.4. Show all products and when each first appeared in a purchase. Identify unsold products. 
-- Hint: LEFT JOIN from product
SELECT p.prod_id, p.name AS product,
	MIN(pu.purchase_id) AS first_purchase_id
FROM purchases pu
RIGHT JOIN products p ON p.prod_id = pu.prod_id
GROUP BY p.prod_id, p.name
ORDER BY p.prod_id;



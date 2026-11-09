# MGT5492 Data Management and Engineering 26/27
## Lab 5: Basic Security
## GTA: Kris Ruochen Qi （Ruochen.Qi@glasgow.ac.uk）


# Section 1: Checking number of customers, orders, and items
##======================================================##
USE retail; 

SELECT COUNT(*) AS n_customer FROM customers;
SELECT COUNT(*) AS n_order FROM orders;
SELECT COUNT(*) AS n_item FROM order_items;


# Section 2: Recap of Business analysis
##======================================================##
-- Q1: Monthly revenue trend:
SELECT 
	DATE_FORMAT (o.order_date, '%Y-%m') as Month,
    SUM(oi.qty * oi.unit_price) AS Revenue
FROM orders o
JOIN order_items oi 
ON o.order_id = oi.order_id
GROUP BY Month
ORDER BY Month;

# Why it's only SEP order revenue shown in the return. Where is Revenue for June? 
SELECT * FROM order_items;
SELECT * FROM orders;

# Write 1–2 sentences on which months are higher/lower and any patterns you see.

-- Q2: All customers' total spent:
SELECT AVG (total_spent) AS AVERAGE
FROM (
	SELECT 
		c.name,
		SUM(oi.qty * oi.unit_price) AS Total_spent
	FROM customers c
	LEFT JOIN orders o ON o.cust_id = c.cust_id
	LEFT JOIN order_items oi ON oi.order_id = o.order_id
	GROUP BY c.name
	ORDER BY Total_spent DESC
) AS t;

# Write 1–2 sentences: who are your top customers and what’s the gap between top and median?


# Section 3: Security Basics
##======================================================##
use retail;
-- 1) Create a read-only analyst
CREATE USER IF NOT EXISTS 'analyst'@'localhost' IDENTIFIED BY 'Password123!';

-- 2) Grant read-only across a schema (retail)
GRANT SELECT ON retail.* TO 'analyst'@'localhost'; # grant all SELECT access to analyst
# or:
GRANT SELECT ON retail.customers TO 'analyst'@'localhost'; # grant only customers table SELECT access to analyst
	
SHOW GRANTS FOR 'analyst'@'localhost';

-- 3) Mask emails via a view
SELECT email from customers;

CREATE OR REPLACE VIEW retail.v_customers_masked AS
SELECT 
	cust_id,
    name,
    CONCAT(
		LEFT(email, 1), 
        '***@', 
        SUBSTRING_INDEX(email, '@', -1)
	) AS email_masked
FROM retail.customers;

SELECT * FROM v_customers_masked;

-- 4) Limit access to the masked view

REVOKE SELECT ON retail.* FROM 'analyst'@'localhost'; # depends what grant analyst hold now, double checking grant for analyst
GRANT SELECT ON retail.v_customers_masked TO 'analyst'@'localhost';

SHOW GRANTS FOR 'analyst'@'localhost';

-- 5) Safe drop
DROP TABLE IF EXISTS retail.tmp_stage_products;
DROP DATABASE IF EXISTS retail_1; # if there is a new db created by the 'NewDB_Creation'



 

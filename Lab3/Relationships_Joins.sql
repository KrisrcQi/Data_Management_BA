# MGT5492 Data Management and Engineering 26/27
## Lab 3: Relationships & Joins
## GTA: Kris Ruochen Qi （Ruochen.Qi@glasgow.ac.uk）


# Section 1: Create Tables with Relationships
##======================================================##
USE retail; 

CREATE TABLE orders(
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_id INT,
    order_date DATE,
    status VARCHAR (50),
    FOREIGN KEY (cust_id) REFERENCES customer (cust_id) # define relationship between customer table and order table by cust_id
);

CREATE TABLE order_items (
	item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    prod_id INT,
    qty INT,
    unit_price DECIMAL (10,2) NULL,
    FOREIGN KEY (order_id) REFERENCES orders (order_id) #define relationship between order_item table and order table by order_id 
);

INSERT INTO orders (cust_id, order_date, status) VALUES
(1,'2025-09-20','Shipped'),
(2,'2025-09-21','Delivered');

INSERT INTO order_items (order_id, prod_id, qty, unit_price) VALUES
(1,1,2,800),
(1,2,1,500),
(2,3,3,120);

SELECT * FROM orders;
SELECT * FROM order_items;
##======================================================##
# In case there is no suppliers table created by last section, using the code below:
-- CREATE TABLE supplier (
--     sup_id INT PRIMARY KEY AUTO_INCREMENT,
--     supplier_name VARCHAR(50),
--     country VARCHAR(30)
-- );

-- INSERT INTO supplier (supplier_name, country) VALUES
-- ('GTech Supplies', 'USA'),
-- ('Sakura Trading', 'Japan'),
-- ('BMW Manufacturing', 'Germany');

-- SELECT * FROM supplier;
##======================================================##


# Section 2: Adding relationship 
##======================================================##
### Alter table names in the same rule
ALTER TABLE product_catalog RENAME TO products;
ALTER TABLE supplier RENAME TO suppliers;
ALTER TABLE customer RENAME TO customers;

### Adding relationship
ALTER TABLE products ADD COLUMN sup_id INT; # in case there is no sup_id in products table

ALTER TABLE products 
ADD CONSTRAINT fk_suppliers_products 
FOREIGN KEY (sup_id) REFERENCES suppliers(sup_id); # Establishes a one-to-many relationship between suppliers and products.


# Section 3: JOIN: inner, left, right
##======================================================##

### To retrieve order ID, customer name, order date, and order status 
-- Step_1: looking for columns location of tables: orders and customer tables 	
-- Step_2: consider join function types: no conditions, try JOIN function:

SELECT o.order_id, c.name, o.order_date, o.status
FROM orders o 
JOIN customer c ON c.cust_id = o.cust_id;

### Try INNER JOIN: 
SELECT o.order_id, c.name, o.order_date, o.status
FROM orders o 
INNER JOIN customer c ON c.cust_id = o.cust_id;


### To retrieve products name and suppliers name, call products name as "Product":
SELECT * FROM products;
SELECT * FROM suppliers;

### Try JOIN:
SELECT p.name AS Product, s.supplier_name
FROM products p
JOIN suppliers s ON s.sup_id = p.sup_id;

### Try LEFT JOIN:
SELECT p.name AS Product, s.supplier_name
FROM products p
LEFT JOIN suppliers s ON s.sup_id = p.sup_id;

### Try RIGHT JOIN:
SELECT p.name AS Product, s.supplier_name
FROM products p
RIGHT JOIN suppliers s ON s.sup_id = p.sup_id;

### To retrieve order id, customer name, order iterm quantity, order item's unit price: 
SELECT o.order_id, c.name, oi.qty, oi.unit_price
FROM orders o 
JOIN customers c ON c.cust_id = o.cust_id
JOIN order_items oi ON oi.order_id = o.order_id;


-- In-class tasks
-- Task 1 – Create and Link
-- Add a sup_id column to products_v2 if not already present.
-- Establish a foreign key linking it to suppliers(sup_id).
-- Update a few products with valid sup_id values.
SELECT * FROM products;
UPDATE products 
SET sup_id = 1 
WHERE product_id = 1;

UPDATE products 
SET sup_id = 1 
WHERE product_id = 2;

UPDATE products 
SET sup_id = 2 
WHERE product_id = 3;

UPDATE products 
SET sup_id = 2 
WHERE product_id = 4;


-- Task 2 – INNER JOIN
-- Display all products with their supplier names.
SELECT p.name AS Products,
       s.supplier_name AS Suppliers
FROM products p
INNER JOIN suppliers s ON p.sup_id = s.sup_id;

-- Show supplier names and the number of products they provide (GROUP BY supplier_name).
SELECT s.supplier_name AS Suppliers,
       COUNT(*) AS Product_count
FROM suppliers s
INNER JOIN products p ON s.sup_id = p.sup_id
GROUP BY Suppliers
ORDER BY Product_count DESC;

-- List suppliers who supply products priced above £200.
SELECT DISTINCT s.name AS Suppliers
FROM suppliers s
INNER JOIN products p ON s.sup_id = p.sup_id
WHERE p.price > 200;


-- Task 3 – LEFT JOIN
-- Retrieve all products, including those without any supplier assigned.
SELECT p.name AS Products,
       s.name AS Suppliers
FROM products p
LEFT JOIN suppliers s ON p.sup_id = s.sup_id;

-- Display all suppliers, and show product names (if any) they provide — use LEFT JOIN in the opposite direction.
SELECT s.name AS Suppliers,
       p.name AS Products
FROM suppliers s
LEFT JOIN products p ON s.sup_id = p.sup_id;


-- Task 4 – Multi-Table JOIN
-- Create a join across orders, order_items, and products_v2 showing:
	-- order_id, product_name, quantity, and total value (qty * unit_price).
	-- Add a condition to show only orders with status is 'Shipped' and 'Returned'.
	-- Sort results by total value (descending).
    
SELECT o.order_id,
       p.name AS Products,
       oi.qty AS Quantity,
       oi.qty * oi.unit_price AS Total_value
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.prod_id = p.pro_id
WHERE o.status IN ('Shipped', 'Returned')
ORDER BY total_value DESC;


-- Task 5 – RIGHT JOIN / FULL JOIN (Conceptual)
-- These may not be directly supported in MySQL, but explain conceptually or simulate them:
	-- RIGHT JOIN → reverse of LEFT JOIN.
SELECT s.name AS Suppliers,
       p.name AS Products
FROM products p
RIGHT JOIN suppliers s ON p.sup_id = s.sup_id;
	
	-- FULL OUTER JOIN → union of LEFT and RIGHT JOIN results.
SELECT p.name AS Products,
       s.supplier_name AS Suppliers
FROM products p
LEFT JOIN suppliers s ON p.sup_id = s.sup_id

UNION ALL

SELECT p.name AS Products,
       s.supplier_name AS Suppliers
FROM products p
RIGHT JOIN suppliers s ON p.sup_id = s.sup_id;
# WHERE p.sup_id IS NULL;




# MGT5492 Data Management and Engineering 26/27

## Lab 2: Filter, Update and Alter Table
## GTA: Kris Ruochen Qi （Ruochen.Qi@glasgow.ac.uk）


# section 1: Table Creation for 'products'
##======================================================##
USE retail; # making sure to use the correct database

## 1.1) Create Table and Insert Rows
CREATE TABLE products (
	pro_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR (50),
    cat VARCHAR (50),
    price DECIMAL (10,2),
    brand VARCHAR (50) NULL # allow brand is null
);

INSERT INTO products (name, cat, price, brand) VALUES
('Laptop', 'Electronics', 800, 'Dell'),
('Phone', 'Electronics', 500, 'Apple'),
('Shoes', 'Fashion', 120, 'Nike'),
('Watch', 'Fashion', 20000, NULL), 
('Headphones', 'Electronics', 150, 'Sonic');

-- SELECT * FROM products;


# section 2: Read, Filter, Sort, Paginate data
##======================================================##
SELECT * FROM products; 
SELECT name, price FROM products ORDER BY price DESC; # DESCENDING order, Ascending is default

SELECT name, price FROM products WHERE cat = 'Electronics'; 

SELECT * FROM products WHERE cat IN ('Electronics', 'Fashion'); 

SELECT * FROM products WHERE name LIKE 'W%'; # fuzzy search where name starts with 'w'

SELECT * FROM products WHERE brand IS NULL;

SELECT * FROM products ORDER BY price DESC LIMIT 3; # top 3 price 


# section 3: Update and Delete data
##======================================================##
UPDATE products SET price = price*1.1 WHERE cat = 'Fashion';
SELECT * FROM products WHERE cat = 'FASHION';

UPDATE products SET brand = 'AP' WHERE name = 'Watch' AND brand IS NULL;
SELECT * FROM products WHERE name = 'Watch';

DELETE FROM products WHERE name = 'Headphones' AND price < 160;
SELECT * FROM products WHERE name = 'Headphones'; # return all null cuz the only one headphone's price is below 160, which is deleted


# section 4: Schema Changes 
##======================================================##
ALTER TABLE products ADD COLUMN stock INT DEFAULT 0;

ALTER TABLE products MODIFY COLUMN name VARCHAR (80) NOT NULL; 

ALTER TABLE products RENAME COLUMN cat TO category;

RENAME TABLE products TO product_catalog;

ALTER TABLE product_catalog DROP COLUMN brand;

DROP TABLE IF EXISTS old_products_backup; 


# section 5: In-class tasks
##======================================================##

## Task 1 - Create a supplier table
### Create a new table supplier with columns: 
	-- sup_id (INT, PK, auto_increment), 
	-- supplier_name (VARCHAR(50)), 
	-- country (VARCHAR(30)).
    
### Insert at least three suppliers from different countries.


## Task 2 - Filtering 
### Display all products where price > 200.

### Retrieve name and price of Fashion items sorted by price ascending.

### Show all products where category is either ‘Electronics’ or ‘Fashion’.

### Find products with names starting with ‘P’ using LIKE.

### Display all products where brand information is missing.


## Task 3 – Update & Delete
### Increase price of all Electronics items by 5%.

### Set stock = 10 for all products with price less than 300.

### Delete any product priced below 100.


## Task 4 – Schema Changes
### Add a new column discount DECIMAL (4,2) with default = 0.

### Rename category column to product_category.

### Remove the brand column if it's null.

### Rename the table product_catalog to products_v2.


## Task 5 – Aggregation & Pagination (Optional) 
### Count total number of products per category (GROUP BY). 
SELECT category, COUNT(category) AS number_of_category FROM product_catalog GROUP BY category;

### Find the average price of all Electronics products (AVERAGE).
SELECT category, AVG(price) AS avg_price FROM product_catalog GROUP BY category;

### Display the top 2 most expensive products (DESC sort with LIMIT).

### Create a query to list all products with price greater than the average price of all products.










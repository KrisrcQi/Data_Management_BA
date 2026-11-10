# Section 1: Creation of database
CREATE DATABASE retail_1;
USE retail_1;


# Section 2: Customer table 
##======================================================##
CREATE TABLE customers(
	cust_id INT auto_increment PRIMARY KEY,
    name VARCHAR (50),
    email VARCHAR (100),
    city VARCHAR (50),
    region VARCHAR (50)
);

INSERT INTO customers (name, email, city, region) VALUES
('Kris Qi', 'KrisQi@ucla.edu', 'Los Angeles', 'USA'),
('Alex Chen', 'alex.chen@example.com', 'San Francisco', 'USA'),
('Emma Wilson', 'emma.wilson@example.com', 'London', 'UK'),
('Liam Patel', 'liam.patel@example.com', 'Toronto', 'Canada'),
('Sofia Garcia', 'sofia.garcia@example.com', 'Madrid', 'Spain'),
('Noah Kim', 'noah.kim@example.com', 'Seoul', 'South Korea');

# Section 3: Product table:
##======================================================##
CREATE TABLE products (
	prod_id INT AUTO_INCREMENT PRIMARY KEY,
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


# Section 4: order and order_items table:
##======================================================##
CREATE TABLE orders(
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_id INT,
    order_date DATE,
    status VARCHAR (50),
    FOREIGN KEY (cust_id) REFERENCES customers (cust_id) # define relationship between customer table and order table by cust_id
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
(2,'2025-09-21','Delivered'),
(3,'2026-06-01', 'Returned');

INSERT INTO order_items (order_id, prod_id, qty, unit_price) VALUES
(1,1,2,800),
(1,2,1,500),
(2,3,3,120);

# Section 5: Suppliers table:
##======================================================##
CREATE TABLE suppliers (
    sup_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(50),
    country VARCHAR(30)
);

INSERT INTO suppliers (supplier_name, country) VALUES
('GTech Supplies', 'USA'),
('Sakura Trading', 'Japan'),
('BMW Manufacturing', 'Germany');

### Adding relationship
ALTER TABLE products ADD COLUMN sup_id INT; # in case there is no sup_id in products table

ALTER TABLE products 
ADD CONSTRAINT fk_suppliers_products 
FOREIGN KEY (sup_id) REFERENCES suppliers(sup_id); # Establishes a one-to-many relationship between suppliers and products.


# Section 6: Sales table:
##======================================================##
CREATE TABLE sales (
	sale_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_name VARCHAR (50),
    prod_name VARCHAR (50),
    qty INT,
    unit_price DECIMAL (10,2),
    sale_date DATE
);

INSERT INTO sales (cust_name, prod_name, qty, unit_price, sale_date) VALUES
("Kris Qi", "Laptop", 2, 800, "2025-09-20"),
("Kris Qi", "Phone", 1, 500, "2025-09-20"),
("Alex Chen", "Shoes", 3, 132, "2025-09-21"),
("Noah Kim", null, null, null, "2026-06-01");


# Section 7: Table checking:
##======================================================##
-- SELECT * FROM customers;
-- SELECT * FROM orders;
-- SELECT * FROM order_items;
-- SELECT * FROM products;
-- SELECT * FROM suppliers;
-- SELECT * FROM sales;


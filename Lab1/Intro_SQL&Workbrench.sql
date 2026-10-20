# MGT5492 Data Management and Engineering 26/27
## Lab 1: SQL, Workbench and Database Creation
## GTA: Kris Ruochen Qi


# section 1: Database Creation
##======================================================##
CREATE DATABASE retail;
USE retail;


# section 2: Customer table Creation
##======================================================##
CREATE TABLE customer(
	cust_id INT auto_increment PRIMARY KEY,
    name VARCHAR (50),
    email VARCHAR (100),
    city VARCHAR (50),
    region VARCHAR (50)
);


# section 3: Data generation
##======================================================##
INSERT INTO customer (name) VALUES ('Kris');
SELECT * FROM customer;

DELETE FROM customer WHERE name = "Kris";
SELECT * FROM customer;

INSERT INTO customer (name, email, city, region) VALUES
('Kris Qi', 'KrisQi@ucla.edu', 'Los Angeles', 'USA'),
('Your name', 'Email of you', 'Your born city', 'Place you from');
SELECT * FROM customer;


# section 4: Retrieve data
##======================================================##
SELECT * FROM customer;
SELECT name FROM customer;
SELECT * FROM customer ORDER BY cust_id;



#section 5: in-class tasks
##======================================================##
### 1. Insert another 5 rows for table of customers:
INSERT INTO customer (name, email, city, region) VALUES
('Alex Chen', 'alex.chen@example.com', 'San Francisco', 'USA'),
('Emma Wilson', 'emma.wilson@example.com', 'London', 'UK'),
('Liam Patel', 'liam.patel@example.com', 'Toronto', 'Canada'),
('Sofia Garcia', 'sofia.garcia@example.com', 'Madrid', 'Spain'),
('Noah Kim', 'noah.kim@example.com', 'Seoul', 'South Korea');

### 2. Retreive data of city and region, sorting by city descendingly

SELECT city, region FROM customer order by city DESC;

### 3. Create a table, named as sales 
-- (Hint, there is some relationship between tables of sales and customer).

CREATE TABLE sales (
	order_id INT auto_increment primary key,
    cust_name VARCHAR (50),
    order_name VARCHAR (50),
    price DECIMAL (50,2),
    number INT,
    total DECIMAL (50,2)
);

INSERT INTO sales(cust_name, order_name, price, number, total)
VALUES('Kris', 'Headphone', '500.20', '1', '500.20');

SELECT * FROM sales;


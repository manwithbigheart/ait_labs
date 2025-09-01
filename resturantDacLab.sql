CREATE DATABASE resturant_daclab;

USE resturant_daclab;

CREATE TABLE resturant(
	rest_id INT PRIMARY KEY,
	rest_Name varchar (100) NOT NULL,
	rest_Location VARCHAR (50)
);*

CREATE TABLE orders (
	order_id INT PRIMARY KEY,
	rest_id int,
	customer_name VARCHAR (100) NOT NULL,
    amount DECIMAL(8,2) NOT NULL,
    order_date DATE,
    FOREIGN KEY (rest_id) REFERENCES resturant (rest_id)
);


INSERT INTO resturant 

VALUES
		(1,'THE GREAT SAGAR', 'AURANGABAD'),
        (2,'BOMBAY RESTURANT', 'MUMBAI'),
        (3,'ESPLANDE', 'NASHIK'),
        (4,'SUVIDHA','PUNE'),
        (5,'NAIIVEDYA', 'HYDERABAD'),
        (6,'RAJBHOG', 'NOIDA');
        
	
    
INSERT INTO orders 
(order_id, rest_id, customer_name, amount, order_date) 
VALUES
    (101, 1, 'Amit Sharma', 850.50, '2025-08-01'),
    (102, 2, 'Sneha Patil', 1200.00, '2025-08-02'),
    (103, 3, 'Rahul Verma', 675.75, '2025-08-02'),
    (104, 1, 'Pooja Singh', 940.00, '2025-08-03'),
    (105, 4, 'Mohit Gupta', 1500.25, '2025-08-04'),
    (106, 5, 'Kiran Rao', 1120.40, '2025-08-04'),
    (107, 2, 'Deepak Yadav', 980.90, '2025-08-05'),
    (108, 6, 'Anjali Nair', 1350.00, '2025-08-06'),
    (109, 3, 'Suresh Kumar', 775.30, '2025-08-06'),
    (110, 4, 'Neha Mehta', 660.00, '2025-08-07'),
    (111, 5, 'Vikas Joshi', 1450.00, '2025-08-07'),
    (112, 1, 'Rohan Desai', 870.00, '2025-08-08'),
    (113, 6, 'Priya Kapoor', 990.50, '2025-08-09'),
    (114, 2, 'Aditya Pandey', 1100.75, '2025-08-09'),
    (115, 3, 'Manisha Kulkarni', 1300.20, '2025-08-10');

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. LIST ALL ORDERS/Resturant Name   WIH CUSTOMER NAME ?


SELECT  r.rest_Name, o.customer_name
FROM orders o
JOIN resturant r ON o.rest_id = r.rest_id;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. SHOW RESTURANT NAME WITH THEIR ORDER AMOUNT ?

select r.rest_Name, o.amount
from resturant r
join orders o on r.rest_id;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.  MUCH BETTER You get in sequence

SELECT r.rest_Name, o.amount
FROM resturant r
JOIN orders o ON r.rest_id = o.rest_id;
 
 
 -- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 3. Find all orders/Resturant placed at restaurants in 'Mumbai'

select o.order_id, r.rest_Name , r.rest_Location
from  orders o
JOIN resturant r ON o.rest_id = r.rest_id
where r.rest_Location = 'MUMBAI';

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 4. Get Toatl sales (sum of amount ) for each resturant ?

select r.rest_Name, sum(o.amount) AS total_amount
from resturant r 
join orders o on o.rest_id= r.rest_id
group by r.rest_Name;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------

-- 5. Find Resturant that have no orders (LEFT JOIN)

SELECT r.rest_Name
FROM resturant r
LEFT JOIN orders o ON r.rest_id = o.rest_id
WHERE o.order_id IS NULL;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------

-- 6. List customers and restaurant names (INNER JOIN)

SELECT o.customer_name, r.rest_Name
FROM orders o
INNER JOIN resturant r ON o.rest_id = r.rest_id;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------

-- 7. Show restaurant and order details (RIGHT JOIN)

SELECT r.rest_Name, o.order_id, o.customer_name, o.amount, o.order_date
FROM orders o
RIGHT JOIN resturant r ON o.rest_id = r.rest_id;


-- -----------------------------------------------------------------------------------------------------------------------------------------------------


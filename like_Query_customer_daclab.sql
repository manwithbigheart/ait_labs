CREATE DATABASE like_customer_daclab;
USE like_customer_daclab;

-- -----------------------------------------------------------------------------------
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    city VARCHAR(30),
    phone VARCHAR(15)
);

-- -----------------------------------------------------------------------------------
INSERT INTO customer (customer_id, name, email, city, phone) VALUES
(1, 'Amit Sharma', 'amit@gmail.com', 'Delhi', '9876543210'),
(2, 'Sneha Patil', 'sneha@yahoo.com', 'Mumbai', '9823456789'),
(3, 'Rahul Verma', 'rahul@gmail.com', 'Nagpur', '9765432109'),
(4, 'Pooja Singh', 'pooja@hotmail.com', 'Kanpur', '9988776655'),
(5, 'Ankit Rao', 'ankit@gmail.com', 'Bangalore', '9123456780'),
(6, 'Rohan Das', 'rohan@gmail.com', 'Jaipur', '9812345678'),
(7, 'Manish Gupta', 'manish@yahoo.com', 'Chennai', '9955443322'),
(8, 'Deepa Nair', 'deepa@gmail.com', 'Hyderabad', '9876501234'),
(9, 'Suresh Kumar', 'suresh@gmail.com', 'Aurangabad', '9898989898'),
(10, 'Neha Mehta', 'neha@rediffmail.com', 'Pune', '9000012345');

-- -----------------------------------------------------------------------------------
-- 1. Write a query to display customers whose name starts with 'A'.

SELECT * FROM customer
WHERE name LIKE 'A%';

-- -----------------------------------------------------------------------------------
-- 2. Write a query to display customers whose city ends with 'pur' (like Jaipur, Nagpur, Kanpur).

SELECT * FROM customer
WHERE city LIKE '%pur';

-- -----------------------------------------------------------------------------------
-- 3. Write a query to display customers whose email contains 'gmail'.

SELECT * FROM customer
WHERE email LIKE '%gmail%';

-- -----------------------------------------------------------------------------------
-- 4. Write a query to display customers whose name has 'an' in it (like Rohan, Ankit, Manish).

SELECT * FROM customer
WHERE name LIKE '%an%';

-- -----------------------------------------------------------------------------------
-- 5. Write a query to display customers whose phone number starts with '98'.

SELECT * FROM customer
WHERE phone LIKE '98%';

-- -----------------------------------------------------------------------------------
-- 6. Write a query to display customers whose name is exactly 5 characters long.

SELECT * FROM customer
WHERE name LIKE '_____';

-- -----------------------------------------------------------------------------------
-- 7. Write a query to display customers whose city name has second character 'a' (like 'Nagpur', 'Bangalore').

SELECT * FROM customer
WHERE city LIKE '_a%';

-- -----------------------------------------------------------------------------------

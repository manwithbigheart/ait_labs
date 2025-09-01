CREATE DATABASE customer_bank_daclab;
USE  customer_bank_daclab;

-- -----------------------------------------------------------------------------------
CREATE TABLE customer (
	cust_ID INT PRIMARY KEY,
    cust_Name VARCHAR (100) NOT NULL,
    cust_City VARCHAR (100) NOT NULL
);

CREATE TABLE bank (
	account_ID INT PRIMARY KEY ,
    cust_ID INT,
    bank_Name VARCHAR (100) NOT NULL,
    balance DECIMAL(8,2),
    FOREIGN KEY (cust_ID) REFERENCES customer (cust_ID)
    );
    
-- ---------------------------------------------------------------------------------------------------------

INSERT INTO customer (cust_ID, cust_Name, cust_City) VALUES

(1, 'Amit Sharma', 'Delhi'),
(2, 'Sneha Patil', 'Mumbai'),
(3, 'Rahul Verma', 'Pune'),
(4, 'Pooja Singh', 'Hyderabad'),
(5, 'Mohit Gupta', 'Chennai'),
(6, 'Kiran Rao', 'Bangalore'),
(7, 'Deepak Yadav', 'Noida'),
(8, 'Anjali Nair', 'Kochi'),
(9, 'Suresh Kumar', 'Nagpur'),
(10, 'Neha Mehta', 'Aurangabad');

INSERT INTO bank (account_ID, cust_ID, bank_Name, balance) VALUES
(101, 1, 'SBI', 25000.75),
(102, 2, 'HDFC', 40000.00),
(103, 3, 'ICICI', 15000.50),
(104, 4, 'Axis Bank', 60000.20),
(105, 5, 'Kotak', 32000.00),
(106, 6, 'SBI', 28000.30),
(107, 7, 'HDFC', 10000.00),
(108, 8, 'ICICI', 50000.75),
(109, 9, 'Axis Bank', 12000.90),
(110, 10, 'SBI', 45000.00);


-- ----------------------------------------------------------------------------------------------------

-- 1. List all customers with their bank accounts.

SELECT c.cust_ID, c.cust_Name, c.cust_City, b.account_ID, b.bank_Name, b.balance
FROM customer c
LEFT JOIN bank b ON c.cust_ID = b.cust_ID;

-- ----------------------------------------------------------------------------------------------------

-- 2. Show customers with their account balance.

SELECT c.cust_Name, b.balance
FROM customer c
INNER JOIN bank b ON c.cust_ID = b.cust_ID;

-- ----------------------------------------------------------------------------------------------------

-- 3. Find all customers who live in 'Pune' with their bank details.

SELECT c.cust_Name, c.cust_City, b.account_ID, b.bank_Name, b.balance
FROM customer c
INNER JOIN bank b ON c.cust_ID = b.cust_ID
WHERE c.cust_City = 'Pune';

-- ----------------------------------------------------------------------------------------------------

-- 4. List customers who don't have any bank account.

SELECT c.cust_ID, c.cust_Name, c.cust_City
FROM customer c
LEFT JOIN bank b ON c.cust_ID = b.cust_ID
WHERE b.account_ID IS NULL;

-- ----------------------------------------------------------------------------------------------------

-- 5. Show all bank accounts and their customer names.

SELECT b.account_ID, b.bank_Name, b.balance, c.cust_Name
FROM bank b
INNER JOIN customer c ON b.cust_ID = c.cust_ID;

-- ----------------------------------------------------------------------------------------------------

-- 6. Display customers with more than 50,000 balance.

SELECT c.cust_Name, b.account_ID, b.bank_Name, b.balance
FROM customer c
INNER JOIN bank b ON c.cust_ID = b.cust_ID
WHERE b.balance > 50000;

-- ----------------------------------------------------------------------------------------------------





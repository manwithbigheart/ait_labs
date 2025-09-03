-- Task1: Create New Database

CREATE DATABASE AbdulRehmanDB;
USE AbdulRehmanDB;


-- --------------------------------------------------------------------------------------------------------------------------------------------

-- Task2: Friend List Table


CREATE TABLE friendList (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    contact VARCHAR(15),
    address VARCHAR(100)
);

INSERT INTO friendList VALUES
(1,'Amit','9876543210','Aurangabad'),
(2,'Rohit','9123456780','Pune'),
(3,'Sohail','9988776655','Mumbai'),
(4,'Faizan','9112233445','Delhi'),
(5,'Raj','9001122334','Nagpur'),
(6,'Arjun','9332211445','Nashik'),
(7,'Samir','9887766554','Hyderabad');


-- --------------------------------------------------------------------------------------------------------------------------------------------

-- Task3: Employee Table (Insert, Update, Drop)

CREATE TABLE employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    post VARCHAR(50),
    gender VARCHAR(10),
    salary DECIMAL(10,2),
    state VARCHAR(50),
    district VARCHAR(50),
    age INT,
    email VARCHAR(100)
);

-- Insert 10 employees
INSERT INTO employee VALUES
(1,'Amit','Manager','Male',75000,'Maharashtra','Aurangabad',32,'amit@mail.com'),
(2,'Rohit','Clerk','Male',25000,'Maharashtra','Pune',28,'rohit@mail.com'),
(3,'Sneha','HR','Female',45000,'Delhi','New Delhi',30,'sneha@mail.com'),
(4,'Faizan','Developer','Male',55000,'Maharashtra','Nagpur',26,'faizan@mail.com'),
(5,'Raj','Tester','Male',40000,'Karnataka','Bengaluru',29,'raj@mail.com'),
(6,'Pooja','Manager','Female',72000,'Tamil Nadu','Chennai',34,'pooja@mail.com'),
(7,'Arjun','Analyst','Male',38000,'Gujarat','Ahmedabad',27,'arjun@mail.com'),
(8,'Samir','Developer','Male',51000,'Maharashtra','Mumbai',31,'samir@mail.com'),
(9,'Neha','Clerk','Female',22000,'Rajasthan','Jaipur',25,'neha@mail.com'),
(10,'Karan','Developer','Male',58000,'Maharashtra','Aurangabad',29,'karan@mail.com');

-- Update
UPDATE employee SET salary = 60000 WHERE name='Rohit';

-- Delete/Drop record
DELETE FROM employee WHERE id=9;

-- Drop whole table
-- DROP TABLE employee;



-- --------------------------------------------------------------------------------------------------------------------------------------------


-- Task4: Product Details

CREATE TABLE productdetails (
    id INT PRIMARY KEY,
    productId VARCHAR(20),
    pname VARCHAR(50) NOT NULL,
    pprice DECIMAL(10,2) NOT NULL,
    pcompany VARCHAR(50) NOT NULL,
    pquantity INT,
    available BOOLEAN
);

-- Insert 10 products
INSERT INTO productdetails VALUES
(1,'P01','Laptop',55000,'Dell',10,TRUE),
(2,'P02','Phone',25000,'Samsung',20,TRUE),
(3,'P03','Tablet',18000,'Lenovo',15,FALSE),
(4,'P04','Headphones',2000,'Sony',30,TRUE),
(5,'P05','Charger',500,'Samsung',50,TRUE),
(6,'P06','Keyboard',1500,'Dell',25,FALSE),
(7,'P07','Mouse',800,'HP',40,TRUE),
(8,'P08','Monitor',12000,'LG',12,FALSE),
(9,'P09','Speaker',3000,'Sony',18,TRUE),
(10,'P10','Smartwatch',10000,'Apple',8,TRUE);

-- Add new columns
ALTER TABLE productdetails ADD city VARCHAR(50), ADD pincode VARCHAR(10);

-- Update city & pincode
UPDATE productdetails SET city='Aurangabad', pincode='431136' WHERE id=1;
UPDATE productdetails SET city='Mumbai', pincode='400001' WHERE id=2;
UPDATE productdetails SET city='Delhi', pincode='110001' WHERE id=3;
UPDATE productdetails SET city='Nagpur', pincode='440001' WHERE id=4;
UPDATE productdetails SET city='Pune', pincode='411001' WHERE id=5;
UPDATE productdetails SET city='Chennai', pincode='600001' WHERE id=6;
UPDATE productdetails SET city='Bengaluru', pincode='560001' WHERE id=7;
UPDATE productdetails SET city='Hyderabad', pincode='500001' WHERE id=8;
UPDATE productdetails SET city='Nashik', pincode='422001' WHERE id=9;
UPDATE productdetails SET city='Jaipur', pincode='302001' WHERE id=10;

-- Show unavailable products
SELECT * FROM productdetails WHERE available = FALSE;

-- Same company products
SELECT * FROM productdetails WHERE pcompany='Samsung';

-- Remove all records
TRUNCATE TABLE productdetails;

-- Drop table
DROP TABLE productdetails;


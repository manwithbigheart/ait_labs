CREATE DATABASE logicalops_employee_daclab;
USE logicalops_employee_daclab;
SELECT * FROM employee;
-- -----------------------------------------------------------------------------------
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(38),
    salary INT,
    age INT,
    gender VARCHAR(10),
    city VARCHAR(38)
);

-- -----------------------------------------------------------------------------------
INSERT INTO employee (emp_id, name, department, salary, age, gender, city) VALUES
(1, 'Amit Sharma', 'IT', 60000, 28, 'Male', 'Delhi'),
(2, 'Sneha Patil', 'HR', 45000, 32, 'Female', 'Mumbai'),
(3, 'Rahul Verma', 'Finance', 38000, 29, 'Male', 'Pune'),
(4, 'Pooja Singh', 'Sales', 35000, 24, 'Female', 'Chennai'),
(5, 'Mohit Gupta', 'IT', 52000, 26, 'Male', 'Mumbai'),
(6, 'Kiran Rao', 'Finance', 48000, 31, 'Female', 'Delhi'),
(7, 'Deepak Yadav', 'HR', 62000, 34, 'Male', 'Kolkata'),
(8, 'Anjali Nair', 'Sales', 29000, 23, 'Female', 'Pune'),
(9, 'Suresh Kumar', 'IT', 41000, 35, 'Male', 'Nagpur'),
(10, 'Neha Mehta', 'Finance', 55000, 27, 'Female', 'Delhi');

-- -----------------------------------------------------------------------------------
-- 1. Employees in 'IT' department AND salary greater than 50,000.

SELECT * FROM employee
WHERE department = 'IT' AND salary > 50000;

-- -----------------------------------------------------------------------------------
-- 2. Employees from 'Mumbai' OR 'Delhi'.

SELECT * FROM employee
WHERE city = 'Mumbai' OR city = 'Delhi';

-- -----------------------------------------------------------------------------------
-- 3. Employees NOT from the 'HR' department.

SELECT * FROM employee
WHERE department <> 'HR';

-- -----------------------------------------------------------------------------------
-- 4. Employees from 'Finance' XOR salary greater than 40,000.

SELECT * FROM employee
WHERE (department = 'Finance' AND salary <= 40000)
   OR (department <> 'Finance' AND salary > 40000);

-- -----------------------------------------------------------------------------------
-- 5. Employees in 'Sales' AND (salary > 30,000 OR age < 25).

SELECT * FROM employee
WHERE department = 'Sales' AND (salary > 30000 OR age < 25);

-- -----------------------------------------------------------------------------------
-- 6. Employees NOT from 'Pune' AND salary greater than 35,000.

SELECT * FROM employee
WHERE city <> 'Pune' AND salary > 35000;

-- -----------------------------------------------------------------------------------
-- 7. Employees from 'IT' OR NOT from 'Finance'.

SELECT * FROM employee
WHERE department = 'IT' OR department <> 'Finance';

-- -----------------------------------------------------------------------------------
-- 8. Employees who are male XOR (salary above 60,000 AND belong to 'HR').

SELECT * FROM employee
WHERE (gender = 'Male' AND NOT (salary > 60000 AND department = 'HR'))
   OR (gender <> 'Male' AND (salary > 60000 AND department = 'HR'));

-- -----------------------------------------------------------------------------------
-- 9. Employees age > 30 AND (department = 'IT' OR department = 'Finance').

SELECT * FROM employee
WHERE age > 30 AND (department = 'IT' OR department = 'Finance');

-- -----------------------------------------------------------------------------------
-- 10. Employees NOT from 'Delhi' XOR salary less than 25,000.

SELECT * FROM employee
WHERE (city <> 'Delhi' AND salary >= 25000)
   OR (city = 'Delhi' AND salary < 25000);

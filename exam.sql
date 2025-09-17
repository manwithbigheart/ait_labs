
-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- Set 1: Joins (Basic)

-- 1. INNER JOIN: Display all students along with their course names
SELECT s.student_id, s.name, c.course_name
FROM students s
INNER JOIN courses c ON s.course_id = c.course_id;

-- 2. LEFT JOIN: Display all students and their course names, including students not enrolled
SELECT s.student_id, s.name, c.course_name
FROM students s
LEFT JOIN courses c ON s.course_id = c.course_id;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- Set 2: Aggregation & Group By

-- 1. Total amount spent by each customer
SELECT c.customer_id, c.customer_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 2. Find the city with the highest number of customers
SELECT city, COUNT(customer_id) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC
LIMIT 1;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- Set 3: Subqueries

-- 1. Employees earning more than the average salary
SELECT emp_id, emp_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 2. Department name of the highest paid employee
SELECT d.dept_name
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary = (SELECT MAX(salary) FROM employees);

-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- Set 4: Window Functions

-- 1. Total sales and rank of each product
SELECT p.product_id, p.product_name, SUM(s.amount) AS total_sales,
       RANK() OVER (ORDER BY SUM(s.amount) DESC) AS sales_rank
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name;

-- 2. Running total of sales for each product
SELECT product_id, sale_date, amount,
       SUM(amount) OVER (PARTITION BY product_id ORDER BY sale_date) AS running_total
FROM sales;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- Set 5: Constraints & Keys

-- 1. Create users table with PRIMARY KEY and UNIQUE email
CREATE TABLE users (
  user_id INT PRIMARY KEY,
  username VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  created_at DATETIME
);

-- 2. Display all users with count of posts they created
SELECT u.user_id, u.username, COUNT(p.post_id) AS total_posts
FROM users u
LEFT JOIN posts p ON u.user_id = p.user_id
GROUP BY u.user_id, u.username;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- Set 6: String & Date Functions

-- 1. Display each student’s age
SELECT student_id, name,
       TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS age
FROM students;

-- 2. Extract domain from email
SELECT student_id, name,
       SUBSTRING_INDEX(email, '@', -1) AS domain
FROM students;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- Set 7: Advanced Joins

-- 1. Employee’s manager name using SELF JOIN
SELECT e.emp_id, e.emp_name, m.emp_name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

-- 2. Departments with number of employees (using RIGHT JOIN)
SELECT d.dept_id, d.dept_name, COUNT(e.emp_id) AS total_employees
FROM departments d
RIGHT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- Set 8: Transactions & ACID

-- 1. Transfer ₹500 from account_id=1 to account_id=2
START TRANSACTION;
UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;
COMMIT;

-- 2. Demonstrate rollback
START TRANSACTION;
UPDATE accounts SET balance = balance - 1000 WHERE account_id = 1;
ROLLBACK;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- Set 9: Indexing & Performance

-- 1. Create index on order_date
CREATE INDEX idx_order_date ON orders(order_date);

-- 2. Explain query performance with index
EXPLAIN SELECT * FROM orders WHERE order_date > '2025-01-01';

-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- Set 10: Complex Query Challenge

-- 1. Top 3 customers who spent the most in the last 6 months
SELECT c.customer_id, c.customer_name, SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 3;

-- 2. Most sold product by quantity
SELECT p.product_id, p.product_name, SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC
LIMIT 1;


-- ------------------------------------------------------------------------------------------------------------------------------------------------
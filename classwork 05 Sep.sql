-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 🔹 What is a Trigger?

-- A trigger is a stored program in MySQL that runs automatically when a specified event happens on a table.

-- Runs before or after INSERT, UPDATE, or DELETE.

-- Common use cases:

-- 🔹 Maintaining logs

-- 🔹 Validating data

-- 🔹 Auto-updating related tables


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE DATABASE trigger_demo_daclab;
USE trigger_demo_daclab;

-- Employee table

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    salary DECIMAL(10,2)
);

-- Audit table for logging changes

CREATE TABLE employee_audit (
    id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    action VARCHAR(20),
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- --------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$

CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (emp_id, action, new_salary)
    VALUES (NEW.emp_id, 'INSERT', NEW.salary);
END$$

DELIMITER ;


INSERT INTO employees (name, salary) VALUES ('Abdul', 40000);
SELECT * FROM employee_audit;


-- ---------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$
CREATE TRIGGER after_employee_update
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (emp_id, action, old_salary, new_salary)
    VALUES (NEW.emp_id, 'UPDATE', OLD.salary, NEW.salary);
END; $$
DELIMITER ;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$
CREATE TRIGGER after_employee_delete
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (emp_id, action, old_salary)
    VALUES (OLD.emp_id, 'DELETE', OLD.salary);
END; $$
DELIMITER ;

DROP TRIGGER after_employee_delete;

DELETE FROM employees WHERE emp_id = 1;
SELECT * FROM employee_audit;


-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER before_employee_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 10000 THEN
        SET NEW.salary = 10000;  -- Set's minimum salary
    END IF;
END; $$

DELIMITER ;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$ 
CREATE TRIGGER Check_age BEFORE INSERT ON employees
FOR EACH ROW 
BEGIN 
IF NEW.age< 18 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR
	AGE MUST BE ATLEAST 25 YEARS !';
END IF;
END; $$
DELIMITER ;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER prevent_negative_salary
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be negative!';
    END IF;
END; $$
DELIMITER ;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1. Cursor in MySQL

-- Cursor ka use tab hota hai jab hume ek query se multiple rows fetch karke row by row process karna ho. Jaise loop ki tarah.

-- Syntax:

-- DECLARE cursor_name CURSOR FOR SELECT_statement;
-- OPEN cursor_name;
-- FETCH cursor_name INTO variable_list;
-- CLOSE cursor_name;



-- (Cursor to display student names one by one)

DELIMITER $$

CREATE PROCEDURE show_students()
BEGIN
  DECLARE sname VARCHAR(50);
  DECLARE done INT DEFAULT 0;
  
  -- cursor declaration
  DECLARE cur CURSOR FOR SELECT name FROM students;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
  
  OPEN cur;
  
  read_loop: LOOP
    FETCH cur INTO sname;
    IF done = 1 THEN
      LEAVE read_loop;
    END IF;
    SELECT sname; -- print or use value
  END LOOP;
  
  CLOSE cur;
END $$

DELIMITER ;


CALL show_students();

-- ----------------------------------------------------------------------------------------------------------------------------------------------------


-- 2. Algebraic Expressions (Relational Algebra in DBMS)

-- Ye ek theoretical language hai jo SQL ka base hai. Database queries ko mathematical form mein likhne ke liye use hota hai.

-- Basic Operators:

-- σ (Selection) – filter rows
-- σ(age > 18)(Students)
-- → Students table se sirf wo rows jahan age > 18

-- π (Projection) – choose columns
-- π(name, age)(Students)
-- → Students table se sirf name aur age column

-- ∪ (Union) – combine results (no duplicates)
-- Students ∪ Teachers

-- − (Set Difference) – subtract one table from another
-- Students − Passed

-- × (Cartesian Product) – all combinations of rows
-- Students × Courses

-- ⨝ (Join) – combine rows with condition
-- Students ⨝ Students.course_id = Courses.course_id Courses

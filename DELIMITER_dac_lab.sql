CREATE DATABASE companyDB;
USE companyDB;



CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2)
);



INSERT INTO employees (emp_name, salary) 
VALUES 
('Rahul', 40000),
('Sneha', 55000),
('Amit', 30000);

INSERT INTO employees (emp_name, salary)
VALUES
('Priya', 60000),
('Kunal', 45000),
('Fatima', 70000),
('Rohit', 38000);




-- ______________________________________________________________________________________________________________________________________________________________________________


DELIMITER $$

CREATE PROCEDURE GetEmployeeDetails()
BEGIN
    SELECT * FROM employees;
    SELECT COUNT(*) AS total_employees FROM employees;
END$$

DELIMITER ;



CALL GetEmployeeDetails();


-- ______________________________________________________________________________________________________________________________________________________________________________


DELIMITER $$

CREATE PROCEDURE GetHighSalaryEmployees(IN min_salary DECIMAL(10,2))
BEGIN
    SELECT * 
    FROM employees
    WHERE salary > min_salary;
END$$

DELIMITER ;


CALL GetHighSalaryEmployees(45000);

-- ______________________________________________________________________________________________________________________________________________________________________________


DELIMITER $$

CREATE PROCEDURE GetAverageSalary(OUT avg_salary DECIMAL(10,2))
BEGIN
    SELECT AVG(salary) INTO avg_salary FROM employees;
END$$

DELIMITER ;


CALL GetAverageSalary(@avg);
SELECT @avg AS AverageSalary;



-- ______________________________________________________________________________________________________________________________________________________________________________

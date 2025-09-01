CREATE DATABASE myCompanyDacLab;
USE myCompanyDacLab;

CREATE TABLE department (
dept_ID INT PRIMARY KEY,
dept_Code VARCHAR (30) NOT NULL,
dept_Name VARCHAR (100) NOT NULL,
dept_Loc VARCHAR (100) NOT NULL );

DESC department;

ALTER TABLE department 
MODIFY dept_Loc ENUM ('pune', 'mumbai', 'kolkata','delhi');


INSERT INTO department (dept_ID, dept_Code, dept_Name, dept_Loc) VALUES
(1, 'CS101', 'Computer Science', 'pune'),
(2, 'EE102', 'Electrical Engineering', 'mumbai'),
(3, 'ME103', 'Mechanical Engineering', 'kolkata'),
(4, 'CE104', 'Civil Engineering', 'delhi'),
(5, 'IT105', 'Information Technology', 'pune');

CREATE TABLE employee (
    emp_ID INT PRIMARY KEY,
    emp_Code VARCHAR (30) NOT NULL,
    emp_Name VARCHAR (100) NOT NULL,
    Gender ENUM ('MALE','FEMALE','OTHER') NOT NULL,
    emp_DOB DATE NOT NULL,
    emp_DateOfJoining DATETIME NOT NULL,
    emp_Salary DECIMAL(10,2) NOT NULL,
    isActive BOOLEAN NOT NULL DEFAULT TRUE,
    emp_ADDRESS VARCHAR (100) NOT NULL,
    profile_picture BLOB,
    workTime TIME NOT NULL,
    dept_ID INT,
    FOREIGN KEY (dept_ID) REFERENCES department(dept_ID)
);


INSERT INTO employee 
(emp_ID, emp_Code, emp_Name, Gender, emp_DOB, emp_DateOfJoining, emp_Salary, isActive, emp_ADDRESS, profile_picture, workTime, dept_ID) 
VALUES
(1, 'E001', 'Amit Sharma', 'MALE', '1990-05-12', '2015-06-01 09:15:00', 55000.00, TRUE, 'Pune, Maharashtra', NULL, '09:00:00', 1),
(2, 'E002', 'Priya Singh', 'FEMALE', '1992-11-23', '2017-04-15 10:00:00', 62000.00, TRUE, 'Mumbai, Maharashtra', NULL, '09:30:00', 2),
(3, 'E003', 'Ravi Verma', 'MALE', '1988-07-05', '2014-02-20 08:45:00', 72000.00, TRUE, 'Delhi, India', NULL, '08:45:00', 3),
(4, 'E004', 'Neha Kulkarni', 'FEMALE', '1995-03-30', '2019-09-10 09:00:00', 48000.00, TRUE, 'Nagpur, Maharashtra', NULL, '09:00:00', 4),
(5, 'E005', 'Arjun Mehta', 'MALE', '1991-08-17', '2016-01-05 09:30:00', 68000.00, TRUE, 'Hyderabad, Telangana', NULL, '09:30:00', 1),
(6, 'E006', 'Sneha Patil', 'FEMALE', '1993-06-12', '2018-07-12 10:15:00', 53000.00, TRUE, 'Aurangabad, Maharashtra', NULL, '10:00:00', 2),
(7, 'E007', 'Karan Yadav', 'MALE', '1989-09-25', '2013-03-15 08:30:00', 75000.00, TRUE, 'Chennai, Tamil Nadu', NULL, '08:30:00', 3),
(8, 'E008', 'Ritika Desai', 'FEMALE', '1994-01-10', '2020-11-01 09:45:00', 46000.00, TRUE, 'Surat, Gujarat', NULL, '09:45:00', 4),
(9, 'E009', 'Mohit Kapoor', 'MALE', '1990-12-05', '2015-08-20 09:00:00', 70000.00, TRUE, 'Jaipur, Rajasthan', NULL, '09:00:00', 1),
(10, 'E010', 'Anjali Gupta', 'FEMALE', '1996-04-08', '2021-01-18 10:30:00', 42000.00, TRUE, 'Lucknow, Uttar Pradesh', NULL, '10:30:00', 2),
(11, 'E011', 'Vikram Rao', 'MALE', '1987-02-28', '2012-12-01 08:15:00', 82000.00, TRUE, 'Bangalore, Karnataka', NULL, '08:15:00', 3),
(12, 'E012', 'Komal Jain', 'FEMALE', '1995-10-14', '2019-05-25 09:15:00', 50000.00, TRUE, 'Indore, Madhya Pradesh', NULL, '09:15:00', 4),
(13, 'E013', 'Rahul Nair', 'MALE', '1991-07-22', '2016-03-12 09:45:00', 65000.00, TRUE, 'Kochi, Kerala', NULL, '09:45:00', 1),
(14, 'E014', 'Pooja Reddy', 'FEMALE', '1993-05-18', '2017-10-05 10:00:00', 57000.00, TRUE, 'Secunderabad, Telangana', NULL, '10:00:00', 2),
(15, 'E015', 'Aditya Joshi', 'MALE', '1989-11-02', '2014-07-30 08:30:00', 78000.00, TRUE, 'Nashik, Maharashtra', NULL, '08:30:00', 3);



SELECT * FROM department;
SELECT * FROM employee;




-- 1. INNER JOIN / JOIN 		only matching rows
    
SELECT 	e.emp_ID, 
		e.emp_Name, 
        e.emp_Code,
        
		d.dept_ID, 
        d.dept_Code, 
        d.dept_Name, 
        d.dept_Loc
        
FROM employee e
INNER JOIN department d
ON e.dept_ID = d.dept_ID;




-- 2. LEFT JOIN			all employees, dept info if exists

SELECT  e.emp_ID, 
		e.emp_Name, 
        e.emp_Code,
        
		d.dept_ID, 
        d.dept_Code, 
        d.dept_Name, 
        d.dept_Loc

FROM employee e
LEFT JOIN department d
ON e.dept_ID = d.dept_ID;
  
  

-- 3. RIGHT JOIN — all departments (shows dept_ID 5 with NULL employee columns)

SELECT 	e.emp_ID, 
		e.emp_Name, 
        e.emp_Code,
        
		d.dept_ID, 
        d.dept_Code, 
        d.dept_Name, 
        d.dept_Loc
        
FROM employee e
RIGHT JOIN department d
on e.dept_ID = d.dept_ID;
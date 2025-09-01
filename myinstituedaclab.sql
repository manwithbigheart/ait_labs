
-- -------------------------------------------------------------------------------------------------------------------------------------------

CREATE DATABASE myinstituedaclab;
USE myinstituedaclab;

CREATE TABLE institute (
inst_ID INT PRIMARY KEY,
inst_Name VARCHAR (100) NOT NULL,
dept_city VARCHAR (100) NOT NULL );



CREATE TABLE students (
    Student_ID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    age INT NOT NULL,
    course VARCHAR(50) ,
    inst_ID INT,
    FOREIGN KEY (inst_ID) REFERENCES institute (inst_ID)
);

-- -----------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO institute (inst_ID, inst_Name, dept_city) VALUES
(1, 'Sunrise Institute', 'Mumbai'),
(2, 'Global Tech College', 'Pune'),
(3, 'Greenfield Academy', 'Nagpur'),
(4, 'Bright Future Institute', 'Delhi');

INSERT INTO students (Student_ID, StudentName, age, course, inst_ID) VALUES
(101, 'Arjun Kale', 21, 'Computer Science', 1),
(102, 'Meera Deshmukh', 22, 'Mechanical', 2),
(103, 'Ravi Patil', 20, 'Electrical', NULL),   -- not enrolled
(104, 'Snehal Jadhav', 23, 'Civil', 3),
(105, 'Rohan Gupta', 21, 'IT', 1),
(106, 'Anita Singh', 22, 'Computer Science', NULL), -- not enrolled
(107, 'Karan Joshi', 24, 'Electronics', 2),
(108, 'Pooja Shah', 20, 'Biotech', 4),
(109, 'Suresh Yadav', 22, 'Mechanical', NULL), -- not enrolled
(110, 'Neha Kulkarni', 21, 'Commerce', 3);


-- -----------------------------------------------------------------------------------------------------------------------------------------

-- 1️. Students with their institute names (only enrolled students)

SELECT s.StudentName, s.course, i.inst_Name
FROM students s
JOIN institute i ON s.inst_ID = i.inst_ID;


-- -----------------------------------------------------------------------------------------------------------------------------------------

-- 2. All students with institute names, "Not Assigned" if none

SELECT s.StudentName, s.course, 
       COALESCE(i.inst_Name, 'Not Assigned') AS InstituteName
FROM students s
LEFT JOIN institute i ON s.inst_ID = i.inst_ID;


-- -----------------------------------------------------------------------------------------------------------------------------------------

-- 3. All institutes with students, "No Student" if none

SELECT i.inst_Name, 
       COALESCE(s.StudentName, 'No Student') AS StudentName
FROM institute i
LEFT JOIN students s ON i.inst_ID = s.inst_ID;



-- -----------------------------------------------------------------------------------------------------------------------------------------

-- 4.All students and all institutes (full outer join simulation in MySQL)

SELECT s.StudentName, i.inst_Name
FROM students s
LEFT JOIN institute i ON s.inst_ID = i.inst_ID

UNION

SELECT s.StudentName, i.inst_Name
FROM students s
RIGHT JOIN institute i ON s.inst_ID = i.inst_ID;


-- -----------------------------------------------------------------------------------------------------------------------------------------

-- 5.Students in institutes located in Mumbai

SELECT s.StudentName, s.course, i.inst_Name
FROM students s
JOIN institute i ON s.inst_ID = i.inst_ID
WHERE i.dept_city = 'Mumbai';


-- -----------------------------------------------------------------------------------------------------------------------------------------

select * from students;
select * from institute;
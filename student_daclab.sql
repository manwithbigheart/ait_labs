CREATE DATABASE student_daclab;
USE student_daclab;

-- -----------------------------------------------------------------------------------
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(30),
    gender VARCHAR(10),
    age INT,
    marks INT
);

-- ----------------------------------------------------------------------------------------------------

INSERT INTO students (student_id, name, department, gender, age, marks) VALUES
(1, 'Amit Sharma', 'Computer', 'Male', 20, 85),
(2, 'Sneha Patil', 'Electronics', 'Female', 21, 78),
(3, 'Rahul Verma', 'Mechanical', 'Male', 22, 65),
(4, 'Pooja Singh', 'Computer', 'Female', 20, 92),
(5, 'Mohit Gupta', 'Civil', 'Male', 23, 74),
(6, 'Kiran Rao', 'Electronics', 'Female', 21, 88),
(7, 'Deepak Yadav', 'Mechanical', 'Male', 24, 55),
(8, 'Anjali Nair', 'Computer', 'Female', 22, 81),
(9, 'Suresh Kumar', 'Civil', 'Male', 23, 69),
(10, 'Neha Mehta', 'Electronics', 'Female', 20, 95);

-- ----------------------------------------------------------------------------------------------------

-- 1. Write a query to display the number of students in each department.

SELECT department, COUNT(*) AS total_students
FROM students
GROUP BY department;

-- ----------------------------------------------------------------------------------------------------

-- 2. Write a query to find the average marks of students in each department.

SELECT department, AVG(marks) AS avg_marks
FROM students
GROUP BY department;

-- ----------------------------------------------------------------------------------------------------

-- 3. Write a query to display the number of male and female students.

SELECT gender, COUNT(*) AS total_students
FROM students
GROUP BY gender;

-- ----------------------------------------------------------------------------------------------------

-- 4. Write a query to find the maximum marks scored by students in each department.

SELECT department, MAX(marks) AS max_marks
FROM students
GROUP BY department;

-- ----------------------------------------------------------------------------------------------------

-- 5. Write a query to display the average age of students grouped by department and gender.

SELECT department, gender, AVG(age) AS avg_age
FROM students
GROUP BY department, gender;

-- ----------------------------------------------------------------------------------------------------

-- 6. Write a query to find the total marks obtained by students in each department.

SELECT department, SUM(marks) AS total_marks
FROM students
GROUP BY department;

-- ----------------------------------------------------------------------------------------------------

-- 7. Write a query to display the minimum marks obtained by male and female students.

SELECT gender, MIN(marks) AS min_marks
FROM students
GROUP BY gender;

-- ----------------------------------------------------------------------------------------------------

-- 8. Write a query to count the number of students in each age group.

SELECT age, COUNT(*) AS total_students
FROM students
GROUP BY age;

-- ----------------------------------------------------------------------------------------------------

-- 9. Write a query to display the department-wise student count and average marks.

SELECT department, COUNT(*) AS total_students, AVG(marks) AS avg_marks
FROM students
GROUP BY department;

-- ----------------------------------------------------------------------------------------------------

-- 10. Write a query to find the total number of students grouped by both department and age.

SELECT department, age, COUNT(*) AS total_students
FROM students
GROUP BY department, age;

-- ----------------------------------------------------------------------------------------------------

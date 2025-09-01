-- create database OnlineCourseManage;

-- create table students (Student_ID int primary key, StudentName varchar(50), eamil varchar (50) unique, is_active boolean default true);

-- create table courses (Course_ID int primary key, CourseName varchar(50), Duration_Month int );

-- create table enrollments (Enrollment_ID int primary key, Student_ID int foreign key references students(Student_ID ),
-- Course_ID int foreign key references courses (Course_ID), is_completed boolean default false;


CREATE DATABASE OnlineCourseManage;
use OnlineCourseManage;

CREATE TABLE students (
    Student_ID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE courses (
    Course_ID INT PRIMARY KEY,
    CourseName VARCHAR(50),
    Duration_Month INT
);

CREATE TABLE enrollments (
    Enrollment_ID INT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    is_completed BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (Student_ID) REFERENCES students(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES courses(Course_ID)
);



INSERT INTO students (Student_ID, StudentName, email, is_active) VALUES
(1, 'Aarav Sharma', 'aarav.sharma@example.com', TRUE),
(2, 'Vivaan Mehta', 'vivaan.mehta@example.com', TRUE),
(3, 'Aditya Verma', 'aditya.verma@example.com', TRUE),
(4, 'Krishna Iyer', 'krishna.iyer@example.com', TRUE),
(5, 'Riya Kapoor', 'riya.kapoor@example.com', TRUE),
(6, 'Anaya Singh', 'anaya.singh@example.com', TRUE),
(7, 'Ishaan Reddy', 'ishaan.reddy@example.com', TRUE),
(8, 'Diya Desai', 'diya.desai@example.com', TRUE),
(9, 'Arjun Patil', 'arjun.patil@example.com', TRUE),
(10, 'Kavya Joshi', 'kavya.joshi@example.com', TRUE),
(11, 'Neha Pandey', 'neha.pandey@example.com', TRUE),
(12, 'Siddharth Nair', 'siddharth.nair@example.com', TRUE),
(13, 'Meera Roy', 'meera.roy@example.com', TRUE),
(14, 'Yash Thakur', 'yash.thakur@example.com', TRUE),
(15, 'Pooja Malhotra', 'pooja.malhotra@example.com', TRUE);


INSERT INTO courses (Course_ID, CourseName, Duration_Month) VALUES
(1, 'Python Programming', 3),
(2, 'Data Science Basics', 4),
(3, 'Web Development', 5);



INSERT INTO enrollments (Enrollment_ID, Student_ID, Course_ID, is_completed) VALUES
(1, 1, 1, FALSE),
(2, 2, 2, TRUE),
(3, 3, 1, TRUE),
(4, 4, 3, FALSE),
(5, 5, 2, TRUE),
(6, 6, 1, FALSE),
(7, 7, 3, FALSE),
(8, 8, 1, TRUE),
(9, 9, 2, TRUE),
(10, 10, 3, FALSE),
(11, 11, 1, TRUE),
(12, 12, 2, TRUE),
(13, 13, 1, FALSE),
(14, 14, 2, FALSE),
(15, 15, 3, TRUE);

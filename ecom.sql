create database ecom;

create table employees;
create table products;
create table customer;
create table billing;
create table manufucturer;
create table distributor;
create table department;

create table employees (
	employee_id int,
    Name varchar (50),
    Email varchar (100),
    Phone int,
    Role varchar (90)
    department_id int 
    

);





























-- Customer (Customer_ID PK) ------------< Order (Order_ID PK) ------------< Order_Item (Order_Item_ID PK) >------------ Product (Product_ID PK) >------------ Category (Category_ID PK)

-- Order (Order_ID PK) ------------ Payment (Payment_ID PK)

-- Customer (Customer_ID PK) ------------ Cart (Cart_ID PK) ------------< Cart_Item (Cart_Item_ID PK) >------------ Product (Product_ID PK)


create database practise;
use   practise;


CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2)
);



INSERT INTO employees (emp_name, salary) 
VALUES 
('Rahul', 40000),
('Sneha', 55000),
('Amit', 30000),
('Priya', 60000),
('Kunal', 45000),
('Fatima', 70000),
('Rohit', 38000);


-- --------------------------------------------------------------------------------------------------------------------------------------------


	DELIMITER $$
    CREATE PROCEDURE check_day(IN dayNum INT)
    BEGIN 
			SELECT
			CASE dayNum
            WHEN 1 THEN  'MONDAY'
            WHEN 2 THEN  'TUESDAY'
            WHEN 3 THEN  'WEDNESDAY'
            WHEN 4 THEN  'THURSDAY'
            WHEN 5 THEN  'FRIDAY'
            WHEN 6 THEN  'SATURDAY'
            WHEN 7 THEN  'SUNDAY'
            ELSE 'INVALID ENTERY' 
            END AS DayName;
		END $$	
        DELIMITER ;
        CALL check_day(5);
	
    -- --------------------------------------------------------------------------------------------------------------------------------------------
    
    -- 1. Procedure to Display Month Name:
    
    DELIMITER $$

CREATE PROCEDURE get_month_name(IN monthNum INT)
BEGIN
    SELECT 
        CASE monthNum
            WHEN 1 THEN 'January'
            WHEN 2 THEN 'February'
            WHEN 3 THEN 'March'
            WHEN 4 THEN 'April'
            WHEN 5 THEN 'May'
            WHEN 6 THEN 'June'
            WHEN 7 THEN 'July'
            WHEN 8 THEN 'August'
            WHEN 9 THEN 'September'
            WHEN 10 THEN 'October'
            WHEN 11 THEN 'November'
            WHEN 12 THEN 'December'
            ELSE 'INVALID ENTRY'
        END AS MonthName;
END $$

DELIMITER ;

            
    CALL get_month_name(3);


   -- --------------------------------------------------------------------------------------------------------------------------------------------
   
   -- 2. Procedure to Check If a Number is Even or Odd:
   
   DELIMITER $$

CREATE PROCEDURE check_even_or_odd(IN number INT)
BEGIN
    IF number % 2 = 0 THEN
        SELECT 'EVEN' AS Result;
    ELSE
        SELECT 'ODD' AS Result;
    END IF;
END $$

DELIMITER ;


CALL check_even_or_odd(7);


   -- --------------------------------------------------------------------------------------------------------------------------------------------
   
   
   -- 3 Employee Bonus Calculation Procedure
   
   
   DELIMITER $$

CREATE PROCEDURE calculate_bonus(IN salary DECIMAL(10,2))
BEGIN
    DECLARE bonus DECIMAL(10,2);
    
    IF salary > 50000 THEN
        SET bonus = salary * 0.20;  -- 20% bonus
    ELSEIF salary BETWEEN 30000 AND 50000 THEN
        SET bonus = salary * 0.10;  -- 10% bonus
    ELSE
        SET bonus = salary * 0.05;  -- 5% bonus
    END IF;
    
    SELECT bonus AS EmployeeBonus;
END $$

DELIMITER ;


CALL calculate_bonus(40000);


   -- --------------------------------------------------------------------------------------------------------------------------------------------
   
   -- 4. Age Group Categorization Procedure 
   
   DELIMITER $$

CREATE PROCEDURE categorize_age(IN age INT)
BEGIN
    DECLARE age_group VARCHAR(20);
    
    IF age < 13 THEN
        SET age_group = 'Child';
    ELSEIF age BETWEEN 13 AND 19 THEN
        SET age_group = 'Teenager';
    ELSEIF age BETWEEN 20 AND 59 THEN
        SET age_group = 'Adult';
    ELSE
        SET age_group = 'Senior Citizen';
    END IF;
    
    SELECT age_group AS AgeGroup;
END $$

DELIMITER ;

CALL categorize_age(3);
CALL categorize_age(13);
CALL categorize_age(30);

   -- --------------------------------------------------------------------------------------------------------------------------------------------
   
   -- 5. Electricity Bill Calculation
   
   DELIMITER $$ 
   CREATE PROCEDURE BILL_CAL(IN UNIT INT)
   BEGIN 
		DECLARE BILL_AMT INT;
        IF UNIT <= 100 THEN
        SET BILL_AMT = UNIT * 5;
        ELSEIF UNIT <= 300 THEN
        SET BILL_AMT = UNIT * 7;
        ELSE SET BILL_AMT = UNIT * 10;
        END IF;
        SELECT BILL_AMT AS Total_Bill;
        END $$
	DELIMITER ;
    
   CALL BILL_CAL(40);
   
      -- --------------------------------------------------------------------------------------------------------------------------------------------
      
      -- 6. Traffic Signal Simulation
      
      DELIMITER $$
      CREATE PROCEDURE TRAFFIC_SIGNAL(IN SIGNAAL CHAR)
      BEGIN
			SELECT
            CASE SIGNAAL 
            WHEN 'R' THEN 'STOP'
            WHEN 'Y' THEN 'WAIT'
            WHEN 'G' THEN 'GO'
            ELSE 'INVALID INPUT SIGNAL'
            END AS SIGNAL_RESULT;
            
            END $$
            DELIMITER ;
            
            
            CALL TRAFFIC_SIGNAL('W');
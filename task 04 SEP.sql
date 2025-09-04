

--  Task 1: Print Even Numbers from 1 to 30


DELIMITER //

CREATE PROCEDURE Task1_Even()
BEGIN
    DECLARE i INT DEFAULT 2;
    DECLARE result TEXT DEFAULT '';

    WHILE i <= 30 DO
        SET result = CONCAT(result, i, ', ');
        SET i = i + 2;
    END WHILE;

    SELECT TRIM(TRAILING ', ' FROM result) AS even_numbers;
END //

DELIMITER ;

CALL Task1_Even();

-- ---------------------------------------------------------------------------------------------------------------------------

-- Task 2: Print Odd Numbers from 1 to 30


DELIMITER //

CREATE PROCEDURE Task2_Odd()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE result TEXT DEFAULT '';

    WHILE i <= 30 DO
        SET result = CONCAT(result, i, ', ');
        SET i = i + 2;
    END WHILE;

    SELECT TRIM(TRAILING ', ' FROM result) AS odd_numbers;
END //

DELIMITER ;

CALL Task2_Odd();

-- -------------------------------------------------------------------------------------------------------------------------

-- Task 3: Print Numbers in Reverse Order from 20 to 1



DELIMITER //

CREATE PROCEDURE Task3_Reverse()
BEGIN
    DECLARE i INT DEFAULT 20;
    DECLARE result TEXT DEFAULT '';

    WHILE i >= 1 DO
        SET result = CONCAT(result, i, ', ');
        SET i = i - 1;
    END WHILE;

    SELECT TRIM(TRAILING ', ' FROM result) AS reverse_numbers;
END //

DELIMITER ;

CALL Task3_Reverse();


--  ----------------------------------------------------------------------------------------------------------------------

-- Task 4: Print 8 Table using REPEAT Loop 


DELIMITER //

CREATE PROCEDURE Task4_Table8()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE result TEXT DEFAULT '';

    REPEAT
        SET result = CONCAT(result, '8 x ', i, ' = ', 8*i, ', ');
        SET i = i + 1;
    UNTIL i > 10
    END REPEAT;

    SELECT TRIM(TRAILING ', ' FROM result) AS table_of_8;
END //

DELIMITER ;

CALL Task4_Table8();


-- ----------------------------------------------------------------------------------------------------------------------

-- Task 5: Print Cube of Numbers from 1 to 20 

DELIMITER //

CREATE PROCEDURE Task5_Cubes()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE result TEXT DEFAULT '';

    WHILE i <= 20 DO
        SET result = CONCAT(result,  POW(i,3), ', ');
        SET i = i + 1;
    END WHILE;

    SELECT TRIM(TRAILING ', ' FROM result) AS cubes;
END //

DELIMITER ;

DROP PROCEDURE Task5_Cubes;
CALL Task5_Cubes();

-- --------------------------------------------------------------------------------------------------------------------------

-- Task 6: Factorial of a Number (Using WHILE Loop)

DELIMITER //

CREATE PROCEDURE Task6_Factorial(IN num INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE fact BIGINT DEFAULT 1;

    WHILE i <= num DO
        SET fact = fact * i;
        SET i = i + 1;
    END WHILE;

    SELECT fact AS factorial_result;
END //

DELIMITER ;


CALL Task6_Factorial(5);


-- -----------------------------------------------------------------------------------------------------------------------------

-- Task 7: Fibonacci Series (First 10 Terms Using REPEAT Loop)

DELIMITER //

CREATE PROCEDURE Task7_Fibonacci(IN n INT)
BEGIN
    DECLARE a INT DEFAULT 0;
    DECLARE b INT DEFAULT 1;
    DECLARE temp INT;
    DECLARE i INT DEFAULT 1;
    DECLARE result TEXT DEFAULT '';

    REPEAT
        SET result = CONCAT(result, a, ', ');
        SET temp = a + b;
        SET a = b;
        SET b = temp;
        SET i = i + 1;
    UNTIL i > n
    END REPEAT;

    SELECT TRIM(TRAILING ', ' FROM result) AS fibonacci_series;
END //

DELIMITER ;

DROP PROCEDURE Task7_Fibonacci;

CALL Task7_Fibonacci(5);

-- -------------------------------------------------------------------------------------------------------
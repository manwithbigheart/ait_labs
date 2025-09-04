-- Loops in Databases



CREATE DATABASE loopDB_dac;
USE loopDB_dac;

CREATE TABLE numbers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    num INT
);





-- -----------------------------------------------------------------------------------------------------------------------------------------

-- Here whatever exectued will be save in number table in num column

DELIMITER $$
CREATE PROCEDURE insert_numbers()
BEGIN
    DECLARE x INT DEFAULT 1;

    WHILE x <= 5 DO
        INSERT INTO numbers (num) VALUES (x);
        SET x = x + 1;
    END WHILE;
END $$
DELIMITER ;

call insert_numbers();

select * from numbers;

-- ------------------------------------------------------------------------------------------------------------------------------------------------


DELIMITER //

CREATE PROCEDURE Calculate_sum(IN num INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE total_sum INT DEFAULT 0;

    WHILE i <= num DO
        SET total_sum = total_sum + i;
        SET i = i + 1;
    END WHILE;

    SELECT total_sum AS sum_of_numbers;
END //

DELIMITER ;

call Calculate_sum(3);


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------


DELIMITER //

CREATE PROCEDURE Sum_Loop(IN num INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE total_sum INT DEFAULT 0;

    myloop: LOOP
        SET total_sum = total_sum + i;
        SET i = i + 1;

        IF i > num THEN
            LEAVE myloop;  -- exit loop
        END IF;
    END LOOP myloop;

    SELECT total_sum AS sum_of_numbers;
END //

DELIMITER ;

CALL Sum_Loop(5);  -- Output: 15

-- ----------------------------------------------------------------------------------------------------------


DELIMITER //

CREATE PROCEDURE printnumbers(IN num INT)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE output VARCHAR(255) DEFAULT '';

    lbl: LOOP
        SET i = i + 1;
        IF i > num THEN 
            LEAVE lbl;
        END IF;

        IF i % 2 = 0  THEN
            ITERATE lbl; -- skip number 5
        END IF;

        SET output = CONCAT(output, ' ', i%2=0);
    END LOOP lbl;

    SELECT output AS Numbers;
END //

DELIMITER ;


call printnumbers(10);
call printnumbers(20);
call printnumbers(30);


-- ----------------------------------------------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE Even_While(IN num INT)
BEGIN
    DECLARE i INT DEFAULT 2;  -- start from 2

    WHILE i <= num DO
        SELECT i AS even_number;
        SET i = i + 2;   -- move to next even number
    END WHILE;
END //

DELIMITER ;

CALL Even_While(10);

-- ------------------------------------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE Even_Repeat(IN num INT)
BEGIN
    DECLARE i INT DEFAULT 2;

    REPEAT
        SELECT i AS even_number;
        SET i = i + 2;
    UNTIL i > num
    END REPEAT;
END //

DELIMITER ;

CALL Even_Repeat(10);

-- ----------------------------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE Even_While_List(IN num INT)
BEGIN
    DECLARE i INT DEFAULT 2;
    DECLARE result TEXT DEFAULT '';

    WHILE i <= num DO
        SET result = CONCAT(result, i, ', ');
        SET i = i + 2;
    END WHILE;

    -- Remove last comma and space
    SELECT TRIM(TRAILING ', ' FROM result) AS even_numbers;
END //

DELIMITER ;

CALL Even_While_List(10);

-- ----------------------------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE Even_While_Reverse(IN num INT)
BEGIN
    DECLARE i INT;
    DECLARE result TEXT DEFAULT '';

    -- Start from the largest even <= num
    SET i = IF(num % 2 = 0, num, num - 1);

    WHILE i >= 2 DO
        SET result = CONCAT(result, i, ', ');
        SET i = i - 2;
    END WHILE;

    SELECT TRIM(TRAILING ', ' FROM result) AS reverse_even_numbers;
END //

DELIMITER ;

CALL Even_While_Reverse(10);



-- ----------------------------------------------------------------------------------------------------


DELIMITER //

CREATE PROCEDURE Even_While_Reverse(IN num INT)
BEGIN
    DECLARE i INT;
    DECLARE result TEXT DEFAULT '';

    -- Start from the largest even <= num
    SET i = IF(num % 2 = 0, num, num - 1);

    WHILE i >= 2 DO
        SET result = CONCAT(result, i, ', ');
        SET i = i - 2;
    END WHILE;

    SELECT TRIM(TRAILING ', ' FROM result) AS reverse_even_numbers;
END //

DELIMITER ;

CALL Even_While_Reverse(10);


-- ----------------------------------------------------------------------------------------------------------

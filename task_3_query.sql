USE test_db_2019;
DECLARE @i INT, @j INT, @k INT, @grp_id INT, @grp_def VARCHAR(MAX);

DECLARE @result_tb TABLE
(
   grp INT,
   user_id INT,
   attributes VARCHAR(250)
);

DECLARE @tmp_tb_1 TABLE
(
   id INT NOT NULL IDENTITY(1, 1),
   user_id INT
);

DECLARE @tmp_tb_2 TABLE
(
   id INT NOT NULL IDENTITY(1, 1),
   attribute VARCHAR(50)
);

SET @grp_id = 1;
SET @k = 1;
SELECT @i = MIN(user_id) FROM test_4;

WHILE (@i IS NOT NULL)
BEGIN
    INSERT INTO @tmp_tb_1 (user_id) VALUES (@i);

    SELECT @j = MIN(id) FROM @tmp_tb_1;

    WHILE (@j IS NOT NULL)
    BEGIN
        INSERT INTO @tmp_tb_2 (attribute) 
            SELECT attribute FROM test_4
                WHERE user_id = (SELECT user_id FROM @tmp_tb_1 WHERE id = @j)
                EXCEPT SELECT attribute FROM @tmp_tb_2;
        
        WHILE ((SELECT attribute FROM @tmp_tb_2 
                WHERE id = @k) IS NOT NULL)
        BEGIN
            INSERT INTO @tmp_tb_1 (user_id) 
                SELECT DISTINCT user_id FROM test_4 
                WHERE attribute 
                IN (SELECT attribute FROM @tmp_tb_2 
                WHERE id = @k)
                EXCEPT (SELECT user_id FROM @tmp_tb_1)
            
            SET @k = @k + 1

        END

        SELECT @j = MIN(id) FROM @tmp_tb_1 WHERE id > @j;

    END

    SELECT @grp_def = STRING_AGG(attribute, ', ') FROM @tmp_tb_2;
    INSERT INTO @result_tb (user_id) SELECT user_id FROM @tmp_tb_1;
    UPDATE @result_tb SET grp = @grp_id,
        attributes = @grp_def
        WHERE user_id IN (SELECT user_id FROM @tmp_tb_1);
    

    SET @grp_id = @grp_id + 1;

    SELECT @i = MIN(user_id) FROM test_4 
        WHERE (user_id > @i) AND user_id NOT IN 
        (SELECT user_id FROM @result_tb);

    DELETE FROM @tmp_tb_1;
    DELETE FROM @tmp_tb_2;
END

SELECT * FROM @result_tb;

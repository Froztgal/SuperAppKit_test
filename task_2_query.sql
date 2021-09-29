DECLARE @i DATE, @counter INT, @change_grp INT,
@counter_lim INT, @group_num INT, @cur_grp INT;

DECLARE @tmp_tb_2 TABLE
(
   dates DATE,
   group_num INT
);

-- Make group labels

WITH tmp_tb_1 AS 
    (SELECT start_dates, end_dates,
            ROW_NUMBER() OVER(ORDER BY start_dates) AS group_num
        FROM test_2)

-- To timeline
    INSERT INTO @tmp_tb_2
    SELECT start_dates as dates, group_num FROM tmp_tb_1
    UNION 
    SELECT end_dates as dates, group_num FROM tmp_tb_1


-- Loop

SET @counter = 0
SET @counter_lim = 2
SELECT @i = MIN(dates) FROM @tmp_tb_2
SELECT @change_grp = group_num FROM @tmp_tb_2 WHERE dates = @i
SET @cur_grp = @change_grp

WHILE (@i IS NOT NULL)
BEGIN
    SELECT @group_num = group_num FROM @tmp_tb_2 WHERE dates = @i

    IF @change_grp != @group_num
    BEGIN
        UPDATE @tmp_tb_2 SET group_num = @change_grp WHERE group_num = @group_num
        SET @counter = @counter + 1
        SET @counter_lim = @counter_lim + 2
        SET @cur_grp = @cur_grp + 1
    END
    ELSE 
    BEGIN
        SET @counter = @counter + 1
    END
    
    IF @counter_lim = @counter
    BEGIN
        SET @cur_grp = @cur_grp + 1
        SET @change_grp = @cur_grp
        SET @counter = 0
        SET @counter_lim = 2
        SELECT @i = MIN(dates) FROM @tmp_tb_2 WHERE group_num = @change_grp
    END
    ELSE
    BEGIN
        SELECT @i = MIN(dates) FROM @tmp_tb_2 WHERE dates > @i
    END
END

SELECT MIN(dates) AS start_dates, MAX(dates) AS end_dates 
FROM @tmp_tb_2 GROUP BY group_num;


-- ALTER TABLE test_1 ADD result INT;

DECLARE @i INT, @res INT, @tmp INT
SET @res = 0
SELECT @i = MIN(years) FROM test_1
WHILE (@i IS NOT NULL)
BEGIN
    SELECT @tmp = accr FROM test_1 WHERE years = @i
    IF @tmp >= @res
        SET @res = @res + @tmp
    ELSE 
        SET @res = @res 
    UPDATE test_1 SET result = @res WHERE years = @i
    SELECT @i = MIN(years) FROM dbo.test_1 WHERE years > @i
END

SELECT * FROM test_1;
WITH cte
     AS (SELECT num,
                Lead(num, 1)
                  OVER (
                    ORDER BY id) AS num2,
                Lead(num, 2)
                  OVER (
                    ORDER BY id) AS num3
         FROM   logs)
SELECT DISTINCT num AS ConsecutiveNums
FROM   cte
WHERE  num = num2
       AND num = num3 
SELECT Max(num) AS num
FROM   (SELECT num,
               Count(num) AS cnt
        FROM   mynumbers
        GROUP  BY num
        HAVING Count(num) = 1) AS T 
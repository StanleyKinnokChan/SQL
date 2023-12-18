WITH cte
     AS (SELECT *,
                Sum(weight)
                  OVER (
                    ORDER BY turn) AS total
         FROM   queue)
SELECT TOP 1 person_name
FROM   cte
WHERE  total <= 1000
ORDER  BY turn DESC 
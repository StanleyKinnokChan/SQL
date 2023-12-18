WITH cte
     AS (SELECT DISTINCT *
         FROM   activities)
SELECT sell_date,
       Count(1)                          AS num_sold,
       String_agg(product, ',')
         within GROUP (ORDER BY product) AS products
FROM   cte
GROUP  BY sell_date
ORDER  BY sell_date 
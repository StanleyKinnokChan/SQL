SELECT product_name,
       Sum(unit) AS unit
FROM   orders o
       LEFT JOIN products p
              ON o.product_id = p.product_id
WHERE  LEFT(order_date, 7) = '2020-02'
GROUP  BY product_name
HAVING Sum(unit) >= 100 
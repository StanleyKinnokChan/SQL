WITH s
     AS (SELECT delivery_id,
                customer_id,
                ( CASE
                    WHEN order_date = customer_pref_delivery_date THEN 1
                    ELSE 0
                  END )                  AS immediate,
                Row_number()
                  OVER (
                    partition BY customer_id
                    ORDER BY order_date) AS order_no
         FROM   delivery)
SELECT Round(Sum(immediate) * 100.0 / Count(immediate), 2) AS
       immediate_percentage
FROM   s
WHERE  order_no = 1 
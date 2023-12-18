SELECT P.product_id,
       Isnull(Round(1.0 * Sum(u.units * p.price) / Sum(u.units), 2), 0) AS
       average_price
FROM   prices P
       LEFT JOIN unitssold U
              ON P.product_id = U.product_id
                 AND U.purchase_date BETWEEN P.start_date AND P.end_date
GROUP  BY P.product_id 
SELECT customer_id,
       Count(customer_id) AS count_no_trans
FROM   visits V
       LEFT JOIN transactions T
              ON V.visit_id = T.visit_id
WHERE  transaction_id IS NULL
GROUP  BY customer_id 
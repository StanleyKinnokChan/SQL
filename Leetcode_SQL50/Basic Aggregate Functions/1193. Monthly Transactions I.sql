SELECT Format (trans_date, 'yyyy-MM') AS month,
       country,
       Count(*)                       AS trans_count,
       Sum(CASE
             WHEN state = 'approved' THEN 1
             ELSE 0
           END)                       AS approved_count,
       Sum(amount)                    AS trans_total_amount,
       Sum(CASE
             WHEN state = 'approved' THEN amount
             ELSE 0
           END)                       AS approved_total_amount
FROM   transactions
GROUP  BY Format (trans_date, 'yyyy-MM'),
          country 
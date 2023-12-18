SELECT s.user_id,
       Round(Sum(CASE
                   WHEN action = 'confirmed' THEN 1
                   ELSE 0
                 END) * 1.0 / Count(*), 2) AS confirmation_rate
FROM   signups s
       LEFT JOIN confirmations c
              ON s.user_id = c.user_id
GROUP  BY s.user_id 
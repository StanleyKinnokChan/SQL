SELECT query_name,
       Round(Avg(rating * 1.0 / position), 2)     AS quality,
       Round(Sum(CASE
                   WHEN rating < 3 THEN 1.0
                   ELSE 0
                 END) * 100.0 / Count(rating), 2) AS poor_query_percentage
FROM   queries
GROUP  BY query_name 
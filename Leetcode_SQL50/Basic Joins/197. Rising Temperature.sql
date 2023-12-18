SELECT W1.id
FROM   weather W1,
       weather W2
WHERE  Datediff(day, W1.recorddate, W2.recorddate) = -1
       AND W1.temperature > W2.temperature 
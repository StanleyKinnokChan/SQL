SELECT NAME,
       bonus
FROM   employee E
       LEFT JOIN bonus B
              ON E.empid = B.empid
WHERE  bonus < 1000
        OR bonus IS NULL 
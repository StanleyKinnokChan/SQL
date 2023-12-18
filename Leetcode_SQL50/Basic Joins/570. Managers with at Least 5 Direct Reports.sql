SELECT NAME
FROM   employee
WHERE  id IN (SELECT managerid
              FROM   employee
              GROUP  BY managerid
              HAVING Count(*) >= 5); 
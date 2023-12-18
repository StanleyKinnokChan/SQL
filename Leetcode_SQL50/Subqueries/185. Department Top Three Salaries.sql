SELECT department,
       employee,
       salary
FROM   (SELECT D.NAME                      AS Department,
               E.NAME                      AS Employee,
               E.salary,
               Dense_rank()
                 OVER (
                   partition BY E.departmentid
                   ORDER BY E.salary DESC) AS rank
        FROM   employee E
               JOIN department D
                 ON E.departmentid = D.id) T
WHERE  rank <= 3 
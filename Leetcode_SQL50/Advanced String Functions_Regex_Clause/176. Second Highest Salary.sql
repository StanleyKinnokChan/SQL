SELECT Max(salary) AS SecondHighestSalary
FROM   employee
WHERE  salary < (SELECT Max(salary)
                 FROM   employee); 
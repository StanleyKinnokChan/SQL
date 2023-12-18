SELECT e1.employee_id,
       e1.NAME,
       Count(*)                    AS reports_count,
       Round(Avg(E2.age * 1.0), 0) AS average_age
FROM   employees E1
       JOIN employees E2
         ON E1.employee_id = E2.reports_to
GROUP  BY e1.employee_id
ORDER  BY e1.employee_id 
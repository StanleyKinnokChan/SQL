SELECT project_id,
       Round(Avg(experience_years * 1.0), 2) AS average_years
FROM   project p
       LEFT JOIN employee E
              ON P.employee_id = E.employee_id
GROUP  BY project_id 
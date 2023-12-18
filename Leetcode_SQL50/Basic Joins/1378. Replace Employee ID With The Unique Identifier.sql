SELECT unique_id,
       NAME
FROM   employees n
       LEFT JOIN employeeuni u
              ON n.id = u.id 
select employee_id from Employees

--managers which are not in the company
where manager_id not in ( 
    select employee_id 
    FROM Employees
    )
and salary <30000
order by employee_id
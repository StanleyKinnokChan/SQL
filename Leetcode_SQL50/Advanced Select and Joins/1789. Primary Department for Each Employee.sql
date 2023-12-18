# --using union
# select employee_id,department_id from employee group by employee_id having count(*)=1
# union
# select employee_id,department_id from employee where primary_flag='Y' 


# --OR create new flag
# with CTE as (
#   select 
#     employee_id, 
#     count(distinct primary_flag) as cnt_flag
#   from Employee
#   group by employee_id 
# )

# select e.employee_id, max(department_id) as department_id 
# FROM Employee e
# JOIN CTE on  e.employee_id = CTE.employee_id
# where cnt_flag = 2 and primary_flag = 'Y' or cnt_flag = 1
# group by employee_id,cnt_flag
# having count(department_id) = 1

-- using IN keywords
select employee_id,department_id 
from employee
where primary_flag='Y' OR employee_id IN (
  select employee_id 
  from employee
  group by employee_id having count(*)=1)

--sum of the amount each day first
with CTE as (
  select visited_on, sum(amount) as amount
  from Customer
  group by visited_on
),

--create sliding window
CTE2 as (
  select 
  visited_on,
  sum(amount) over (order by visited_on ROWS BETWEEN 6 preceding and current row) as amount,
  avg(amount*1.0) over (order by visited_on ROWS BETWEEN 6 preceding and current row) as average_amount,
  row_number() over (order by visited_on) as row_number
  from CTE
)

--rounding the avg and filter the days
select
  visited_on,
  amount,
  round(average_amount,2) as average_amount 
FROM CTE2
where row_number>6

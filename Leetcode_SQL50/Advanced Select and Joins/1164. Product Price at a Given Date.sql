--product list with changes up to target date
with ProductBeforeDate as (
  select product_id, max(change_date) as change_date 
  From Products
  where change_date <= '2019-08-16' --before the target date
  group by product_id
)

select Products.product_id, new_price as price
FROM Products 
INNER JOIN ProductBeforeDate
  ON Products.product_id = ProductBeforeDate.product_id and 
  Products.change_date = ProductBeforeDate.change_date 

Union

-- product without changes before target date
select product_id, 10 as price
FROM Products
group by product_id
having min(change_date) > '2019-08-16' 

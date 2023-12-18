WITH CTE AS
(SELECT product_id, year, quantity, price, RANK() OVER(partition by product_id order by year) as year_order
FROM Sales)
SELECT product_id, year as first_year, quantity, price
FROM CTE
WHERE year_order = 1

# --OR
# select product_id ,year as first_year,quantity,price
# from Sales
# where (product_id,year) in (select product_id,min(year) from Sales group by 1);
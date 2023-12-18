--user with most rating number
WITH CTE1 as (select top 1 U.name as results from MovieRating R
INNER JOIN Users U on R.user_id = U.user_id
group by R.user_id,U.name
order by count(U.user_id) DESC,U.name),

--movie with higest avg rating
CTE2 as (
select top 1 M.title as results from MovieRating R
INNER JOIN Movies M
ON R.movie_id = M.movie_id
where year(created_at) = 2020 and month(created_at)=2
group by R.movie_id, M.title
order by round(avg(rating*1.0),2) desc, M.title)

--combining the result
select * from CTE1
UNION ALL
select * from CTE2
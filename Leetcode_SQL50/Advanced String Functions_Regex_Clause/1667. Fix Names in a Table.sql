SELECT user_id,
       LEFT(Upper(NAME), 1)
       + Lower(RIGHT(NAME, Len(NAME)-1)) AS NAME
FROM   users
ORDER  BY user_id 
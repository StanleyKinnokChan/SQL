SELECT activity_date           AS day,
       Count(DISTINCT user_id) AS active_users
FROM   activity
WHERE  activity_date BETWEEN Dateadd(day, -30 + 1, '2019-07-27') AND
                             '2019-07-27'
GROUP  BY activity_date 
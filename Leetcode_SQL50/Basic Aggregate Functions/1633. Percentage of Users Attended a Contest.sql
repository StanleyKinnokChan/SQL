SELECT contest_id,
       Round(100.0 * Count(*) / (SELECT Count(user_id)
                                 FROM   users), 2) AS percentage
FROM   register r
GROUP  BY contest_id
ORDER  BY percentage DESC,
          contest_id 
DELETE FROM person
WHERE  id NOT IN (SELECT Min(id)
                  FROM   person
                  GROUP  BY email) 
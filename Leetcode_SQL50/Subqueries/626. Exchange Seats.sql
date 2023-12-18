--if ID is odd, fetch next id, if ID is even, ID-1
SELECT 
  CASE 
    WHEN ID % 2 = 1 THEN LEAD(ID, 1, ID) OVER (ORDER BY ID ASC)
    WHEN ID % 2 = 0 THEN ID - 1
  END AS ID,
  STUDENT
FROM SEAT
ORDER BY ID
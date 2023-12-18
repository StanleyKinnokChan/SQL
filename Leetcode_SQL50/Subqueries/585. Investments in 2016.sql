
--using subquery
select round(sum(tiv_2016*1.0),2) as tiv_2016
FROM Insurance 
WHERE 
      tiv_2015 IN (SELECT tiv_2015 
      FROM Insurance
      GROUP BY tiv_2015
      HAVING count(tiv_2015)>1) 
  AND 
    CONCAT(lat,lon) IN (SELECT CONCAT(lat,lon) 
      FROM Insurance 
      GROUP BY lat, lon
      HAVING COUNT(*) = 1)


---- using window func
-- WITH CTE AS (
-- 		SELECT
-- 			*,
-- 			COUNT(lat) OVER(PARTITION BY lat,lon) CountLatLon,
-- 			COUNT(tiv_2015) OVER(PARTITION BY tiv_2015) CountT_2015
-- 		FROM
-- 			Insurance T1
-- )
-- SELECT
-- 	ROUND(SUM(tiv_2016),2) tiv_2016 
-- FROM
-- 	CTE
-- WHERE
-- 	CountLatLon = 1
-- AND
-- 	CountT_2015 > 1
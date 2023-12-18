--reverse the column order and combine them so that all combination of requesting and accepting from each person can be captured
with CTE as ( 
  select requester_id,accepter_id 
  FROM RequestAccepted

  UNION ALL

  select accepter_id,requester_id
  FROM RequestAccepted
)


select top 1 requester_id as id, count(requester_id) as num
FROM CTE
GROUP BY requester_id
order by count(requester_id) desc
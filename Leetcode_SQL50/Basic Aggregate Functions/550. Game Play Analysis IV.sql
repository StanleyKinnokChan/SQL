
-- select round(count(distinct S1.player_id)*1.0/(select count(distinct player_id) FROM Activity),2) as fraction 
--  from S as S1 
-- JOIN S as S2 on S1.player_id = S2.player_id
-- where datediff(day, S1.event_date, S2.event_date) = 1

Select round(count(distinct a1.player_id)*1.0/(select count(distinct player_id) from Activity),2) as fraction
from (select player_id, min(event_date) as event_date
    from Activity
    group by player_id) as a1 
JOIN Activity as a2 on a1.player_id = a2.player_id
where datediff(day, a1.event_date, a2.event_date) = 1

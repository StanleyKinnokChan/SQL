SELECT teacher_id,
       Count(DISTINCT subject_id) AS cnt
FROM   teacher
GROUP  BY teacher_id 
SELECT s.student_id,
       s.student_name,
       J.subject_name,
       Count(e.student_id) AS attended_exams
FROM   students S
       CROSS JOIN subjects J
       LEFT JOIN examinations E
              ON S.student_id = E.student_id
                 AND J.subject_name = E.subject_name
GROUP  BY S.student_id,
          S.student_name,
          j.subject_name
ORDER  BY S.student_id,
          j.subject_name 
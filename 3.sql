SELECT sub.name AS subject, g.name AS [group], ROUND(AVG(m.grade), 2) AS average_grade
FROM marks m 
JOIN students s ON s.id = m.id 
JOIN subjects sub ON sub.name  = m.subject_name
JOIN [groups] g ON g.id = s.group_id 
WHERE m.subject_name = 'Maths'
GROUP BY g.name
ORDER BY average_grade DESC;
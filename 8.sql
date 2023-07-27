SELECT sub.name AS subject, ROUND(AVG(m.grade), 2) AS average_grade
FROM marks m 
JOIN subjects sub ON sub.name = m.subject_name 
JOIN lectors l ON l.id = sub.lector_id 
WHERE l.id = 1
GROUP BY sub.name
ORDER BY average_grade DESC;
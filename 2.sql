SELECT sub.name AS subject, s.full_name AS student_name, ROUND(AVG(m.grade), 2) AS average_grade
FROM marks m 
JOIN students s ON s.id = m.id 
JOIN subjects sub ON sub.name  = m.subject_name 
WHERE m.subject_name = 'Maths'
GROUP BY s.full_name 
ORDER BY average_grade DESC 
LIMIT 1;
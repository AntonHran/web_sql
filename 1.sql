SELECT s.full_name AS student_name, ROUND(AVG(m.grade), 2) AS average_grade 
FROM marks m 
LEFT JOIN students s ON s.id = m.student_id 
GROUP BY s.full_name 
ORDER BY average_grade DESC 
LIMIT 5;
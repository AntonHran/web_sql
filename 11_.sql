SELECT ROUND(AVG(m.grade), 2) AS average_grade, s2.full_name AS student, l.full_name AS lector, s.name AS subject
FROM subjects s 
JOIN students s2 ON s2.id = m.student_id
JOIN marks m ON m.subject_name = s.name 
JOIN lectors l ON l.id = s.lector_id 
WHERE s2.id = 9 and l.id = 4
GROUP BY s.name 
ORDER BY s.name;
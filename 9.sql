SELECT s.name AS student_subject
FROM subjects s 
JOIN marks m ON m.subject_name = s.name 
JOIN students s2 ON s2.id = m.student_id 
WHERE s2.id = 12
GROUP BY s.name 
ORDER BY s.name;

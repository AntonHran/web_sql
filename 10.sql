SELECT s.name AS subject, s2.full_name AS student, l.full_name AS lector 
FROM subjects s 
JOIN students s2 ON s2.id = m.student_id
JOIN marks m ON m.subject_name = s.name 
JOIN lectors l ON l.id = s.lector_id 
WHERE s2.id = 1 and l.id = 4
GROUP BY s.name 
ORDER BY s.name;

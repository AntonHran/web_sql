SELECT s.full_name AS student_name, m.grade
FROM students s 
JOIN [groups] g ON g.id = s.group_id
JOIN marks m ON m.student_id  = s.id 
JOIN subjects s2 ON s2.name = m.subject_name 
WHERE g.id = 1 AND s2.id = 6
GROUP BY s.full_name, m.grade  
ORDER BY s.full_name;
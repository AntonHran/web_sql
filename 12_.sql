SELECT s.full_name, m.grade, m.subject_name, m.date_getting
FROM students s 
JOIN [groups] g ON g.id = s.group_id
JOIN marks m ON m.student_id  = s.id 
WHERE g.id = 1 AND m.date_getting = (
SELECT MAX(date_getting)
FROM marks
JOIN subjects s ON s.name = marks.subject_name 
WHERE s.id = 1
GROUP BY s.name)
GROUP BY s.full_name, m.grade  
ORDER BY m.date_getting  DESC;
SELECT s.full_name AS student_name, ROUND(AVG(m.grade), 2) AS average_grade 
FROM marks m 
LEFT JOIN students s ON s.id = m.student_id 
GROUP BY s.full_name 
ORDER BY average_grade DESC 
LIMIT 5;

SELECT sub.name AS subject, s.full_name AS student_name, ROUND(AVG(m.grade), 2) AS average_grade
FROM marks m 
JOIN students s ON s.id = m.id 
JOIN subjects sub ON sub.name  = m.subject_name 
WHERE m.subject_name = 'Maths'
GROUP BY s.full_name 
ORDER BY average_grade DESC 
LIMIT 1;

SELECT sub.name AS subject, g.name AS [group], ROUND(AVG(m.grade), 2) AS average_grade
FROM marks m 
JOIN students s ON s.id = m.id 
JOIN subjects sub ON sub.name  = m.subject_name
JOIN [groups] g ON g.id = s.group_id 
WHERE m.subject_name = 'Maths'
GROUP BY g.name
ORDER BY average_grade DESC;

SELECT ROUND(AVG(m.grade), 2) AS average_grade
FROM marks m 

SELECT s.name AS subject, l.full_name AS lector_name
FROM subjects s 
JOIN lectors l ON l.id = s.lector_id  
WHERE l.id  = 4
GROUP BY s.name 
ORDER BY s.name;

SELECT s.full_name
FROM students s 
JOIN [groups] g ON g.id = s.group_id 
WHERE g.id = 1
GROUP BY s.full_name 
ORDER BY s.full_name;

SELECT s.full_name AS student_name, m.grade
FROM students s 
JOIN [groups] g ON g.id = s.group_id
JOIN marks m ON m.student_id  = s.id 
JOIN subjects s2 ON s2.name = m.subject_name 
WHERE g.id = 1 AND s2.id = 6
GROUP BY s.full_name, m.grade  
ORDER BY s.full_name;

SELECT sub.name AS subject, ROUND(AVG(m.grade), 2) AS average_grade
FROM marks m 
JOIN subjects sub ON sub.name = m.subject_name 
JOIN lectors l ON l.id = sub.lector_id 
WHERE l.id = 1
GROUP BY sub.name
ORDER BY average_grade DESC;

SELECT s.name AS student_subject
FROM subjects s 
JOIN marks m ON m.subject_name = s.name 
JOIN students s2 ON s2.id = m.student_id 
WHERE s2.id = 12
GROUP BY s.name 
ORDER BY s.name;

SELECT s.name AS subject, s2.full_name AS student, l.full_name AS lector 
FROM subjects s 
JOIN students s2 ON s2.id = m.student_id
JOIN marks m ON m.subject_name = s.name 
JOIN lectors l ON l.id = s.lector_id 
WHERE s2.id = 1 and l.id = 4
GROUP BY s.name 
ORDER BY s.name;

SELECT ROUND(AVG(m.grade), 2) AS average_grade, s2.full_name AS student, l.full_name AS lector, s.name AS subject
FROM subjects s 
JOIN students s2 ON s2.id = m.student_id
JOIN marks m ON m.subject_name = s.name 
JOIN lectors l ON l.id = s.lector_id 
WHERE s2.id = 9 and l.id = 4
GROUP BY s.name 
ORDER BY s.name;

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

SELECT MAX(date_getting)
FROM marks
JOIN subjects s ON s.name = marks.subject_name 
WHERE s.id = 1
GROUP BY s.name;

SELECT MAX(date_getting)
FROM marks;

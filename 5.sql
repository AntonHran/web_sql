SELECT s.name AS subject, l.full_name AS lector_name
FROM subjects s 
JOIN lectors l ON l.id = s.lector_id  
WHERE l.id  = 4
GROUP BY s.name 
ORDER BY s.name;
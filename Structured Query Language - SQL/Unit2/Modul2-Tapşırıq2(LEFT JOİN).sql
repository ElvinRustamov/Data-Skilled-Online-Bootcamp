/*
Tapşırıq-2 (LEFT JOİN)
1.Hansı ölkələrin əlaqəli şöbələri yoxdur?

2.Bütün işçilərin adları və e-poçt ünvanları və onların menecerlərinin adları və e-poçt ünvanlarını (əgər varsa) bir araya gətirin.
*/

/* 1 */

SELECT 
	country_name, 
	c.country_id, 
	d.department_id
FROM 
	countries AS c
LEFT JOIN 
	locations AS l 
ON 
	c.country_id = l.country_id
LEFT JOIN 
	departments AS d
ON 
	l.location_id = d.location_id
WHERE 
	d.location_id IS NULL;


/* 2 */

SELECT 
	e1.first_name, 
	e1.email,
	e2.manager_id,
	e2.first_name,
	e2.email
FROM 
	employees AS e1
INNER JOIN employees AS e2
ON e1.manager_id = e2.manager_id

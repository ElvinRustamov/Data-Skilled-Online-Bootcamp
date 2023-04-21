/*
Tapşırıq-1 (İNNER JOİN)
Seattle şəhərində yerləşən şöbələrdə hansı işçilər işləyir?
*/

SELECT 
	e.employee_id,
	e.first_name,
	d.department_id,
	d.department_name,
	d.location_id,
	l.city
FROM 
	departments d
INNER JOIN employees e ON d.department_id = e.department_id
INNER JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'Seattle';

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


/*
Tapşırıq-2 (LEFT JOİN)
1.Hansı ölkələrin əlaqəli şöbələri yoxdur?

2.Bütün işçilərin adları və e-poçt ünvanları və onların menecerlərinin adları və e-poçt ünvanlarını (əgər varsa) bir araya gətirin.
*/

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

/*
Tapşırıq -3(SUM)
Hər bir departament üçün ümumi əmək haqqı nə qədərdir?
*/


SELECT department_id, SUM(salary) AS salary
FROM employees
GROUP BY department_id;


SELECT 
	d.department_name,
	SUM(salary) AS salary
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;


/*
Tapşırıq -4(AVG)
'Marketing Manager' vəzifəsi olan bütün işçilər üçün orta əmək haqqı nə qədərdir?
*/

SELECT 
	e.job_id,
	j.job_title,
	AVG(salary) AS average_salary
FROM 
	employees e
INNER JOIN jobs j ON e.job_id = j.job_id
WHERE 
	j.job_title = 'Marketing Manager'
GROUP BY 
	e.job_id,
	j.job_title;



SELECT 
	e.job_id,
	j.job_title,
	AVG(salary) AS average_salary
FROM 
	employees e
INNER JOIN jobs j ON e.job_id = j.job_id
GROUP BY 
	e.job_id,
	j.job_title
HAVING 	
	j.job_title = 'Marketing Manager';


/*
Tapşırıq -4(GROUP BY)
Hər bir job title üçün orta əmək haqqını göstərən SQL sorğusu yazın.
*/

SELECT 
	e.job_id,
	j.job_title,
	AVG(salary) AS average_salary
FROM 
	employees e
INNER JOIN jobs j ON e.job_id = j.job_id
GROUP BY 
	e.job_id,
	j.job_title;


/*
Tapşırıq -4(SUBQUERY)
Alt sorğu ilə işçilərinin əmək haqqı 5.000 dollardan çox olan şöbələri tapın.
*/

SELECT
	*
FROM 
	departments
WHERE 
	department_id IN (SELECT 
			department_id 
		FROM 
			employees 
		WHERE 
			salary > 5000);


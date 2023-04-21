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
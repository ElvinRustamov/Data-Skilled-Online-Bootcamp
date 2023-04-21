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
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
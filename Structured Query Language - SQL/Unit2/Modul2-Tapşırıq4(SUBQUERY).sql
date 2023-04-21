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

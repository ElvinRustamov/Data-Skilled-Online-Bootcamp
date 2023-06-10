/*
Tapşırıq-2 (UPDATE)
"Employees" cədvəlində bir sətir üzrə iki sütunu yeniləyin.
*/

-- employee_id-si 100 beraber olan setir uzerinde first_name ve last_name sutunlarinin deyerini yeniledim.
UPDATE
	employees
SET 
	first_name = 'Updated',
	last_name = 'Updated'
WHERE 
	employee_id = 100;


SELECT 
	*
FROM 
	employees
WHERE 
	employee_id = 100;
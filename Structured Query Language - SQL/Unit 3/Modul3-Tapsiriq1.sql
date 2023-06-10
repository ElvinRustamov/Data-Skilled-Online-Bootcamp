/*Tapşırıq-1 (İNSERT)
"Employees" cədvəlinə bütün sütunlar üzrə uyğun qiymətlər daxil edin.
*/
SET IDENTITY_INSERT employees ON;
INSERT INTO 
	employees(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id)
VALUES 
	(99, 'Inserted Name', 'Inserted lastname', 'insertedmail@gmail.com', '999 999 9999', '1999-09-19', '9', '99999', '100', '9')
SET IDENTITY_INSERT employees OFF; 

SELECT 
	*
FROM 
	employees;
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


/*
Tapşırıq-3 (DELETE)
dependents cədvəlindən employee_id 101,102 və 103 olan sətirləri silin. Bunu bir sorğu yazaraq edin.
*/

DELETE FROM 
	dependents
WHERE 
	employee_id in (101, 102, 103);

SELECT 
	* 
FROM 
	dependents 
WHERE 
	employee_id IN (101, 102, 103);


/*
Tapşırıq-4 (CREATE)
4 sütunlu yeni bir cədvəl yaradın.
*/

-- Deyerler ucun istifade etdiyim vebsayt: https://www.mockaroo.com/

CREATE TABLE createdtable (
	id INTEGER,
	name VARCHAR(50),
	birthday DATE,
	email VARCHAR(100)
);

insert into createdtable (id, name, birthday, email) values (1, 'Evered', '2006-02-26', 'eestrella0@xing.com');
insert into createdtable (id, name, birthday, email) values (2, 'Basilio', '1976-05-31', 'bchezelle1@alibaba.com');
insert into createdtable (id, name, birthday, email) values (3, 'Austina', '1964-01-31', 'agogin2@zimbio.com');
insert into createdtable (id, name, birthday, email) values (4, 'Burke', '1988-03-05', 'bmilazzo3@microsoft.com');


/*
Tapşırıq-5 (ALTER)
Yeni yaratdığınız cədvələ bir yeni sütun əlavə edin.
*/

ALTER TABLE 
	createdtable
ADD 
	last_name VARCHAR(50);


SELECT * FROM createdtable;


/*
Tapşırıq-6 (DROP)
Yaratdığınız yeni cədvəli silin.
*/
DROP TABLE createdtable;

-- SELECT * FROM createdtable;  Output: Invalid object name 'createdtable'. DELETED.
                                                                   /**Tapşırıq-1 (SELECT)**/
--1. “employees” cədvəlindən bütün sütunları seçmək əmri hansıdır?
SELECT * FROM [master].[dbo].[employees]; /**SELECT * FROM employees **/

--2.“employees” cədvəlindən yalnız "first_name" və "last_name" sütunlarını necə seçərdiniz?
SELECT first_name, last_name FROM [master].[dbo].[employees]; /**SELECT first_name, last_name FROM employees **/



                                                                   /**Tapşırıq-2 (ORDER BY)**/
--1. Employee ID, first name, last name, və salary sütunlarını seçin və onları last name-ə görə əlifba sırası ilə sıralalayın.
SELECT employee_id, first_name, last_name, salary 
FROM [master].[dbo].[employees] 
ORDER BY last_name ASC;

--2. department ID, department name, və location ID sütunalrını seçin və location ID-yə gürə azalan qaydada sıralayın.
SELECT department_id, department_name, location_id 
FROM [master].[dbo].[departments] 
ORDER BY location_id DESC;



                                                                   /**Tapşırıq-3 (DISTINCT)**/
--Bütün unikal iş adlarının(job title) siyahısını "employees" cədvəlindən necə əldə edərdiniz?
-- Employees cədvəlindı job_title adlı sütun yoxdur. job_title adlı sütün jobs cədvəlində var, buna görədə mən jobs cədvəlindən istifadə etmişəm.
SELECT DISTINCT job_title FROM [master].[dbo].[jobs];

--Ikinci bir usul olaraqda employees cədvəlində yerləşən job_id sütunundan istifadə edə bilərəm.
SELECT DISTINCT job_id FROM [master].[dbo].[employees];
--Çıxan nəticə bir o qədər məna ifadə etmir.
--Hər iki cədvəldə job_id sütunu var. Bu sütunnan istifadə edib əldə etdiyim unikal job_id uyğun gələn job_title nəticə olaraq çıxarda bilərəm.

SELECT a.job_id, b.job_id, a.job_title 
FROM [master].[dbo].[jobs] a, [master].[dbo].[employees] b 
WHERE a.job_id = b.job_id;



                                                                   /**Tapşırıq-4 (FETCH)**/

--Ən yüksək maaş alan 6-cı işçidən başlayaraq, maaşa görə azalan sıraya görə ən yüksək maaş alan 10 işçinin siyahısını necə əldə edərdiniz?
SELECT * FROM [master].[dbo].[employees]
ORDER BY salary DESC
OFFSET 5 ROWS
FETCH NEXT 10 ROWS ONLY;



                                                                   /**Tapşırıq-5 (COMPARE)**/
--1.İllik 5.000 ABŞ dollarından çox və ya ona bərabər maaş alan bütün işçilərin siyahısını "işçilər" cədvəlindən necə əldə edərdiniz?
SELECT * FROM [master].[dbo].[employees]
WHERE salary >= 5000;



                                                                   /**Tapşırıq-6 (LIKE)**/
--Soyadında "son" hərfləri olan bütün işçilərin siyahısını "employees" cədvəlindən necə əldə edərdiniz?
SELECT * FROM [master].[dbo].[employees]
WHERE last_name LIKE '%son%';

--SELECT * FROM [master].[dbo].[employees]
--WHERE last_name LIKE '%son';

--SELECT * FROM [master].[dbo].[employees]
--WHERE last_name LIKE 'son%';


                                                                   /**Tapşırıq-7 (CASE)**/
/**"employees'' cədvəlindən first_name,last_name və salary sütunlarını seçin. 
Maaşı 100000-dən çox olan işçləri 'High', 50000 və 100000 aralığında olanları isə 'Medium' olaraq işarələyin. 
Yeni sütunu isə 'salary_range' adını verin.**/
SELECT first_name, 
	last_name, 
	salary,
	CASE 
		WHEN salary > 10000 THEN 'High'
		WHEN salary >= 5000 AND salary <= 10000 THEN 'Medium'
	END salary_range
FROM [master].[dbo].[employees];

--Datadan gördüyüm qədəri ilə ən böyük dəyər 24000-dir. Şərtdə olan 50 000 və 100 000 dəyərləri olmadığı üçün bu dəyərləri 5000 və 10 000 olaraq götürdüm.
SELECT first_name, 
	last_name, 
	salary,
	CASE 
		WHEN salary > 10000 THEN 'High'
		WHEN salary >= 5000 AND salary <= 10000 THEN 'Medium'
		WHEN salary < 5000 THEN 'Low'
	END salary_range
FROM [master].[dbo].[employees];
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
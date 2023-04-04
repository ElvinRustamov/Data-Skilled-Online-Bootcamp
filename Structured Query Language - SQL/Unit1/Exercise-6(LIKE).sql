                                                                   /**Tapşırıq-6 (LIKE)**/
--Soyadında "son" hərfləri olan bütün işçilərin siyahısını "employees" cədvəlindən necə əldə edərdiniz?
SELECT * FROM [master].[dbo].[employees]
WHERE last_name LIKE '%son%';

--SELECT * FROM [master].[dbo].[employees]
--WHERE last_name LIKE '%son';

--SELECT * FROM [master].[dbo].[employees]
--WHERE last_name LIKE 'son%';
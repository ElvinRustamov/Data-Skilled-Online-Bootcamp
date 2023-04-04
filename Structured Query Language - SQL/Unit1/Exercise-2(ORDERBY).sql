                                                                   /**Tapşırıq-2 (ORDER BY)**/
--1. Employee ID, first name, last name, və salary sütunlarını seçin və onları last name-ə görə əlifba sırası ilə sıralalayın.
SELECT employee_id, first_name, last_name, salary 
FROM [master].[dbo].[employees] 
ORDER BY last_name ASC;

--2. department ID, department name, və location ID sütunalrını seçin və location ID-yə gürə azalan qaydada sıralayın.
SELECT department_id, department_name, location_id 
FROM [master].[dbo].[departments] 
ORDER BY location_id DESC;
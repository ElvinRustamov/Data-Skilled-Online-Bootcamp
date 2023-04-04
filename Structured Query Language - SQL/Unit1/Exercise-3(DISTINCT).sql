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

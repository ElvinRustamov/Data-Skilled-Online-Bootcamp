                                                                   /**Tapşırıq-4 (FETCH)**/

--Ən yüksək maaş alan 6-cı işçidən başlayaraq, maaşa görə azalan sıraya görə ən yüksək maaş alan 10 işçinin siyahısını necə əldə edərdiniz?
SELECT * FROM [master].[dbo].[employees]
ORDER BY salary DESC
OFFSET 5 ROWS
FETCH NEXT 10 ROWS ONLY;

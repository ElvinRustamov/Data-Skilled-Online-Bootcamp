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
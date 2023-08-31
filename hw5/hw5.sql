USE seminar4;
/*Создайте представление, в которое попадет информация о пользователях (имя, фамилия,
город и пол), которые не старше 20 лет*/
CREATE VIEW young_users AS
	(SELECT firstname, lastname, hometown, gender
	FROM users
	JOIN profiles ON users.id = profiles.user_id
   WHERE YEAR(NOW()) - YEAR(profiles.birthday) <= 20 );
   
SELECT * FROM young_users;
   
/*Найдите кол-во, отправленных сообщений каждым пользователем и выведите
ранжированный список пользователей, указав имя и фамилию пользователя, количество
отправленных сообщений и место в рейтинге (первое место у пользователя с максимальным
количеством сообщений) . (используйте DENSE_RANK)*/
SELECT users.id, firstname, lastname, 
COUNT(body) AS cnt,
DENSE_RANK() OVER (ORDER BY COUNT(body) DESC) AS 'rank'
FROM users
LEFT JOIN messages ON users.id = messages.from_user_id
GROUP BY users.id;
   
/*Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления
(created_at) и найдите разницу дат отправления между соседними сообщениями, получившегося
списка. (используйте LEAD или LAG)*/
SELECT id, body, created_at,
LAG(created_at) OVER time_created_at AS previous,
LEAD(created_at) OVER time_created_at AS next
FROM messages
WINDOW time_created_at AS (ORDER BY created_at)
ORDER BY created_at;
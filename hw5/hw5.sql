USE seminar4;
/*Создайте представление, в которое попадет информация о пользователях (имя, фамилия,
город и пол), которые не старше 20 лет*/
CREATE VIEW young_users AS
	(SELECT firstname, lastname, hometown, gender
	FROM users
	JOIN profiles ON users.id = profiles.user_id
   WHERE YEAR(NOW()) - YEAR(profiles.birthday) <= 20 );
   
   SELECT * FROM young_users;
   
/*Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления
(created_at) и найдите разницу дат отправления между соседними сообщениями, получившегося
списка. (используйте LEAD или LAG)*/
SELECT id, body, created_at,
LAG(created_at) OVER time_created_at AS previous,
LEAD(created_at) OVER time_created_at AS next
FROM messages
WINDOW time_created_at AS (ORDER BY created_at)
ORDER BY created_at;
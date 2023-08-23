USE seminar4; 
-- Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.
SELECT SUM(likes.media_id) FROM likes
JOIN `profiles` AS p ON likes.user_id = p.user_id
WHERE YEAR(NOW()) - YEAR(p.birthday) < 12;

-- Определить кто больше поставил лайков (всего): мужчины или женщины
SELECT 
IF (
	(SELECT SUM(likes.media_id)  AS "winner_of_likes" 
	FROM likes
	JOIN `profiles` AS p ON likes.user_id = p.user_id
	WHERE p.gender = 'm') > 
    (SELECT SUM(likes.media_id)  AS "winner_of_likes" 
	FROM likes
	JOIN `profiles` AS p ON likes.user_id = p.user_id
	WHERE p.gender = 'f'), 
    "men", "women"
)
AS "winner_of_likes";

-- Вывести всех пользователей, которые не отправляли сообщения.
SELECT users.id, firstname, lastname FROM users
WHERE users.id  NOT IN 
	(SELECT DISTINCT from_user_id FROM messages);    
    
    
    

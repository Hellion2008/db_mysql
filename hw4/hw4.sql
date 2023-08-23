USE seminar4; 
-- Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.
SELECT p.user_id, p.birthday 
FROM `profiles` AS p
WHERE YEAR(NOW()) - YEAR(p.birthday) < 12;

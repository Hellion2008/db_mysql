USE seminar4;
/* выбрать всех пользователей, указав их id, имя и фамилию, город и аватарку
(используя влож енны е запросы )
*/
SELECT id, firstname, lastname, 
(SELECT hometown FROM profiles 
WHERE users.id = profiles.user_id ) AS hometown,
(SELECT photo_id FROM profiles 
WHERE users.id = profiles.user_id ) AS photp_id 
FROM users;

/*выбрать фотографи и (filename) пользователя с email:
arlo50@ example.org.
ID типа медиа, соответствующий фотограф иям неизвестен
(используя влож енны е запросы )
*/
SELECT filename, user_id 
FROM media
WHERE media.user_id = 
	(SELECT id FROM users 
	WHERE email = "arlo50@example.org")
AND media_type_id = 
	 (SELECT id FROM media_types
     WHERE name_type = 'Photo');
     
/* выбрать id друзей пользователя с id = 1
(используя UNI ON)
*/
SELECT initiator_user_id FROM friend_requests
WHERE target_user_id = 1 
AND `status` = 'approved'
UNION SELECT target_user_id FROM friend_requests
WHERE initiator_user_id = 1 
AND `status` = 'approved';

/*выбрать всех пользователей, указав их id, имя ифамилию, город и аватарку
(используя J OI N)
*/
SELECT id, firstname, lastname, hometown, photo_id FROM users
LEFT JOIN profiles ON users.id = profiles.user_id;

/*Список медиаф айлов пользователей с количеством
лайков (используя J OI N)
*/
SELECT media.user_id, firstname, lastname, filename, COUNT(likes.media_id) FROM media
JOIN users ON media.user_id = users.id
JOIN likes ON likes.media_id = media.id
GROUP BY likes.media_id;
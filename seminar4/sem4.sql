USE seminar4;

SELECT id, firstname, lastname, 
(SELECT hometown FROM profiles 
WHERE users.id = profiles.user_id ) AS hometown,
(SELECT photo_id FROM profiles 
WHERE users.id = profiles.user_id ) AS photp_id 
FROM users;

SELECT filename, user_id 
FROM media
WHERE media.user_id = 
	(SELECT id FROM users 
	WHERE email = "arlo50@example.org")
AND media_type_id = 
	 (SELECT id FROM media_types
     WHERE name_type = 'Photo');

SELECT initiator_user_id FROM friend_requests
WHERE target_user_id = 1 
AND `status` = 'approved'
UNION SELECT target_user_id FROM friend_requests
WHERE initiator_user_id = 1 
AND `status` = 'approved';

SELECT id, firstname, lastname, hometown, photo_id FROM users
LEFT JOIN profiles ON users.id = profiles.user_id;

SELECT media.user_id, firstname, lastname, filename, COUNT(likes.media_id) FROM media
JOIN users ON media.user_id = users.id
JOIN likes ON likes.media_id = media.id
GROUP BY likes.media_id;
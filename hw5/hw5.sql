USE seminar4;

CREATE VIEW young_users AS
	(SELECT firstname, lastname, hometown, gender
	FROM users
	JOIN profiles ON users.id = profiles.user_id
   WHERE YEAR(NOW()) - YEAR(profiles.birthday) <= 20 );
   
   SELECT * FROM young_users;
   
   
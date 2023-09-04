/*создайте процедуру, которая выберет для 1 пользователя 5 пользователей 
в случайно комбинации, которые удовлетворяют хотя бы 1 критерию:
1. из одного города 
2. состоит в 1 группе 
3. друзья друзей */ 
DROP PROCEDURE IF EXISTS user_friends;
DELIMITER // 
CREATE PROCEDURE user_friends(id INT)
	BEGIN
		SELECT * FROM profiles
      WHERE hometown = 
			(SELECT hometown FROM profiles WHERE user_id = id)
		AND user_id != id; 
   END//
   DELIMITER ;
   
   CALL user_friends(1);
   -- НЕ РЕШЕНА!!!!!
   
   /*Создание функции, вычисляющей коэфф популярности пользователя (по заявкам на дружбу friend_requests)*/
   DROP PROCEDURE IF EXISTS rank_user;
   DELIMITER //
   CREATE FUNCTION rank_user(us_id INT)
   RETURNS FLOAT READS SQL DATA
   BEGIN
		set @rank := 1.0;
      
      set @rank := 
			(SELECT COUNT(friend_requests.initiator_user_id) 
         FROM friend_requests 
         WHERE friend_requests.target_user_id = us_id) / 
         (SELECT COUNT(users.id) FROM users);
      RETURN @RANK;
   END//
   DELIMITER ;
   
   SELECT rank_user(1);
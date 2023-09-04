
/*Создайте таблицу users_old, аналогичную таблице users. Создайте
процедуру, с помощью которой можно переместить любого (одного)
пользователя из таблицы users в таблицу users_old. (использование
транзакции с выбором commit или rollback – обязательно)*/
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);

DROP PROCEDURE IF EXISTS add_user;
DELIMITER //
CREATE PROCEDURE add_user(id_users INT)
BEGIN
	START TRANSACTION;
	INSERT INTO users_old SELECT * FROM users WHERE users.id = id_users;
	DELETE FROM users WHERE users.id = id_users LIMIT 1;
	COMMIT;
	END //
DELIMITER ;

CALL add_user(10);

DROP FUNCTION IF EXISTS hello;
 DELIMITER //
 CREATE FUNCTION hello()
 RETURNS VARCHAR(20) READS SQL DATA
 BEGIN
   SET @morning = '06:00:00';
   SET @afternoon = '12:00:00';
   SET @evening = '18:00:00';
   SET @night = '00:00:00';
   RETURN
	CASE
		WHEN CURTIME() >= @evening_up AND CURTIME() <  @night_up THEN 'Доброй ночи!'
        WHEN CURTIME() >= @night_up AND CURTIME() <  @morning_up THEN 'Доброу утро!'
        WHEN CURTIME() >= @morning_up AND CURTIME() <  @afternoon_up THEN 'Добрый день!'
        WHEN CURTIME() >= @afternoon_up AND CURTIME() <  @evening_up THEN 'Добрый вечер!'
	END;
END//
 DELIMITER ;
 
 SELECT CURTIME() AS 'time', hello() AS message;
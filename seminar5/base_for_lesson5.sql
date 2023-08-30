DROP DATABASE IF EXISTS seminar5;
CREATE DATABASE seminar5;
USE seminar5;

-- Персонал
DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	firstname VARCHAR(45),
	lastname VARCHAR(45),
	post VARCHAR(100),
	seniority INT, 
	salary INT, 
	age INT
);

-- Наполнение данными
INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
('Вася', 'Петров', 'Начальник', '40', 100000, 60),
('Петр', 'Власов', 'Начальник', '8', 70000, 30),
('Катя', 'Катина', 'Инженер', '2', 70000, 25),
('Саша', 'Сасин', 'Инженер', '12', 50000, 35),
('Ольга', 'Васютина', 'Инженер', '2', 70000, 25),
('Петр', 'Некрасов', 'Уборщик', '36', 16000, 59),
('Саша', 'Петров', 'Инженер', '12', 50000, 49),
('Иван', 'Сидоров', 'Рабочий', '40', 50000, 59),
('Петр', 'Петров', 'Рабочий', '20', 25000, 40),
('Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
('Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
('Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
('Максим', 'Максимов', 'Рабочий', '2', 11000, 22),
('Юрий', 'Галкин', 'Рабочий', '3', 12000, 24),
('Людмила', 'Маркина', 'Уборщик', '10', 10000, 49),
('Юрий', 'Онегин', 'Начальник', '8', 100000, 39);



-- Оценки учеников
DROP TABLE IF EXISTS academic_record;
CREATE TABLE academic_record (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(45),
	quartal  VARCHAR(45),
    subject VARCHAR(45),
	grade INT
);

INSERT INTO academic_record (name, quartal, subject, grade)
values
	('Александр','1 четверть', 'математика', 4),
	('Александр','2 четверть', 'русский', 4),
	('Александр', '3 четверть','физика', 5),
	('Александр', '4 четверть','история', 4),
	('Антон', '1 четверть','математика', 4),
	('Антон', '2 четверть','русский', 3),
	('Антон', '3 четверть','физика', 5),
	('Антон', '4 четверть','история', 3),
    ('Петя', '1 четверть', 'физика', 4),
	('Петя', '2 четверть', 'физика', 3),
	('Петя', '3 четверть', 'физика', 4),
	('Петя', '2 четверть', 'математика', 3),
	('Петя', '3 четверть', 'математика', 4),
	('Петя', '4 четверть', 'физика', 5);

/*получить с помощью оконных функций: ср. балл ученика, мин оценку ученика, макс оценку ученика, сумму всех оценок
кол-во всех оценок*/
SELECT name, 
AVG(grade) OVER (partition by name), 
MIN(grade) OVER (partition by name), 
MAX(grade) OVER (partition by name),
SUM(grade) OVER (partition by name), 
COUNT(grade) OVER (partition by name)
FROM academic_record;

/*получить информацию об оценках Пети по физике по четвертям
текущая успеваемость, оценка в след четверти, оценка а предыдущей четверти*/
SELECT name, 
grade, 
LAG(grade) OVER ql,
LEAD(grade) OVER ql
FROM academic_record
WHERE name = 'Петя'
AND subject = 'физика'
WINDOW ql AS (ORDER BY quartal);

use seminar4;

/*1. создайте представление, в котором будут выводиться все сообщения, в которых принимал участие пользователь с id=1
2. найдите друзей у друзей пользователя с id = 1 и поместите выборку в представление (с помощью with)
3. найдите друзей у друзей пользователя  с id = 1 (решение с помощью представления "друзья")*/
CREATE  OR REPLACE VIEW view_messages AS
SELECT body FROM messages
WHERE from_user_id = 1 OR 
to_user_id = 1;

WITH temp_friends AS
	(SELECT initiator_user_id AS fid
    FROM friend_requests
    WHERE target_user_id = 1
    AND status = 'approved'
    UNION
    SELECT target_user_id
    FROM friend_requests
    WHERE initiator_user_id = 1
    AND status = 'approved'
    )
SELECT * FROM temp_friends;

SELECT initiator_user_id
from temp_friends
join friend_requests on target_user_id = fid
where initiator_user_id != 1
AND status = 'approved'
UNION
SELECT target_user_id
FROM temp_friends
join friend_requests on initiator_user_id = fid
WHERE target_user_id = 1
AND status = 'approved';


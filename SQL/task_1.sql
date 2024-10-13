CREATE DATABASE family;
USE family ;

CREATE TABLE FamilyMembers (
member_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
status ENUM('Dad', 'Mom', 'Son', 'Daughter'),
member_name VARCHAR(30),
birthdate DATE 
);

CREATE TABLE Payments (
payment_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
good_name VARCHAR(20),
amount INT,
date DATE 
);

CREATE TABLE FamilyFriends (
friend_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
friend_name VARCHAR(30),
member_name VARCHAR(30),
friend_age INT
);


SELECT * FROM FamilyMembers;
SELECT * FROM Payments;
SELECT * FROM FamilyFriends;

INSERT INTO FamilyMembers VALUE ('Mom' , 'Ayazhan', '2021-11-03')
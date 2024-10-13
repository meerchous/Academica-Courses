DROP DATABASE university;

CREATE DATABASE university;
USE university;


CREATE TABLE Address (
Id INT NOT NULL  AUTO_INCREMENT,
Country VARCHAR(20),
City VARCHAR(20),
Street VARCHAR(30),
Number INT DEFAULT NULL ,
PRIMARY KEY (Id)
);

CREATE TABLE Person (
Id INT NOT NULL AUTO_INCREMENT,
FirstName VARCHAR(30),
LastName VARCHAR(30),
PhoneNumber VARCHAR(12),
BirthDate DATE,
AddressId INT,
PRIMARY KEY (Id),
FOREIGN KEY (AddressId) REFERENCES Address(Id) ON DELETE CASCADE,
UNIQUE (PhoneNumber)
);

CREATE TABLE Teacher (
Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Position VARCHAR(30),
PersonId INT,
FOREIGN KEY (PersonId) REFERENCES Person(Id) ON DELETE CASCADE 
);

CREATE TABLE Course (
Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(30),
Credits INT,
Description VARCHAR(50),
TeacherId INT,
FOREIGN KEY (TeacherId) REFERENCES Teacher(Id) ON DELETE CASCADE
);

CREATE TABLE Student (
Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
PersonId INT,
Description VARCHAR(50),
FOREIGN KEY (PersonId) REFERENCES Person(Id) ON DELETE CASCADE
);

INSERT INTO Address (Id, Country, City, Street) VALUES (NULL, 'USA', 'Ozark', 'Blue Cat Lodge');

INSERT INTO Address VALUES (NULL, 'Kazakhstan', 'Almaty', 'Tole bi', '59'),
(NULL, 'Kazakhstan', 'Astana', 'Manglik El', '55'),
(NULL, 'Kazakhstan', 'Almaty', 'Furmanova', '14'),
(NULL, 'Switzerland', 'Basel', 'Freie Str.', '47');


				/* Adding Teachers to Person table */
INSERT INTO Person VALUES (NULL, 'Chokan', 'Laumullin', '87051234567', '1961-05-05', 4),
(NULL, 'Marty', 'Byrde', '87006667766', '1960-10-23', 1),
(NULL, 'Beibut', 'Kulpeshev', '87026591985', '1962-02-17', 2),
(NULL, 'Kuat', 'Akezhan', '87771452231', '1977-11-11',3),
(NULL, 'Avrelli', 'Kavendish', '87771312244','1971-05-17', 5); 

INSERT INTO Teacher VALUES (NULL, 'Professor', 1),
(NULL, 'Assistant', 2),
(NULL, 'Professor', 3),
(NULL, 'Senior Lector', 4),
(NULL, 'Lector', 5);

INSERT INTO Course VALUES (NULL, 'Finance', 4, 'Money, currency and capital assets', 2),
(NULL, 'IT Audit', 3, 'technology audit, or information systems audit', 5),
(NULL, 'Philosophy', 5, 'study of general and fundamental questions', 1),
(NULL, 'Calculus', 5, 'study of generalizations of arithmetic operations',3),
(NULL, 'Business', 4, 'any activity or enterprise entered into for profit', 4);

				/* Adding Students to Person table */
INSERT INTO Person VALUES (NULL, 'Perviy', 'Student', '87071470706', '2000-06-05', 2),
(NULL, 'Vtoroy', 'Student', '87051344312', '2002-10-24', 2),
(NULL, 'Tretiy', 'Student', '87088067171', '2003-05-01', 3),
(NULL, 'Petr', 'Kapitsa', '87011987654', '2001-03-03', 4),
(NULL, 'Alex', 'Kan', '87051557654', '2001-10-29', 2);

INSERT INTO Student VALUES (NULL, 6, 'Master degree'),
(NULL, 7, 'Bachelor degree'),
(NULL, 8, 'Bachelor degree'),
(NULL, 9, 'Master degree'),
(NULL, 10, 'Master degree');


SELECT * FROM Address;
SELECT * FROM Person;
SELECT * FROM Teacher;
SELECT * FROM Course;
SELECT * FROM Student;
				/*	Teachers list */
SELECT Course.Id, Course.TeacherId AS TeacherId, Course.Name, Person.FirstName, Person.LastName,
Teacher.Position, Course.Credits, Course.Description FROM Course 
INNER JOIN Teacher ON Course.TeacherId = Teacher.Id
INNER JOIN Person  ON Person.Id = Teacher.PersonId;

				/* Students list */
SELECT Student.Id, Person.Id AS PersonId, Person.FirstName, Person.LastName FROM Student 
INNER JOIN Person ON Student.PersonId = Person.Id 
CREATE DATABASE MiniCourse2022
CREATE TABLE Employees (N INT PRIMARY KEY, LastName VARCHAR(50), FirstName VARCHAR(50),	Age MONEY )
INSERT INTO Employees VALUES 
(1, 'ZAKERYA', 'DIMASH', 21),
(2, 'BAKITULY', 'BEKZHAN', 35),
(3, 'SYZDYKOVA', 'MEIYRYM', 24),
(4, 'LAUMULLIN', 'CHOKAN', 45),
(5, 'ISAKHOV', 'ASYLBEK', 50)

SELECT * FROM Employees
ORDER BY AGE
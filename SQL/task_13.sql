USE employees;

/*1. Создать процедуру, в которой мы получаем на вход два параметра p_salary, p_dept и на выходе получим:
- Список сотрудников (emp_no, first_name, gender), у которых средняя зарплата больше p_salary и которые когда-то работали в департаменте p_dept.*/

DROP PROCEDURE IF EXISTS p_1;

DELIMITER $$
CREATE PROCEDURE p_1 (p_salary INT, p_dept VARCHAR(4))
BEGIN
	SELECT employees.emp_no, first_name, gender, salary, dept_no FROM employees
	JOIN (
	SELECT emp_no, AVG(salary) AS salary FROM salaries
	GROUP BY emp_no
	) a ON a.emp_no = employees.emp_no
	JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
	WHERE dept_no = p_dept AND salary > p_salary;
END $$
DELIMITER ;

CALL p_1(70000,'d007');

/*2. Создать функцию, которая получает на вход f_name и выдает максимальную зарплату среди сотрудников с именем f_name.*/

DROP FUNCTION IF EXISTS max_salary_by_name ;
DELIMITER $$
CREATE FUNCTION max_salary_by_name(f_name VARCHAR(50)) RETURNS DECIMAL(10,2) 
DETERMINISTIC
BEGIN
	DECLARE max_salary DECIMAL(10,2);
    SELECT MAX(salary) INTO max_salary 
    FROM salaries 
    JOIN employees ON salaries.emp_no=employees.emp_no
    WHERE first_name = f_name;
    RETURN max_salary;
END$$

DELIMITER ;

SELECT max_salary_by_name('Parto');




USE world;

/*1. Посчитайте количество городов в каждой стране, где IndepYear = 1991 (Independence Year).*/

SELECT CountryCode, COUNT(city.Name), IndepYear FROM city
JOIN country ON city.CountryCode=country.Code
WHERE IndepYear = 1991
GROUP BY CountryCode;

/*2. Узнайте, какая численность населения и средняя продолжительность жизни людей в Аргентине (ARG).*/

SELECT population, LifeExpectancy FROM country
WHERE Code = 'ARG';

/*3. В какой стране самая высокая продолжительность жизни?*/

SELECT country.Name FROM country
WHERE LifeExpectancy = (SELECT MAX(LifeExpectancy) FROM country);

/*4. Перечислите все языки, на которых говорят в регионе «Southeast Asia».*/

SELECT DISTINCT Language, Region FROM country c
JOIN countrylanguage l ON l.CountryCode=c.Code
WHERE Region = 'Southeast Asia';

/*5. Посчитайте сумму SurfaceArea для каждого континента.*/

SELECT Continent, SUM(SurfaceArea) AS SurfaceArea FROM country
GROUP BY Continent;

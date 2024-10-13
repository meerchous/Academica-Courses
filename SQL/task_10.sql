USE employees;

/*1. Объединение сотрудников и менеджеров: Напишите запрос, который использует UNION для объединения списка всех сотрудников (мужчин) и всех менеджеров (только идентификаторы сотрудников emp_no).*/

(SELECT emp_no FROM employees
WHERE gender = 'M')
UNION 
(SELECT emp_no FROM dept_manager);

/*2. Список уникальных должностей и отделов: Создайте запрос, который объединяет уникальные названия должностей из таблицы titles и названия отделов из departments.*/

SELECT dept_name AS departments_and_titles FROM departments
UNION ALL
SELECT DISTINCT title FROM titles;

/*3. Сотрудники с зарплатами выше и ниже среднего: Напишите запрос, который использует UNION для объединения двух списков:
 сотрудников с зарплатой выше 60.000 долларов и сотрудников с зарплатой ниже 40.000 долларов (используйте имя и зарплату).*/

SELECT a.emp_no, first_name, last_name, salary FROM employees
JOIN (
SELECT emp_no, AVG(salary) AS salary FROM salaries
GROUP BY emp_no
HAVING salary > 60000
UNION ALL 
SELECT emp_no, AVG(salary) AS salary FROM salaries
GROUP BY emp_no
HAVING salary < 40000
) a ON a.emp_no=employees.emp_no 
ORDER BY salary;

/*4. Объединение текущих и бывших сотрудников: Используйте UNION для создания списка сотрудников, которые в настоящее время работают в компании, и тех, кто уже ушел
 (используйте имя, фамилию и статус 'Текущий' или 'Бывший' , то есть first_name, last_name, 'Текущий' AS status, 'Бывший' AS status ).*/

SELECT first_name, last_name, 'Бывший' AS status FROM employees 
RIGHT JOIN 
(
SELECT DISTINCT emp_no FROM dept_emp 
WHERE dept_emp.emp_no NOT IN 
(SELECT emp_no FROM dept_emp
WHERE to_date = '9999-01-01')
) a ON employees.emp_no=a.emp_no

UNION ALL

SELECT first_name, last_name, 'Текущий' AS status FROM employees
WHERE emp_no IN  
(SELECT emp_no FROM dept_emp
WHERE to_date = '9999-01-01');

/*5. Сравнение зарплат менеджеров и обычных сотрудников: Создайте запрос с использованием UNION, чтобы сравнить средние зарплаты менеджеров и обычных сотрудников (выведите тип сотрудника, либо Менеджер, либо Обычный сотрудник их среднюю зарплату, то есть 'Менеджер' AS type, 'Обычный сотрудник' AS type, AVG(salary) AS avg_salary ).*/

SELECT dept_manager.emp_no, AVG(salary) AS avg_salary, 'Менеджер' AS type FROM dept_manager
JOIN salaries ON dept_manager.emp_no=salaries.emp_no
GROUP BY emp_no
UNION ALL
SELECT employees.emp_no, AVG(salary) AS avg_salary, 'Обычный сотрудник' AS type FROM employees
JOIN salaries ON salaries.emp_no=employees.emp_no
WHERE employees.emp_no NOT IN (SELECT emp_no FROM dept_manager)
GROUP BY emp_no; 







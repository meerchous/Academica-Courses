USE employees;

/*1. Создание простого View: Напишите SQL-запрос для создания представления (View), которое отображает имена и фамилии всех сотрудников.*/

DROP VIEW IF EXISTS full_name;
CREATE VIEW full_name AS 
SELECT first_name, last_name FROM employees;

SELECT * FROM full_name;

/*2. View с JOIN: Создайте представление, которое объединяет таблицы employees и salaries, показывая идентификатор сотрудника, его имя, фамилию и текущую зарплату.*/

DROP VIEW IF EXISTS emp_salary;
CREATE VIEW emp_salary AS 
SELECT employees.emp_no, first_name, last_name, salary FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE to_date = '9999-01-01';

SELECT * FROM emp_salary;

/*3. View для агрегированных данных: Создайте представление, которое показывает среднюю зарплату по каждому отделу.*/

DROP VIEW IF EXISTS avg_salary_by_dept;
CREATE VIEW avg_salary_by_dept AS 
SELECT dept_no, AVG(salary) AS avg_salary FROM dept_emp
JOIN salaries ON salaries.emp_no=dept_emp.emp_no
GROUP BY dept_no
ORDER BY dept_no;

SELECT * FROM avg_salary_by_dept;

/*4. Комбинированный View с JOIN и WHERE: Создайте представление, которое отображает информацию о сотрудниках, работающих в отделе 'Sales'.*/

DROP VIEW IF EXISTS v_employees;
CREATE VIEW v_employees AS 
SELECT employees.*, dept_name FROM employees
JOIN dept_emp ON employees.emp_no=dept_emp.emp_no
JOIN departments ON departments.dept_no=dept_emp.dept_no
WHERE dept_name = 'Sales';

SELECT * FROM v_employees;


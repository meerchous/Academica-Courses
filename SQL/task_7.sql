USE employees;

/*1. Выведите список всех менеджеров, а именно их emp_no, имена/фамилии, номер департамента, который они курируют, и дату найма в компанию.
(именно менеджером, то есть подсказка dept_manager) */

SELECT employees.emp_no, first_name, last_name, dept_no, hire_date FROM employees
RIGHT JOIN dept_manager ON employees.emp_no = dept_manager.emp_no;

/*2. Существует ли сотрудник по фамилии Markovitch, который когда-то был менеджером департамента.
Может быть таких сотрудников несколько? (именно менеджером, то есть подсказка dept_manager) */

SELECT employees.emp_no, first_name, last_name, dept_no, hire_date FROM employees
RIGHT JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
WHERE last_name = 'Markovitch';

/*3. Вывести список сотрудников, имена/фамилии, дату найма, должность в компании, у которых имя начинается на М, а фамилия заканчивается на H.*/

SELECT first_name, last_name, hire_date, title FROM employees
LEFT JOIN titles ON employees.emp_no = titles.emp_no
WHERE first_name LIKE 'M%' AND last_name LIKE '%h';

/*4. Создайте временную таблицу на основе salaries, где у вас будет emp_no и его/ее максимальная и минимальная зарплата за весь период работы в компании.
Далее сделайте JOIN используя эту временную таблицу и таблицу employees чтобы получить список сотрудников, их имена/фамилии, и их мин/макс зарплат.*/

DROP TEMPORARY TABLE IF EXISTS salaries_copy;
CREATE TEMPORARY TABLE salaries_copy
SELECT emp_no, MAX(salary) AS max_salary, MIN(salary) AS min_salary FROM salaries 
GROUP BY emp_no;

SELECT employees.emp_no, first_name, last_name, salaries_copy.min_salary, salaries_copy.max_salary FROM salaries_copy 
JOIN employees ON employees.emp_no = salaries_copy.emp_no;


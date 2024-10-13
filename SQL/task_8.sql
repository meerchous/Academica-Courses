USE employees;

/*1. Найдите количество сотрудников мужского пола (M) и женского пола (F) и выведите записи в порядке убывания по количеству сотрудников.*/

SELECT gender, COUNT(gender) FROM employees
GROUP BY gender
ORDER BY COUNT(gender) ASC;

/*2. Найдите среднюю зарплату в разрезе должностей сотрудников (title), округлите эти средние зарплаты до 2 знаков после запятой и выведите записи в порядке убывания.*/

SELECT title, ROUND(AVG(salary),2) AS avg_salary FROM titles
JOIN salaries ON titles.emp_no = salaries.emp_no 
GROUP BY title
ORDER BY avg_salary DESC;

/*3. Вывести месяцы (от 1 до 12), и количество нанятых сотрудников в эти месяцы.*/

SELECT MONTH(hire_date) AS month, COUNT(emp_no) AS hired_employees FROM employees
GROUP BY month
ORDER BY month ASC;

/*4. Сформируйте запрос, который соединяет employees, dept_emp, departments и titles, чтобы показать имена и фамилии сотрудников, названия их отделов и их текущие должности (именно текущие должности, то есть фильтр по таблице titles, столбец to_date).*/

SELECT employees.emp_no, first_name, last_name, dept_name, title FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
JOIN titles ON employees.emp_no = titles.emp_no
WHERE titles.to_date = '9999-01-01';

/*5. Используйте Self JOIN в таблице employees, чтобы найти пары сотрудников с одинаковыми фамилиями. Отобразите их имена и фамилии.*/

SELECT a.last_name, a.first_name as name_1 , b.first_name AS name_2 FROM employees a
JOIN employees b ON a.last_name = b.last_name
WHERE a.first_name <> b.first_name;


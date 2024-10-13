USE employees;

/*1. Найдите всех сотрудников, которые работали как минимум в 2 департаментах.
Вывести их имя, фамилию и количество департаментов, в которых они работали.
Показать записи в порядке возрастания.*/

SELECT first_name, last_name, num_dept FROM employees
JOIN (
SELECT emp_no, COUNT(dept_no) AS num_dept FROM dept_emp
GROUP BY emp_no
HAVING num_dept > 1
ORDER BY num_dept
) a ON a.emp_no=employees.emp_no;

/*2. Вывести имя, фамилию и зарплату самого высокооплачиваемого сотрудника.*/

SELECT first_name, last_name, salary FROM employees
JOIN (
SELECT emp_no, MAX(salary) AS salary FROM salaries
GROUP BY emp_no
ORDER BY salary DESC
LIMIT 1
) a ON employees.emp_no=a.emp_no;

/*3. Создайте запрос, который выбирает названия всех отделов, в которых работает более 100 сотрудников.*/

SELECT dept_name, num_emp FROM departments
JOIN (
SELECT dept_no, COUNT(emp_no) AS num_emp FROM dept_emp
GROUP BY dept_no
HAVING num_emp > 100
) a ON departments.dept_no=a.dept_no
ORDER BY num_emp;

/*4. Напишите запрос, который находит имена и фамилии всех сотрудников, которые никогда не были менеджерами.*/

SELECT first_name, last_name FROM employees
WHERE emp_no NOT IN (SELECT emp_no FROM dept_manager);

/*5. Создайте запрос, который для каждого отдела выводит сотрудников, получающих наибольшую зарплату в этом отделе.*/

DROP TEMPORARY TABLE IF EXISTS emp_salary;
CREATE TEMPORARY TABLE emp_salary
SELECT employees.emp_no AS emp_no , first_name, last_name, dept_name, salary AS salary FROM employees
JOIN dept_emp ON dept_emp.emp_no=employees.emp_no
JOIN departments ON departments.dept_no=dept_emp.dept_no
JOIN (
SELECT emp_no, AVG(salary) AS salary FROM salaries
GROUP BY emp_no 
) a ON a.emp_no = employees.emp_no
ORDER BY salary DESC;

SELECT b.dept_name, first_name, last_name, max_salary FROM 
(
SELECT employees.emp_no AS emp_no , first_name, last_name, dept_name, salary AS salary FROM employees
JOIN dept_emp ON dept_emp.emp_no=employees.emp_no
JOIN departments ON departments.dept_no=dept_emp.dept_no
JOIN (
SELECT emp_no, AVG(salary) AS salary FROM salaries
GROUP BY emp_no 
) a ON a.emp_no = employees.emp_no
ORDER BY salary DESC
) a
RIGHT JOIN 
(
SELECT dept_name, MAX(salary) AS max_salary FROM emp_salary
GROUP BY dept_name
) b ON a.dept_name=b.dept_name AND b.max_salary=a.salary;

/*6. Напишите запрос, который выбирает названия отделов, где средняя зарплата выше общей средней зарплаты по компании.*/

DROP TEMPORARY TABLE IF EXISTS salaries_copy;
CREATE TEMPORARY TABLE salaries_copy
SELECT emp_no, AVG(salary) AS salary FROM salaries
GROUP BY emp_no;

SET @average =(SELECT AVG(salary) FROM salaries_copy);
                 
SELECT dept_name, AVG(salary) AS avg_salary FROM employees
JOIN dept_emp ON employees.emp_no=dept_emp.emp_no
JOIN departments ON departments.dept_no=dept_emp.dept_no
JOIN salaries_copy ON employees.emp_no=salaries_copy.emp_no
GROUP BY dept_name
HAVING avg_salary > @average;

#6 same answer 
SELECT e.first_name, e.last_name, de.dept_no
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN salaries s ON e.emp_no = s.emp_no
WHERE (de.dept_no, s.salary) IN (
SELECT de.dept_no, MAX(s.salary)
FROM dept_emp de
JOIN salaries s ON de.emp_no = s.emp_no
GROUP BY de.dept_no
);




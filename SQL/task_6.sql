USE employees;

#1. Основы INNER JOIN: Напишите запрос, который соединяет таблицы employees и dept_emp, чтобы отобразить идентификаторы сотрудников (emp_no) и номера отделов (dept_no), в которых они работают (когда-то работали).

SELECT employees.emp_no, dept_no FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no;

#2. Понимание LEFT JOIN: Создайте запрос, использующий LEFT JOIN для соединения таблиц employees и dept_manager. Для каждого сотрудника отобразите его идентификатор и номер отдела, которым он управляет, если он является менеджером.

SELECT employees.*, dept_no FROM employees
LEFT JOIN dept_manager 
ON employees.emp_no=dept_manager.emp_no
ORDER BY dept_no DESC;

#3. Применение RIGHT JOIN: Напишите запрос, который соединяет таблицы departments и dept_emp через RIGHT JOIN. Выведите название отдела и идентификатор сотрудника.

SELECT dept_name, dept_emp.emp_no FROM departments
RIGHT JOIN dept_emp ON departments.dept_no = dept_emp.dept_no;

#4. Используйте INNER JOIN для соединения таблиц employees и salaries, чтобы отобразить идентификаторы сотрудников и их среднюю зарплату.

SELECT employees.emp_no, AVG(salary) AS avg_salary FROM employees 
JOIN salaries ON employees.emp_no=salaries.emp_no
GROUP BY employees.emp_no;



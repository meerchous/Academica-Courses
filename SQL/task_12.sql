USE employees;

/*1. Определение наивысшей текущей зарплаты в каждом отделе (для подсчета текущей зарплаты, используем фильтр WHERE to_date = '9999-01-01'):
   - Цель: Найти наивысшую текущую зарплату в каждом отделе.
   - Таблицы для использования: salaries (содержит информацию о зарплатах сотрудников), dept_emp (содержит информацию о том, к каким отделам относятся сотрудники).
   - Колонки для отображения: Идентификатор сотрудника (emp_no), зарплата (salary), номер отдела (dept_no), наивысшая зарплата в отделе (max_salary_in_dept).*/
   
SELECT salaries.emp_no, salary, dept_no, MAX(salary) OVER (PARTITION BY dept_no) AS max_salary_in_dept FROM salaries 
JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no
WHERE salaries.to_date = '9999-01-01';

/*2. Сравнение зарплаты каждого сотрудника с средней зарплатой в их отделе:
   - Цель: Сравнить зарплату каждого сотрудника с средней зарплатой в его/ее отделе.
   - Таблицы для использования: salaries, dept_emp.
   - Колонки для отображения: Идентификатор сотрудника (emp_no), зарплата (salary), номер отдела (dept_no), средняя зарплата в отделе (avg_salary_in_dept).*/

SELECT salaries.emp_no, salary, dept_no, AVG(salary) OVER (PARTITION BY dept_no) AS avg_salary_in_dept FROM salaries
JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no;

/*3. Ранжирование сотрудников в отделе по стажу работы:
   - Цель: Ранжировать сотрудников в каждом отделе по длительности их работы в компании.
   - Таблицы для использования: employees (содержит информацию о сотрудниках, включая дату найма), dept_emp.
   - Колонки для отображения: Идентификатор сотрудника (emp_no), дата найма (hire_date), номер отдела (dept_no), ранг опыта (experience_rank). То есть мы хотим разделить на партиции по департаменту и сортировать по hire_date.*/

SELECT employees.emp_no, hire_date, dept_no, RANK() OVER (PARTITION BY dept_no ORDER BY hire_date) AS experience_rank FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
ORDER BY experience_rank;

/*4.Нахождение следующей должности каждого сотрудника:
   - Цель: Определить, какая должность будет следующей для каждого сотрудника в ходе их карьеры.
   - Таблицы для использования: titles (содержит информацию о должностях сотрудников).
   - Колонки для отображения: Идентификатор сотрудника (emp_no), текущая должность (title), следующая должность (next_title).*/

SELECT employees.emp_no, title, LEAD(title) OVER (PARTITION BY emp_no) AS next_title FROM employees 
JOIN titles ON employees.emp_no = titles.emp_no
WHERE next_title <> NULL;

/*5. Определение начальной и последней зарплаты сотрудника:
   - Цель: Узнать, какая была начальная и какая текущая зарплата у каждого сотрудника.
   - Таблицы для использования: salaries (содержит информацию о зарплатах сотрудников).
   - Колонки для отображения: Идентификатор сотрудника (emp_no), текущая зарплата (salary), начальная зарплата (first_salary), последняя зарплата (last_salary).*/
   
SELECT emp_no, salary, FIRST_VALUE(salary) OVER (PARTITION BY emp_no) AS first_salary, LAST_VALUE(salary) OVER (PARTITION BY emp_no)  last_salary FROM salaries;

/*6. - Цель: Вычислить скользящее среднее зарплаты для каждого сотрудника, основываясь на его последних трех зарплатах.
- Таблицы для использования: salaries: содержит информацию о зарплатах сотрудников, включая emp_no (идентификатор сотрудника), salary (зарплата), и from_date (дата начала действия зарплаты).
- Колонки для отображения: emp_no (идентификатор сотрудника), from_date (дата начала действия зарплаты), salary (текущая зарплата), moving_avg_salary (скользящее среднее зарплаты, рассчитанное на основе последних трех зарплат).*/

SELECT emp_no, from_date, salary, AVG(salary) OVER (PARTITION BY emp_no ORDER BY salary ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_salary FROM salaries;
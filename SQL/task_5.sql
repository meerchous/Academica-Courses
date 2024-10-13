USE employees

#1. Вывести hire_date в годах, и количество сотрудников, которых наняли в эти года.

SELECT YEAR(hire_date), COUNT(emp_no) FROM employees
GROUP BY YEAR(hire_date);

#2. Вывести dept_no и рядом количество сотрудников, которые когда-либо работали в этих департаментах.

SELECT dept_no, COUNT(emp_no) FROM dept_emp
GROUP BY dept_no;

/*3. Вывести birth_date и количество сотрудников, которые родились в эти дни.
Отфильтровать birth_date не равен 1952-02-13 и вывести только те дни, где количество сотрудников > 60.
Отсортировать по убыванию (по количеству сотрудников), и далее показать только топ 20 birth_date (по количеству сотрудников).*/

SELECT birth_date, COUNT(emp_no) FROM employees
WHERE birth_date != '1952-02-13'
GROUP BY birth_date
HAVING COUNT(emp_no) > 60
ORDER BY COUNT(emp_no) DESC 
LIMIT 20;

/*4. Вывести имена (которые начинается на А) и количество сотрудников с этим именем в компании.
Отфильтровать имена, у которых количество сотрудников с этим именем больше 250,
отсортировать по количеству сотрудников и показать только топ 10 first_name (по количеству сотрудников).
*/

SELECT first_name, COUNT(emp_no) FROM employees
WHERE first_name LIKE 'a%'
GROUP BY first_name
HAVING COUNT(emp_no) > 250
ORDER BY COUNT(emp_no) DESC
LIMIT 10;

/*5. Создать копию таблицы employees, где имена начинается на B.
Удалить строки в employees, где имена начинаются на B, далее из копии нашей таблицы вставить обратно эти строки.
Удалить все строки из копии нашей таблицы, далее дропнуть эту таблицу.
*/

CREATE TABLE employees_1 LIKE employees; 

INSERT INTO employees_1
SELECT * FROM employees 
WHERE first_name LIKE 'b%';

DELETE FROM employees
WHERE first_name LIKE 'b%';

INSERT INTO employees
SELECT * FROM employees_1;

TRUNCATE TABLE employees_1;

DROP TABLE employees_1;


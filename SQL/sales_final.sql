DROP DATABASE IF EXISTS sales_final;
CREATE DATABASE IF NOT EXISTS sales_final; 
USE sales_final;

DROP TABLE IF EXISTS t_tab1, t_tab2;

CREATE TABLE t_tab2(
	id INT NOT NULL,
    name VARCHAR(15) NOT NULL,
    salary INT NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (name) );

CREATE TABLE t_tab1(
	id INT NOT NULL AUTO_INCREMENT,
    goods_type VARCHAR(20) NOT NULL,
    quantity INT NOT NULL,
    amount INT NOT NULL,
    seller_name VARCHAR(15) NOT NULL,
    FOREIGN KEY (seller_name) REFERENCES t_tab2 (name),
    PRIMARY KEY (id) );
    
INSERT INTO `t_tab2` VALUES (1, 'Anna', 110000, 27),
(2, 'Jane', 80000, 25),
(3, 'Mike', 120000, 25),
(4, 'Joe', 70000, 24),
(5, 'Rita', 120000, 29);

INSERT INTO `t_tab1` (goods_type, quantity, amount, seller_name) VALUES ('Mobile Phone', 2, 400000, 'Mike'),
('Keyboard', 1, 10000, 'Mike'),
('Mobile Phone', 1, 50000, 'Jane'),
('Monitor', 1, 110000, 'Joe'),
('Monitor', 2, 80000, 'Jane'),
('Mobile Phone', 1, 130000, 'Joe'),
('Mobile Phone', 1, 60000, 'Anna'),
('Printer', 1, 90000, 'Anna'),
('Keyboard', 2, 10000, 'Anna'),
('Printer' , 1, 80000, 'Mike');

SELECT * FROM t_tab1;
SELECT * FROM t_tab2;

#1
SELECT DISTINCT(goods_type) FROM t_tab1;
SELECT COUNT(DISTINCT(goods_type)) as Количсетво_уникальных FROM t_tab1;

#2
SELECT goods_type, SUM(quantity) AS Количество, SUM(amount) AS Стоимость FROM t_tab1
GROUP BY goods_type
HAVING goods_type = 'Mobile Phone';

#3
SELECT name, salary FROM t_tab2
WHERE salary > 100000;

#4
(SELECT concat('Age:', MIN(age)) AS Min, concat('Age:', MAX(age)) AS Max FROM t_tab2)
UNION 
(SELECT concat('Salary:', MIN(salary)) AS Min, concat('Salary:', MAX(salary)) AS Max FROM t_tab2);

#5
SELECT goods_type, AVG(quantity) AS average_qty FROM t_tab1
GROUP BY goods_type
HAVING goods_type IN ('Keyboard', 'Printer');

#6
SELECT seller_name, SUM(amount) AS sales FROM t_tab1
GROUP BY seller_name;

#7
SELECT name, goods_type, quantity, amount, salary, age FROM t_tab1
JOIN t_tab2 ON t_tab1.seller_name = t_tab2.name
WHERE name = 'Mike';

#8
SELECT name, age FROM t_tab2
WHERE name NOT IN (SELECT DISTINCT(seller_name) FROM t_tab1);

#9
SELECT name, salary FROM t_tab2
WHERE age < 26;
# Ответ: 3

#10
select
*
from T_TAB1 t
join T_TAB2 t2 on t2.name = t.seller_name
where t2.name = 'RITA';

# Ответ: 0 так как Рита не продала ни одного товара

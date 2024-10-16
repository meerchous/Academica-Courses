--CREATING STAGE--
CREATE DATABASE SHOP;

USE SHOP;

CREATE TABLE BUYER(
B_ID INT IDENTITY(100,1) PRIMARY KEY,
B_NAME VARCHAR(50) NOT NULL,
B_ADDRESS VARCHAR(60) NOT NULL,
B_COUNTRY VARCHAR(30) NOT NULL,
DELIVERY_TIME INT NOT NULL,
MIN_QTY INT NOT NULL);


CREATE TABLE BUYER_STOCK(
S_NAME VARCHAR(100) PRIMARY KEY,
B_ID INT FOREIGN KEY REFERENCES BUYER(B_ID) ON DELETE CASCADE,
B_S_PRICE INT NOT NULL);

CREATE TABLE ORDERS(
O_ID INT IDENTITY(1,1) PRIMARY KEY,
O_DATE DATE NOT NULL,
TOTAL INT NOT NULL);

CREATE TABLE ORDER_DETAIL(
O_ID INT FOREIGN KEY REFERENCES ORDERS(O_ID) ON DELETE CASCADE,
S_NAME VARCHAR(100) FOREIGN KEY REFERENCES BUYER_STOCK(S_NAME),
QTY INT NOT NULL, 
CHECK (QTY >= 10),
CONSTRAINT COMP_NAME_1 PRIMARY KEY (O_ID,S_NAME));


CREATE TABLE STOCK(
S_ID INT PRIMARY KEY,
S_NAME VARCHAR(100) FOREIGN KEY REFERENCES BUYER_STOCK(S_NAME) ON DELETE CASCADE, 
S_CATEGORY VARCHAR(50) NOT NULL,
S_QTY INT,
S_PRICE INT NOT NULL);

CREATE TABLE CUSTOMER(
CUST_ID INT IDENTITY(1,1) PRIMARY KEY,
CUST_NAME VARCHAR(60) NOT NULL,
CUST_ADDRESS VARCHAR(50) NOT NULL,
CUST_PHONE VARCHAR(11) NOT NULL);


CREATE TABLE INVOICE(
INVOICE_ID INT IDENTITY(1,1) PRIMARY KEY ,
INVOICE_DATE DATE NOT NULL,
CUST_ID INT FOREIGN KEY REFERENCES CUSTOMER(CUST_ID) ON DELETE CASCADE,
PAID_DATE DATE,
SUBTOTAL INT NOT NULL,
TOTAL INT NOT NULL);

CREATE TABLE INVOICE_ITEM(
INVOICE_ID INT FOREIGN KEY REFERENCES INVOICE(INVOICE_ID) ON DELETE CASCADE,
S_ID INT FOREIGN KEY REFERENCES STOCK(S_ID),
I_QTY INT NOT NULL,
CONSTRAINT COMP_NAME_2 PRIMARY KEY (INVOICE_ID,S_ID));


--INSERT--
INSERT INTO BUYER values
('Apple Inc', 'California, San-Francisco, Cupertino ', 'USA', 20, 10),
('Samsung', 'Seoul, Giheung', 'South Korea', 15, 10),
('LG Electronics Inc', 'Lg Twin Tower 128','South Korea', 15, 10);

INSERT INTO BUYER_STOCK VALUES
('Iphone 14 Pro, black, 256GB',100,1200),
('Iphone 13, blue, 128GB',100, 950),
('Samsung S22 Ultra, white, 256GB', 101, 1000),
('Samsung S21 Ultra, pink,512GB', 101, 1000),
('LG Washing-machine F2H5990, black, 10kg', 102 ,600);

INSERT INTO ORDERS VALUES
('2023-01-01',314000)

INSERT INTO ORDER_DETAIL VALUES
(1, 'Iphone 14 Pro, black, 256GB', 100),
(1, 'Iphone 13, blue, 128GB', 100),
(1, 'Samsung S22 Ultra, white, 256GB', 50),
(1, 'Samsung S21 Ultra, pink,512GB', 50);
(1,'LG Washing-machine F2H5990, black, 10kg', 20)

INSERT INTO STOCK VALUES 
(1,'Iphone 14 Pro, black, 256GB','Phone',100, 1490),
(2,'Iphone 13, blue, 128GB', 'Phone', 100, 1290),
(3,'Samsung S22 Ultra, white, 256GB', 'Phone', 50, 1390),
(4,'Samsung S21 Ultra, pink,512GB', 'Phone', 50, 1190),
(5,'LG Washing-machine F2H5990, black, 10kg','Washing machine', 20, 890)

INSERT INTO CUSTOMER values ('Aizhan Abylkasymova', 'Tole bi 59', '7776543289'),
('Aliya Borsikbaeva', 'Abylai khan 23', '7079843677'),
('Anel Zainoldanova', 'Suleimenova 24', '7053790831'),
('Adilkhan Zhumabekov', 'Aksai 4', '7784371700'),
('Meyirim Syzdykova', 'Samal 2', '7476258840')

INSERT INTO INVOICE VALUES
('2023-01-13',1, '2023-01-13', 2980,2980),
('2023-01-17',2, '2023-01-20', 2680,2948),
('2023-01-20',1, '2023-01-21', 890,890);
 
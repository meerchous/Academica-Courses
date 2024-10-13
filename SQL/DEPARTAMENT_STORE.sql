CREATE DATABASE DEPARTAMENT_STORE 

USE DEPARTAMENT_STORE

CREATE TABLE CITY(
CITY_NAME VARCHAR(15) PRIMARY KEY,
HEADQ_LOC VARCHAR(50) NOT NULL)

CREATE TABLE STORE(
STORE_ID INT IDENTITY(10,1) PRIMARY KEY,
STORE_ADDRESS VARCHAR(50) NOT NULL)


CREATE TABLE STORES_IN_CITIES(
CITY_NAME VARCHAR(15) FOREIGN KEY REFERENCES CITY(CITY_NAME) ON DELETE CASCADE,
STORE_ID INT FOREIGN KEY REFERENCES STORE(STORE_ID),
CONSTRAINT COMP_NAME1 PRIMARY KEY (CITY_NAME,STORE_ID))

CREATE TABLE ITEM(
ITEM_ID INT IDENTITY(1,1) PRIMARY KEY,
ITEM_QTY INT ,
ITEM_DESC VARCHAR(50) NOT NULL,
COST_PRICE INT NOT NULL)

CREATE TABLE ITEMS_IN_STORES(
STORE_ID INT FOREIGN KEY REFERENCES STORE(STORE_ID) ON DELETE CASCADE,
ITEM_ID INT FOREIGN KEY REFERENCES ITEM(ITEM_ID),
ITEM_IN_STORE_QTY INT,
ITEM_PRICE INT NOT NULL,
CONSTRAINT COMP_NAME2 PRIMARY KEY(STORE_ID,ITEM_ID))

CREATE TABLE CUSTOMER(
CUST_ID INT IDENTITY(1,1) PRIMARY KEY,
CUST_NAME VARCHAR(30) NOT NULL,
CUST_PHONE VARCHAR(11) NOT NULL,
CUST_ADDRESS VARCHAR(50) NOT NULL)

CREATE TABLE ORDERS(
ORDER_ID INT IDENTITY(1,1) PRIMARY KEY,
ORDER_DATE DATE NOT NULL,
CUST_ID INT FOREIGN KEY REFERENCES CUSTOMER(CUST_ID),
STORE_ID INT FOREIGN KEY REFERENCES STORE(STORE_ID),
ITEM_ID INT FOREIGN KEY REFERENCES ITEM(ITEM_ID),
O_QTY INT NOT NULL,
OVERALL INT NOT NULL)


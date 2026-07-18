#create database 
CREATE DATABASE company_db;
-----------------------------------------
#Create Table 

CREATE TABLE company_db.test_table (
  id INT,
  name VARCHAR(100)
);

SELECT id FROM company_db.test_table;

select * from company_db.test_table;
 -------------------------------------------------------------
 #Insert Data into the Table
 
INSERT INTO company_db.test_table (id,name)
 VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');

INSERT INTO company_db.test_table (id, name)
 VALUES
(5, 5);

INSERT INTO company_db.test_table (id, name)
 VALUES
('joey', 5);

---------------------------------
#Select 

SELECT * FROM company_db.test_table;
------------------------------------
#Alter table 
ALTER TABLE company_db.test_table
ADD Email varchar(255);
---
ALTER TABLE company_db.test_table
RENAME COLUMN Email to email_id;
---------------------------------------------------------------
# SQL constraints are used to specify rules for data in a table.

#not null and  unique constraints 
drop table if exists company_db.Persons;

CREATE TABLE company_db.Persons (
    ID int NOT NULL unique,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);

SELECT * FROM company_db.Persons;

INSERT INTO  company_db.Persons (ID, LastName, FirstName, Age)
VALUES (1, 'Smith', 'John', 30);

INSERT INTO  company_db.Persons (ID, LastName, FirstName, Age)
VALUES (2, 'Doe', NULL, NULL);  -- NULLs allowed for FirstName and Age


-- This will FAIL because ID = 1 already exists
INSERT INTO  company_db.Persons (ID, LastName, FirstName, Age)
VALUES (1, 'Brown', 'Charlie', 25);


-- This will FAIL because LastName is NOT NULL
INSERT INTO company_db.Persons (ID, LastName, FirstName, Age)
VALUES (3, null, 'Alice', 28);
--------------------------------------------------------

#PRIMARY KEY 

ALTER TABLE  company_db.Persons
ADD PRIMARY KEY (ID);
-----
SELECT CONSTRAINT_NAME
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'sakila'
AND TABLE_NAME = 'actor';
-- AND CONSTRAINT_TYPE = 'PRIMARY KEY';-- 
-------------------------------------

ALTER TABLE company_db.Persons
DROP  PRIMARY key ;
-------
ALTER TABLE company_db.Persons
ADD CONSTRAINT PK_Person PRIMARY KEY (ID);

------------------------------------------------------------------------
#Foregin KEY
-- A FOREIGN KEY is a field (or collection of fields) in one table, that refers to the PRIMARY KEY in another table.
-- The table with the foreign key is called the child table, and the table with the primary key is called the referenced or parent table.

CREATE TABLE company_db.Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    PersonID INT,
    FOREIGN KEY (PersonID) REFERENCES Persons(ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

INSERT INTO company_db.Orders (OrderID, OrderDate, PersonID)
VALUES (1001, '2024-06-10', 1);

SELECT * FROM company_db.Orders;
SeLECT * FROM company_db.persons;
INSERT INTO company_db.Orders (OrderID, OrderDate, PersonID)
VALUES (1002, '2024-06-11', 999);  -- PersonID 999 doesn't exist

DELETE FROM company_db.Persons WHERE ID = 1;

select * FROM company_db.persons; -- parent 
SELECT * FROM company_db.Orders; -- child 

UPDATE company_db.Persons SET ID = 4 WHERE ID = 1;
	
------------------------------------------------------------------------------------------------
#check and default 

CREATE TABLE company_db.employee (
    ID int NOT NULL ,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int  CHECK (Age>=18),
	city varchar(255) DEFAULT 'new york'
);

SELECT * FROM company_db.employee;
--------

INSERT INTO company_db.employee (ID, LastName, FirstName, Age,city)
VALUES (1, 'joey', 'tribiani', 19, 'texas');

INSERT INTO company_db.employee (ID, LastName, FirstName, Age)
VALUES (2, 'jim', 'halpert', 22);

--------------------------
# Difference between drop and delete 
select * FROM company_db.test_table;

select * FROM company_db.test_table where id = 1;

SET SQL_SAFE_UPDATES = 0;

DELETE from company_db.test_table where id = 1; 
--------------------------------------
#drop 

DROP TABLE company_db.test_table;
DROP TABLE  company_db.employee;

# Truncate
SELECT * FROM company_db.employee;
truncate TABLE company_db.employee;
--------------------------

DROP TABLE company_db.persons;
DROP TABLE company_db.Orders;

drop database   company_db;

#select 

 SELECT * FROM sakila.actor;
 
 SELECT DISTINCT first_name from sakila.actor;
 ----------
 select * from sakila.film where original_language_id is null;
  select * from sakila.film where rental_duration = 6;
 
 select count(*) from sakila.film where rental_duration = 6;
 

 
 select * from sakila.film;
 --------------
select distinct title from sakila.film where original_language_id is  null;
select title from sakila.film where original_language_id is  null;

------------------------------------------------
select count(distinct(title)) from sakila.film;
-------------------------------
#count and distinct count 

select count(first_name) from sakila.actor;
select count(distinct(first_name)) from sakila.actor;

select first_name from sakila.actor
    group by first_name 
    having count(first_name)>1;
    
select * from sakila.actor where first_name = 'PENELOPE';
-------------------
#select specific columns 

SELECT first_name,last_name FROM sakila.actor;
-------------------------------
#Limit 

SELECT first_name, last_name FROM sakila.actor limit 200;

--------------------
#filtering with where 

SELECT distinct(rating) FROM sakila.film;

SELECT * FROM sakila.film;

SELECT * FROM sakila.film WHERE rating = 'R'  and length >= 92;

SELECT * FROM sakila.film WHERE length >= 92;
------------------
#sorting 
SELECT rental_rate from sakila.film;

SELECT  title  FROM sakila.film ORDER BY rental_rate desc ;
--------------------
#AND #OR operators 

SELECT * FROM sakila.film 
where rating = 'PG' and rental_duration = 5
ORDER BY rental_rate ASC;

SELECT * FROM sakila.film 
where rating = 'PG' or rental_duration = 5
ORDER BY rental_rate ASC;


--------------------------------------
#NOT 

SELECT * FROM sakila.film 
where rental_duration  not IN ( 6, 7,3)
ORDER BY rental_rate ASC;

SELECT * FROM sakila.film 
where  not rental_duration = 6 
ORDER BY rental_rate ASC;

SELECT * FROM sakila.film 
where rental_duration != 6 
ORDER BY rental_rate ASC;

-------------------------------------
SELECT * FROM sakila.film 
where rental_duration = 6 and (rating = 'G' OR rating = 'PG')
ORDER BY rental_rate ASC;


--------------------------------------------
#LIKE used with where clause 

-- There are two wildcards often used in conjunction with the LIKE operator:
-- 	The percent sign % represents zero, one, or multiple characters
-- 	The underscore sign _ represents one, single character

SELECT city FROM sakila.city where city like 'As%d';
SELECT rating FROM sakila.film where rating like  '%PG%';


SELECT city FROM sakila.city where city like '_a__s%';

-- select title from sakila.film where title like '%super%';
-- select title from sakila.film where title like '__s_s%';

-----------------------------------------------------------------------
#NULL Value

#Check Rentals That Were Never Returned 

select * from sakila.rental;

SELECT rental_id, inventory_id, customer_id, return_date
FROM sakila.rental
WHERE return_date  IS NULL;

-----------------------------------------
#between 

SELECT rental_id, inventory_id, customer_id, return_date
FROM sakila.rental
WHERE  return_date between '2005-05-26' and '2005-05-30';

------------------
#group by and having 
#TO CHECK DUPLICATES 

select customer_id,rental_date,COUNT(rental_id) as count_rentals
FROM sakila.rental
where return_date is null
GROUP BY customer_id,rental_date
HAVING COUNT(rental_id) <  30 
order by  count_rentals desc
limit 50;


select * from sakila.rental where customer_id = 168;
select * from sakila.rental;

-- select count(*) as count from sakila.rental;
-----------------------------------
#order of execution is SQL 

# from (table) ---> join ---> where --- group by --> having ---> select ---> order by  --> limit

----------------------
# DIFFERENCE BETWEEN where cluase and having 

-- order by count;PRIMARY

select * from sakila.rental where return_date is null;

select * from sakila.rental where customer_id = 33;
------------------------------
SELECT * FROM sakila.payment;

SELECT customer_id, sum(amount) as total_payment 
FROM sakila.payment
group by customer_id
having sum(amount) < 100 and customer_id between 1 and 100;
-----------------------------------------
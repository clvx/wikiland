MySQL & SQL Query Language Basics
=================================

Installing MySQL on Ubuntu And CentOS
=====================================
On Ubuntu 
$sudo apt-get install mysql-server mysql-client, installs mysql server and client.
Introduce a mysql password.
$sudo service mysql start, starts mysql server
$mysql -u [user] -p, connects to mysql server with user [user](-u) and asks to enter a plain text password(-p)
mysql>show databases; , shows all databases.
mysql>select * from mysql.user; , selects all users from table user on database mysql.
mysql>exit, exits.

On CentOS
$sudo yum -y install mariadb-server mariadb, installs mysql server and client.
$sudo systemctl start mariadb.service, starts mariadb server.
$sudo systemctl enable mariadb.service, enables mariadb at boot.
$mysql_secure_installation, starts default configuration for mariadb(root password).
MariaDB [(none)]> show databases; , shows all databases.
MariaDB [(none)]>select * from mysql.user; , selects all users from table user on database mysql.
MariaDB [(none)]>exit, exits. 


Basic MySQL administration Creating Databases, Tables & Users
=============================================================

mysql>show databases; lists available database existing in the system.
- information_schema, shows schema informatioin about other databases in mysql. 
- mysql, provides information about users on the system. 
mysql> CREATE DATABASE [database]; creates a database called [database].
mysql>USE [database]; moves inside [database]. 
mysql>describe mysql.user; describes information about mysql.user table. It specifies fields, type, if it's null, if it's primary key, etc.
mysql>drop database [database]; deletes database [database].

mysql>CREATE TABLE mydb.customers (`id` int(11) NOT NULL, `first_name` varchar(20) NOT NULL, `last_name` varchar(20) NOT NULL); creates a table in database mydb called customers with mandatory fields id, first_name, last_name each one with their own type.
mysql>SHOW TABLES; shows tables for the current database.
mysql>INSERT INTO customers (id, first_name, last_name) VALUES (1, 'jeff', 'jefferson'); inserts into customers table values 1, 'jeff', 'jefferson' for the corresponding fields. 
mysql>SELECT * FROM [database].[table_name]; selects all rows from [database].[table_name]
mysql>SELECT * FROM customers WHERE id=1; selects all rows from customers where id is equal to 1.
mysql>INSERT INTO customers (id, first_name, last_name) VALUES (2, 'anthony', 'jefferson'); 
mysql>SELECT * FROM customers WHERE first_name = "anthony"; selects all rows from customers where first_name is equal to anthony.
mysql>SELECT id,first_name FROM customers WHERE last_name = "jefferson"; selects  rows showing only id and first_name columns from customers where last_name is equal to jefferson.

mysql>CREATE USER 'jeff'@'localhost' IDENTIFIED BY 'test'; creates a user jeff who connects from localhost and with a password 'test'.
mysql>GRANT ALL PRIVILEGES ON mydb.* TO 'jeff'@'localhost'; grants all privileges to all tables on mydb database to 'jeff' connecting from 'localhost'.



SQL Query Statements
====================

$mysql -u root -p store < store.sql, loads a sql file to store database

mysql>INSERT INTO customers (first_name, last_name) VALUES ('jeff', 'jackson'); inserts into customers table values 'jeff', 'jefferson' for the corresponding fields. The id field is auto generated.  
mysql>SELECT * FROM customers WHERE first_name='jeff' AND last_name='jackson'; selects all rows from customers who begins with jeff AND has as last_name jackson.
mysql>UPDATE customers SET last_name="francis" WHERE frist_name="jeff" AND last_name="jackson"; updates jeff last_name from jackson to francis on customers table. IF THE WHERE CLAUSE IS NOT SET IT WILL CHANGE EACH CUSTOMER last_name TO 'francis'.
mysql>DELETE FROM customers WHERE first_name='stephen'; deletes all rows which first_name matches 'stephen'. IF THE WHERE CLAUSE IS NOT SET IT WILL DELETE ALL ROWS FROM THE TABLE.


Basic MySQL Group By And Order By Statement
===========================================

mysql>SELECT name,type,price FROM products ORDER BY price ASC; selects name, type, price from products ordering in ascending order.
mysql>SELECT name,type,price FROM products ORDER BY price DESC; selects name, type, price from products ordering in descending order.
mysql>SELECT * FROM products GROUP BY type; shows group results based on column 'type'.  



Basic MySQL Left Join Statement
===============================

SELECT * FROM orders LEFT JOIN customers ON orders.customer_id=customers.id; LEFT JOIN will return all rows from the left table, with the matching rows from the right table. If the right table contains no match, the result is NULL. 

mysqldump Command
=================

mysql>mysqldump -u root -p [database] > [dump].sql, dumps database [database] to dump.sql

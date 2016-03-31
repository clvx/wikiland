Introduction
============

Introduction to Databases
-------------------------

Database: An organized collection of data. 
DBMS: Database Management Systems, is a software that interact with an end user, other applications and the database itself, to capture and analyze data. 
    - Allows the definition, creation, querying, updates, deletions and administration of databases. 
    - Databases themselves are not generally portable across different DBMSs, but the data within then can generally be exported and imported into any other database with some changes to datatypes.

Types of databases: 
    - Cloud database.
    - Data Warehouse.
    - Distributed Database, nodes in multiple locations. 
    - Relational Database, clear relations between indexes and key tables.
    - Federated Database.
    - Knowledge Base or Knowledge Management System, wikipedia as a knowledge base database.
    - Operation Database, stores company operation information.
    - Parallel Database
    - SQL Database
    - NoSQL Database
    - Spatial Database, geolocalization database.
    - Unstructured Database

Data Normalization
------------------

Data normalization is a process used to reduce or eliminate the redundancy of data in a database.
    1. Redundancy wastes space and resources.
    2. Synchronization between multiple instances of the same data is difficult.
    3. Structure and location of multiple instances of the same data is often unknown outside of the data creator or creation mechanism. 

    Three common forms that normalization takes:
    - First normal form(1NF).
        A relation is in first normal form if and only if the domain of each attribute contains only atomic (indivisible) values, and the value of each attribute contains only a single value from that domain.
    - Second normal form (2NF).
        A table is in 2NF if it is in 1NF and no non-prime attribute is dependent on any proper subset of any candidate key of the table. A non-prime attribute of a table is an attribute that is not a part of any candidate key of the table.
    - Third normal form (3NF).
        The entity is in 2NF, and all the attributes in a table are determined only by the candidate keys of that table and not by any non-prime attributes.


Indexes, Relationships and Keys
-------------------------------

Index: is an internal structure that improves the speed of data retrieval on a database table.
    - Speed of those operations comes at the cost of additional writes to and storage space withing your data structure.
    - Allow the retrieval and location of data that meet certain criteria without having to search ever row in a table. 
    - They are created on one or more columns in a database table and give the database the ability to do fast lookups and access of ordered records.
Data relationships: Defined by the existence of one field of data that exists in multiple tables.
Primary Key: The most common type of key, should be unique for each record in that table. 
Foreign Key: Used to create relationships between tables in your database.

Introduction to RDBMS
---------------------

Relational Database Management System, same as DBMS with a key difference that is based on the relational database model.
Key Concepts:
    - Data organized into tables of rows and columns with a unique key or each row.
    - Each entity type in a database has its own table.
    - Each row with in an entity type represents and instace of that type. 
    - Each column in that entity represents values within those instances.
    - Rows in a table can be linked to rows in other tables through the storage of the unique key of the row it needs to be linked to (the foreign key).
    - Use SQL as the language for querying and manintaining the database.

Introduction to PostgreSQL 9.4
------------------------------

PostgreSQL is a representation of a set of utilities and software to manage relational data.
- Classified as an RDBMS similar to Oracle, MySQL, SQL Server, etc. 
- It has an open source and enterprise version.
Features:
    - Primary Keys.
    - Foreign Keys.
    - Views.
    - Triggers.
    - Transactional Integrity.
    - Complex Queries.
    - SQL Compliance.
    - NoSQL Capability.
    - Big Data Processing.
    - Database Centric Logic.
Management Tools:
    - PgAdmin III.
    - phppgadmin.
    - DbVisualizer.
    - pgaccess.
    - pgShark.
Programming Interfaces:
    - psql - command line
    - libpq - C library
    - Drivers - jdbc, odbc, dbi, .net
    - Pgtcl - TCL bindings.
Supported Operating Systems:
    - Linux.
    - Mac OSX.
    - Microsoft Windows.
    - HP UX.
    - AIX.
    - Solarix/Sun OS.
    - Cygwin.



















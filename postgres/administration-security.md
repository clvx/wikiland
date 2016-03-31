Administration and Security
===========================

Creating Databases
------------------

- postgres user is the only user by default. Any database created will be owned by the postgres user by default.
- `createdb`, creates a new PostgreSQL database. 
    - The database user who executes this command becomes the owner of the new database.
    - Creating database using PostgreSQL commands:
        ```
        $createdb [database]
        $psql
        postgres=#\connect [database];
        [database]=#
        ```
    - Creating database using SQL commands:
        ```
        $psql
        postgres=#CREATE DATABASE [database];
        postgres=#\connect [database];
        [database]=#
        ```
    - Droping a database using PostgreSQL commands:
        ```
        $dropdb [database]
        ```
    - Droping a database using SQL commands:
        ```
        $psql
        postgres=#DROP DATABASE [database];
        ```

Creating Tables
---------------

- Creating tables using SQL commands:
    ```
    CREATE TABLE cities (
    cityid varchar(5),
    cityname varchar(80),
    state varchar(20) );
    ```
- Inserting city values:
    ```
    INSERT into cities VALUES (
    12345,
    'Cincinnati',
    'Ohio');
    ```
Roles - Creating and Deleting Users
-----------------------------------

- Creating users using PostgreSQL commands:
    ```
    $createuser [user]
    $psql
    postgres=#ALTER USER [user] WITH PASSWORD '[password]';
    postgres=\q
    All local connections to all databases are authenticated through password.
    #sed -i 's/^local\ *all\ *all\ *peer/local\ all\ all\ password/' /var/lib/pgsql/9.4/data/pg_hba.conf
    #systemctl restart postgresql-9.4
    #su - postgres
    $psql -U [user]
    ```
- Deleting users using PostgreSQL commands:
    ```
    A user can be only deleted if it doesn't own any object.
    $dropuser [user]
    ```

Roles - Assigning Permissions
-----------------------------

- List roles: 
    `postgres=#\du`
- Adding a role:
    ```
    Creating a user
    $createuser [user]
    $psql
    postgres=#ALTER USER [user] WITH PASSWORD '[password]';
    postgres=#CREATE DATABASE [database];
    postgres=#\connect [database];
    [database]=>GRANT [object] ON [table] TO [user];
    [database]=>\q;
    $psql -U [user]
    ```

Installing and Configuring myPgAdmin
------------------------------------

- Instalando Epel Repo:
`yum install epel-release`
- Instalando phpPgAdmin:
`yum install phpPgAdmin httpd`
- Habilitando el servicio:
```
systemctl enable httpd
systemctl start httpd
```
- Si fuese necesario modificar `/etc/httpd/conf.d/phpPgAdmin.conf` o `/etc/phpPgAdmin/config.inc.php`

Accepting External Connections
------------------------------

- Modificar en `/var/lib/pgsql/9.4/data/postgresql.conf` para que escuche en todos los puertos.
- Modificar en `/var/lib/pgsql/9.4/data/pg_hba.conf` para que acepte conexiones por contraseña.
- Para CentOS 7 añadir en `/etc/httpd/conf/httpd.conf`, para obtener correctamente los CSS:
    ```
    AddType text/css .css
    AddType text/javascript .js
    ```
Backing Up and Restoring Databases
----------------------------------

- To create a backup file:
`$pg_dump [database] > dump_file.sql`

- To restore a backup file:
`$psql [database] < dump_file.sql`

Replication - Master Server Configuration
-----------------------------------------



Replication - Slave Server Configuration
----------------------------------------

Discussion - Database Clustering
--------------------------------

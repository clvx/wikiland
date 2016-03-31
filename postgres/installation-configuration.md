Installation and Configuration
==============================

Installation and Service Configuration
--------------------------------------
CentOS:
    ```
    Installing repo postgresql 9.4
    #yum localinstall http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm

    Installing dependencies
    #yum install postgresql94-server postgresql94-contrib
    
    Initializing database
    #/usr/pgsql-9.4/bin/postgresql94-setup initdb

    Enable service on reboot
    #systemctl enable postgresql-9.4

    Start database service
    #systemctl start postgresql-9.4

    Enables httpd to interact with database
    #setsebool -P httpd_can_network_connect_db 1

    Optional - Changes SELinux to permissive mode
    #setenforce 0

    Restart database service
    #systemctl restart postgresql-9.4
    ```
Ubuntu:
    ```
    Installing repo:
    #echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list
    #wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    #apt-get update 

    Installing dependencies
    #apt-get install postgresql postgresql-contrib

    Restart database service
    #service postgresql restart
    ```


Using the Command Line Client
-----------------------------

    ```
    Entering the command line
    #su - postgres
    $psql
    postgres=#
    ```

    ```
    changes postgres password
    postgres=#\password postgres
    ```

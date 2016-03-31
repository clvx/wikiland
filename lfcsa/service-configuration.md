Service Configuration 
====================== 
    
Provide/Configure Network Shares via NFS/CIFS - Server 
------------------------------------------------------
    
Network File Share(NFS).
- Ubuntu:
    - `apt-get install nfs-kernel-server`
- CentOS:
    - `yum install nfs-utils nfs-utils-lib`
    - `chkconfig nfs on`
    - `service nfs start`
    - `/etc/exports`, contains a table of local file systems on a nfs server
    that are accesible to NFS clients. Then contents of the files are mantained
    by the server's system administrator.
        - e.g.: 
            - `mkdir /var/share/; chmod 755 /var/share`
            - Subnet 192.168.1.0 can access /home with permissions read and write,
            mantaining root privileges between client and server, but /var/share
            as read only.
            ```
            cat << EOF > /etc/exports
            /home 192.168.1.0/24(rw,no_root_squash)
            /var/share 192.168.1.0/24(ro)
            EOF
            ```
            - `service nfs restart`
    
Provide/Configure Network Shares via NFS/CIFS - Client 
------------------------------------------------------
    
- CentOS:
    - `yum install nfs-utils nfs-utils-lib`
    - e.g:
        - `mkdir /mnt/{nfs_home,nfs_share}`
        - `mount [IP_NFS_SERVER]:/home /mnt/nfs_home`
        - `mount [IP_NFS_SERVER]:/var/share /mnt/nfs_share`
        - To mount at boot:
            - `echo '[IP_NFS_SERVER]:/home /mnt/nfs_home nfs rw,sync,hard,intr 0 0' >> /etc/fstab`
            - `echo '[IP_NFS_SERVER]:/var/share /mnt/nfs_share nfs rw,sync,hard,intr 0 0' >> /etc/fstab`
                - It doesn't matter if rw is defined because it will be 
                overrided according to ` /etc/exports` on the server
                - `mount -a`, mounts all mount point defined on `/etc/fstab`
    
Configure an SMTP Service 
-------------------------
    
- CentOS:
    - `yum install postfix`
    - `/etc/postfix/main.cf`, postfix main configuration file.
        - `myorigin`, specifies the domain that locally-posted mail appears to 
        come.
        - `mydestination`, specifies the list of domains that this machine 
        considers itself the final destination.
        - `mynetwork`, specify the list of "trusted" network addresses which
        can send email through the mail server.
    - `/etc/postfix/transport`, defines relationships between domains and 
    servers where messages will be transported.
    - `postmap /etc/postfix/transport`, create transport database.
    
Restrict Access to SMTP Service 
-------------------------------
    
- CentOS:
    - `/etc/postfix/main.cf`, postfix main configuration file.
        - `smtpd_helo_required = yes`, rejects any communication which is not 
        a HELO or EHLO.
        - `smtpd_sender_restrictions = permit_mynetworks, reject_unknown_sender_domain`,
        reject any non local destinations sender adress.
        - `smtpd_helo_restriction = permit_mynetworks, reject_invalid_helo_hostname`,
        reject anything that has a bad domains or network address.
        - `smtpd_recipient_restrictions = permit_mynetworks, reject_unauth_destinations`, 
        reject anything for mail forwarding and non-destinations.
    
Configure an IMAP/IMAPS Service 
-------------------------------
    
- CentOS:
    - `yum install dovecot`
    - `/etc/dovecot/conf.d/10-mail.conf`,
        - `mail_location = mbox:~/mail:INBOX=/var/mail/%u`, where the mailboxes are going to be.
        - `mail_privileged_group = mail` = group to enable temporary privileged
        operations.
    - `/etc/dovecot/conf.d/10-ssl.conf`,
        - `ssl_cert = <[path_to_cert]`
        - `ssl_key = <[path_to_key]`
    - `/etc/dovecot/dovecot.conf` 
        - `protocols = imap pop3 imaps pop3s`
    - `/etc/pki/dovecot/`, certificates directory.
    - `systemctl restart dovecot`
    
Configure Email Aliases 
-----------------------
    
- `echo "user: user, user2\nadmin: user" > /etc/postfix/aliases`, users must exist. 
- `postalias /etc/postfi/aliases` 
    
Verify Email Configuration 
--------------------------
    
#NADA IMPORTANTE
    
Configure SSH-Based Remote Access Using Public/Private Key Pairs 
-----------------------------------------------------------------
    
```
#Generate keys
ssh-key -t rsa -b 4096
#Copy pub key to remote host .ssh/authorized_keys.
ssh-copy-id user@hostname
```
    
Configure HTTP Proxy Server 
---------------------------
    
- CentOS:
    - `yum install squid squidGuard`
    - `service squid start`
    - `chkconfig squid on`
    - edit `/etc/squid/squid.conf` and add an acl entry for your internal network.
        - `acl localnet src [IP_NETWORK]/[MASK]`
        - `http_access allow localnet`
    - `service squid restart`
    
Create HTTP Proxy Server Black List 
-----------------------------------
    
- SquidGuard, content filter.
- On CentOS:
    - `wget http://www.shallalist.de/Downloads/shallalist.tar.gz`
    - `tar zxvff shallalist.tar.gz`
    - `mkdir /var/squidguard/blacklists`
    - `echo -e 'cnn.com\nwww.cnn.com\nwww.news.com\nnews.com' > /var/squidguard/backlists/testdomains`
    - `chown -R squid:squid /var/squidguard/`
    - `squidGuard -C all &`, genera la base de datos.
    - `chown -R squid:squid /var/squidguard/`, cambia los permisos a la nueva 
    BD generada.
    - editar `/etc/squid/squidguard.conf` y agregar:
        - 
        ```
        dest test {
            domainlist testdomains
            redirect http://www.google.com
        }
        ```

Restrict Access to the HTTP Proxy Server 
----------------------------------------
To restrict an specific host:
- edit `/etc/squid/squid.conf` and add an acl entry for your internal network.
    - `acl [rule_name] src [IP_HOST]/32`
    - `http_access allow localnet ![rule_name]`
- `service squid restart`

    
    
Configure an HTTP Client to Automatically Use a Proxy Server 
-------------------------------------------------------------
    
- Firefox/Settings/Network/Manual Proxy.
    
Configure an HTTP Server - RHEL/CentOS 
--------------------------------------
    
- `yum install httpd`
- `systemctl enable httpd`, enables httpd at boot.
- `systemctl start|stop|restart|status httpd.service`, manages httpd service.
- `/etc/httpd/`, apache directory.
    - `/etc/httpd/conf/httpd.conf`, apache configuration file.
    - `/etc/httpd/conf.d/`, configuration directory.
    - `/etc/httpd/conf.modules.d/`, modules directory.
    
Configure an HTTP Server - Debian/Ubuntu 
----------------------------------------
    
- `apt-get install apache2`
- `service apache2 start|stop|restart`
- `/etc/apache2/`, apache directory.
    - `/etc/apache2/apache2.conf`, apache configuration file.
    - `sites-available/`, virtual host directory.
    - `conf-available/`, configuration directory.
    - `mods-available/`, modules directory.
- `a2ensite|a2dissite [vhost].conf`, enables and disables a site.
- `a2enmod|a2dismod [module]`, enables and disables a module.
    
Configure HTTP Server Logs 
--------------------------

- LogFormat directive, describes a format for use in a log file.
    - `LogFormat format|nickname [nickname]`
- CustomLog directive, is used to log requests to the server. 
    - `CustomLog file|pipe format|nickname [env=[!]environment-variable| expr=expression]`
- LogFormat and CustomLog can be specified on a vhost config file or the apache
config file.
- e.g.
```
# CustomLog with format nickname
LogFormat "%h %l %u %t \"%r\" %>s %b" common
CustomLog "logs/access_log" common

# CustomLog with explicit format string
CustomLog "logs/access_log" "%h %l %u %t \"%r\" %>s %b"
```

Configure SSL with HTTP Server - Server Setup 
---------------------------------------------
    
- Add a new vhost:
```
cat << EOF > [apache_dir_vhost]/ssl-web.conf
NameVirtualHost *:443
<VirtualHost *:443>
    DocumentRoot /var/www/clvx
    ServerName bitclvx.com
    ServerAlias www.bitclvx.com
    
    SSLEngine on
    SSLCertificateFile [path_to_cert]/bitclvx.crt
    SSLCertificateKeyFile [path_to_key]/bitclvx.key
</VirtualHost>
EOF
```
- `systemctl restart httpd.service`
- `service apache2 restart`
    
Configure SSL with HTTP Server - Certificate Creation and Installation 
-----------------------------------------------------------------------
    
```
mkdir [apache_dir]/ssl-certs/
# Creates an x509 certificate not encrypting the key expiring in a year with a 
# encryption key of 2048 bits(apache.key) and getting a certificate(apache.crt) 
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout [apache_dir]/ssl-certs/apache.key -out [apache_dir]/ssl-certs/apache.crt
```
    
Set Up Name Based Virtual Web Hosts - RHEL/CentOS 
-------------------------------------------------
    
```
cat << EOF > /etc/httpd/conf.d/example.com.conf
<VirtualHost *:80>
    ServerName example.com
    ServerAlias www.example.com
    DocumentRoot /var/www/example.com
    ErrorLog /var/log/httpd/error.log
    CustomLog /var/log/httpd/custom.log combined
</VirtualHost>
EOF
```
`systemctl restart httpd`
    
Set Up Name Based Virtual Web Hosts with SSL - RHEL/CentOS 
-----------------------------------------------------------
    
```
yum install mod_ssl

mkdir [apache_dir]/ssl-certs/
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout [apache_dir]/ssl-certs/apache.key -out [apache_dir]/ssl-certs/apache.crt

cat << EOF > [apache_dir_vhost]/example.conf
<VirtualHost *:443>
    SSLEngine on
    SSLCertificateFile [path_to_cert]/apache.crt
    SSLCertificateKeyFile [path_to_key]/apache.key

    DocumentRoot /var/www/clvx
    ServerName bitclvx.com
    ServerAlias www.bitclvx.com
    
    ErrorLog /var/log/httpd/error.log
    CustomLog /var/log/httpd/custom.log combined
</VirtualHost>
EOF
```
`systemctl restart httpd`
    
    
Set Up Name Based Virtual Web Hosts - Debian/Ubuntu 
---------------------------------------------------
    
```
apt-get install apache2

cat << EOF > /etc/apache2/sites-available/example.com.conf
<VirtualHost *:80>
    DocumentRoot /var/www/clvx
    ServerName example.com
    ServerAlias www.example.com
    
    ErrorLog /var/log/httpd/error.log
    CustomLog /var/log/httpd/custom.log combined
</VirtualHost>
EOF

a2ensite example.com.conf
service apache2 restart
```

    
Set Up Name Based Virtual Web Hosts with SSL - Debian/Ubuntu 
-------------------------------------------------------------
    
```
a2enmod ssl
service apache2 restart
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout [apache_dir]/ssl-certs/apache.key -out [apache_dir]/ssl-certs/apache.crt
cat << EOF > /etc/apache2/sites-available/example.com.conf
<VirtualHost *:443>
    SSLEngine on
    SSLCertificateFile [path_to_cert]/apache.crt
    SSLCertificateKeyFile [path_to_key]/apache.key

    DocumentRoot /var/www/clvx
    ServerName example.com
    ServerAlias www.example.com
    
    ErrorLog /var/log/httpd/error.log
    CustomLog /var/log/httpd/custom.log combined
</VirtualHost>

EOF
```
    
Deploy a Basic Web Application / Restrict Access to a Web Page 
--------------------------------------------------------------
    
```
<Directory [path_to_dir]/>
    # How the directory will be scanned, first Allow directives then Deny
    # directives which is implicit.
    Order allow, deny
    Allow [IP_NETWORK]
    Allow [IP_ADDRESS]
</Directory
```

    

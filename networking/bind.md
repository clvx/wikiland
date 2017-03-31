# DNS(Domain Name System)

- DNS is a ditributed database system that is used to associate host names with their respective IP addresses.

## Introduction

- Implemented using one or more centralized servers that are authoritative for certain domains.

## How it works

When a client host requests information from a nameserver, it usually connects to port 53. 
The nameserver then attempts to resolve the name requested. If the nameserver is configured to be a 
recursive name servers and it does not have an authoritative answer, or does not already have 
the answer cached from a earlier query, it queries other nameservers, called *root nameserver*, to
determine which nameservers are authoritative for the name in question, and then queries them to get 
the requested name. Nameservers configured as purely authoritative, with recursion disabled, will not
do lookups on behalf of clients.

## Nameserver Zones

All information is sotred in basic data elements called *resource records*(RR).
The domain names are organized into a tree structure. Each level of the hierarchy is divided by a period(.).
For example: 
- the root domain, denoted by ., is the root of the DNS tree, which is at level zero. 
- The domain name com, referred to as the *top-level domain(TLD)* is child of the root domain(.) so it is the first level of the hierarchy.
- The domain name *example.com* is at the second level of the hierarchy.

        example.com.    86400   IN  A   192.0.2.1

        - The domain name, *example.com*, is the *owner* for the RR. 
        - The value *86400* is the **time to live(TTL)**.
        - *IN*, meaning "the Internet system", indicates the *class* of the RR.
        - *A* indicates the *type& of RR(host address here).
        - The host address *192.0.2.1 is the data contained in the final section of this RR.

A set of RRs with the same type, owner and class is called a *resource record set (RRSet)*.

Zones are defined on authoritative nameservers through the use of *zone files*, which contain
definitions of the RR in each zone. 

Zone files are stored on *primary/master nameservers*, where changes are made to the files, and *secondary/slave nameservers*, which
receive zone definitions from the primary nameservers. Both primary and secondary nameservers are authoritative for the zone and look the same to clients.

## Nameserver Types

- Authoritative 
    * Answer to resource records that are part of ther zones only. 
    * Inncludes both primary/master and secondary/slave nameservers.
    * *Should be available to all clients all the time*.
- Recursive: 
    * Offer resolution services, but they are not authoritative for any zone. 
    * Answers for all resolutions are cached in a memory for a fized period of time, which is specified by the retrieved resource record.

# Bind

## Empty Zones
- Bind configures *empty zones* to prevent recursive servers from sending unnecessary 
queries to Internet servers that cannot handle them(thus creating delays and SERVFAIl responses to clients who query for them). 
These empty zones ensure that immediate and authoritative NXDOMAIN responses are returned instead. 
- `empt-zones-enable` controls whether or not empty zones are created.
    * Default to `yes`
- `disable-empty-zone` can be used to disable one or more empty zones from the 
list of default prefixes that would be used.

## Configuring the named service

Then the `named` service is started, it reads the configuration files from:
- `/etc/named.conf`, main configuration file.
    * Consists of a collection of statements with nested options surrounded by opening and closing curly brackets {}. 
    * Any error will fail to start the `named` service .
- `/etc/named/ `, auxiliary directory for configuration files that are included in the 
main configuration file.

        statement-1 ["statement-1-name"] [statement-1-class] {
          option-1;
          option-2;
          option-N;
        };
        statement-2 ["statement-2-name"] [statement-2-class] {
          option-1;
          option-2;
          option-N;
        };

Note: 
- If you have installed the `bind-chroot package, the BIND service will run in the `chroot` environment: `/var/named/chroot`.
- vim -c "set backupcopy=yes" /etc/named.conf

## Installing BIND

        $sudo yum install bind-chroot
        $sudo systemctl status named
        $sudo systemctl stop named
        $sudo systemctl disable named
        $sudo systemctl enable named-chroot
        $sudo systemctl start named-chroot
        $sudo systemctl status named-chroot

## Common Statement Types

**acl**
- Allows to define groups of hosts, so that they can be permitted or denied access to the nameserver. 

		acl acl-name {
		  match-element;
		  ...
		};
        - match-element is an IP address or a CIDR network.

| Keyword | Description |
| ------- | ----------- |
| any | Matches evey ipaddr |
| localhost | Matches any ipaddr that is in use by the local system |
| localnets | matches any ipaddr on any network to which the local system is connected |
| none | Does not match any ipaddr | 

**include**
- Allows to include files in the `/etc/named.conf`.
    
        include "file-name"
        - *file-name* is an absolute path to a file.

**options**
- Allows to define global server configuration options as well as to set defaults for other statements.
- It can be used to specify the location of the named working directory, types of queries allowed, etc.

        options {
            option;
            ...
        };

- Example:

		options {
		  allow-query       { localhost; };
		  listen-on port    53 { 127.0.0.1; };
		  listen-on-v6 port 53 { ::1; };
		  max-cache-size    256M;
		  directory         "/var/named";
		  statistics-file   "/var/named/data/named_stats.txt";

		  recursion         yes;
		  dnssec-enable     yes;
		  dnssec-validation yes;

		  pid-file          "/run/named/named.pid";
		  session-keyfile   "/run/named/session.key";
		};

**zone**
- Allows to define the characteristics of a zone, such as the location of its 
configuration file and zone-specifc options, 

        zone zone-name [zone-class] {
          option;
          ...
        };
        - zone-name, name of the zone.
            * It's the default value assigned for the $ORIGIN directive used 
            within the corresponding zone file located in /var/named.
            * The named daemon appends the name of the zone to any non-fully 
            qualified domain name listed in the zone file.
        - zone-class is the optional class of the zone.
        - option is a zone statement.
        

- Commonly used options in zone statements

| Option | Description | 
| ------ | ----------- |
| allow-query | Specifies which clients are allowerd to request information about this zone |
| allow-transfer | Specifies which secondary servers are allowed to request a transfer of the zone's information. All transfer requests are allowed by default |
| allow-update | Specifies which hosts are allowed to dynamically update information in their zone. Default option is to deny all dynamic update requests |
| file | Specifies the name of othe file in the *named* working directory that contains the zone's configuration data |
| masters | Specifies from which ipaddr to request authoritative zone information. This option is used only if the zone is define as *type slave* |
| notify | Specifies whether to notify the secondary nameservers when a zone is updated |
|   | yes - The server will notify all secondary nameservers |
|   | no - The server will not notify all secondary nameservers |
|   | master-only - The server will notify primary server for the zone only |
|   | explicity - The server will notify only the secondary nameservers in the *also-notify* list |
| type | Specifies the zone type |
|   | delegation-only - Enfoces the delegation status of infrastructure zones such as COM, NET or ORG |
|   | forward - Forwards all requests for information about this zone to other nameservers |
|   | hint - A special type of zone used to point to the root nameservers which resolve queries when a zone is not otherwise known. No configuration beyond the default is necessary with a *hint* zone |
|   | master - Designates the nameserver as authoritative for this zone. A zone should be set as the master if the zone's configuration files reside on the system |
|   | slave - Designates the nameserver as a salve server for this zone. Master server is specified in *masters* directive |

- A zone statement for a primary nameserver

		zone "example.com" IN {
		  type master;
		  file "example.com.zone";
		  allow-transfer { 192.168.0.2; };
		};

- A zone statement for a seconday nameserver

        zone "example.com" {
          type slave;
          file "slaves/example.com.zone";
          masters { 192.168.0.1; };
        };


**controls**
**key**
**logging**
**server**
**trusted-keys**
**view**

## Editing zone files

- Each zone file contains information about a namespace.
- They are stored in the `named` working directory located in `/var/named/` by default.
- Each zone file is named according to the `file` option in the `zone` statement, 
usuallly in a way that relates to the domain in and identifies the file as 
containing zone data, such as `example.com.com.zone`

- The named service zone files

| Path | Description |
| ---- | ----------- |
| /var/named | Working directory for the `named` service. Only directory `NOT` writable by the `named` service |
| /var/named/slaves | Directory for secondary zones. This directory is writable by the `named` service | 
| /var/named/dynamic |  Directory for files like dynamic DNS(DDNS) zones or managed DNSSEC keys |
| /var/named/data | Directory for various statistics and debugging files |

- A zone file consists of directives and resource records. 
    * Directives tell the nameserver to perfom taks or apply special settings to the zone.
    * Resource records define the prameters of the zone and assign identities to individual hosts.
    * While the directives are optional, the resoruce records are required in order to provide name service to a zone. 

#### Common directives

- Directives begin with the dollar sign character($) followed by the name of 
the directive, and usually appear at the top of the file. 

**$INCLUDE**
- Allows to include another file at the place where it appears, so tthat other 
zone settings can be stored in a separate zone file.

        $INCLUDE /var/named/penguin.example.com

**$ORIGIN**
- Allows to append the domain name to unqualified records, such as those with the host name only.
- Not necessary if the zone is specified in `/etc/named.conf`, since the zone name is used by default.

        $ORIGIN example.com.

**$TTL**
- Allows to set the default `Time to Live(TTL)` value for the zone, that is, how long is a zone record valid.
- Each resource record can contain its own TTL value, which overrides this directive.
- Increasing this value allows remote nameservers to cache the zone information for a longer period of time,
reducing the number of queries for the z one and lengthenin the amount of time 
required propagate resource record changes.

        $TTL 1D

### Common resource records

**A**
- Specifies an ipaddr to be assigned to a name.
- If the `hostname` value is omitted, the record will point to the last specified `hostname`.

        hostname IN A ipaddr

        server1  IN  A  10.0.1.3
                 IN  A  10.0.1.5

**CNAME**
- Canonical name record maps one name to another.
- *CNAME records should not point to other CNAME records*.
- CNAME records should not contain other resource record types(such as A, NS, MX, etc). 
- Other resource records that point to the fully qualifeid domain name (FQDN) of a host(NS, MX, PTR) 
should not point to a CNAME record.

        alias-name IN CNAME real-name

        server1  IN  A      10.0.1.5
        www      IN  CNAME  server1

**MX**

- Mail Exchange record specifies where the mail sent to a particular namespace controlled by this zone should go.
- `email-server-name` is a fully qualified domain name(FQDN). 
- `preference-value` allows numerical ranking of the email servers for a namespace, giving preference to some
email systems over others.
- The MX resource record **with the LOWEST `preference-value` is preferred** over the others.
However, multiple emaiml servers can possess the same value to distribute email traffic evenly among them.

        example.com. IN MX preference-value email-server-name


		example.com.  IN  MX  10  mail.example.com.
					  IN  MX  20  mail2.example.com.

**NS**
- Nameserver record announces authroitative nameservers for a particular zone.
- `nameserver-name` should be a fully qualified domain name(FQDN).

        example.com. IN NS nameserver-name

                     IN NS dns1.example.com.
                     IN NS dns2.example.com.

**PTR**
- The Pointer record points to another part of the namespace.
- `last-IP-digit` directive is the last number in an ipaddr.
- `FQDN-of-system` is a fully qualified domain name(FQDN).
- Used for reverse name resolution, as they point IP addresses back to a particular name.

        last-IP-digit IN PTR FQDN-of-system

**SOA**

- The Start of Authority record announces important authoritative information about a namespace to the nameserver. 
Located after the directives, *it is the first resource record in a zone file*.

        @ IN SOA primary-name-server hostmaster-email (
            serial-number
            time-to-refresh
            time-to-retry
            time-to-expire
            minimun-TTL )

- @ symbol places the $ORIGIN directive as the namespace being defined by this SOA resource record.
- The primary-name-server directive is the host name of the primary nameserver that is authoritative for this domain.
- The hostmaster-email directive is the email of the person to contact about the namespace.
- The serial-number directive is a numerical value incremented every time the zone file is altered to indicate
it is time for the named service to reload the zone.
- The time-to-refresh directive is the numerical value secondary nameservers use to determine how long to
wait before asking the primary nameserver if any changes have been made to the zone.
- The time-to-retry is a numerical value used by secondary nameservers to determine the length of time to wait 
before issuing a refresh request in the event that the primary nameserver is not answering. If the primary server
has not replied to a refresh request before the amount of time specified in the time-to-expire directive elapses, 
the secondary stop responding as an authority for requests concerning that namespace.
- the minimun-TTL defines how long negative answers are cached for. Caching of negative answers can be set to a maximun
of 3 hors(3H).

        @  IN  SOA  dns1.example.com.  hostmaster.example.com. (
               2001062501  ; serial
               21600       ; refresh after 6 hours
               3600        ; retry after 1 hour
               604800      ; expire after 1 week
               86400 )     ; minimum TTL of 1 day

Examples: 

        $ORIGIN example.com.
        $TTL 86400
        @         IN  SOA  dns1.example.com.  hostmaster.example.com. (
                      2001062501  ; serial
                      21600       ; refresh after 6 hours
                      3600        ; retry after 1 hour
                      604800      ; expire after 1 week
                      86400 )     ; minimum TTL of 1 day
        ;
        ;
                  IN  NS     dns1.example.com.
                  IN  NS     dns2.example.com.
        dns1      IN  A      10.0.1.1
                  IN  AAAA   aaaa:bbbb::1
        dns2      IN  A      10.0.1.2
                  IN  AAAA   aaaa:bbbb::2
        ;
        ;
        @         IN  MX     10  mail.example.com.
                  IN  MX     20  mail2.example.com.
        mail      IN  A      10.0.1.5
                  IN  AAAA   aaaa:bbbb::5
        mail2     IN  A      10.0.1.6
                  IN  AAAA   aaaa:bbbb::6
        ;
        ;
        ; This sample zone file illustrates sharing the same IP addresses
        ; for multiple services:
        ;
        services  IN  A      10.0.1.10
                  IN  AAAA   aaaa:bbbb::10
                  IN  A      10.0.1.11
                  IN  AAAA   aaaa:bbbb::11

        ftp       IN  CNAME  services.example.com.
        www       IN  CNAME  services.example.com.
        ;
        ;

This zone file would be called into service with a `zone` statement in the `/etc/named.conf`:

        zone "example.com" IN {
            type master:
            file "example.com.zone"
            allow-update { none; };
        };


**Reverse name resolution zone file**

- A reverse name resolution zone file is used to translate an ipaddr in a particular namespace into a fully qualified
domain name (FQDN). 

Example:

        $ORIGIN 1.0.10.in-addr.arpa.
        $TTL 86400
        @  IN  SOA  dns1.example.com.  hostmaster.example.com. (
               2001062501  ; serial
               21600       ; refresh after 6 hours
               3600        ; retry after 1 hour
               604800      ; expire after 1 week
               86400 )     ; minimum TTL of 1 day
        ;
        @  IN  NS   dns1.example.com.
        ;
        1  IN  PTR  dns1.example.com.
        2  IN  PTR  dns2.example.com.
        ;
        5  IN  PTR  server1.example.com.
        6  IN  PTR  server2.example.com.
        ;
        3  IN  PTR  ftp.example.com.
        4  IN  PTR  ftp.example.com.

This zone would be called into service with a zone statement in the `/etc/named.conf` file similar to the following:

        zone "1.0.10.in-addr.arpa" IN {
            type master;
            file "example.com.rr.zone";
            allow-update { none; };
        };


## rndc

- Allows to administer the `named` service.

        rndc [option.. ] command [ command-option ]
        rndc status, checks status
        rndc reload, reloads all zones
        rndc reload zone-name, reloads a specific zone
        rndc reconfig, reloads config file and adds new zones.
        


























































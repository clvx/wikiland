System Logging
==============

Syslogd and Rsyslogd
====================

- Rsyslogd  is  a  system  utility providing support for message logging.
    - Every logged message contains at least a time and a hostname field, normally a program name field, too, but that depends on how trusty the logging program is. 
    - The rsyslog  package  supports  free definition  of  output  formats  via templates. 
    - It also supports precise timestamps and writing directly to databases.
    - Log files are generally owned by root, although conventions for the ownership and mode of log files vary. 
        - For log files that don't contain sensitive system details, it's usually safe to change the permissions to be world-readable.

- rsyslog.conf file is the main configuration file for the rsyslogd(8) which logs system messages on *nix systems.  
    - This file specifies rules for logging.
    - Basic format: 
        - `selector <Tab> action`
        - selector: `facility.level`
        - The selector and actions fields MUST BE SEPARATED by one or more tabs; spaces don't work.
        - Selectors identify the program ("facility") that is sending a log message and the message's severity level with the syntax.
            - Facility and level lists are listed in syslog(3). 
        - Facility: The facility argument is used to specify what type of program is logging the message.   
            - auth                          security/authorization messages
            - authpriv                      security/authorization messages (private)
            - cron                          clock daemon (cron and at)
            - daemon                        system daemons without separate facility value
            - ftp                           ftp daemon
            - kern                          kernel messages (these can't be generated from user processes)
            - local0 through local7         reserved for local use
            - lpr                           line printer subsystem
            - mail                          mail subsystem
            - news                          USENET news subsystem
            - syslog                        messages generated internally by syslogd(8)
            - user (default)                generic user-level messages
            - uucp                          UUCP subsystem
        - Levels: This de termines the importance of the message:  
            - emerg                         system is unusable
            - alert                         action must be taken immediately
            - crit                          critical conditions
            - err                           error conditions
            - warn                          warning conditions
            - notice                        normal, but significant, condition
            - info                          informational message
            - debug                         debug-level message
        - Actions: The actions field tells syslog|rsyslog what to do with each message.
            - filename                      Appends the message to a file on the local machine. 
                                            Must be an absolute path.
            - @hostname                     Forwards the message to the rsyslogd on hostname.
            - @ipaddress                    Forwards the message to the rsyslogd on host ipaddress
            - |fifoname                     Writes the message to the named pip fifoname.
            - user1,user2,...               Writes the message to the screens of users if they are logged in.
            - *                             Writes the message to all users who are currently logged in.
        - Examples:
            - `facility.level     action`
            - `facility1,facility2.level     action`
            - `facility1.level1;facility2,level2     action`
            - `*.level     action`

Using Logger To Add Entries To Log Files
========================================

- logger, sends messages to an specified log file.
    - -s, --stderr, Outputs the message to standard error as well as to the system log.
    - -i, Logs the PID of the logger process with each line.
    - -t, --tag tag, Marks every line to be logged with the specified tag.

Logrotate
=========

- logrotate  is  designed to ease administration of systems that generate large numbers of log files.  
    - It allows automatic rotation, compression, removal, and mailing of log files.  
    - Each log file may be handled daily, weekly, monthly, or when it grows too large.
    - Normally, logrotate is run as a daily cron job. 

- /etc/logrotate.conf, logrotate configuration file consists of a series of specifications for groups of log files to be managed. 
    - Options that appear outside the context of a log file specification apply to all following specifications. 
        - They can be overridden within the specification for a particular file and can also be respecified later in the file to modify the defaults. 
    - logrotate(5) para mayor información

- Common logrotate options:
    - compress                      Compresses all noncurrent versions of the log file
    - daily, weekly, monthly        Rotates log files on the specified schedule
    - delaycompress                 Compresses all versions but current and next-most-recent
    - endscript                     Marks the end of a prerotate or postrotate script
    - errors emailaddr              Emails error notifications to the specified emailaddr
    - missingok                     Doesn’t complain if the log file does not exist
    - notifempty                    Doesn’t rotate the log file if it is empty
    - olddir dir                    Specifies that older versions of the log file be placed in dir
    - postrotate                    Introduces a script to run after the log has been rotated
    - prerotate                     Introduces a script to run before any changes are made
    - rotate n                      Includes n versions of the log in the rotation scheme
    - sharedscripts                 Runs scripts only once for the entire log group
    - size logsize                  Rotates if log file size > logsize (e.g., 100K , 4M )

```
 # sample logrotate configuration file
       compress

       /var/log/messages {
           rotate 5
           weekly
           postrotate
               /usr/bin/killall -HUP syslogd
           endscript
       }

       "/var/log/httpd/access.log" /var/log/httpd/error.log {
           rotate 5
           mail www@my.org
           size 100k
           sharedscripts
           postrotate
               /usr/bin/killall -HUP httpd
           endscript
       }

       /var/log/news/* {
           monthly
           rotate 2
           olddir /var/log/news/old
           missingok
           postrotate
               kill -HUP `cat /var/run/inn.pid`
           endscript
           nocompress
       }

       ~/log/*.log {}
```



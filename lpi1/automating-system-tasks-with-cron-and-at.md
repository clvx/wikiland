Automating System Tasks With Cron and AT
========================================

Understanding System Cron
=========================

/etc/crontab - This is a special cron file whose primary purpose is to run system wide. The format of this cron file is NOT the same as user cron. /etc/crontab will also execute any files located in /etc/cron.daily /etc/cron.weekly /etc/cron.hourly /etc/cron.monthly as long the user who owns the file has permissions to execute the entire script.

/etc/crontab should contain the following definitions:
01 * * * * root run-pats /etc/cron.hourly
02 4 * * * root run-pats /etc/cron.daily
22 4 * * 0 root run-pats /etc/cron.weekly
42 4 1 * * root run-pats /etc/cron.monthly

# Example of job definition:
# .----------------- minute (0-59)
# | .--------------- hour (0-23)
# | | .------------- day of month (1-31)
# | | | .----------- month (1-12) OR jan,feb,mar,apr ...
# | | | | .--------- day of week (0-6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# | | | | |
# * * * * * user-name command-to-be-executed

Note: Cron entries for crontab are different than usercron because it has a SIXTH entry which defines the user the task shoulb be run as.

Crontab files must end with a line ending.

Note: Cron assumes the machine is running contantly. To schedule a cron on a machine such as a desktop that is shutdown often use *anacron*

run-parts runs all the executable files named within constraints described below, found  in  directory  directory.   Other  files  and directories are silently ignored.

Understanding User Cron Job
===========================

With the right permissions users on your system can each have their own cron.
- User crons are edited and "installed" with *crontab command*.
    - -e allows you to edit the file.
    - -l allows you to view the file.
User cron configuration files are stored in */var/spool/cron* but should never be directly edited.
The root user also has a cron just like all other users on the system.

Cron User Permissions
=====================

- /etc/cron.allow - Users listed will have access to cron and all others will be denied access.
- /etc/cron.deny - Users listed here will be denied access and all others allowed.
- If cron.deny exists then all users are allowed access to cron unless listed in cron.deny.
- If cron.allow all users are denied unless listed in cron.allow.
- Root user can bypass cron.deny and cron.allow.

Creating Cron Jobs By Example
=============================

Special Characters (Most common and ones you need to know):
    - * - Indicates the expression matches "all" values in a field. * in the day field would mean "every day".
    - "-" - (Hyphen) Defines a range value. 0-60 in the minutes field indicates "every minute from 0-60". 5-9 in the hour field indicates "every hour starting from 5 and going through 9".
    - / - (increment of ranges) */2 placed in the minutes field indicates "every two minutes". 3-24/4 in the hour field indicates "run once at 3am and then every 4 hours after up until 23:59".
    - , -(comma) allows you to set multiple times. In the hour field 5,7,9 indicates the cron should run on hour 5,7 and 9.

- *tail -f /var/log/cron*, View cron log and crons running in real time  
`
#Cron examples:
*/2 * * * * date >> minute.txt
10-20 * * * * echo should occur every min for 10 min >> minute.txt
32,40,55 * * * * echo 32-40-55-test date >> minute.txt
`

Using The AT utility
====================

at, executes commands or a file once at a specified time.
atrm, atrm job# will remove the job# of pending AT task.
atq. Displays pending at tasks and job#.
`
at now +1 minute
at>echo "hello"
at>(ctrl+d)
`
Accepts the following time formats:
- hh:mm - if day time is passed on current day will asume next day.
- midnight,
- noon,
- teatime (4pm)
- Can specify am/pm
- Can also specify full date or dates such as now +1 day, now +1 year.

AT User Permissions
===================

/etc/at.allow, users listed here can access at all else will be denied.
/etc/at.deny, users here will be denied at access all other users allowd.


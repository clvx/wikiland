Linux Date And Time
===================

The Date Command
================
- date, displays the current time in the given FORMAT, or set the system date.
- date +%T, prints the time.
- date +%A, locale's full weekday name
- date +%F, full date; same as %Y-%m-%d
- date -d,--date now, prints current time.
- date -d, --date tomorrow, prints tomorrow time
- date -d, --date yesterday, prints yesterday time.
- date -r, --reference=FILE [filename], displays the last modification time of filename.
- date -u, --utc, --universal, prints or set Coordinated Universal Time (UTC)
- date -s STRING, sets time describing STRING.


Working with the hwclock command (hardware clock)
=================================================
- hwclock  is  a  tool for accessing the Hardware Clock.
- It can: 
    - display the Hardware Clock time; 
    - set the Hardware Clock to a specified  time; 
    - set the Hardware Clock from the System Clock; 
    - set the System Clock from the Hardware Clock; 
    - compensate for Hardware Clock drift;
    - correct  the System Clock timescale; 
    - set the kernel's timezone, NTP timescale, and epoch (Alpha only); 
    - compare the System and Hardware Clocks; 
    - and predict future Hardware Clock values based on its drift rate.

hwclock -s, --hctosys, sets the system time from the hardware clock.
hwclock -w, --systohc, sets the hardware clock to the current system time.

Managing Linux Time Zones
=========================

- /etc/localtime, configures the system-wide timezone of the local system that is used by applications for presentation to the user. 
    - It should be an absolute or relative symbolic link pointing to /usr/share/zoneinfo/, followed by a timezone identifier such as "Europe/Berlin" or "Etc/UTC". 
    - For any GNU/Linux:
        - `$ln -s /usr/share/zoneinfo/America/Lima /etc/localtime`
    - For CentOS 7 or Ubuntu - systemd:
        - `timedatectl list-timezones`
        - `timedatectl set-timezone America/Lima`
    - For Ubuntu:
        - `sudo dpkg-reconfigure tzdata`
            - A menu based tool should be started that allows you to change the timezone.

Network Time Protocol(NTP)
==========================

- ntpd program is an operating system daemon which sets and maintains the system time of day in synchronism with  Internet  standard time  servers.
    - The daemon can operate in any of several modes, including symmetric active/passive, client/server broadcast/multicast and manycast.
    - A broadcast/multicast or manycast client can discover remote servers, compute server-client propagation  delay  correction  factors  and configure  itself  automatically.
        - This  makes it possible to deploy a fleet of workstations without specifying configuration details specific to the local environment.
    - ntpd reads the ntp.conf configuration file at startup time in order to determine the synchronization sources and operating modes.
        - Timezone servers can be found at http://www.poll.ntp.org; each server can be added to ntp.conf by adding a line `server 0.ntp.server.location`.

- Install:
    - `yum install ntp`
    - `apt-get install ntp`
- Start service:
    - `serivce ntpd start|stop|restart`

- ntpq utility program is used to monitor NTP daemon ntpd operations and determine performance.
    - ntpq -p, prints a list of the peers known to the server as well as a summary of their state. 
        - This is equivalent to the  peers
                   interactive command.

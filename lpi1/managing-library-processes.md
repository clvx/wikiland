Software Libraries
==================

Managing libraries in Linux
---------------------------
- Configure a system wide library path:/etc/ld.so.conf
    - File includes include ld.so.conf.d/*.conf
        - Tells system to load all files in /etc/ld.so.conf.d that have extensions that end in .conf.
        - ldconfig - must run this program after updating library path.
- /lib and /usr/lib are always included in the libraries even if they are not located in the ld.so.conf file.
- By default library path is /etc/ld.so.conf. However, you can change the library path in your environment by updating the LD_LIBRARY_PATH environment variable. 
    - export LD_LIBRARY_PATH=/usr/local/mylib:/opt/mylib
        - Adds two new locations to the library search path.
        - Does not require ldconfig to be ran for change to take place. Adding libraries to the main ld.so.conf files always do.

    library is a collection of non-volatile resources used by computer programs, often to develop software. These may include configuration data, documentation, help data, message templates, pre-written code and subroutines, classes, values or type specifications.
    ldconfig.  creates  the necessary links and cache to the most recent shared libraries found in the directories specified on the command line,  in the file /etc/ld.so.conf, and in the trusted directories (/lib and /usr/lib).
    LD_LIBRARY_PATH, environment variable to check for library paths per user. 
           /etc/ld.so.conf     File containing a list of colon, space, tab, newline, or comma-separated directories in which to search for libraries.
    /etc/ld.so.cache, File  containing  an  ordered  list of libraries found in the directories specified in /etc/ld.so.conf, as well as those found in /lib and /usr/lib.

Correcting Library Path Problems
--------------------------------
- Most common problems are programs looking in wrong locations for library and library names having minor .x.x.x differences.
    - Fix by creating symbolic links to expected locations and new file names.
        - After creating symbolic link run ldconfig to apply library changes.
        - Be sure to add the location of the symbolic links in the library paths so they can be searched. Or use LD_LIBRARY_PATH environment variable to set the location.

Library Management Commands
---------------------------
- ldd path-to-program: shows library dependencies on a certain program.
- ldconfig - updates cache and links used to locate libraries. (Read chacnges from /etc/ld.so.conf) this is NOT needed when you change the LD_LIBRARY_PATH environment variable.
    - Flags:
    - -N, Does not rebuild cache but updates symbolic links.
    - -n, processes only specified directories.
    - -X, updates cache but not links.
    - -C, new cache file.
    - -r, new root dir.
    - -p, displays current cache.

Using ps To Manage Processes
===========================

PS is used to display LInux system processes. By default PS command truncates the data to fit your console window. Display all columns you will want to dump the information to a text file. By default ps only displays process that were run from its own terminal. 
- -Ae will display all processes on a system. 
- -u displays processes given by a specified user.
- H -F group proceses and use identation to show the hierarchy of relationships between processes. 
- ps w > all.txt tells ps no to truncate to system and output to file. 
- Typing ps with no options/flags(default view) you will only see processes that were RUN FROM IT'S OWN TERMINAL.
    - You can change some default settings in ps by altering PS_PERSONALITY environment variable.
    - Display all processes on a system:
        - -e displays all processes.
        - -x display process user owner.
    - -U or -user, -i Display processes by a specific user.
    - -p select by process id.
    - -u show user list.
    - ps aux, BSD style show users list and all processes.
    - --forest, displays forest.
    - h, used to print process tree.
- ps can use a combination of BSD and other ps version such as GNU, UNIX and BSD.
- ps column headers:
    - PID (process id) can be used to search or kill processes.
    - Username of the user who runs the program.
    - Parent Process IP - The process that launches the child process.
    - TTY, teletype code that identifies the terminal not all processes have these.
    - CPU Time, represents the total CPU time used.
    - %CPU, represents the percentage of cpu time the process is using when it's running.
    - CPU Priority, priority set by nice. Lower priority the more priority the process has with the CPU.
    - %mem , same concept as CPU percentage of memory the process is using.
    - command - the command that launched the process if any.

    ps, displays information about a selection of the active processes
    ps, shows only the processes that are running by the terminal.
    ps -e, display all the processes in the system.
    ps -x, displays all processes by owner.
    ps -U [user], displays processes by specific user.
    ps aux, displays all the processes of the system showing the USER, PID, %CPU, %MEM, VSZ, RSS, TTY, STAT, START TIME, COMMAND
    ps aux --forest,  displays all the process relationships in a hierarchy. 
    ps -U [user] --forest, displays  process relationships in a hierarchy for an specific user..

Using TOP 
=========

- top flags:
    - -d specifies delay between updates.
    - -p lists of to 20 specific PID's.
    - -n displays certain number of updates then quit.
    - -b batch mode.
- Commands while running top:
    - k, kills processes. 
    - q, quits processes.
    - r, changes process priority.
    - s, changes update rate.
    - P, sorts by cpu usage.
    - M, sorts by memory usage.
    - M, displays memory usage.
- Top will also show uptime, memory info, and load average).

    top program provides a dynamic real-time view of a running system.  It can display system summary information as well as a list of pro‐        cesses or threads currently being managed by the Linux kernel.
    - Information is updated every 3 seconds.
    - q, to exit
    - m, for a clean view
    - PID, USER, PR(priority), VIRT, RES, SHR, S, %CPU, %MEM, TIME+, COMMAND
    top -d [N], updates the delay time in N seconds.
    top -p N1,N2, N3; Monitor only processes with specified process IDs in this case shows N1, N2, N3 processes..
    top -n [N], Specifies the maximum number of updates(N), or frames, top should produce before ending.
    top
    - k [PID], kills a process.
    - M, to sort by memory
    - P, to sort by cpu usage
    - s [N], to change delay
    - r [PID] then renice value, renices a PID from -20 to 20. Being -20 top priority and 20 bottom priority.
    top -u [user], displays processes by an specific user.
    top -b,  Starts top in 'Batch mode', which could be useful for sending output from top to other programs or to a file.  In this mode, top will not accept input and runs until the iterations limit you've set with the '-n'  command-line  option  or until killed.

Using nice To Change Linux Process Priorities
=============================================
    process priority: -20 highest priority and -19 lowest priority.
    nice, run a program with modified scheduling priority.
    nice -n [N] [program], nice -[N] [program],  launchs a program with an specific nice value.
    renice -n [N] -p|-g|-u [identifier], alters the scheduling priority of one or more running processes.
    - if -p the identifier is PID.
    - if -g the identifier is the GID.
    - if -u the identifier is the username. 

Killing Processes In Linux
==========================
    kill, sends the specified signal to the specified process or process group.  If no signal is specified, the TERM sig-        nal is sent.  The TERM signal will kill processes which do not catch this signal.  For other processes, it may be  necessary  to        use the KILL (9) signal, since this signal cannot be caught
    - SIGHUP(1), is sent to a process when its controlling terminal is closed. In modern systems, this signal usually means that the controlling pseudo or virtual terminal has been closed. Many daemons will reload their configuration files and reopen their logfiles instead of exiting when receiving this signal.
    - SIGTERM(15),  is sent to a process to request its termination. Unlike the SIGKILL signal, it can be caught and interpreted or ignored by the process. This allows the process to perform nice termination releasing resources and saving state if appropriate. SIGINT is nearly identical to SIGTERM.
    - SIGKILL(9), is sent to a process to cause it to terminate immediately (kill). In contrast to SIGTERM and SIGINT, this signal cannot be caught or ignored, and the receiving process cannot perform any clean-up upon receiving this signal.
    nohup [COMMAND] [ARG]... , run a command inmune to hangups, with output to a non-tty

Using The uname Command To Query System Information
===================================================
    uname, prints certain system information.
    uname -o, prints the operanting system.
    uname -o, --operating-system, prints the operanting system.
    uname -n, --nodename, prints the network node hostname
    uname -s, --kernel-name, prints the kernel name.
    uname -m, --machine, prints the machine hw name.
    uname -v, --kernel-version, prints the kernel version. 
    uname -r, --kernel-release, prints the kernel release. 
    uname -i, --hardware-platform, prints the hw platform or 'unknown'.
    uname -a, --all, prints all information.
    uname -p, --processor, prints the processor type or 'unknown'.

Understanding Background VS Foreground processes
================================================
    fg [jobspec] , resumes jobspec in the foreground, and make it the current job.
    command &, sends a program to the background. 
    jobs, lists all background tasks. 
    bg [jobspec ...],  resumes  each  suspended  job jobspec in the background, as if it had been started with &.

The nohup Command
=================
    nohup [COMMAND], run a command immune to hangups, with output to a non-tty.
    nohup ping -c 500 example.com > /dev/null 2>&1, executes a command even if the terminal is closed.

The free Command
================
    free,  displays the total amount of free and used physical and swap memory in the system, as well as the buffers used by the        kernel.  The shared memory column. represents the 'Shmem' value.  The available memory column represents the  'MemAvailable'        value
    free -b, displays  the  amount  of memory in bytes.
    free -m, displays the amount of memory in megabytes.
    free -s [delay], activates continuous polling delay seconds apart.

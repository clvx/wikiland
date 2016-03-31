Managing Printing
=================

LPD Legacy interface
====================

• Legacy printing subsystem (lpd), “line printing daemon”.
    • `sudo apt-get install lpr`
• Uses configuration file /etc/printcap.
    ◦ Options contained include the printer URL (smb://, file://, lp#://, etc) along with print driver options.
• Was replaced by CUPS as printer definitions/drivers became more complex (and manufacturers required more proprietary control over non-standard protocols unlike dot matrix or PCL printers).
• lpd/lpr: submits files for printing at the command line, to the default or other indicated printer.
    ◦ -P: printer destination (common name).
        - lpr -P [printer] [filename]
    ◦ -U: username in case the printer requires user information for options.
    ◦ -m: send email to indicated address when print is complete.
    ◦ -q: hold the job,
    ◦ -r: remove the print job after successful printing.

• lpoptions, displays or sets printer options and defaults.  If no printer is specified using the -p option, the default printer is used as described in lp(1).
•  lpstat,  displays status information about the current classes, jobs, and printers.
    ◦ -p [printer(s)], shows the printers and whether they are enabled for printing.  If no printers are specified then all printers are listed.
• spool directory:
    ◦ /var/spool/lpd or /var/spool/cups
• lpr can be used at the command line despite the fact that it has been replaced by CUPS, maintains complete compatibility.

CUPS Configuration and Tools
============================

• Modern printing subsystem, replacing lpd as printer drivers became more proprietary, less standard and more complex.
• Command line utilities maintain command and execution compatibility with lpr.
• Predominately GUI, all GUI interfaces interact with the default CUPS server which can be accessed with a browser at port 631.
    ◦ http://localhost:631 – will bring up documentation page, add /admin to bring up admin interface.
• Adding a printer.
    ◦ allows the designation as generic or point to a provided printer PPD definition file or chose from a list of provided common drivers.
        ▪ install hplip package in Debian or RPM distributions for more HP printers.
    ◦ allows options to be set (page size, header page, etc).
    ◦ allows a common name to be set and referred to at command line and within applications.
    ◦ add/change any printer to default system printer.
• Manage and view/change/delete/move print jobs, for the system or by user depending on privileges.
• Configuration file.
    ◦ /etc/cups/cupsd.conf, who can connecto to system to print.
    ◦ /etc/cups/cupsd-browsed.conf 
    ◦ can be edited in browser GUI console.
        - `/etc/init.d cups start|stop|restart`
        - `/etc/init.d cups-browsed start|stop|restart`
• Spool directory.
    ◦ /var/spool/cups.
        ▪ file names correspond to job numbers that can be listed in admin GUI.

Managing Print Queues
=====================

• Primary method for managing print queues is to use the CUPS admin GUI interface.
• Jobs are listed by printer and by user.
    ◦ Previous jobs can be repeated
    ◦ Printers can be paused/disabled or set to reject jobs altogether
• Command line utilities for queue management (legacy)
    ◦ lpr (see video one)
    ◦ lpq: show printer queue status
        ▪ -P: destination printer to show status of, default behavior is to show status of default printer
        ▪ -a: print information on jobs for all printers
        ▪ -l: print information on one or more printer jobs in more verbose mode
    ◦ lpstat: prints printer status information
        ▪ -a: shows whether indicated (or default) printer is accepting jobs.
        ▪ -d: displays the current default printer destination.
        ▪ -l: shows a verbose/long listing for printers, classes or jobs (as indicated).
        ▪ -p: shows the printers and indicates if they are enabled for printing.
        ▪ -s: shows status summary for all (or default) printers (equivalent to -d -c and -v options).
        ▪ -v: shows the printers and the devices they are attached to.
    ◦ lprm: removes the indicated job from the print queue
        ▪ -P: destination printer.
        ▪ ID: the ID of the print job in the queue to remove (can be seen in GUI or by issuing lpq for a list of current jobs).
    ◦ cupsenable/cupsdisable [printer], start/stop printers
        ▪ -c: cancel all jobs on named destination.
        ▪ --hold: hold remaining jobs on named destination.
        ▪ --release: releases jobs on named destination for printing.
    ◦ cupsaccept/reject [printer], accept or reject jobs
        ▪ -r: allows you to indicate a reason for rejecting jobs.
        ▪ must indicate a printer name as part of the command or will disable all printers.

Troubleshooting Print Subsystems
================================

• Most easily managed troubleshooting can be accomplished through the admin GUI.
• lpq – current status of default printer or all printers.
    ◦ first step to determine if jobs are being processed by any or all of the printers.
    ◦ lpr -P printername testfile.txt.
        ▪ check the output to see if that print job has been created.
        ▪ look at /var/spool/cups and see if the job # at the command line when submitted exists.
• cupsenable: enable the printer for accepting/processing jobs.
    ◦ look at the output of the printer to see if it has happened.
• cupsdiable: disable the printer for maintenance, does NOT reject jobs, will queue them up for later.
    ◦ cupsenable when complete.
• lpq will indicate QUEUE status regarding cuspenable/cupsdisable, but lpstatus will indicate PRINTER status regarding cupsaccept/cupsreject.
• lpadmin configures printer and class queues provided by CUPS. It can also be used to set the server default printer or class.
    ◦ lpadmin -E -d [printer], enables the destination and accepts jobs; this is the same as running the cupsaccept(8) and cupsenable(8) programs on the  destination.


systemd

Systemd vs SysvInit
===================

- SysvInit, starts processes one by one.
- Systemd starts processes in parallel, and starts daemons on demand. 
-- Systemd manages daemons and services, and starts them as required.
-- It's a central controller and uses systemctl to manage it.
---- systemctl  [options] [command] [name] may be used to introspect and control the state of the "systemd" system and service manager.
- interface to manage systemd.
- Defines how we enable services at boot time instead of checkconf.
- systemctl get-default, prints the default target.
-- systemd.unit, encodes information about a service, a socket, a device, a mount point, an automount point, a swap file or partition, a start-up target, a watched file system path, a timer controlled and supervised by systemd(1), a temporary system state snapshot, a resource management slice or a group of externally created processes.
---- systemctl -t help, lists all units permitted by the system.
-- Use service units instead of bash scripts to define services. 
-- Use target units(boot targets) instead of runlevels to define which services to initialize in which context. 
---- E.g. a target unit permits not to start a service if its dependency is not loaded yet. 
-- file.service, defines a service unit.
-- file.target, defines a target unit. 

Using Systemd with Services and Service Unit Files
==================================================

- /etc/systemd, systemd configuration directory.
- /etc/systemd/system, systemd local configuration. Consists in service files (file.service) and target files (file.target).
- /usr/lib/systemd/system, overrides any configuration that matches files in /etc/systemd/system. 
- /etc/systemd/system/multi-user.target.wants/, symlinks to service files inside the /usr/lib/systemd/system directory. When a service file is instructed to start(or enable) for a specific target a symlink is created to include this service in the target.  

$systemctl -t help, lists all the potential unit configurations
$systemctl status file.service, shows terse runtime status information about one or more units, followed by most recent log data from the journal. If no units are specified, show system status.

file.service unit file: A unit configuration file whose name ends in .service encodes information about a process controlled and supervised by systemd.
- [Unit], Common variables for unit files. 
-- Description=, A free-form string describing the unit.
-- After=, Space-separated list of unit names. Ensures that the configured unit is started after the listed unit finished starting up.  Configures ordering dependencies between units. 

- [Service], carries information about the service and the process it supervises.
---ExecStart= Commands with their arguments that are executed when this service is started.
--- ExecStartPre=, ExecStartPost=,  Additional commands that are executed before or after the command in ExecStart=, respectively.
--- ExecReload= Commands to execute to trigger a configuration reload in the service.
--- Restart= Configures whether the service shall be restarted when the service process exits, is killed, or a timeout is reached.

-[Installation], carries installation information for the unit. It is used exclusively by the enable and disable commands of the systemctl(1) tool during installation of a unit.
-- WantedBy= This option may be used more than once, or a space-separated list of unit names may be given. A symbolic link is created in the .wants/ or .requires/ directory of each of the listed units when this unit is installed by systemctl enable

$systemctl enable [file].service, Enable one or more unit files or unit file instances. This will create a number of symlinks as encoded in the "[Install]" sections of the unit files. After the symlinks have been created, the systemd configuration is reloaded to ensure the changes are taken into account immediately, but it doesn't activate it only load it.
- This does not have the effect of also starting any of the units being enabled. 
$systemctl start [file].service, Start (activate) one or more units specified on the command line.
$systemctl is-active [file].service, Check whether any of the specified units are active. 


Systemd Targets & Boot Targets
==============================

Target units, group of dependencies that needed to be launched when the target is called. A target can call other targets.
$systemctl list-dependencies [target_unit], shows units required and wanted by the specified unit. This recursively lists units following the Requires=, RequiresOverridable=, Requisite=, RequisiteOverridable=, Wants=, BindsTo= dependencies.
$systemctl list-units --type=target, lists all target units describing if it's loaded, actived, and their descriptions. 
$systemctl list-units --type=target --all, lists all target units describing if it's loaded and NOT loaded, actived, and their descriptions. 
$systemctl list-unit-files --type=target --all, lists all target available to use on the system.

In SysvInit and upstart $telinit [runlevel] was used to change between runlevels, in $systemd systemctl isolate [target_unit] is used to change between boot targets(or runlevels according to SysvInit terminology). 
- recue.target is the same as runlevel 1 or single user mode. 
- shutdown.target is the same as runlevel 0 or shutdown.
- graphical.target is the same as runlevel 5 or graphical user mode.
- multi-user.target is the same as runlevel 3 or multi user mode.
- /etc/systemd/system/default.target, is a symlink which points to the default target unit.
-- To change the default.target a new symlink must be created pointing to the desired target unit.

Identify Enabled Services And Running Services
==============================================

$systemctl list-units --type=service, shows all the active and running services that are started throuhg systemctl
$systemctl list-units --type=service --all, shows all the active, inactive and running services that are started throuhg systemctl
$systemctl list-unit-files --type=service, shows all service unit files which are enable and disable on the system. 
$systemctl list-unit-files --type=service --all, shows all service unit files which are enable and disable on the system regardless of their state(active or inactive). 

Using Wall To Issue System Wide Messages
========================================

wall [message | file], wall  displays  a  message,  or  the  contents of a file, or otherwise its standard input, on the terminals of all currently logged in users
wall -n|--nobanner [message], Suppress the banner who sends the messages
wall messages are recorded to syslog


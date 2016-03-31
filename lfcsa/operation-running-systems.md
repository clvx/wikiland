Operation of Running Systems
============================


Change the Priority of a Process / Identify Resource Utilization by Process 
----------------------------------------------------------------------------

`ps`, prints processes running in the current terminal for current user.
`ps aux`, prints all processes running by user.
`ps axjf`, tree view with PPID.
`pgrep bash`, gets PID of a program.

`kill -KILL PID`, terminates or kills a program.
`kill -SIGHUP PID`, restart a program.
`kill -l`, lists signal names.

`nice [OPTION] [COMMAND]`,  Run  COMMAND  with  an  adjusted  niceness, which 
affects process scheduling.
    - With no COMMAND, print the current niceness.
    - Niceness values range from -20 (most favorable to the process) to 19 
    (least favorable to the process).

`renice`,  alters  the  scheduling  priority of one or more running processes.  
    - `renice [priority] PID`
        - The first argument is the priority value to be used.
        - The other arguments are interpreted as process IDs (by default), process 
        group IDs, user IDs, or user names.
        - renice'ing a process  group  causes  all processes  in the process group 
        to have their scheduling priority altered.
        - renice'ing a user causes all processes owned by the user to have their 
        scheduling priority altered.


Manage the Startup Processes and Services 
-----------------------------------------

System service is a program which starts on boot.

Upstart
- Processes managed by init are known as jobs and are defined by files in the `/etc/init` directory, and watches for future changes to these files using inotify(7).
    - `status [service]`, shows status of a service.
    - `stop/start/restart [service]`, to manage states of a service.
- Files ending .override are called override files which it takes precedence over those equivalent named stanzas in the corresponding configuration file contents for a particular job.
    - `echo "manual" | sudo tee /etc/init/[service].override`, to disable a service at startup.


Systemd
- Systemd starts processes in parallel, and starts daemons on demand. 
- Use service units instead of bash scripts to define services. 
- Use target units(boot targets) instead of runlevels to define which services to initialize in which context. 
    - `systemctl status [service]`, shows status of a service.
    - `systemctl start|stop|restart [service]`, shows status of a service.
    - `systemctl disable|enable [service]`, disables service at startup.

Install and Update Packages from the Network, a Remote Repository, or from the Local Filesystem (Debian/Ubuntu Distributions) 
-----------------------------------------------------------------------------------------------------------------------------

- `dpgk -l [package-name-pattern]`, List packages matching given pattern.
- `dpkg -L [package name]`, List files installed to your system from package-name.
- `apt-cache pkgnames [prefix]`, This command prints the name of each package APT knows. 
    - The optional argument is a prefix match to filter the name list.
- `sudo apt-cache search [pattern]`,  looks up for a pattern.
- `apt-cache showpkg [package..]`, displays information about the packages
- `apt-cache stats`, stats displays some statistics about the cache.
- `apt-get autoclean`, Like clean, autoclean clears out the local repository of 
retrieved package files. The difference is that it only removes package files 
that can no longer be downloaded, and are largely useless. This allows a cache 
to be maintained over a long period without it growing out of control.
- `apt-get clean` , clears out the local repository of retrieved package files.
    - It removes everything but the lock file from /var/cache/apt/archives/ 
    and /var/cache/apt/archives/partial/.
- sources.list
    - contains the list of repositories that you can download content from.
    - sources section list allows download of source code for packages.
    - packages section allow the binary packages.
- `apt-get update`, updates the repository list cache, making available 
packages for installation from any of those configured repositories.
- `apt-get upgrade`, upgrades your distribution packages, i.e., if there are 
updates for packages you have installed then it will list and offer to install 
them.
- `apt-get dist-upgrade`, will offer to upgrade your distribution from one 
version to another if another ‘released’ version is available, beta versions 
can also be installed but require a configuration change in the repos file.
- `apt-get install [package..]`, this command will install whatever package(s) 
that you indicate directly following along with the dependencies for it.
- `apt-get remove [package]`, this command will remove whatever package(s) that
you indicate directly following along with dependencies that are no longer 
needed by any other installed packages.
- `apt-get purge [package]`, removes a package and its configuration files. 
- `apt-get download [package]`, downloads a package only without dependencies.
- `apt-get changelog [package]`, shows package changelog.
- `apt-get check`, show if a dependency is broken.

Install and Update Packages from the Network, a Remote Repository, or from the Local Filesystem (RHEL/CentOS Distributions) 
---------------------------------------------------------------------------------------------------------------------------

- RPM Package Naming Convention: `rpm-package-name.versionumber-buildnumber.architecture.rpm`
- yum, Yellowdog updater Modified, is  an interactive, rpm based, package manager. 
    - It can automatically perform system updates, including dependency 
    analysis and obsolete processing based on "repository" metadata. 
    - It can also perform installation of new packages, removal of old packages
    and perform queries  on the  installed and/or available packages among many
    other commands/services.
- `yum update` 
    - If run without any packages, update will update every currently
installed package.  
    - If one or more  packages  are specified,  Yum  will only update the 
    listed packages.
- `yum search [pattern]`, By default search will try searching just package 
names and summaries, but if that "fails" it will then try descriptions and url.
- `yum install -y [package]`, installs a package accepting by default.
- `yum info [package]`, displays summary information about a package.
- `yum install -y yum-utils`, utils like yumdownloader.
- `yumdownloader [package]`, downloads rpm package only.
- `yum list`, lists all packages.
- `yum list installed`, lists all installed packages.
- `yum check-update`, checks if there's any update.
- `yum grouplist`, list group software packages.
- `yum groupinstall [group]`, install a package group.
- `yum repolist all`, lists all repositories.
- `yum --enablerepo=[repo_name] [package]`, install a package using a specific
repo.
- `yum clean all`, cleans all the cache. 
- `yum history`, lists yum log commands.
- `yum provides [package]`, lists what a package provides and its repo.

- `rpm -q --requires [package-name]`, lists all the package dependencies.
- `rpm -ql [package_name]`, list the files and directories that are installed 
with that package.
- `rpm -ihv [package-name]`, installs a package displaying progress verbously. 
- `rpm -Uvh [package-name]`, This  upgrades  or installs the package currently 
installed to a newer version.  This is the same as install, except all other 
version(s) of the package are removed after the new package is installed, 
displaying progress verbously.
- `rpm -qi [Package]`, verifies that a package is installed.
- `rpm -qa [package]`, prints all the installed packages.
- `rpm -evv [package]`, removes a package verbously.
- `rpm -qdf [/path/to/program]`, gets all documentation dependency for a package.
- `rpm -Va`, checks if all package keys are verified.
- `rpm -qa gpg-pubkey*`, searches for all pubkeys existing on the system.
- `rpm --rebuilddb`, rebuilds rpm database.



Set File Permission and Ownership 
---------------------------------

Everything in Linux is a file. 
- chmod -R [file], changes permissions for a file or directory. 
    -r or 4: reads a file or lists a directory
    -w or 2 : writes in a file or a directory.
    -x or 1: executes a file or opens a directory.
    -a: all.
    -u: user or owner.
    -g: group.
    -o: other.
    - chmod a+rwx [file], adds read, write and execute to user, group and others.
    - chmod a-rwx [file], removes read, write and execute to user, group and others.
    - chmod 700 [file], add read, write and execute to owner and removes all 
    permissions to group and others.
- chown -R user.group [directory], changes ownership of a directory
    - if a user owns a file or directory, the user can changes permissions of 
    that file or directory.


Use Shell Scripting to Automate System Maintenance Tasks - Part I 
-----------------------------------------------------------------
- Shebang, `#!`, declaration of script.
- A shell script consists of sequential shell commands.
    - It must be executable by its caller.
- `export PATH=$PATH:[path_to_scripts]`, to have scripts at PATH.
- A script can be linked by another file using symlinks. 

```
#!/bin/bash 
```

Use Shell Scripting to Automate System Maintenance Tasks - Part II 
------------------------------------------------------------------

#REVISAR bash-scripting del lpi
```
DIRECTORY="/tmp/"
if [ -d "$DIRECTORY" ]; then
    for count in 1 2 3
    do
        echo "Directory Exists - line $count"
    done
else
    echo "This directory does not exist"
fi

for count in 1 2 3 4 5
do
    echo "This is line $count"
done


while read HOST; do
    ping -c 3 $HOST
done < myhosts

```

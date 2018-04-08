Logs & More File Management Tools
=================================

`/var/log`, system and services log files.

`tail -n # [file]`, outputs the last n lines of a file.

`tail [file]`, outputs the last 10 lines of a file by default.

`tail -f [file]`, outputs appended data as the file grows.

`cat file1 > file2`, concatenates file2 and redirects output to file2

`cat file1 > file2`, prints file1 and redirects output to file2 instead of standard output

`cat file | grep 'pattern'`, pipes stdout to grep and then searches for pattern.

`/var/log/messages`, Contains global system messages, including the messages that are logged during system startup.

`/var/log/dmesg`, Contains kernel ring buffer information. When the system boots up, it prints number of messages on the screen that displays information about the hardware devices that the kernel detects during boot process. These messages are available in kernel ring buffer and whenever the new message comes the old message gets overwritten

`/var/log/auth.log`, Contains system authorization information, including user logins and authentication machinsm that were used.

`/var/log/boot.log`, Contains information that are logged when the system boots

`var/log/dpkg.log`, Contains information that are logged when a package is installed or removed using dpkg command

`var/log/dpkg.log`, Contains information that are logged when a package is installed or removed using dpkg command

`/var/log/kern.log`, Contains information logged by the kernel. Helpful for you to troubleshoot a custom-built kernel.

`/var/log/lastlog`, Displays the recent login information for all the users. This is not an ascii file. You should use lastlog command to view the content of this file.

`/var/log/maillog` `/var/log/mail.log`, Contains the log information from the mail server that is running on the system. For example, sendmail logs information about all the sent items to this file

`/var/log/alternatives.log`, Information by the update-alternatives are logged into this log file. On Ubuntu, update-alternatives maintains symbolic links determining default commands.

`/var/log/cups`,  All printer and printing related log messages

`/var/log/yum.log`, Contains information that are logged when a package is installed using yum

`/var/log/anaconda.log`, When you install Linux, all installation related messages are stored in this log file

`/var/log/cron`, Whenever cron daemon (or anacron) starts a cron job, it logs the information about the cron job in this file

`/var/log/secure`, Contains information related to authentication and authorization privileges

`/var/log/wtmp` `/var/log/utmp`, Contains login records. Using wtmp you can find out who is logged into the system. who command uses this file to display the information.

`/var/log/faillog`, Contains user failed login attemps. Use faillog command to display the content of this file.


Root User, Sudo Users And Setting Up Your User Account
======================================================

    sudo, execute a command as the superuser or another user, as specified by the security policy.
    useradd, create a new user or update default new user information.. adds information to /etc/passwd
    visudo, edit the sudoers file. locks the sudoers file against multiple simultaneous edits, provides basic sanity checks, and checks for parse errors.
    %wheel group, super user group
    usermod -G [group] [user], adds a group to a user
    userdel -r [user], deletes a user and its files and directories; without -r only deletes the user.
    In Debian, Ubuntu, or Centos the sudo, admin or wheel group is the super user group.

Navigating Linux & The File System
==================================

    .file, hidden file
    ls  -la, lists all files in long listing(timestamp, permissions, owner, group).
    cd [directory], changes directory
    mv [source] [dest], moves from source to destination
    tail [file], output the last part of files.
    pwd, prints the working directory
    head [file], output the first part of files.
    rm [file], removes a file
    cd, changes to the current user home directory
    rmdir [directory], removes a directory if it's empty
    mkdir [directory], creates a directory
    rm -r, removes everything inside the directory including the directory.
    touch, changes file timestamps
    cp -r [source] [directory], copy files recursevely 
    rm -rf, rm -r, removes recursevely everything inside the directory including the directory even if it has files.
    /var, directory for variable data
    /etc, directory for configuration files

File Permissions 
================

    touch [file], creates a file without editing
    ls -al, lists all file in a long listing
    -rw-rw-r--. 1 mike mike   0 nov  9 15:04 my_file
    - First -, type of file: d(directory), t(sticky).
    - Segundo ---, represents tuser permissions rwx or 777 as octal.
    - Second ---, represents tuser permissions rwx or 777 as octal.
    - Third ---, represents group permissions rwx or 777 as octal.
    - Fourth ---, represents others permissions rwx or 777 as octal.
    chmod -R [file], changes permissions for a file or directory. 
    - r or 4: reads a file or lists a directory
    - w or 2 : writes in a file or a directory.
    - x or 1: executes a file or opens a directory.
    chown -R user.group [directory], changes ownership of a directory
    if a user owns a file or directory, the user can changes permissions of that file or directory.

Cron Jobs
=========
           crond - daemon to execute scheduled commands. 
    - stateless, it doesn't save the last time a command has been executed.
    - cron only works if the system is awake. 
    anacron,  is  used  to  execute commands periodically, with a frequency specified in days.  Unlike cron(8), it does not assume that the        machine is running continuously.  Hence, it can be used on machines that are not running 24 hours a day to  control  regular  jobs  as  daily, weekly, and monthly jobs. For each job, Anacron checks whether this job has been executed in the last n days, where n is the time period specified for that job.        If a job has not been executed in n days or more, Anacron runs the job's shell command, after waiting for the number of minutes specified as the delay parameter.
    regular users can schedule their own taks. 
    cron.deny, each user listed in the file can't execute scheduled jobs. 
    cron.allow, each user listed in the file can execute scheduled jobs.
    /etc/crontab, system crontab.  Nowadays the file is empty by default.  Originally it was usually used to run daily, weekly, monthly jobs.  By               default these jobs are now run through anacron which reads /etc/anacrontab configuration  file
    Sintax: 1 2 3 4 5 /path/to/command arg1 arg2
    Sintax: 1 2 3 4 5 /root/backup.sh
    Where,
    - 1: Minute (0-59)
    - 2: Hours (0-23)
    - 3: Day (0-31)
    - 4: Month (0-12 [12 == December])
    - 5: Day of the week(0-7 [7 or 0 == sunday])
    - /path/to/command - Script or command name to schedule
    Operators:
    - The asterisk (*) : This operator specifies all possible values for a field.
    - The comma (,) : This operator specifies a list of values,
    - The dash (-) : This operator specifies a range of values
    - The separator (/) : This operator specifies a step value, for example: "0-23/" can be used in the hours field to specify command execution every other hour. Steps are also permitted after an asterisk, so if you want to say every two hours, just use */2.
    Syntax: 1 2 3 4 5 USERNAME /path/to/command arg1 arg2
    Syntax: 1 2 3 4 5 USERNAME /path/to/script.sh
    /etc/{cron.daily, cron.hourly,cron.monthly,cron.weekly}, if you put a script inside of one of these directories, the script will wun automatically according to the directory.
    crontab, is  the  program  used  to install, remove or list the tables used to serve the cron(8) daemon.  Each user can have their own        crontab, and though these are files in /var/spool/cron, they are not intended to be edited directly.
    more info: http://www.cyberciti.biz/faq/how-do-i-add-jobs-to-cron-under-linux-or-unix-oses/
A Look At System Resources With The Linux Top Command
    top, displays linux processes. The top program provides a dynamic real-time view of a running system.  It can display system summary information as well as a list of  processes or threads currently being managed by the Linux kernel.

Basic User Management For Fresh Images/Server Installs
======================================================

    whoami, changes user
    su, subtitutes user. Without parameters logs as root user
    passwd, changes a user password
    passwd [user], changes a user password, without parameters changes the current user.

Finding Files In Linux Using Find, Locate, Whereis, Which and Type
===================================================================

    find /etc -name motd, looks for motd in /etc
    find permits to look for files and their attributes.
    find / -name *.c , looks for files which contains any file wich ends with .c
    find /etc -perm 777, looks for files and directories with all the permissions enabled. 
    find / -size 1M, finds files with a size of 1MB.
    fin /etc -maxdepth 1, looks for files with a maximun recursivity of maxdepth N. 
    fin /etc -maxdepth 1(it could be N), looks for files with a maximun recursivity of 1 maxdepth(it could be N maxdepth).
    find /home -user user(it could be any user), looks for files owned by user(it could be any user). 
    locate, indexes file on the system and stores it in a database.
    - sudo updatedb, to index the files before using update.
     whereis,  locates source/binary and manuals sections for specified files.
     whereis [filename], locates source/binary and manuals sections for specified files.
    which filename, returns the pathnames of the files (or links) which would be executed in the current environment.
    type, indicate how each name would be interpreted if used as a command name.

Getting Started With Python 3
=============================
    sudo apt-get install python3, to install python3

Sticky/Repeat Keys and Slow/Bounce Keys Toggle
==============================================
    sticky keys, useful for people with inhability to type or having trouble with typing. 
    - sticky key would stick until the next key press happens
    To enable in ubuntu: settings -> universal access -> turn on sticky keys, check in beep when a modifier key is pressed.
    - with this if I press a key it will wait until a next key is pressed. eg. ALT + F4, it will wait for F4. 
    Bounce keys, Ignores fast duplicate keypresses.
    - To enable in ubuntu: settings -> universal access -> turn on bounce keys

Mouse Keys and Onscreen Keyboard
================================
          System settings -> Universal Access -> Pointing and Clicking ->  Mouse keys, Control the pointer using the keypad.
     System settings -> Universal Access -> Typing -> On screen keyboard, shows a keyboard.

Screen Reader and Screen Magnifier
==================================

    System settings -> Universal Access -> Seeing -> Screen Reader, reads out loud in which desktop context the mouse is. 
     System settings -> Universal Access -> Seeing -> Zoom, enables zoom functions

A Look At VI And Nano Text Editors
==================================

    nano, editor for newcomers
    vi, installed by default
    vi, insert - command - visual modes
    :wq!, saves and closes the file. 
    :q!, closes without saving changes. 
    esc + u, undo a change.
    :w!, saves the file without closing.
    nano [file], opens a file
    ctrl + k, deletes the whole line in nano.
    ctrl +x, exits a file

Disk Quotas
===========

    Quota, a user system call interface to restrict how much disk  a particular user or group could have.
    To enable quotas, add usrquota and grpquota to the mount options of the filesystem specified. 
    quotacheck  examines  each filesystem, builds a table of current disk usage, and compares this table against that recorded in the disk quota        file for the filesystem. If any inconsistencies are detected, both the quota file  and  the        current  system  copy  of the incorrect quotas are update.
    -  By default, only user quotas are checked.  quotacheck expects each filesystem to be checked to have  quota  files  named  [a]quota.user  and        [a]quota.group located at the root of the associated filesystem.  If a file is not present, quotacheck will create it.
    touch /quota.{user,group}
    chmod 600 /quota.{user,group}
    quotacheck -avugm, checks all filesystems in /etc/fstab which it supports quotas for users an groups but not remount them. 

User Quotas
===========

    edquota  is  a  quota  editor.
    edquota [user], to add, modify or delete quotas for a user
    repquota -s [filesystem], prints a summary of the disc usage and quotas for the specified file systems. For each user the current number of files and amount of space (in kilobytes) is printed, along with any quota limits set with edquota(8) or setquota(8). In the second column repquota prints two characters marking which limits are exceeded.
    - If user is over his space softlimit or reaches his space hardlimit in case softlimit is        unset, the first character is '+'. Otherwise the character printed is '-'. The second character denotes the  state  of  inode  usage  analogously.
    One way to keep updated user quota information is to run daily(in cron) quotacheck -avugm.
A Look At dselect
    dselect,       select operates as a front-end to dpkg(1), the low-level debian package handling tool. It features a full-screen package selections manager with package depends and conflicts resolver. When run with administrator privileges, packages can be installed, upgraded and removed. Vari‐ ous access methods can be configured to retrieve available package version information and installable packages from package repositories.
Which and Whereis
    which [command], takes one or more arguments. For each of its arguments it prints to stdout the full path of the executables that would have been executed when this argument had been entered at the shell prompt. It does this by searching for an exe- cutable or script in the directories listed in the environment variable PATH
    whereis [command], locates source/binary and manuals sections for specified files.
Finding Files With Locate
    locate [pattern],   locate  reads  one or more databases prepared by updatedb(8) and writes file names matching at least one of the PATTERNs to standard output, one per line.
    updatedb,  creates  or  updates  a  database used by locate(1).  If the database already exists, its data is reused to avoid        rereading directories that have not changed.
    -        updatedb is usually run daily by cron(8) to update the default database.
    locate -w|--wholename [command],               Match only the whole path name against the specified patterns.
The Powerful Find Command
    find searches the directory tree rooted at each given file name by        evaluating the given expression from left to right, according to the rules of precedence (see section OPERATORS), until the        outcome  is  known  (the left hand side is false for and operations, true for or), at which point find moves on to the next file name.
    find . , finds all files in the current path
    find . -name 'cron*', finds all files which starts with cron in the current path.
    find . -type f -name  'cron*', finds only files which starts with cron in the current path.
    find . -type d -name 'cron*', finds only directories which starts with cron in the current path.
    find /home -perm 777, finds all files with 777 permissions. 
    find /home -perm 777 -exec chmod 555 {} \; finds all files with 777 permissions and changes permissions to those found files to 555.
    - "All following arguments to find are taken to be arguments to the command until an argument consisting of ';' is encountered".  find needs to know when the arguments of exec are terminated. It is natural to terminate a shell command with ; because also the shell uses this character. For the very same reason such a character must be escaped when inserted through the shell.
    find / -mtime +1, finds everytime in the root filesystem that is modified in the past day.  
    find / -group mygroup, finds all files owned by group mygroup in the root directory.
    find . -sizw 1Mb, finds all files with a 1M size.
wc, split, cat, and diff commands
           cat - concatenate files and print on the standard output
    cat file1 file2, concatenates both files. 
           wc - print newline, word, and byte counts for each file.
    split - split a file into pieces. Output  fixed-size  pieces of INPUT to PREFIXaa, PREFIXab, ...; default size is 1000 lines, and default PREFIX is 'x'.  With no INPUT, or when INPUT is -, read standard input.
    split -l 2 [filename], splits a file in a size of 2 line in many file as needed.
    diff - compare files line by line

Streams (stdin, stdout, stderr) and Redirects
=============================================

    Streams: 
        1>filename       # Redirect stdout to file "filename."
      1>>filename       # Redirect and append stdout to file "filename."
       2>filename       # Redirect stderr to file "filename."
     2>>filename       # Redirect and append stderr to file "filename."
     &>filename       # Redirect both stdout and stderr to file "filename."
    0< , < filename # Accept input from a file.
    2>&1       # Redirects stderr to stdout.
    - bad_command >>filename 2>&1
    -  # Appends both stdout and stderr to the file "filename" ...
    set -o noclobber,  If  set, bash does not overwrite an existing file with the >, >&, and <> redirection operators. This may be overridden                       when creating output files by using the redirection operator >| instead of >.
Pipes
    $command 1 | command 2, Pipes, General purpose process and command chaining tool.
grep, egrep, and fgrep
           grep, egrep, fgrep - print lines matching a pattern
    grep [pattern] [file], searches pattern in a file.
    grep -c [pattern] [file],  Suppress normal output; instead print a count of matching lines for each input file.
    grep -f [input_file_patterns] [file], Obtain  patterns  from  FILE,  one  per  line.   The  empty file contains zero patterns, and therefore matches nothing.
    grep -l -r [pattern] [path], Suppress  normal  output;  instead  prints  the name of each input file from which output would normally have been printed recursively.  The scanning will stop on the first matc.
    egrep, grep -E, extended grep. 
    grep -i [pattern] [file], Ignore case distinctions in both the PATTERN and the input files
    grep -E [pattern1|pattern2] [file], Two regular expressions may be joined by the infix operator |; the resulting regular expression matches  any  string  matching  either alternate expression.
    grep -v [pattern] [file], Invert the sense of matching, to select non-matching lines.
    fgrep, grep -F, Interpret  PATTERN  as  a  list  of  fixed  strings, separated by newlines, any of which is to be matched.
    fgrep, grep -F, Interpret pattern LITERALLY as a list of fixed strings.

Working with Objects
====================

    Object: a data structure to hold methods and data in a logical unit.
    Everything in Python is an object.
    Class, is a template to define the attributes and methods of an object.
    Class names should be Upper Camel Case with no spaces.
    All classes and methods should have a doc string.
    module, a file containing python code.
    imports automatically from the directory you are in, or must be defined using sys.path if in a different location.
    import sys\n sys.path.append("/path/to/module")\m from module import myfunction

Cut Command
===========

    cut - remove sections from each line of files
    cut -f1 -d: /etc/passwd, obtains the first field delimiting each filed with a colon(:).

Disk Partitioning Schemes
=========================

    Setting up your disk layout is going to be infinitely easier during installation than making adjustments afterwards.
    Determine what kind of server or desktop you are building. This will affect the partition layout.
    Desktop build 100gb Disk:
    - /boot: 2gb
    - /home: 30gb
    - /opt: 20gb
    - /var: 10gb
    - /: 30gb
    - swap: 8gb
    Server build 100gb disk:
    - /boot: 2gb
    - /home: 10gb
    - /opt: 10gb
    - /var: 40gb
    - /: 30gb

sed Stream Editor
=================
    sed, A stream editor is used to perform basic text transformations on an input stream (a file or input from a pipeline).
    sed 's/pattern1/pattern2/' file, substitutes pattern1 for pattern2 on stdout.
    sed 's/pattern1/pattern2/w output_file' file, substitutes pattern1 for pattern2 and writes matches substitution to output.txt
    sed '/pattern/w output_file' file, writes all pattern matechs to output_file.
    sed '0,/pattern/s/pattern1/pattern2/' file, looks for the first occurrence of pattern, then subtitutes in that line pattern1 for pattern2.

tee command
===========
    tee - read from standard input and write to standard output and files
    $cat /etc/shadow | sudo tee ~/shadow_file, takes the cat contents as stdin and writes to ~/shadow_file
    $cat /etc/fstab |  tee -a ~/fstab, takes the cat contents as stdin and appends to ~/fstab

Docker Architecture
===================

    Docker Architecture: Daemon, client, docker registry
    Docker clients and daemons communicate via sockets or through a RESTful API.
    Containers are isolated, but share OS and, where appropriate, bins/libraries. 

The Docker Hub
--------------

    Docker Hub, is a public registry/repository that is maintained by Docke containing a large number of images that you can download and use to build containers. 
    Docker hub, http://hub.docker.com

Docker Installation
-------------------

    Installation, sudo apt install docker.io 

Creating Our First Image
------------------------

    sudo docker version, print docker information
    sudo docker info, prints information about docker installation.
    sudo docker pull [image], Pull an image or a repository from a Docker registry server
    sudo docker run -i -t /bin/bash, abre una shell en el contenedor

Working With Multiple Images
----------------------------

    sudo docker search [pattern], looks up for an image

Packaging A Customized Container
--------------------------------

     sudo docker commit -m="commit message" -a="author" [image-id] [image-name], commits changes of an image and publish it.
    sudo docker images, to list the new image created.
    Docker can build images automatically by reading the instructions from a Dockerfile. A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. Using docker build users can create an automated build that executes several command-line instructions in succession
    The docker build command builds an image from a Dockerfile and a context. The build’s context is the files at a specified location PATH or URL. The PATH is a directory on your local filesystem. The URL is a the location of a Git repository.  A context is processed recursively. So, a PATH includes any subdirectories and the URL includes the repository and its submodules.
    sudo docker build -t="ubuntu:latest" . , overrides the ubuntu:latest image with the new variables defined in the Dockerfile located in path '.'
    echo "# This is our custom Dockerfile build for sharing\nFROM ubuntu:latest\nMAINTAINER Clvx <michael.ibarra@gmail.com>\nRUN apt update\nRUN apt install -y ruby ruby-dev" > Dockerfile

Running Container Commands With Docker
--------------------------------------

    sudo docker ps, prints which containers are running. 
    sudo docker run -i -t [image] /bin/bash, launchs a docker container with an interactive shell.
    sudo docker run [image] [command], launcha a docker container then runs a command a shuts down.
    sudo docker run -d ubuntu:latest /bin/bash -c "while true; do echo DOCKERMAN; sleep 3; done", launchs a docker container as a daemon then runs a comand.
    sudo docker logs [docker_name], Fetch the logs of a container
    sudo docker stop [docker_name], Stop a running container

Exposing Our Container With Port Redirects
------------------------------------------
          sudo docker run -d -p [local_port]:[container_port] [image_name], launchs a container as a daemon and redirects a local port to a container port.

Container Snapshots
-------------------

          Each time you  make changes on a running  container, those changes are made in runtime and not change the container image which the container is based on. If you want to modify a container, you must build a new container based on the image ID of the running ccontainer.
    sudo docker commit [running-container-id] [image_type:version], to commit changes

Attach to a Running Container
-----------------------------

    sudo docker -t -i -d [container_type:container_version] /bin/bash, launchs a container in the background with a shell. 
    sudo docker attach [container_name], attachs to a running container

Removing Images
---------------
    To delete an image, first all the containers depending on an image must be deleted. Then, the image can be deleted. 
    sudo docker ps -a, to list all the created containers.
    sudo docker rm [container_id], to delete a container.
    sudo docker rmi [image_id], to delete an image. Keep in mind that all containers based on the image must be deleted first. 

Directory Structure
-------------------
    /var/lib/docker, docker variable data
    rm -rf /var/lib/docker/containers/* , to delete all the created containers.

Services That Run on Startup
----------------------------
    In ~/.bashrc you can add any sbin commands at the end of that file, then you just run a daemon container  with an interactive shell
    #!/bin/bash \nrm -rf /run/httpd/* \nexec /usr/sbin/apachectl -D FOREGROUND, then execute from .bashrc

Pushing Images to Docker Hub
----------------------------

          sudo docker build -t [user/image_name:image_Version] /path/to/dockerfile, builds an image to support dockerhub
    sudo docker push [user/image_name:image_version], pushes to dockerhub
    Each time an image is pushed, only the images references are uploaded saving bandwith. 

Adding External Content 
-----------------------
    Use ADD declaration in the Dockerfile, to add external content to the container.

Image Volume Management
------------------------
    sudo docker run -i -t -v [/path/in/host:/path/in/container] [image_name:image_version] /bin/bash, mounts a volumen inside a container

Advanced Container Network Management
-------------------------------------
    To change docker network subnet:
    1. Stop docker daemon, sudo service docker stop
    2. Create a new bridge with the desired subnet.
    3. Tell docker to use the new bridge with sudo docker -d -b [new bridge iface] &

Interactive Shell Control
-------------------------
    sudo docker run -i -t --name [MYCONTAINER] [image_name:image_version] /bin/bash, launchs a container with a specific name
    sudo docker exec -i -t [container_name] [command], attachs a command to be executed inside the container

Previous Container Management
-----------------------------
    sudo docker [start|stop|restart] [container_name], starts or stops or restarts a container 
    When you keep working on a container, you are just using the deltas between the container and the image base and not a full ubique image.

Taking Control of Ports
-----------------------

    sudo docker run -i -t -d -P [image_name:image_version] /bin/bash, -P dynamically maps a local port to a fixed port in the container.
    sudo docker run -i -d -p [local_ip_addr:local_port:container_port] [image_name:image_version] /bin/bash,  binds a specific host interface(and ports)  to a container port.

Sharing Container Resources
---------------------------
    sudo docker run -d -i -t -v [/path/to/volumen] --name [container_name] [image_name:image_version] /bin/bash, launchs a container in background with a volumen mounted.
    sudo docker run -d -i -t --volumes-from [container_name_to_import_volumes] --name [container_name] [image_name:image_version] /bin/bash, launchs a container in background with a volumen mounted from another container.
    Useful when I want to share a directory between many containers. 

Container Linking and Communication
-----------------------------------

    a link allows a source container to provide information about itself to a recipient container
    Docker creates a secure tunnel between the containers that doesn’t need to expose any ports externally on the container. That’s a big benefit of linking: we don’t need to expose the source container.
    Docker exposes connectivity information for the source container to the recipient container in two ways:      Environment variables,     Updating the /etc/hosts file.
    Docker creates several environment variables when you link containers. Docker automatically creates environment variables in the target container based on the --link parameters. It will also expose all environment variables originating from Docker from the source containe
    In the /etc/hosts file you can see two relevant host entries. The first is an entry for the container that uses the Container ID as a host name. The second entry uses the link alias to reference the IP address of the container to link.
    sudo docker run -i -t --name [container_name] --link [container_to_link]:[alias] [image_name:image_version] /bin/bash

Committing a Running Container (Snapshot Images)
------------------------------------------------

          sudo docker commit [container_name] [container_name:container_version], creates a new image 
    A difference between commiting with  the commit id over the container name, it's you can only create a new base image with the container name is when the container is running.

Optimizing Our Dockerfile Builds
--------------------------------

    Each RUN declaration creates a new container to run a command; so, it's better to chain commands per RUN declaration to optimize container creations.
Five Useful Docker CLI Commands
          sudo docker cp [container_name]:[/path/to/file] [/path/to/host], Copy files/folders from a container's filesystem to the host path 
    sudo docker diff [container_name], Inspect changes on a container's filesystem: A for append, C for change, D for delete.
    sudo docker events, Get real time events from the server
    sudo docker history [image], show the history of an image. 
    sudo docker exec -i -t [container_number] [command], executes a command inside a running container.

More Useful Docker CLI Commands
-------------------------------

    sudo docker info, Display system-wide information
    sudo docker top [container_name], lookups the running processes of a container
    sudo docker kill [container_name], kill a running container.
    sudo docker pause [container_name], Pause all processes within a container
    sudo docker unpause [container_name], unpause a container
    sudo docker load < [image_name].tar, sudo docker load -i  [image_name].tar, Loads the contents of a image to make an image.
    sudo docker export [container_name] > [image_name].tar, sudo docker export -o [container_name] [image_name].tar, Stream the contents of a container as an image tar archive

Testing Version Compatibility - Using Tomcat and Java (Part Three)
------------------------------------------------------------------

    sudo docker run -e [ENV_VAR]=[/path/], to pass environment variables to a container

Open Source Philosophy
----------------------

    GNU: Gnus is not unix
    Differs from unix because it's a copy of unix and free
    GPL: the source code remains freely available to anyone who might want it
    GPL: General Public License

Distributions
-------------

    Distributions: linux kernel + utilities + configurations
    Distribution: Linux kernel + core unix tools + supplemental software + startup scripts + installers
    different types of distributions: desktops, servers, corporate, etc

Embedded Systems
----------------

    Set-top boxes, smart tv's , networking equipment, navigation equipment(TOM TOM), mobile devices

Desktop Applications 
--------------------
    gnome, kde, lxde, unity, xfce
    widget set: library that handles UI features like menus and dialogue boxes
    common widget set: gtk, kde
    yum install firefox gimp openoffice thunderbird blender audacity pidgin calibre

Server Applications
-------------------

    22-ssh-openssh, 23-telnet-telnetd, 25-smtp-postfix, 53-dns-bind, 67-bootp-dnsmasq|dhcp, 80-http-apache, 443-https-apache

Development Languages
----------------------

    cathedral model: source code is limited to the developers until the release date
    bazaar model: pretty caothic, devs can bring more perspective to the project. not vertical
    java, c/c++, js, python, ruby, per, php
    compiled, interpreted and assembly languages are some environments a linux admin has to deploy

Package Management Tools and Repositories
-----------------------------------------

    package: dependency, version, architecture information. 
    packages: install programs which depends on libraries
    package tool sw keeps a database info about packages: name, version number, location of the files. It facilitates installing, updating and removing sw easily
    rpm, debian, tarball, pacman, ebuild

Licensing
---------

    Free software foundation(FSF), open source initiative(OSI), creative commons
    copyright: legalized right to copy something
    berne convention: internation treaty that requieres countries to recognize the other countries copyrights
    patents: idea of a copyrighted work
    trademarks: exclusively identify the commercial source or origin of products or services.
    Commercial software, developed with the intent to sell that software as a profit
    shareware, similar to commercial software except at the copyright and legal perspectives
    Freeware, like shareware but the software is always free and has no cost involved

Free Software Foundation (FSF), Open Source Initiative (OSI)
------------------------------------------------------------

    GPL: General Public License
    Freedom to use the software for any purpose.
    Freedom to examine the source code and modify it as you see fit
    Freedom to redistribute the software
    Freedom to redistribute your modified software
    GPLv2: 1991
    GPLv3: 2007, combats clauses of hardware restrictions.
    LGPL, applied to libraries. but it can be used jointly with commercial libraries avoiding the need to release the commercial code. .
    OSI: 1998 by Bruce Perens and Eric Raymond
    OSI: Promotes open source software in the business world
    Open source, harness the power of distributed peer review and the transparencey of process. The promise of open source is better quality, higher realiability, more flexibility, lower cost, and an end to propieraty lock-in.
    OSI licences: GPL, LGPL, Apache, MIT, BSD, FreeBSD, BSD, MPL2, NCSA, OpenLDAP, PublicDomain, PHP License
    OSI permits a software to be locked, in contrast FSF enfoces software to reamin free
    FOSS, Computer software that can be classified as both free software and opensource software. 
    FOSS, source code is shared so that people are encouraged to voluntarily improve the design of the software.
    OSI 10 Principles:
    1. Permission to derive works
    2. Respect for source code integrity
    3. No discrimination against persons or groups
    4. no disrimination against fields of endeavor
    5. Automatic license distribution
    6. Lack of product specificity
    7. Lack of restrictions on other software.
    8 Tecnology neutrality
    Creative Commons, create by Lawrence Lessig
    Creative Commons(CC) license, enable the free distribution of an otherwise copyrighted work. It's used when an author wants to give people the right to share, use, and build upon a work they have created. Provides an author flexibility and protects the people who use or redistribute that work if they abide by the conditions specified in the author's word license.
    FSF and OSI are dedicated to promoting software freedoms. CC goals are broader as the license are aimed at things like audio recordings, textual works, and so on.

Desktop Skills
--------------

    KDE: Default for Mandriva and SUSE
    KDE uses the qt widget set
    Gnome uses gtk widget set
    Gnome: Red Hat, CentOS
    LXDE: Intended to consume less resources
    Unity: for Ubuntu
    XFCE: gtk+ widget set, consumes fewer resources than kde and gnome
    A desktop manager usually has: Launching programs, desktop menus, panel, context menus, searching for programs, terminals, 

Industry uses of Linux, Cloud Computing and Virtualization
----------------------------------------------------------

    virtualization is the creation of a virtual OS through a virtualization sw that is known as the hypervisor.
    An hypervisor allows us to virtualize an OS in another OS known as the host. 

Basic shell
-----------

    Shell, command line interpreter that allows us to type commands at our keyboard
    shells, sh, bash , csh, tsch, zsh, ksh
    echo $SHELL, shows your shell
    alt+fn, changes the shell on the system

Working With Options
--------------------

    parameters with a dash ("-") are called options
    Parameters with no leading das are called arguments

Variables - Environment / System Variables
------------------------------------------

    variable, placeholder for another value.
    Environment, set of variables that any program can access
    2 variable types: USER DEFINED and SYSTEM DEFINED
    Tilda(key) ~, invokes the $HOME environment  variable
    $BASH, $SHELL, full path to shell executable 
    $CPU, spec to your CPU
    $DISPLAY, the local video monitor
    $ENV, the name of file where bash reads for environmental variables. Default /etc/bash.bashrc 
    $EUID, the effective user id
    $HOME, path to current users home directory
    $HOST, $HOSTNAME, stores the host system name
    $LOGNAME, username of the current user
    $MAIL, path to current user mailboxes
    $MANPTH, stores path to man program. distribution dependant
    $OLDPWD, path to prior current directory
    $OSTYPE, type of OS currently running
    $PATH, stores a list of directories to look for executables
    $PSI, stores the current character that the prompt uses
    $PWD, path to current working directory
    $USER, $USERNAME, current user
    env, prints all envionments variables
    set, prints all variables in alphabetic order
    PATH=$PATH:/new/path, adds a new directory to $PATH env variable
    export PATH, makes available a env variable to all the other interactive user shells
    export,  marks an environment variable to be exported with any newly forked child processes and thus it allows a child process to inherit all marked variable
    /etc/profile, to add an evironment variable for all the users

Globbing
--------
    globbing, global command 
    globbing, it's a process of expanding a non specific  filename contaning a wildcard character into a set of specific filenames  that exist in a storage server , file or network.  
    wildcard, it's a symbol that can stand for one or more character.
    ?, is for a single character.
    *, matches any character or set of characters, inluding no character
    []. matches a character according the subcharacters

Quoting
-------

    double quote, subtitutes the value of variables and commands
    echo "Username is $USER", prints the USER value
    single quote, preserves the literal meaning of each character of a given string.
    echo 'Username is $USER', print literally $USER and not USER value.
    backslash, removes the special meaning from a single character. Used as an escape character.
    $echo "this is $5.00", prints: this is .00
    $echo "this is \$5.00", prints: this is $5.00
    back tick, ``,  used for command substitution

Man
---

    MAN pages are a reference format
    man 1, executables programs and shell commands.
    man 2, system calls provided by the kernel
    man 3, library calls provided by the program libraries
    man 4, device file(usually stored in /dev)
    man 5, file formarts
    man 6, games
    man 7, Miscellaneous(macro packages, conventions, etc)
    man 8, system administration commands(programs run mostly by root)
    man 9, kernel routines
    whatis [program], shows a summary of all the manpages(1-9) about a command
    apropos [program], man -k [program], looks for all the man pages about a certain program.
    Man pages are organized: Name, synopsis, description, options, files, see also, bugs, history, author

Info
----

    Info, supports functions(hyperlinks) in which man can not.
    info [program], supports functions(hyperlinks) in which man can not.

Hidden files and directories
----------------------------

    .file, hidden file
    touch .file, creates a hidden file
    ls -a, lists all files including hidden files
    mkdir .dir, creates a hidden folder.

Absolute and relative paths
---------------------------
    absolute path, full path to a directory: /path/to/directory
    relative path, user the path i'm currently in as reference: path/to/directory. 

Files and directories
---------------------

    touch file, creates an empty text file
    touch, updates  access timestamp information of a  file.
    touch -c [file], updates a file if it exists, it doesn't exist it won't create it. 
    touch -d "Febreuary 1 2015" [file], changes timestamp of a file.
    cp [source] [destination], copies a file.
    cp -f, --force, if an existing destination file cannot be opened, remove it and try again
    cp -i, --interactive,  prompt before overwrite
    cp  -p     same as --preserve=mode,ownership,timestamps
    cp  -p   same as --preserve=mode,ownership,timestamps
    cp -a, --archive  same as -dR --preserve=all
    cp -u, --update               copy only when the SOURCE file is newer than the destination file or when the destination file is missing.
    mv [source] [destination] file, moves or rename a file
    rm file, deletes a file
    mkdir [directory], creates a directory
    mkdir     -m, --mode=MODE , set file mode (as in chmod), not a=rwx - umask
    mkdir  -p, --parents, no error if existing, make parent directories as needed
    rmdir [directory], deletes an empty directory
    rm -rf [directory], deletes a directory recursively and ignores nonexistent files and arguments.

Case sensitivity
----------------

    linux commands, file names and directory names are all case sensitive.

Simple globbing and quoting
---------------------------

    *, zero or more characters
    ?, only one character
    [], looks for characters inside the bracket for one character
    '', doesn't expand variables or it prints literally.
    "", substitutes variables, and escape characters, and ``
    ``, executes a command
    \, escapes a special character
    echo -e, enabales interpretation of backslash escapes.

Files, directories
------------------

    tar, utility that archives things altogether. It doesn't compress or compact files. 
    tar -cvf [name.tar] [folder_to_compress], creates a tarfile and prints verbosely
    tar -xvf [file.tar], extracts a tarfile and prints verbosely
    tar -cvf [name.tar] [files_to_compres...], creates a tarfile and prints verbosely

Archives, compression
---------------------

    gzip, bzip2, zip, compress a file. 
    gunzip, bunzip, unzip, uncompress a file.
    zip, compress and archives files. gzip and bzip2 just compress files.
    zip [file.zip] [folder_to_compress], zip [file.zip] [files_to_compress...]
    unzip [file.zip], decompress a zip file
    zip -r [file.zip] [folder_to_compress], compress recursively 
    zip [file.zip] [files_to_compress...], compress several files
    unzip -l [file.zip], lists files without decompressing them. 
    gzip [file.tar], compress a tar file
    gunzip [file.tar.gz], decompress a tar file
    bunzip [file.tar.bz2], decompress a file
    bzip2 [file.tar], compress a tar file
    bunzip [file.tar.bz2], decompress a tar file
    tar -zcvf [file.tar] [files to compress], compress files using gzip and archive them using tar verbosely.
    tar -jcvf [file.tar] [files to compress], compress files using bzip2 and archive them using tar verbosely.

Command line pipes
------------------

    standard bash file descriptors: stdin, stdout, stderr
    Input -> command -> Output | ->Error
    pipes |, redirects standard output

I/O re-direction
----------------

    >, 1> , redirects stdout
    2> , redirects stderr
    >>, redirects and appends stdout to data if exists instead of creating a new one. 
    command 1> stdout_file 2> stderr_file, redirects stdout to a file and stderr if there's some to a stderr file
    command < stdin_file, redirects stdin file to a command 

Regular Expressions 
-------------------

    *, matches any character of 
    ., any single character
    ?, matches zero or one of the proceeding characters
    ^, matches experssion if it appears at the beginning
    $, matches expression if it appears at the end
    [nnn], matches any one character between the braces
    [^nnn], matches any expression that doesn't contain any one of the characters specified 
    [n-n], matches any single character

Basic text editing
------------------

    text editors: nano, kate, gedit, vim 
    nano file, opens a file
    vim file, opens a file
    vim modes: command, insert, visual

Basic shell scripting
---------------------

    arguments, $1 first argument, $2 second argument, $? exit code status(0 succesful, non 0 unsuccesful)
    #!, shebang 
    &&, AND
    ||, OR
    command1 && command2, command2 executes if commands 1 exit status is 0.  
    command1 || command2, command2 executes if commands 1 exit status is a non 0. 
    if options:
    -d, checks if a directory exists
    -e, checks if file exist
    -f, checks if a file exist and it's a regular file
    -G, checks if file exist and it's owned by a specific group
    -h, -L, checks if it's a symbolic link
    -O, checks if file exist and if it's owned by a specific UID
    -r, checks if file exist and if it has read permission granted
    -w, checks if file exist and if it has write permission granted
    -x, checks if file exist and if it has execute permission granted

Windows, Mac, Linux differences
-------------------------------

    Windows:
    - uses proprietary applications.
    - Active Directory.
    - Microsoft SQL.
    Apple:
    - Has their own hw and sw
    - Tight integration within its own ecosystem.
    - Security-extremely difficult to lock down and manage. 
    Linux:
     - Desktop is freeing and personal.
    -  Server room flexibility.
    - Seen everywhere in the mobile world.
    GUI and CLI?:
    - All of these OS have GUI's(graphical user interface) and CLI's(command linux interface). 
    - Linux server can be administered by CLI only and with no GUI overhead.
    - OSX has UNIX under the hood and we can manage it via CLI for the most part.
    - Windows can have both GUI and CLI. Can use PowerShell to manage it via CLI.

Distribution life cycle management
----------------------------------

    Linux life cycle management:
    - Design: identify features and functions to be added.
    - Develop: Implements the design in a cathedral manner doing some type of validation for a bug free system.
    - Deploy: The completed version of the distribution is release and user deploy it in different environments.
    - Manage, the deployed distribution is manage it day to day applying patches.
    - Retire, a distribution has a end of life, so when a distribution is obsolete has to be retired and upgrade it with a new distribution version.
    Distribution Life Cycle Management:
    - RHEL, 10 years.
    - Fedora, 1 year.
    - SLES, 7 yeras
    - OpenSuse, 1.5 years
    - Debian, 3-4 yeras
    - Ubuntu,(LTS) 5 years
    Distribution Release Cycle Management:
    - RHEL, 3-4 years
    - Fedora, .5 years
    -SLES, 3-4 years
    - OpenSuse, 8 months.
    - Debian, 2 yeras
    - Ubunt, 2 years

Hardware
--------

    CPU, is the electronic circuitry within a computer that carries out the instructions of a computer program by performing the basic arithmetic, logical, control and input/output (I/O) operations specified by the instructions.
    RAM,  allows data items to be accessed (read or written) in almost the same amount of time irrespective of the physical location of data inside the memory.
    RAM, allows data items to be accessed (read or written) in almost the same amount of time irrespective of the physical location of data inside the memory. RAM is normally associated with volatile types of memory (such as DRAM memory modules), where stored information is lost if power is removed, although many efforts have been made to develop non-volatile RAM chips.
    Graphics Card, is an expansion card which generates a feed of output images to a display.
    is the main printed circuit board (PCB) found in computers and other expandable systems. It holds and allows communication between many of the crucial electronic components of a system, such as the central processing unit (CPU) and memory, and provides connectors for other peripherals.Motherboard, 
    Power supply,  is an electronic device that supplies electric energy to an electrical load.
    Hard disks, is a data storage device used for storing and retrieving digital information using one or more rigid ("hard") rapidly rotating disks (platters) coated with magnetic material. The platters are paired with magnetic heads arranged on a moving actuator arm, which read and write data to the platter surfaces. Data is accessed in a random-access manner, meaning that individual blocks of data can be stored or retrieved in any order rather than sequentially. HDDs retain stored data even when powered off.
    Optical drives, is a disk drive that uses laser light or electromagnetic waves within or near the visible light spectrum as part of the process of reading or writing data to or from optical discs. Compact discs, DVDs, and Blu-ray discs are common types of optical media which can be read and recorded by such drive.

Kernel
------

    Kernel, unix-like operating system and created by Linus Torvalds.
    Kernel, lowest level of easily replacement sw that interfaces with the hw of the computer. 
    Kernel, imposes order by using hierarchy. Then the system boots, typically one process called the init process starts up the /sbin/init that in turn manages child processes. 

Processes
---------

    Every process has a associated proces id(PID.
    Every parent process has a parent id (PPID).
    ps -u [user] --forest
    ps aux | grep [user]
    top, shows current running processes
    free -H, show the memory status

syslog, klog, dmesg
-------------------

    log files, files which record operation information. 
    /var/log, default directory to store logs.
    boot.log, mantains startup information.
    cron, logs about the scheduling command
    gdm, gnome logs
    messages or syslog, general purpose log file.
    auth.log, secure, ssh and sudo logs 
    log rotation, backups a log file to keep it small
    klogd, daemon to manage kernel log files.
    syslogd, daemon to manage general log files.
    dmseg, logs for the kernel rin buffer
    The kernel keeps its logs in a ring buffer. The main reason for this is so that the logs from the system startup get saved until the syslog daemon gets a chance to start up and collect them. Otherwise there would be no record of any logs prior to the startup of the syslog daemon. The contents of that ring buffer can be seen at any time using the dmesg command, and its contents are also saved to /var/log/dmesg just as the syslog daemon is starting up.

/lib, /usr/lib, /etc, /var/log
------------------------------

    /lib, linked library files used by binaries in /bin and /usr/bin
    /usr/lib linked library files used by binaries in /bin and /usr/bin
    /etc, configuration files for our linux operating system.
    /var/log, log files for our linux OS.

Internet, network, routers
--------------------------

    domain controller.
    database server
    dhcp server
    web server
    e-mail server
    file and print server
    firewall
    proxy server
    content filter server
    router
    Networks use protocols to talk to one another. 
    IP protocol: 
    - A networking protocol used on the internet.
    OSI model (7 layers): 
    1. Physical, eletrical signal, media(cable, wireless, etc).
    2. Data Link, datagram.
    3. Network(packet), addressing
    4. Transport(Segment), he transport layer provides services such as connection-oriented data stream support, reliability, flow control, and multiplexing.
    5. Session, The session layer provides the mechanism for opening, closing and managing a session between end-user application processes, i.e., a semi-permanent dialogue.
    6. Presentation,  responsible for the delivery and formatting of information to the application layer for further processing or display.[4] It relieves the application layer of concern regarding syntactical differences in data representation within the end-user systems.
    7. Application,  is an abstraction layer that specifies the shared protocols and interface methods used by hosts in a communications network.

Network configuration
---------------------

    ping, testing of connectivity of a remote network device.
    dig, allows us to lookup ip addresses for dns names.
    netstat, list network connections, routing info, NIC info.
    route, current route/net settings.
    traceroute, traces the route a packet takes.
    ifconfig, current network settings.
    ip addr, current ip address and network settings.
    /etc/resolv.conf, where our dns server information is stored.
    /etc/sysconfig/network-scripts/ifcfg-[iface], to change an interface on CentOS.
    route add default gw [next hop], adds a default route for [next hop].
    route add -net [remote network] netmask [remote netmask network] gw [next hop], adds a route.
    route del -net [remote network] netmask [remote netmask network] gw [next hop], deletes a route.
    netstat -a, prints all listening sockets
    netstat -i, displays stats of network interfaces.
    netstat -l, displays just the listening sockets.
    netstat -s, displays a summary for each protocol.

Root and Standard Users
-----------------------

    finger, user information lookup program
    id [user], prints real and effective user and group IDs
    /etc/passwd, contains one line for each user account, with seven fields delimited by colons (“:”). These fields are:
    - login name
    - optional encrypted password
    - numerical user ID
    - numerical group ID
    - user name or comment field
    - user home directory
    - optional user command interpreter
    /etc/shadow, is a file which contains the password information for the system's accounts and optional aging information.         This file must not be readable by regular users if password security is to be maintained.         Each line of this file contains 9 fields, separated by colons (“:”), in the following order:
    -  login name
    - encrypted password
    - date of last password change
    - minimum password age
    - maximum password age
    - password warning period
    - password inactivity period
    - account expiration date
    pwck, verify integrity of password files
    pwconv, convert to and from shadow passwords and groups
    user accounts, limited permission for system tasks.
    su, substitute user for the root account.
    PATH variable is differente for the root account and normal user accounts.
    su - [user], changes user but also gives the  environmental variables for the user.
    su [user], changes user but also keeps the environmental variables for the user who executes the command.
    w, Show who is logged on and what they are doing.
    who, who is logged on.
    last, show listing of last logged in users

System users
------------

    system accounts, are not for use for users to log in, but they are users to run services on the system.
    system accounts have lower ID's 
    system accounts have lower ID's(0 - 999), instead of user accounts which their UID  are above 1000

User commands
-------------

    useradd [user], creates a user with default parameters.
    /etc/default/useradd, default values for useradd
    useradd -D, prints default values
    /etc/login.defs, defines the site-specific configuration for the shadow password suite. This file is required. Absence of this file will not prevent system operation, but will probably result in undesirable operation. Also,  default values for user UID and system UID.
    /etc/skel, contains files and directories that are automatically copied over to a new user's home directory when such user is created by the useradd program. 
    man useradd, for many options
    useradd -c "[comment]" -m -p "[password] -s [shell] [username], creates a user with comments, ensure a home directory is created, a specific shell, and a password
    passwd [username], change user password
    passwd [username], change user password, if a user doesn't set a password, the account is locked until a password is defined. 
    man passwd, for mani options to manage an account
    usermod, modify a user account
    userdel, deletes a user
    userdel -r [username], deletes a user and its home directory

User IDs
--------

    each user has a UID.
    UID, used to validate authorization for different services.
    uid=0, gid=0, root user

File/directory permissions and owners
-------------------------------------

    Permissions: User, Group, Other
    rwx, where: r=read, w=write, x=execute
    the permissions of a file consists of 3 rwx sets: first set  users,  second set groups, thrid set others.
    octal notation: r=4, w=2, x=1. The permission fo a file would be 777 if all permissions are enable. 
    chown user.group [file|directory], changes owner of a directory. To change permissions, you must be owner of the file or be root.
    chmod XXX [filename|directory], modifiy permission with octal notation
    chmod ugo+rwx [filename|directory], adds all permissions  (user, group and other) to a file.
    chmod ugo-rwx [filename|directory], removes all permissions (user, group and other) to a file.

System files, Special Files and Sticky Bit
------------------------------------------

    /var, contains files that change often such as mail, logs, etc.
    /var/tmp, contains files that do not get deleted on reboot.
    /tmp, contains temproary files that do get deleted on reboot.
    sticky bit,  is a permission bit that is set on a directory that allows only the owner of the file within that directory or the root user to delete or rename the file. No other user has the needed privileges to delete the file created by some other user. 
    chmod +t [file|directory], adds a sticky bit to a file or directory.
    chmod -t [file|directory] removes a sticky bit to a file or directory.
     chmod 1XXX [file|directory], adds a sticky bit to a file or directory in octal notation..

Symbolic links
--------------

    ln, make links between files
    ln -s  [target_file] [sym_link],  make symbolic links instead of hard links

The Linux Essentials Exam/Certification
---------------------------------------

    40 questions in 60 minutes
    vendor-neutral linux profressional institute
    5 topics:
    - linux community
    - finding your way on a linux system
    - the power of the command line
    - linux operating system
    - security and file permissons

A linux Introduction
--------------------

    created by linus torvalds
    free of charge
    tennembaum created minix to teach operating system because unix was closed for universities 
screen
      Screen  is a full-screen window manager that multiplexes a physical terminal between several processes (typically interactive shells).
     When screen is called, it creates a single window with a shell in it (or the specified command) and then gets out of your way so  that        you  can  use  the  program as you normally would.  Then, at any time, you can create new (full-screen) windows with other programs in        them (including more shells), kill existing windows, view a list of windows, turn output  logging  on  and  off,  copy-and-paste  text        between  windows, view the scrollback history, switch between windows in whatever manner you wish, etc
    All windows run their programs        completely independent of each other. Programs continue to run when their window is currently not visible  and  even  when  the  whole        screen  session is detached from the user's terminal.  When a program terminates, screen (per default) kills the window that contained        it.  If this window was in the foreground, the display switches to the previous window; if none are left, screen exits.
    screen -list, prints a list of pid.tty.host strings and creation timestamps identifying your screen sessions.
    screen -d [pid.tty.host], detaches the elsewhere running screen session. It has the same effect as typing "C-a d" from screen's             controlling terminal.
    screen -r [pid.tty.host], resumes a detached screen session.
    screen [command], launches a command and terminates it after the command finishes running. 
    screen [command], launches a screen to run command  and terminates it(the screen) after the command finishes running.
    screen -S [session_name], identifies the  ses‐             sion for "screen -list" and "screen -r" actions.
    screen -x [pid.tty.host], Attach to a not detached screen session.

xz Compression
--------------

     xz is a general-purpose data compression tool. 
    - The native file format is  the  .xz        format.
    - xz  compresses  or decompresses each file according to the selected operation mode.  If no files are given or file is -, xz reads from stan‐        dard input and writes the processed data to standard output.
    - The  memory  usage  of xz varies from a few hundred kilobytes to several gigabytes depending on the compression settings. 
    -  Typically the decompressor needs 5 % to 20 % of  the  amount        of memory that the compressor needed when creating the file.
    xz -z [file], compress a file. 
    xz -l [file], prints  information  about  compressed files. 
    xz -d [file], decompress a file. 
    xz can not compress a directory, but a directory can be archived and then compressed using xz
    - tar cfv directory.tar [directory]
    - xz -z directory.tar
    - xz -d directory.tar.xz
    - tar xvf directory.tar

pkill and pgrep
---------------

     pgrep  looks through the currently running processes and lists the process IDs which match the selection criteria to stdout.
    - All the criteria have to match.
    pgrep -l -u [user], lists all processes that the user [user] has in the system. 
    pgrep -u [user] [pattern], prints all processes(PID) that matches the pattern.
    pgrep -v|--inverse -u [user], prints all processes NOT owned by [user], -v negates the matching. 
    pkill [pattern], kills all processes which complies with the pattern.
    pkill -u [user] pattern, kills all process for user [user] which complies the pattern.
    pkill -t [TTY], kills processes whose controlling terminal matches. 
    - The terminal name should be specified without the "/dev/" prefix.
    pgrep -n -u [user], prints only the newest(most recently started process) of the matching processes for user [user].

Upstart Overview
----------------

    init is the parent of all processes on the system, it is executed by the kernel and is responsible for starting all other processes; it is the parent of all processes whose natural parents have died and it is responsible for reaping those when they die.
    - upstart is the first process to start and still launches system services but launch processes in parallel, instead of SysV init which launches processes sequentially.
    --- SysV init used to use bash scripts to launch services.
    - upstart is an event-based init daemon. This means that jobs will be automatically started and stopped by changes that occur to the system state, including as a result of jobs starting and stopping.
    --- This is different to dependency-based init daemons which start a specified set of goal jobs, and resolve the order in which they should be started and other jobs required by iterating their dependencies.
    - Processes managed by init are known as jobs and are defined by files in the /etc/init directory, and watches for future changes to these files using inotify(7).
    --- Files ending in .conf are called configuration files.
    --- Files ending .override are called override files which it takes precedence over those equivalent named stanzas in the corresponding configuration file contents for a particular job..
    --- Each configuration file defines the template for a single service(daemon) or task (short-lived process)
    * A configuration file is a description of a environment a job could be run in. 
    * A job is the runtime embodiment of a configuration file.
    *** Each job may have one or more different processes run as part of its lifecycle, with the most common known as the main process.
    *** The main process is defined using either exec or script stanzas. These specify the executable or shell script that will be run when the job is considered to be running. Once this process terminates, the job stops.
    * Jobs can be started and stopped automatically by the init(8) daemon by specifying which events should cause your job to be started or stopped. 
    *** Also, Jobs can be manually started and stopped at any time using the start(8) and stop(8) tools.
    * When first started , the init(8) daemon will emit the startup(7) event. This will activate jobs that implement System V compatibility and the runlevel(7) event.
    *** start on EVENT, defines the set of events that will cause the job to be automatically started.
    *** stop on EVENT, defines the set of events that will cause the job to be automatically stopped.

dmesg 
-----

           dmesg is used to examine or control the kernel ring buffer.
    A kernel is the core of an operating system. It is the first part of the operating system that is loaded into memory when a computer boots up (i.e., starts up), and it controls virtually everything on a system.
    A buffer is a portion of a computer's memory that is set aside as a temporary holding place for data that is being sent to or received from an external device.
    A ring buffer is a buffer of fixed size for which any new data added to it overwrites the oldest data in it. 
Hands On - Package Management - APT, dpkg
    apt uses /etc/apt/sources.list to check where to get packages
    apt-get update: updates a local cache for a repository listed in sources.list
    apt-cache search [package] looks on the cache list of the repository to look for the package
    apt-get install [package], installs a package
    apt-get purge [package], removes libraries AND CONFIGURATION FILES
    apt-get remove [package], removes a package but only the libraries
    apt-get upgrade, upgrades packages already installed 
    apt-get dist-upgrade, upgrades whe whole system(like kernel)  not only packages
    dpkg -i [package].deb, installs a package from a debian package
    apt-get update; apt-get -f upgrade, installs packages which were notified by a failed installation by dpkg -i due to library dependencies
    dpkg --get-selections, lists all the installed packages
    dpkg  --remove [package], removes binaries and libraries but not configuration files
    dpkg --purge [package], removes a package with binaries, libraries and configuration files

Open Source Business Models
---------------------------

    selling services and support, technical support and training
    dual licensing, 2 version of a product .. one is open source, and other commercial. 
    Multiple products, other products financial the main products
    open source drivers
    Bounties
    Donations

Command Line Syntax - ls
------------------------

    ls, listing of files and folder
    ls -a, lists all files(including hidden files)
    ls -l, long listing
    ls -p, directory listing
    ls -R, recursive listing

Command Line Syntax - $PATH, Case Sensitivity 
---------------------------------------------

    echo $PATH, shows path dirs where executables are located
    /path/to/file.sh, ./file.sh,  if you want to execute a file not located in $PATH

Command Line Syntax - Basic Commands
------------------------------------

    halt, init 0, shuts down the system
    init 6, reboot, shuts down and restore it
    shutdown -P, power off
    shutdown -r, reboot
    shutdown -h, power off
    shutdown -c, cancel a pending shutdown
    exit, close a terminal session
    su, the subtitute user command changes the current user to a different account
    su -, changes to the super user(root)
    env, shows environment variables for the current user
    top, shows current process on the system
    clear, clears terminal
    which [command], shows the path of an executable
    whoami, shows the current user of the system
    netstat, shows network information status
    route, shows the routing table
    ifconfig, shows the net configuration

Command Line Syntax - uname
---------------------------

    uname, returns information of the linux system
    uname -s, displays the current linux name
    uname -n, displays the system hostname
    uname -r, displays the linux kernel release number
    uname -v, displays the linux kernel version
    uname -m, displays the architecture
    uname -p, shows the processor type
    uname -i, diplays the hw platform
    uname -o, displays the operating system
    uname -a, displays all uname information

Command Line Syntax - Command History, Command Completion
---------------------------------------------------------

    .bash_history, shows a user command history for the bash shell
    $HISTFILESIZE, changes the history file size
    command completion, use TAB to accomplish command completion

Command Line Syntax - cd and pwd
--------------------------------

    pwd, prints the current working directory
    cd [path\, changes the directory path to [path]
    cd, changes the directory path to $HOME

Shell Configuration Files
-------------------------

    A login shell is the first process that executes under your user ID when you log in for an interactive session. The login process tells the shell to behave as a login shell with a convention: passing argument 0, which is normally the name of the shell executable, with a - character prepended (e.g. -bash whereas it would normally be bash. Login shells typically read a file that does things like setting environment variables: /etc/profile and ~/.profile for the traditional Bourne shell, ~/.bash_profile additionally for bash†, /etc/zprofile and ~/.zprofile for zsh†, /etc/csh.login and ~/.login for csh, etc.
    When you log in on a text console, or through SSH, or with su -, you get an interactive login shell. When you log in in graphical mode (on an X display manager), you don't get a login shell, instead you get a session manager or a window manager
    It's rare to run a non-interactive login shell, but some X settings do that when you log in with a display manager, so as to arrange to read the profile files. Other settings (this depends on the distribution and on the display manager) read /etc/profile and ~/.profile explicitly, or don't read them.
    When you start a shell in a terminal in an existing session (screen, X terminal, Emacs terminal buffer, a shell inside another, …), you get an interactive, non-login shell. That shell might read a shell configuration file (~/.bashrc for bash, /etc/zshrc and ~/.zshrc for zsh, /etc/csh.cshrc and ~/.cshrc for csh, etc.).
    When a shell runs a script or a command passed on its command line, it's a non-interactive, non-login shell. Such shells run all the time: it's very common that when a program calls another program, it really runs a tiny script in a shell to invoke that other program. Some shells read a startup file in this case (ksh and bash run the file indicated by the ENV variable, zsh runs /etc/zshenv and ~/.zshenv), but this is risky: the shell can be invoked in all sorts of contexts, and there's hardly anything you can do that might not break something.

Introduction
------------

    Jenkins, an application that monitors executions of repeated jobs, such as building a software project or jobs run by cron.
    Continuous integrations, is a development practice that requires developers to integrate code into a shared repository several times per day. Each check-in is then verified by an automated build, allowing everyone to detect and be notified of problems with the package inmediately.
    build pipeline, is a process by which the sw build is broken down in sections:
    - Unit test
    - Acceptance test
    - Packaging
    - Reporting
    - Deployment
    - Notification

Best Practices
--------------

    Jenkins Must Do:
    - Back Up Jenkins.
    - Use file fingerprinting to manage dependencies.
    - Build from Source Control whenever possible. 
    - Integrate Jenkins with an issue management or help desk system.
    - Take advantage of automated testing, generate and look at the reports.
    - Lay out your Jenkins install on the disk with most storage.
    - Before deleting a job, have an archive copy. Better: never delete, move to a anchive group or folder and disable the job. 
    - Resist the temptation to have one build job for multiple environments(dev, test, prod) - consider creating one job to specialize in each environment to retain flexibility to make changes.
    - Email the results to all developers and operations staff for every job, particularly if Jenkins is not integrated into and issue management system.
    - Use Jenkins for common maintenance or clean up tasks that are run regularly.
    - Tag, merge or baseline your code in source control after a successful build.
    - Keep your Jenkins up to date - at least be on the latest LTS version.
    - Keep your plugins up to date.
    - Don't build on master except on very small deployments. 

Jenkins Backup - Using Plugins to Manage Your System
----------------------------------------------------

    backup configuration and job parameters, and job workspace

Variables - User Defined
------------------------

    A variable can container letters and number, but it can not begin with a number.
    A variable can contain hyphen and be upper case.
    A variable can not container spaces.

locate, find, whereis, and using /usr/share/doc/
------------------------------------------------

    README file location, /usr/doc/packagename, /usr/share/dock/packagename, /usr/share/doc/packages/packagename
    On redhat, rpm -ql [packagename] | grep doc
    whereis [program], locate the binary, source, and manual page files for a comman
    locate [program], find files by name
    find [path] -name [program], search for files in a directory hierarchy
    Utilities to read different file formats:
    .1-.9: man, info, less
    .giz or bz2: gunzip, bunzip2, less
    .txt: less, vim, cat 
    .html .html: any web browser
    .odt: LibreOffice, OpenOffice
    .pdf: okular
    .tif, .png, .jpg: gimp

The Linux Filesystem 
--------------------

    Linux file system, where we store information on a storage device in a certain manner. 
    LFS, data is organized and easily located.
    LFS, Data can be saved in a persistent manner.
    LFS, Data integrity is preserved.
    LFS, Data can be quickly retrieved for a user in a later point in time.
    Disk file system, a specific implementation of a general file system.
    File hierarchy standard, FHS, standard to organize data structurally between Linux distributions.
    /, root directory
    /bin, contains executables necesarry to manage and run the linux system.
    /boot, contains the bootloader file.
    /dev, contains the hw devices that can be installed on the system.
    /dev, contains files that represent  hw devices that can be installed on the system.
    /dev, character devices for Tx/Rx sequencially one character at a time(printers, mice, tape drives)..
    /dev, block device files which manages data as block(hard drives).
    /etc, contains text based configuration files used by the system as well as services running on the system. .
    /home, contains subdirectories that serves as home directories for user accounts on the linux system.
    /lib, contains code libraries used by programs that live in /bin or /sbin folders. Those are the libraries the executables are calling upon.
    /media, serves in certain distributions to mount external devices.
    /mnt, used by certain distributions to mount external devices..
    /opt, contains files for some programs you can install for your own.
    /proc, process information pseudo-filesystem
    /root, root home directory
    /sbin, contains system executables(only root) necesary to manage and run the linux system.
    /srv, contains subdirectories for services that are running on the system.
    /sys, contains information about filesystem information loaded in the kernel.
    /tmp, contains temporary files
    /usr, contains user applications files. 
    /var, contains variables data as log files.
    Disk File System, responsible for the reliability of storing data on the hard drive and the organizing so it's easily accesible later.
    ext2, second extented filesystem(1993), stores data in a hirearchial way. Up to 2TB file size, and a ext2 volume could 4TB. It supports groups, users, permissions, and file compression. 
    ext3, ext2 upgrade. Journaling, eliminates the problem of checking all the filesystem if the system goes down; records   transactions and marks it as incomplete, when the transaction is done it marks it as completed; if the system crashes   the system replays the journal to a consist filesystem before the crash.
    Reiser, jornaling and supports larger file size up to 8TB and 16 TB volumes.
    ext4, ext3 upgraded. Supports volumes of 1 exabyte, and file size up to 16TB.

Group commands
--------------

    /etc/group, file to define groups
    - group_name
    - password
    - GID
    - user_list
    groupadd [group_name], creates a group
    groupmod, modify a group definition on the system.
    qroudel [group_name], deletes a group name.

How to Install CentOS 7 with VirtualBox
---------------------------------------

    yum install kernel-dev gcc* para instalar vbox-guest-additions
    Configurar red para obtener la fecha y hora por NTP

commands (revisited)
--------------------

    cat, diplays contents of a text file
    less, reads a file
    head/tail, reads first or last 10 lines of a file.
    find, locates files on system
    grep, searches a string in our file.
    sort, organizes text in a file
    cut, manipulates data by column
    wc, word count on a file
    grep -i pattern file, searchs for pattern without caring if it's lowercase or uppercase
    grep -in pattern file, searchs for pattern without caring if it's lowercase or uppercase, and prints the line of the match
    sort -r file, reverse the sort order.
    sort file, sorts a file.
    echo "welcome to peru"| cut -d' ' -f2- , prints "to peru" because we delimetered by spaces obtaining 3 fieds and then we cut in 2 segments and printing from the second field to the end.  

Hands On - Package Management - YUM, rpm
----------------------------------------

    yum remove [package], removes an application
    rpm -ihv [package], installs a packages, shows installationstatus, and prints verbosely
    which [package], shows the executable
    whereis [package], where all the files of the package are
    rpm -q [package], gives the package true filename
    [package]-[version number]-[bulid number].[architecture]
    rpm -qi [package], gives detailed information about a  package
    rpm -e [package], uninstalls a package
    rpm -qR [package], removes a package and its dependencies
    yum, restores package repositories to retrieve packages
    /etc/yum.repos.d/, lists all the repositories configuration
    yum search [package], search for packages
    yum install [package], installs a package
    yum check-update [package], checks if there are updates for a package
    yum upgrade, upgrades the installed packages
    yum update, updates the repositories 
    yum deplist [package], lists dependencies of a package
    yum remove [package], removes a package
    yum clean packages, yum clean all, cleans the system for any left configuration after removing a package

Introduction to DevOps
----------------------

    devops. is a software development method that stresses communication, collaboration, integration, automation, and measurement of cooperation between software developers and other information-technology professionals. DevOps acknowledges the interdependence of software development, quality assurance, and IT operations, and aims to help an organization rapidly produce software products and services and to improve operations performance.
Traditional Responsibility Silos
    Operations, set of processes and services by IT presonnel to their own internal or external clients in order to run their business, includes:
    0 Infraestructure and monitoring.
    - Architecture and planning
    - Maintenance.
    - Support.
    Develpment, refers to the process of creating software. It involves the programming, documenting, testing and debugging associated with application development and the associated software release lifecycle. Some methodologies to develop software:
    - Prototyping
    - Waterfall.
    - Agile
    - Rapid.

IaaS: Infrastucture as a Service
--------------------------------

    IaaS, charging infraestructure costs back to the business units that consumed them. 
    IaaS Stack: O/S, Virtualization, Servers, Storage, Networking. 
    Iaas, It is a level of service and support that is used to clearly identify where the responsibility starts and ends when providing infraestructure to its consumer.

PaaS: Platform as a Service
---------------------------

    PaaS, IT delivers a "computing platform" for consumption. 
    PaaS: IaaS + Middleware + Runtime. 
    Runtime, Most languages have some form of runtime system, which implements control over the order in which work that was specified in terms of the language gets performed.
    Middleware, is computer software that provides services to software applications beyond those available from the operating system. It can be described as "software glue".[1] Middleware makes it easier for software developers to perform communication and input/output, so they can focus on the specific purpose of their application. Middleware is the software that connects software components or enterprise applications. Middleware is the software layer that lies between the operating system and the applications on each side of a distributed computer network. Typically, it supports complex, distributed business software applications.
SaaS: Software as a Service
    SaaS, delivers ACCESS to the software to be used without having to do anything to manage, configure, monitor or support it. 
    SaaS: PaaS + Data + Applications
    Virtualization and cloud technologies requiere automation in order to provision quickly enough for the service to be readily consumable. In order to do that, a ton of sw has been written to manage those compute resources and allow the automatic scaling based on need. 
Build Automation
          Build Automation, The process of building or compiling software that can then be deployed via script or cron jobs to various environments, including production systems. Also, it encompasses not only the software portion, but the process of automating the deployment of compute resources.
    Infraestructure as code, everything is treated as a "compute resource" and can be managed with code.  
    Build automation, consistency and stability is the key to obtain build automation. By removing the manual process necessary to deploy hw and sw, you eliminate potential inconsistencies amogst the environments and reduce troubleshooting time when there is a problem since rollback and new deployments are trivial.
Continuous Integration and Continuous Deployment
    Continuous integration, practice of merging development working copies with the shared source main multiples times per day. 
    The concept of multiple integrations per day on the main source branch is to prevent integration problems in large development teams where the odds of on change breaking the changes of another developer would be smaller. 
    Continuous Delivery, software teams keep producing valuable software in very short delivery cycles and ensures that those features can be reliably and consistently released at any point in time. 
    CI vs CD: CI manages code  throughout the develpment lifecycly instead of producing valuable and quick features as CD mandates to achieve. 
    plan -> code -> build -> test -> release -> deploy -> operate -> monitor -> plan
Jenkins
    Jenkis, build automation on steroids and cotinuous integration.
    Jenkins, allows you to create build jobs that do anything from deploying a simple software build to the custom creation of a Docker container with specific build branches while doing performance and unit testing while reporting results back to the team. 

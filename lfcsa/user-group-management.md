User and Group Management 
=========================
    
Create, Delete and Modify Local User Accounts 
---------------------------------------------

- `useradd [user]`, creates user [user]
    - `useradd -d|--home-dir [home_dir] [user]`,   The new user will be created 
    using HOME_DIR as the value for the user's login directory.
    - `passwd [user]`
    - `mkdir [home_dir]/`
    - `cp /etc/skel/* [home_dir]` 
    - `chown -R [user]:[user] [home_dir]`

- userdel command modifies the system account files, deleting all entries that 
refer to the user name LOGIN.
    - `userdel [user]; rm -rf [home_dir]`, removes user but home directory has
    to be removed manually.
    - `userdel -r [user]`, removes user and home directory.
    
Create, Delete and Modify Local Groups 
--------------------------------------

- `/etc/group`, Group account information.
    - When a user is created a user group is created by default.
- `groupadd` command, creates a new group account using the values specified on
the command line plus the default values from the system.
- `newgrp` changes the current real group ID to the named group, or to the 
default group listed in /etc/passwd if no group name is given.
    - If not root, the user will be prompted for a password if she does not 
    have a password and the group does, or if the user is not listed as a member 
    and the group has a password. 
    - The user will be denied access if the group password is empty and the user 
    is not listed as a member.
- `gpasswd`, is used to administer /etc/group, and /etc/gshadow.
- `chgrp [file]` - change group ownership of a file if owner is member of the group.

    
Using SUDO to Access the Root Acount 
------------------------------------

sudo, super user do.
- `sudo`, allows a permitted user to execute a command as the superuser or 
another user, as specified by the security policy.
- sudoers policy plugin determines a user's sudo privileges. The policy is 
driven by the `/etc/sudoers` file.
    - `[user] ALL=(ALL:ALL) ALL`, gives root permissions to a user.
    - Adding a user to a group with sudo privileges is another way for a user
    to elevate privileges.

    
Manage User Accounts 
--------------------

- `/etc/passwd`, contains one line for each user account, with seven fields 
delimited by colons (“:”). These fields are:
    ·   login name
    ·   optional encrypted password
    ·   numerical user ID
    ·   numerical group ID
    ·   user name or comment field
    ·   user home directory
    ·   optional user command interpreter

`/etc/shadow`, shadow is a file which contains the password information for the system's accounts and optional aging information.
    ·    login name, It must be a valid account name, which exist on the system.
    ·    encrypted password
    ·    date of last password change, The date of the last password change, expressed as the number of days since Jan 1, 1970.
    ·    minimum password age, The minimum password age is the number of days the user will have to wait before she will be allowed to change her password again.
    ·    maximum password age, The maximum password age is the number of days after which the user will have to change her password.
    ·    password warning period
    ·    password inactivity period
    ·    account expiration date
    ·    reserved field

 `/etc/skel` directory, contains files and directories that are automatically copied over to a new user's home directory when such user is created by the useradd program. 
Each user home directory contains `.bashrc` and `.profile` as the main configuration files in bash.
`/etc/profile` and `/etc/bash.bashrc` are the global customizations for all user shells.
    
Manage User Processes 
---------------------

A user process is a process which is started by a user an not the system.
- `ps aux`, all processes run by all user regarding of terminals.
- `ps axjf`, all processes run by all users with parents in a forest view for children.
- `pgreg [command]`, obtains command PID.
#REVISAR KILL 

    
User Account Attributes 
-----------------------

- `chfn` command, changes user fullname, office room number, office phone 
number, and home phone number information for a user's account.
- `chsh -s [SHELL]` command, changes the user login shell.
- `passwd [user]`, changes password for a user.
- To prevent a user to connect, assigning `/bin/false` or `/usr/bin/nologin` 
prevents a user to log in to a system.

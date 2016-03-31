In Depth User & Group Management
================================


Adding Linux Users Using useradd, Customization And Flags
========================================================
    
useradd [user], creates user [user]
useradd -c|--comment [comment] [user],  Any text string. It is generally a short description of the login, and is currently used as the field for the user's full name.
useradd -d|--home-dir [home_dir] [user],   The new user will be created using HOME_DIR as the value for the user's login directory.
useradd -e, --expiredate [expire_date] [user], The date on which the user account will be disabled. The date is specified in the format YYYY-MM-DD.
useradd -p, --password [password] [user], The encrypted password, as returned by crypt(3). The default is to disable the password.
useradd -M, --no-create-home [user], Do not create the user's home directory, even if the system wide setting from /etc/login.defs (CREATE_HOME) is set to yes.
useradd -m, --create-home [user], Create the user's home directory if it does not exist. By default, if this option is not specified and CREATE_HOME is not enabled(in /etc/login.defs), no home directories are created.
useradd  -G, --groups GROUP1[,GROUP2,...[,GROUPN]]] [user], A list of supplementary groups which the user is also a member of.
useradd -g, --gid GROUP [user], The group name or number of the user's initial login group. The group name must exist.
useradd -f, --inactive INACTIVE, The number of days after a password expires until the account is permanently disabled. A value of 0 disables the account as soon as the password has expired, and a value of -1 disables the feature.
useradd -k, --skel SKEL_DIR, The skeleton directory, which contains files and directories to be copied in the user's home directory, when the home directory is created by useradd.

 /etc/skel directory, contains files and directories that are automatically copied over to a new user's home directory when such user is created by the useradd program. 

/etc/passwd, contains one line for each user account, with seven fields delimited by colons (“:”). These fields are:
·   login name
·   optional encrypted password
·   numerical user ID
·   numerical group ID
·   user name or comment field
·   user home directory
·   optional user command interpreter

/etc/shadow, shadow is a file which contains the password information for the system's accounts and optional aging information.

·    login name, It must be a valid account name, which exist on the system.
·    encrypted password
·    date of last password change, The date of the last password change, expressed as the number of days since Jan 1, 1970.
·    minimum password age, The minimum password age is the number of days the user will have to wait before she will be allowed to change her password again.
·    maximum password age, The maximum password age is the number of days after which the user will have to change her password.
·    password warning period
·    password inactivity period
·    account expiration date
·    reserved field

The pwck command,  verifies the integrity of the users and authentication information. It checks that all entries in /etc/passwd and /etc/shadow have the proper format and contain valid data. The user is prompted to delete entries that are improperly formatted or which have other uncorrectable errors.

/etc/default/useradd, Default values for useradd(8) command.

Modifying User Accounts
=======================

usermod command, modifies the system account files to reflect the changes that are specified on the command line.

usermod -d, --home HOME_DIR [user], The user's new login directory.
usermod -e, --expiredate EXPIRE_DATE [user], The date on which the user account will be disabled. The date is specified in the format YYYY-MM-DD.
usermod -f, --inactive INACTIVE [user], The number of days after a password expires until the account is permanently disabled. A value of 0 disables the account as soon as the password has expired, and a value of -1 disables the feature.
usermod -g, --gid GROU [user]P, The group name or number of the user's new initial login group. The group must exist.
usermod  -G, --groups GROUP1[,GROUP2,...[,GROUPN]]] [user], A list of supplementary groups which the user is also a member of. Each group is separated from the next by a comma, with no intervening whitespace.
usermod -l, --login NEW_LOGIN [user], The name of the user will be changed from LOGIN to NEW_LOGIN.
usermod  -L, --lock [user], Lock a user's password. This puts a '!' in front of the encrypted password, effectively disabling the password.
usermod  -U, --unlock [user], Unlock a user's password. This removes the '!' in front of the encrypted password.

Removing User Accounts In Linux
===============================
    
userdel command modifies the system account files, deleting all entries that refer to the user name LOGIN.
    
userdel -f [user], This option forces the removal of the user account, even if the user is still logged in. It also forces userdel to remove
the user?s home directory and mail spool.
- It's better to kick a user and then remove its account.
userdel -r, --remove [user], Files in the user?s home directory will be removed along with the home directory itself and the user?s mail spool.  Files located in other file systems will have to be searched for and deleted manually.


Managing Groups In Linux
========================

groupadd command, creates a new group account using the values specified on the command line plus the default values from the system.
groupadd -g, --gid GID [group], The numerical value of the group?s ID.
groupadd -r, --system [group], Create a system group.
groupadd -f, --force [group], This option causes the command to simply exit with success status if the specified group already exists.
/etc/group, Group account information.
/etc/gshadow, Secure group account information.
/etc/login.defs, Shadow password suite configuration.

groupmod command, modifies the definition of the specified GROUP by modifying the appropriate entry in the group database.
groupmod -g, --gid GID [group], The group ID of the given GROUP will be changed to GID.
groupmod -o, --non-unique, When used with the -g option, allow to change the group GID to a non-unique value.
- groupmod -o -g GID [group], The group ID is not unique anymore. 
groupmod  -n, --new-name NEW_GROUP [user], The name of the group will be changed from GROUP to NEW_GROUP name.

groupdel [group], modifies the system account files, deleting all entries that refer to group. The named group must exist.
    
System Accounts And Special Purpose Accounts
============================================
    
It's considered a system account if:
- It has a UID/GID in the range 0 to 1000.
    
Password Policy With The chage Command
======================================
    
chage command, changes the number of days between password changes and the date of the last password change. 
chage -E, --expiredate EXPIRE_DATE [user], Set the date or number of days since January 1, 1970 on which the user?s account will no longer be accessible. The date may also be expressed in the format YYYY-MM-DD 
chage -I, --inactive INACTIVE [user], Set the number of days of inactivity after a password has expired before the account is locked. The INACTIVE option is the number of days of inactivity.
chage  -m, --mindays MIN_DAYS [user], Set the minimum number of days between password changes to MIN_DAYS.
change -M, --maxdays MAX_DAYS [user], Set the maximum number of days during which a password is valid.
change -l, --list [user], Show account aging information.


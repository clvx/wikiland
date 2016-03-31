
File Naming Basics And A Look At File Commands
==============================================

• Naming conventions
    o case sensitive: unlike windows, linux is case sensitive.
         example: test.TXT and Test.txt and TEST.txt are all completely separate files.
         spaces: are permitted, but require escape character preceding them (\) when referencing the file.
         "dot" files: file names that are preceded with a 'dot' or period (.), can appear invisible when listing the filesystem with a plain 'ls' command.
            • listing the filesystem with 'ls -al' will list ALL files in all formats in that directory.
            • most commonly used as configuration files in a home directory.
• Wildcard:
    o *: will substituted any value from 1 to N characters.
         example: bul* would be valid to refer to filenames bulk, bull, bullshark.
    o ?: one character substitute rather than 1 to N characters.
         example: bul? is valid for 'bulk' but not 'bulkrate'.
    o [char]: character based substitution, allows specific character designation as substitutes for a file name.
         example: bu[a-z]k would be valid for files 'bulk, buok, bukk' but not 'bu3k, bu#k, bu@k'.
• ls
    o lists files and directories
         -al: list all files, directories and ‘hidden/system config’ files (.dir, .config, etc).
• cp
    o makes copies of existing files
         –f: force overwrite
         -r: recursive (copies directories too)

    Filenames in linux are case sensitive, and file extensions are case sensitive too.
    $touch file\ with\ spaces, creates a file with spaces.
    ext3 has a limit of 256 characters for file names.
    touch .hiddenfile, creates a hidden file putting a dot at the beggining
    ls -la, long lists all files including hidden files.
    Wildcards:
    - ?, any character in place.
    - *, zero or more character match
    - [], matchs any character in the set of the bracket.
    --- [abc], matches any word which contains a or b or c.
    file globbing, is managing files using wildcard expansion. 
    ls -F,  append indicator (one of */=>@|) to entries.
    - /, for directories.
    - @, for symbolic links
    - =, for sockets
    - |, for pipes
    l s -R, recursive listing 
    cp [options] [source] [directory], copies a file or directory
    cp -i [source] [ destination], prompt before overwrite
    cp - [source] [destination],  preserve  the  specified  attributes(default:  mode,ownership,timestamps).
    cp -p [source] [destination], preserve the specified attributes(default: mode,ownership,timestamps).
    cp -R [source] [destination], copies recursively a directory.

File Archiving & The RM, MV Commands
====================================

• mv
    o cannot 'move' a directory to a file, or vice versa.
    o mv file1 file2 - effectively renames the file1 to file2.
         -i: interactive, will prompt before an overwrite or move for example
    o same filesystem moves simply update the location and reference to the content, date/timestamp of the file will remain the same.
    o moves across filesystems (devices or network) recreates the file in a new location, adds the directory references to its location and then deletes the original file, as a result, the date/timestamp will reflect the time/date of the move.
• rm
    o removes files that you have permission to
         -r: recursive (removes directories).
         -f: force (removes with a ‘y’ answer to ‘Are You Sure?’).
• tar
    o used to archive or unarchive files and directories, can be used with or without additional compression:
         -x: extract files from the archive.
         -t: list files in the archive.
         -c: create the file.
         -v: verbose output to console.
         -z: (de)compress with gzip.
         -j: (de)compress with bzip2.
         -A: add to the existing archive.
         -f: name of tar file follows this.
            • Example: tar zxvf list.tar.gz /home/username
                o This will extrac all files and directories in the file into the /home/username directory, uncompress them with gzip, output verbose information to the screen from from the list.tar.gz file

    cp -a [source] [destination], recursively copy preserving ownership.
    cp -u [source] [destination], copy only when the SOURCE file is newer than the destination file or when the destination file is missing.
    mv [source] [destination], move (rename) files.
    mv -i  [source] [destination], prompt before overwrite
    mv -n [source] [destination], do not overwrite an existing file
    mv -u [source][destination],               move only when the SOURCE file is newer than the destination file or when the destination file is missing.
    When moving a file to a different partition, the system reads the file then recreates it in the new location and removes the original file. 
    When moving a file in the same filesystem, the system rewrites the file only. 
    rm -r [directory], removes recursively a directory.
    tar -cvfz [tar_file_name].tgz [files_to_compress], creates a zip tar file tar_file_name.tgz verbously.
    tar -xvzf [tar_file_name].tgz -C [path_to_untar] , extracts zip tar files tag_file_name.tgz verbously in path_to_untar.

The gunzip Command
==================
    gzip [file], compress a file as a zip file. 
    gunzip [file].gz, uncompress a zip file.

Linux Links 
===========
• ln
    o equivalent to windows shortcuts or OSX aliases.
    o give multiple names to a file, in a different location (or the same).
• Soft links vs hard links
    o –s: soft link creates a special file that ‘refers’ to the original file (path and name) but does not duplicate the file content. Deleting this does not delete the original.
    o Hard link: hard link creates a duplicate of the original file and cannot be used across filesystems, nor can they be used to refer to a directory.
         Removing the hard link does not remove the original, you would need to delete both files in both locations.
         Hard linked file updates are replicated to all hard linked locations.

    Hard links  associates multiple directory entries with a single inode. Inodes are associated with precisely one directory entry at a time, hard links helps to have multiples files pointing to an inode. 
    - A Hard link cannot exist between filesystems.
    - If you want to delete a file which contains hard links, you must delete the file and all the hard links pointing to the file.
    a symbolic link (also symlink or soft link) is a special type of file that contains a reference to another file or directory in the form of an absolute or relative path and that affects pathname resolution.
    - A symbolic link is a different file which references the original file. 
    - If you delete a file which contains symbolic links, you can delete the original file and preserve a broken symbolic link because it doesn't have any file to reference it. 
    ln [path_to_system_file] [path_to_hard_link_file], creates a hard link.
    ln -s [path_to_system_file] [path_to_sym_link_file], creates a symbolic link.
    ln -i [-s] [path_to_system_file] [path_to_link_file], replaces a link with a new system_file reference
    ln -f [-s] [path_to_system_file] [path_to_link_file], replaces a link forcely with a new system_file reference

Linking Vs. Copying Files
=========================
    Linking is a good option when you need to reference the same file in multiple locations without needing to pass in a full path.
    Soft linking is less IO intensive on your system and saves on disk space since links are very small files regardless of the size of file linked to. Soft links can also traverse filesystem boundaries.
    - If you delete the original, all link references to that file become invalid.
    Hard linking is a bit more IO intensive and saves on disk space since links are very small files regardless of the size of file linked to. 
    - Deleting the original file simply reduces the link count and does not remove the inode(data).
    - A hard link can't tranverse a filesystem because each filesystem has its own set of inodes. And a hard link is a link to a unique inode. 

Basic Directory & Group Commands
================================
• mkdir
    o makes a new directory with the indicated name.
    o makes one directory level at a time by default.
    o making a full directory path that does not already exist is possible.
         -p: makes a base directory and creates all subs in the command.
         Example: mkdir –p /home/to/my/dir.
• Makes /home and all subs in the path if they do not exist.
• rmdir.
    o removes a directory that you have access to.
         -p: removes all indicated directories in the path that exist
    o only removes empty directories, removing directories that have content can be accomplished with the ‘rm’ command
• chgroup
    o changes the group ownership of a file or directory if you have rights to manipulate that objects ownership.
o the group you are changing to must be one that you are already a member of

    mkdir -p [path/to/directory], creates a directory and makes parent directories as needed.
    rm -r, remove directories and their contents recursively.
    chgrp -R [groupname] [file], changes group ownership recursively.

Special Permission Bits
=======================

• Easiest to manipulate as root user, although caution during bit manipulation in system directories – you could end up with an unbootable system.
• sh (dash).
    o shell interpreter that will run any applications (the environment is independent of the currently logged in user shell, environment is unique, but the environment pulls parameters from the owner of the application).
• +s (chmod)
    o Will change the file/application to run with the same permissions of the user that owns the file setuido run the file with the same permissions as the user that owns the file sgid
    o run the file with the same permissions as the group that owns the file sticky bit permission.
    o +t: protects files or directories from being deleted by those users/groups that do not own the files.
    o can override the normal file/directory permissions on a file

    SUID, Set owner User ID up on execution,  is defined as giving temporary permissions to a user to run a program/file with the permissions of the file owner rather that the user who runs it. In simple words users will get file owner’s permissions as well as owner UID and GID when executing a file/program/command.
    chmod 4ABC [file], chmod u+s [file], sets SUID to a file.
    Sticky Bit, is mainly used on folders in order to avoid deletion of a folder and its content by other users though they having write permissions on the folder contents. If Sticky bit is enabled on a folder, the folder contents are deleted by only owner who created them and the root user.
    chmod o+t [folder], chmod 1ABC [folder], modifies permissions with a sticky bit.

[ Default Permissions umask, newgrp, and chattr ]

• newgrp groupname
    o will change the default group that files/folders are created under to the indicated group.
• umask
    o will display the permissions that files and folders are created under:
         files = ####
         folders = ####
         #### (in octal notation)
            • 0 = rwx
            • 1 = rw
            • 2 = rx
            • 3 = r
            • 4 = wx
            • 5 = w
            • 6 = x
            • 7 = no permissions
    o Can be set by octal notation (above) or symbolic notation.
         Example a+r = allow read for all users.
    o Default permissions are 666.
    o umask values then subtract from the default.
         example: umask 277
         leaves us files = 666 – 277 = 400
• chattr
    o changes the attributes on a linux filesystem.
    o example: chattr –a filename.txt.
         remove the write attribute for a file allowing ONLY append.
    o –i: immutable (cannot write, delete or link to file).
    o –s: set the file attribute for deletion so that recovery is not possible, the inode is  overwritten with 0’s.
    o –A: do not update the modified time if file is written to.

    newgrp [-] [group], changes the current real group ID to the named group, or to the default group listed in /etc/passwd if no group name is  given.  newgrp also tries to add the group to the user groupset. If not root, the user will be prompted for a password if she        does not have a password  and the group does, or if the user is not listed as a member and the group has a password. The user will be denied access if the        group password is empty and the user is not listed as a member.
    umask XXX, is use to determine the file permission for newly created files. It can be used to control the default file permission for new files.
    - The default umask 002 used for normal user. With this mask default directory permissions are 775 and default file permissions are 664.
    - The default umask for the root user is 022 result into default directory permissions are 755 and default file permissions are 644.
    - For directories, the base permissions are (rwxrwxrwx) 0777 and for files they are 0666 (rw-rw-rw).
    chattr, changes the file attributes on a Linux file system.
    - chattr [ mode ] files, The format of a symbolic mode is +-=[acdeijstuADST].
    -- a, appends only.
    -- i, inmutable only; can't delete, update, move. 
    - c, ompresses data written to a file and uncompress it when it's read
    -s, secure deletion, writes zero's to the blocks of the file making it irrecuperable. 
    - A, it won't modify the atime after modifying a file. 

Linux Core Directories & What They Are Used For
===============================================

• /etc
    o system files, configurations, start up information, locale, link to parameters, etc.
    o /etc/init.d: initialization scripts and services that start on boot up.
• /boot
    o grub, kernel parameters.
    o sometimes (ideally) a separate partition from root.
• /bin
    o common system scripts, applications and utilities (ping, kill, top, sh, mount, etc).
• /sbin
    o system administration scripts, applications and utilities (root level user access command like fdisk, format, reboot/shutdown, file system management, etc).
• /lib
    o system binary libraries (like windows DLLs) that are shared and linked to by applications installed on your system.
         ld.so.conf can reference various directories that contain library files for linking.
• /usr
    o bulk of the linux base applications and scripts.
    o common directories for all users, binary files, libraries, local binary files by user, etc.
• /opt
    o user level or post installation user applications that are installed (often referred to as the equivalent of “program files” for windows).
• /root
    o the home directory of the root user.
• /var
    o logs, spools (mail and print), html files for apache servers, libraries for applications, mysql default installation location.
• /tmp
    o temporary system or application directory, this is cleaned up periodically and automatically.
• /mnt
    o typical location for mounting external filesystems (NFS, Samba, Windows, cdrom, etc).
/dev
    o device directory for linux, direct references to all the devices on the system.
/proc
    o list of files that contain system level information (cpu, disk space, kernel version, memory, existing filesystems, distribution type, etc).
    o used by system utilities to cleanly display system level behavior and information.

    /boot, contains information that's related to initial booting of the computer.
    /bin, common system programs. 
    /sbin, programs accsible by the root or privileges users.
    /lib, contains program libraries that system programs use them.
    /usr, bulk system information.
    /opt, bulk information for packages not shipped with the operating system.
    /root,root's home directory
    /var, variable data.
    /tmp, temporary data.
    /mnt, temporary mounts.
    /dev, files that represents hw devices. 
    /proc, system running information
    /etc, configuration files. 

Finding Files In Linux
======================

• find
    o example: find /home/username –name “file*”.
    o look in the /home/username directory for a file with the name “file*”, will display filename.txt files filemeaway.sh, etc.
    o slower since it reads the file and directory system one by one, but more flexible.
    o does not use an indexing system, rereads the entire structure each time.
    o –size: can find files of a certain size.
• locate
    o example: locate etc
         will display any files or directories containing ‘etc’ in the name or path (very quick).
         uses index files by running ‘updatedb’ to create the index used.
• whereis
    o search path directories (binary, man pages, libraries) for the file asked for.
    o example: whereis ls.
     will search and find the command ‘ls’ immediately in /bin.
• which
    o search the binary path directories (/bin, /sbin, /usr/local/bin, etc) indicated in the shell PATH variable.
• type
    o will display how the system will interpret the command.
    o example: type man
     will display “man is /usr/bin/man’ so you will know it is an executable.

    apt-get install locate, yum install locate.
    locate, reads  one  or  more databases prepared by updatedb(8) and writes file names matching at least one of the PATTERNs to standard  output, one per line.
    sudo updatedb, to prepare the database for the locate command.
    find [directory_to_search] [options...] [pattern], looks for a filename according to a pattern inside a path

updatedb.conf configuration file
================================
    /etc/updatedb.conf - a configuration file for updatedb(8)
    bind mount, allows you to mount all or part of another filesystem in a different location.
    PRUNE_BIND_MOUNTS, If PRUNE_BIND_MOUNTS is 1 or yes, bind mounts are not scanned by updatedb(8). All file systems mounted in the subtree of a bind mount are skipped as well, even if they are not bind mounts.
    PRUNEFS,  A whitespace-separated list of file system types which should not be scanned by updatedb(8).
    PRUNENAMES, a whitespace-separated list of directory names (without paths) which should not be scanned by updatedb(8)
    PRUNEPATHS, A whitespace-separated list of path names of directories which should not be scanned by updatedb(8)

Using The dd Command
====================
    dd,  Copy a file, converting and formatting according to the operands. file like devices, volumens and partitions.
    use cases:
    - Creating a usb disk image.
    - Creating a cd disk image.
    - Deleting securely individual files.
    - Backing up the MBR of a root partition.
    - Wiping a hard disk securely. 
    --- Fill with zeros or random data to wipe disks securely.
    - Creating empty files of arbitrary sizes. 
    - To benchmark drive performace, by determining how fast will read and write.
     if=FILE, read from FILE instead of stdin.
    bs=BYTES, read and write BYTES bytes at a time (also see ibs=,obs=).
    /dev/zero, is a special file (in this case, a pseudo-device) that provides an endless stream of null characters (so hex 0x00)
     bs=BYTES(block size), read and write BYTES bytes at a time. By default is 512 bytes.
     bs=BYTES(block size), read and write BYTES bytes at a time. It's a unit meassuring the number of bytes that are read, written or converted at a single time. By default is 512 bytes. 
    count=N, copy only N input blocks. How many times we want to iterate and this.
    dd if=/dev/zero of=file.iso bs=1024 count=1
    - reads from from /dev/zero iterating 1024 bytes just 1 time and write it to a 1K file.iso. 
    dd if=[rootfs] of=mbr.bak bs=512 count=1, backups the mbr which is the first 512 bytes from the root filesystem.
    dd if=[filename], if of= is not specified, it prints to stdout.
    conv=CONVS, conv=CONVS               convert the file as per the comma separated symbol list.
    - ascii, ebcdic, ibm, block, unblock, lcase, nocreat, excl, notrunc, ucase, sparse, swab, noerror, sync, fdatasync, fsync.
    dd if=[filename] conv=ucase, converts and prints all characters in uppercase instead of lowercase to stdout.
    dd if=/dev/urandom of=[filename] bs=512 count1, writes 512 bytes random characters to a file, this permits to secure  deletely or alter a file.
    mkfs,  is  used  to build a Linux file system on a device, usually a hard disk partition.
    if you want copy any type of file or disk to another file or disk, you MUST consider the block size(bs) and the count parameters will copy the file or disk full size. e.g.: if you have a disk of 1GB to be copied your bs=1M count=1000, which is 1M*1000=1024M=1GB.

The touch Command
=================
    touch [filename],  Update the access and modification times of each FILE to the current time. A FILE argument that does not exist is created empty.
    touch -a [filename], change only the access time.
    touch -m [filename], change only the modification time.
    touch -r [source_filename] [dest_filename], use this file's times instead of current time.

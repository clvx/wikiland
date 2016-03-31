Essential Commands
==================

Create and Edit Text Files - Part I
----------------------------
`touch`, modifies the timestampt of a file, but also creates a new file if it 
doesn't exist
`echo "Hello World" > file.txt`, creates a file with a word Hello World using redirection `>`
`echo "Hello Clvx" >> file.txt`, concatanates text to the end of file using redirection `>>`


Create and Edit Text Files - Part II
-------------------------------------

Vim: 3 modes #REVISAR TUTORIAL VIM DE LPI
- Insert
- Command, navigates around the file and enter commands.
    - `i`, enters to insert mode where the cursor is at the moment.
    - `a`, appends to insert mode.
    - `dd`, deletes full line.
    - `:w`, saves file.
    - `:wq`, exits and quits.
    - `:q!`, quits without saving.
    - `/[word]`, searches for "word"
        - `n`, looks forward for next ocurrence of "word".
        - `N`, looks backwards of "word".
- Exec Command, to save files and run external commands.
- Visual

SED: Stream editor, used for character substitution.
`echo "hello hi" | sed 's/h/H/g'`, replaces all ocurrences of h for H.

```
echo "Hello Hi" > sed-example
sed -i 's/h/H/g' sed-example
```
opetion -i modifies file "sed-example" with all ocurrences of h for H.

`uniq`,   Filter adjacent matching lines from INPUT (or standard input), 
writing to OUTPUT (or standard output).

```
du -sch /var/log/* | sort -h
```
estimates file size producing a numeric sorted sumarized grand total for each 
directory argument on /var/log/ 


```
cat syslog | uniq -c -w 6
```
prints number of ocurrences of the first 6 characters of syslog.

Use Input/Output Redirection(>,>>,|)/ Compare Text Files/ Compare Binary Files
------------------------------------------------------------------------------

`sort [file]`, sorts in alphabetically order.
`sort -r [file]`, sorts in reverse order.

`cat file1 file2 >> filecombined`, concatanates file1 and file2 in filecombined.

cut, removing delimeters on a file.
`echo "This is me; on this part of the world." | cut -d";" -f1`

Search for Files
----------------
`find -name 'text.txt'`, searches for text.txt on the local directory and subdirectories.
`find /etc/ -name 'text.txt'`, searches for text.txt on /etc.
`find -iname "test.txt"`, searches for text.txt ignoring case.
`find /etc/ -not -name 'text.txt'`, searches for every file but ignores text.txt
`find / -type c`, searches for all character devices.
`find / -type l`, searches for all symbolic links.
`find / -type f` and `find / -name "*"`, searches all files on a system.
`find / -type -f -name "*.log"`, searches for all log files.
`find / -type d -name "log"`, searches for all log directories.
`find /usr/bin -size +27000c`, searches for files larger than 27000 bytes.
`find / -mtime 1`, searches for files with modification time of 1 day or more.
`find / -mtime -1`, searches for files with modification time less of 1 day.
`find /etc/ -atime -1`, searches for files access time less of 1 day ago.
`find /etc/ -user root`, searches for files owned by root.
`find /usr/bin -perm 755`, searches for files with permissions of 755. 
`find /etc/ -name 'text.txt' -exec chmod 700 {} \;`, searches for text.txt and
executes change permissions and puts a placeholder
`which [filename]`, searches for executable of a command.
`locate [PATTERN]`,  reads  one or more databases prepared by updatedb(8) and 
writes file names matching at least one of the PATTERNs to standard output,
one per line.

Archive, Compress, Unpack and Uncompress Files
-----------------------------------------------

`cp -rf [dir1]/ [dir2]/`, copies recursevly and forcelly.

`tar cvf [file].tar [dir_to_backup]`, stores all files inside dir_to_backup as 
[file].tar.
`tar tvf [file].tar`, lists all files inside [file].tar.
`tar tvf [file].tar | grep [specific_file]`, lists all files inside [file].tar 
and looks for a specific_file.
`gzip [file].tar`, compress [file].tar
`tar cvfz [file].tar.gz [dir_to_backup]/`, stores all files compressed inside
dir_to_backup as [file].tar.gz
`tar zxvf [file].tar.gz`, decompresses and extracts all files inside [file].tar.gz.
`tar cvfz data.tar.gz --exclude=[filename] [dir_to_backup]/`, stores all files 
compressed minus [filename] inside dir_to_backup as [file].tar.gz


Manage Access to the Root Account
----------------------------------

su - [user], change user to [user] with its environment variables.

List, Set and Change Standard File Permissions
-----------------------------------------------

setuid, sets the effective user ID of the calling process.
setgid, set the effective group ID of the calling process.
    - `chmod u+s script.sh`, changes user effective UID to script.sh user when 
    is called by another process.
    - `chmod g+s script.sh`, changes group effective UID to script.sh group 
    - when is called by another process.

The restricted deletion flag or sticky bit is a single bit. 
    - For directories, it prevents unprivileged users from removing or renaming
    a file in the directory unless they own the file or the directory. 
        - `chmod 1755 [sticky_directory]/`
    - For regular files, the bit saves the program's text image on the swap 
    device so it will load more quickly when run; this is called the sticky bit.

`chattr [mode] filename`, changes the file attributes on a Linux file system.
    - `chattr +i file1`, makes it inmutable (can't be removed even by root).
    - `chattr +a file2`, appends only mode (can't rewrite it even by root).
`lsattr filename`, list file attributes on a Linux second extended file system

Transfer Files Securely Via the Network-SCP
--------------------------------------------

 `scp` copies files between hosts on a network.  It uses ssh(1) for data 
 transfer, and uses the same authentication and provides the same security as 
 ssh(1). 
    - `scp -v [full_path_file] [user]@[host]:[full_path_directory]`, copies a 
    file to a remoe location.
    - `scp -v  [user]@[host]:[full_path_file] [relative_path_directory]`, copies 
    a remote file locally.


Transfer Files Securely Via the Network-SFTP
--------------------------------------------

 `sftp` is an interactive file transfer program, similar to ftp(1), which 
 performs all operations over an encrypted ssh(1) transport.
    - It's activated by default on `/etc/ssh/sshd_config` defined as 
    `Subsystem sftp /usr/lib/openssh/sftp-server`.
        - Just comment it to disable it.
    - `sftp [user]@[host]`
        - `sftp > get [file] <new_name>`
        - `help` for all sftp options.

Monitor Security and Conduct Audits
-----------------------------------

`top` - display Linux processes
    - System load averages is the average number of processes that are either 
    in a runnable or uninterruptable state.  A  process  in  a  runnable state 
    is either using the CPU or waiting to use the CPU.  A process in 
    uninterruptable state is waiting for some I/O access, eg waiting for disk. 
    The averages are taken over the three time intervals.  Load averages are 
    not normalized for the number of CPUs in a system, so a load average of 1 
    means a single CPU system is loaded all the time while on a 4 CPU system it
    means it was idle 75% of the time.

`free` - Display amount of free and used memory in the system
    - `free -h`, human readable. 

#REVISAR SOBRE INODES. ~7'
`df` - report file system disk space usage
    - `df -h`, human redable.
    - `df -hTi`, prints file system type by inode in human readable form.

`du` - estimate file space usage
    - `du -h`, human readable.
    - `du -sch /var/*`, sumarizes a grand total of space by each directory of 
    path.

#REVISAR SOBRE PS y verificación de procesos.

`dmesg` - print or control the kernel ring buffer.
`/var/log/{httpd,apache2}/{access.log,error.log}`, apache logs.
`/var/log/{syslog,messages}`, system logs for CentOS or Ubuntu.







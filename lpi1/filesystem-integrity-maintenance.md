
du, df and mount
================

• du: display file and directory sizes on disk.
    o displays directory size totals, by default, directories only and from the current directory only.
    o size in full numeric notation.
    o -h: human readable format (in K, MB or GB).
    o -s: summary of current directory size.
    o -a: all files and directories.
    o --exclude=dirname: will exclude the size of the file totals in the indicated directory.
• df: file system disk space usage.
    o by default, displays mounted, non-special file systems and their mount, device free and used space.
    o -h: human readable format.
    o -a: all, including special filesystems (i.e. tmpfs).
• mount: mounts external or internal file systems.
    o mount only by root/sudo users.
    o directory to mount to must be accessible and writable by user.
    o -t: filesystem type (ext2/3/4 or xfs or ntfs, etc).
    o -a: all, attempt to mount any defined filesystem (as listed in /etc/fstab) that is not currently mounted.
    o /etc/fstab
         sample entry: /dev/sdb1 /mnt/tmp ext4 defaults 0 0
• umount: unmounts indicated filesystem
    o unmount by root/sudo user
    o -f: force unmount a busy filesystem (CAUTION)

    du,        Summarize disk usage of each FILE, recursively for directories.
    du -h, --human-readable,  print sizes in human readable format (e.g., 1K 234M 2G)., 
    du -s, --summarize, display only a total for each argument.
    du  -a, --all,  write counts for all files, not just directories.
     df - report file system disk space usage
    df -h, --human-readable               print sizes in human readable format (e.g., 1K 234M 2G).
    df -a, --all include dummy file systems
    mount [-t vfstype] [-o options] [device] [dir],  All  files  accessible  in a Unix system are arranged in one big tree, the file hierarchy, rooted at /.  These files can be spread out        over several devices. The mount command serves to attach the filesystem found on some device to the big  file  tree.  Conversely,  the        umount(8) command will detach it again.

fsck and e2fsck
===============

• fsck: check and repair linux filesystems.
    o can only be run against unmounted filesystems.
    o can only be run by root/sudo users.
    o -a: (-p is current) automatically repair any issues that fsck runs into.
         most common issues are related to minor filesystem corruption or filesystem cache flush issues, causes orphaned inodes.
         journaled filesystems (ext3/4) and extended attributes allow these inodes to be deleted and files recreated during repair.
• e2fsck: check and repair ext2/3/4 filesystems.
    o fsck.ext2/3/4 are soft links to the binary, but underlying libraries are identical.
    o can only be run against unmounted filesystems.
    o can only be run by root/sudo users.
    o -a: (-p is current) automatically repair any issues that e2fsck runs into.
         most common issues are related to minor filesystem corruption or filesystem cache flush issues, causes orphaned inodes.
         journaled filesystems (ext3/4) and extended attributes allow these inodes to be deleted and files recreated during repair.

    fsck is used to check and optionally repair one or more Linux filesystems.  filesys can be a device name ,   a mount point,  or  an  ext2  label  or  UUID  specifier.
    - Normally,  the  fsck program will try to handle filesystems on different physical disk drives in parallel to reduce the        total amount of time needed to check all of them.
      e2fsck is used to check the ext2/ext3/ext4 family of file systems.  For ext3 and ext4 filesystems that use a journal,  if  the  system        has been shut down uncleanly without any errors, normally, after replaying the committed transactions  in the journal, the file system        should be marked as clean.   Hence, for filesystems that use journalling, e2fsck will normally replay the journal and exit, unless its        superblock indicates that further checking is required.
    fsck can not be run on a mounted filesystem.
    fsck   /dev/xvdf, checks if there's any errors.
    - 0 – No errors.
    - 1 – Filesystem errors corrected
    - 2 – System should be rebooted
    - 4 – Filesystem errors left uncorrected
    - 8 – Operational error
    - 16 – Usage or syntax error
    - 32 – Fsck canceled by user request
    - 128 – Shared-library error
    fsck -A, You can check all the filesystems in /etc/fstab in a single run of fsck using this option. This checks the file system in the order given by the fs_passno mentioned for each filesystem in /etc/fstab.  Please note that the filesystem with a fs_passno value of 0 are skipped, and greater than 0 are checked in the order.
    fsck -a /dev/xvdf,  Automatically repairs the damaged portions.

mke2fs and debugfs
==================

• mke2fs: make linux filesystems
    o -t: type of filesystem to create (ext2/3/4).
    o can only be run by root/sudo user.
    o valid filesystems for tool – ext2/3/4.
         example: mke2fs -t ext3 /dev/sdb1
    o -U: UUID (assign a UUID/generate a UUID).
    o -I: inode size, size of the inodes in the group created.
    o -M: last mounted directory, the last directory this device was mounted as.
    o -L: set volume label.
    o -l: display volume label.
• debugfs: ext2/3/4 file system debugger.
    o interactive shell that is used to display information about the disk device in question or, when mounted with the right flag, adjust that information.
    o debugfs /dev/sdb1 (sample):
     -w: write mode
     -C: catastrophic mode, used to access and repair damaged (even physically damaged) disks.
    o cannot be run on a mounted file system.
    o debugfs:
         stat/stats – detailed statistics on the disk, including all inode status.
         mkdir/rmdir/ln – self explanatory, can be used in conjunction with 'lcd' (change local directory on the drive in question).
         SUPERNERD ALERT.
            • lsdel: list all deleted inodes on the device filesystem.
            • undel: allows undeletion of a file by inode.
                o i.e. debugfs: undel <12> undeleted.txt
                     will restore, to the current directory, the contents of the inode <12> and name it undeleted.txt
                o must be run by root/sudo user.

    mke2fs is used to create an ext2, ext3, or ext4 filesystem, usually in a disk partition.  device is the special file corre- sponding to the device
    mk2fs -t [fstype] [device], formats a device with a fstype filesystem. 
    mk2fs -L [new-volume-label] [device], Set the volume label for the filesystem to new-volume-label.  The maximum length of the volume label is 16 bytes.
    debugfs  program is an interactive file system debugger. It can be used to examine and change the state of an ext2, ext3, or ext4        file system.
    debugfs /dev/xvdf1, opens filesystem in debug mode.
    - freefag,  Report fragmentation information for an inode.
    - stats, List  the  contents of the super block and the block group descriptors.
    - lsdel, List deleted inodes. This  command  was useful for recovering from accidental file deletions for ext2 file systems.  Unfortunately, it is not useful               for this purpose if the files were deleted using ext3 or ext4, since the inode's data blocks are no longer available after  the               inode is released.
    undel <[inode]> [file_pathname], Undelete  the  specified inode number (which must be surrounded by angle brackets) so that it and its blocks are marked in use,               and optionally link the recovered inode to the specified pathname.
    - To undel a file debugfs must be open in read and write mode(debug -w [device]).

dumpe2fs and tune2fs
====================

• dumpe2fs: dump ext2/3/4 filesystem information.
    o terminal dump to console or log file, similar to debugfs but not interactive
    o must be run as root or sudo user
    o cannot be run on a mounted filesystem
         debugfs: stat/stats identical summary information to terminal
• Binary library compatibility.
    o underlying binary system libraries are shared with debugfs so detail information matches exactly.
• tune2fs: adjust tunable parameters on linux filesystems.
    o -c: max counts a device can be mounted before reboot causes filesystem check.
    o -C: set the count of mounts, can be used to exceed the max set earlier to force a filesystem check during the next reboot.
    o command and many parameters are superseded by specific SAN, NFS or RAID driver utilities for performance tuning.
         was more effective when tuning local parallel IDE drives in the past
    o -L: set the volume label for the device
    o -l: display the volume label for the device
    o -U: generate and display the UUID for the device
    o -i: set the interval between filesystem checks
• Can be used in conjunction with the fsck/e2fsck utilities for checking integrity of drives after changed are applied.

    tune2fs allows the system administrator to adjust various tunable filesystem  parameters  on  Linux  ext2,  ext3,  or  ext4        filesystems.
           dumpe2fs prints the super block and blocks group information for the filesystem present on device.
    dumpe2fs /dev/xvdf, prints superblock filesystem information. Like debug2fs stats command but prints to stdout. 
    tune2fs -C  [mount-count] [device], Set the number of times the filesystem has been mounted.  If set to a greater value than the max-mount-counts parameter set  by               the -c option, e2fsck(8) will check the filesystem at the next reboot.
    tune2fs  -c [max-mount-counts] [device], -Adjust the number of mounts after which the filesystem will be checked by e2fsck(8).
    tune2fs -L [label_name] [device], Set  the  volume  label of the filesystem.  Ext2 filesystem labels can be at most 16 characters long.
    dumpe2fs -h [device],  only display the superblock information and not any of the block group descriptor detail information.

xfs tools 
=========

Not installed by default on modern Linux operating systems
    o sudo apt-get xfsprog xfsdump
    o sudo yum install xfsprogs xfsdump
• Installation path
    o not typical system utility path (/sbin) since not default install
    o /usr/sbin
• cat /proc/filesystems
    o look for 'xfs' entry to make sure the kernel module is loaded and filesystem is supported on your distribution.
• Samples
    o xfs_check: check XFS file system integrity
         equivalent of ext2/3/4 fsck/e2fsck utility
         must be run by root/sudo
         cannot be run on mounted filesystems
         sample: xfs_check /dev/sdb1
            • will not show any output if the drive is clean
            • same options as fsck
         -v: verbose mode give ALL inode information settings
    o xfsdump: dump XFS filesystem parameters to log or terminal
         equivalent to dumpe2fs with the exception that it can be used to do a full backup of your filesystem.
         sample: xfsdump -J -f /mnt/xfsdir /home/user/filedump.xfs
            • -J: backup filesystem journal.
            • f: all files and directories.
         restore the system the same way, reversing the order of device and backup file.
         sample xfsdump -J -f /home/user/filedump.xfs /mnt/xfsdir
            • CAUTION: can inadvertantly restore an empty, but existing file, onto the partition.
    o xfs_admin: change paramters of the XFS filesystems
         tune2fs and debugfs ext2/3/4 equivalent
            • -L: set volume label
            • -l: view volume label
            • -U: display the filesystem UUID

    xfs_repair  repairs  corrupt  or  damaged  XFS  filesystems (see xfs(5)).  The filesystem is specified using the device argument which        should be the device name of the disk partition or volume containing the filesystem.
    xfs_repair [device], repairs a xfs device.
    xfsdump  backs up files and their attributes in a filesystem.  The files are dumped to storage media, a regular file, or standard out‐        put.  Options allow the operator to have all files dumped, just files that have changed since a previous dump, or just files contained        in a list of pathnames.
    mkfs.xfs [device], formats a device with a xfs filesystem.
    xfsdump -J -f [path_to_dumpfile] [xfs_mount_device],  backups files and attributes inhibiting the normal update of the inventory to a destination xfs_dump_file for the specified device. 
    xfsrestore -t -v silent -f [path_to_dumpfile], displays the contents fo the dump verbosely, but doesn't create or modify any files or directory.
    xfsrestore -J -f [path_to_dumpfile] [xfs_mount_device], restores a filesystem from a dump inhibiting inventory update when on-media session inventory encountered during restore.
    xfs_admin -L [label] [device], sets a label for the device.
      xfs_admin - change parameters of an XFS filesystem

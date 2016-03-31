
[ Creating And Mounting A Disk Partition ]

/etc/fstab - Configuration file used to permanently mount a disk.
fstab syntax:
- #device #mountpoint #filesystem #options #dump #fsck

- device - Can mount by file name or by disk UUID or by network drive.
- Server:/home or //server/share
- Mount point – Should usually be an empty dir. Location on which you want to mount the disk drive. Example: /mnt/diskdrive.
- File System - Tell the system what type of file system your mounting ext3/4 etc. “auto” tells kernel to auto detect. Auto detect is best used for media devices not for an additional disk partition your mounting.
- Options - Tell the kernel how to treat the mounted system. You can have multiple mount options if separated by commas.
    - uid – set the owner of the mounted files
    - umask – Sets default umask for partition
    - noauto - Do not automatically mount the device at bootup.
    - exec – Lets you executes binaries on the file partition. No exec prevents it.
    - ro – You can mount the file system as read only
    - rw – Mount the file system with read and write privileges
    - user – allow normal users to mount device.
    - nouser -
    - defaults – rw,suid,dev,exec,auto.nouser, and async are the defaults.
- Dump – If set to 1 then the dump utility would back up a partition 0 if it should not backup a partition.
- Fsck – Determine what order the file system should be checked in.
    - 0 means fsck should not check the file system
    - 1 (generally root) would be checked first
    - 2 would be checked next
    - 3 etc..

    All  files  accessible  in a Unix system are arranged in one big tree, the file hierarchy, rooted at /.  These files can be spread out over several devices. The mount command serves to attach the filesystem found on some device to the big  file  tree.  Conversely,  the umount(8) command will detach it again.
    Syntax:  mount -t [type] [device] [dir]
    ext3, ext2 features + journaling which is a way to restore the system in case of failure. In journaling  when a change is made adds an entry into the filesystem journal getting the advantage to reconstruct the filesystem if the system crash.
    mkfs  is  used  to build a Linux filesystem on a device, usually a hard disk partition.  The device argument is either the device name        (e.g.  /dev/hda1, /dev/sdb2), or a regular file that shall contain the filesystem.  The size argument is the number of  blocks  to  be used for the filesystem.
    Syntax:        mkfs [options] [-t type] [fs-options] device [size]
    mkfs.ext3 /dev/xvdf -c -m 25, creates an ext3 filesystem on the /dev/xvdf device checking for bad blocks before creating the file system(-c), and preserving 25% of the filesystem blocks for the super-user to avoid fragmentation and allow system daemons to continue working if the disk fills up(-m 25).
    mount /dev/xvdf /root/mount, mounts the /dev/xvds device to /root/mount


[ Using fdisk, Creating A File System, and Configuring Mount Entry With /etc/fstab ]
    In Linux it's no importante if  there's and extended or primary partition, while there's only 4 partitions. 
     fdisk  (in  the  first form of invocation) is a menu-driven program for creation and manipulation of partition tables.  It understands DOS-type partition tables and BSD- or SUN-type disklabels.
    - fdisk does not understand GUID partition tables (GPTs) and it is not designed for large partitions.  In  these  cases,  use  the  more advanced GNU parted(8).
    - Hard disks can be divided into one or more logical disks called partitions.  This division is recorded in the partition  table,  found in sector 0 of the disk.
    - Linux needs at least one partition, namely for its root file system.  It can use swap files and/or swap partitions, but the latter are        more efficient.  So, usually one will want a second Linux partition dedicated as swap partition.  On  Intel-compatible  hardware,  the        BIOS  that boots the system can often only access the first 1024 cylinders of the disk.  For this reason people with large disks often        create a third partition, just a few MB large, typically mounted on /boot, to store the kernel image and a few auxiliary files  needed        at  boot time, so as to make sure that this stuff is accessible to the BIOS.
    - fdisk /dev/xvdf, enters menu to format /dev/xvdf.
    -- n, adds a new partition.
    -- w, writes table to disk and exit.
    After creating a partition a disk filesystem must be create to be mounted. 
    - mkdir -t ext4 /dev/xvdf1, formats partition /dev/xvdf1(previously created with fdisk) with a ext4 filesystem.
    mount /dev/xvdf1 /mnt/, mounts /dev/xvdf1 on /mnt - a disk can only be mounted if it's been formated with a disk filesystem(ext3, ext4, etc).
    /etc/fstab,  fstab contains descriptive information about the various file systems.  fstab is only read by programs, and not written; it        is the duty of the system administrator to properly create and maintain this file.  Each filesystem is described on a  separate  line;        fields  on  each  line  are  separated by tabs or spaces.
    - Syntax:  fs_spec   fs_file    fs_vfstype    fs_mntops    fs_freq    fw_passno
    - fs_spec, This field describes the block special device or remote filesystem to be mounted.
    --- For ordinary mounts it will hold (a link to) a block special device node for the device to be mounted, like /dev/sdb7.  
    --- For NFS mounts one will have <host>:<dir>.
    --- Instead  of  giving  the  device  explicitly,  one  may indicate the filesystem that is to be mounted by its UUID or LABEL   writing  LABEL=<label>  or  UUID=<uuid>.
    - fs_file, This field describes the mount point for the filesystem.
    --- For swap partitions, this field should be specified as `none'. 
    --- If the name of the mount point contains spaces these can be escaped as `\040'.
    - fs_vfstype, This  field  describes  the type of the filesystem.
    --- Fileystem supported: adfs, affs, autofs, coda, coherent, cramfs, devpts, efs, ext2, ext3, hfs, hpfs, iso9660, jfs, minix, msdos,  ncpfs,  nfs,  ntfs,  proc,  qnx4,  reiserfs, romfs, smbfs, sysv, tmpfs, udf, ufs, umsdos, vfat, xenix, xfs, and possibly others.
    --- if auto is used instead of a specific filesystem, the kernel will try to figure out which filesystem has the device and mount it. 
    - fs_mntops, This field describes the mount options associated with the filesystem.
    --- Check mount(8) for all the mount options.
    --- each option is separated by a comma. 
    --- noauto, Can only be mounted explicitly.
    --- auto, Can be mounted with the -a option.
    --- exec,   Permit execution of binaries.
    --- noexec, Do  not allow direct execution of any binaries on the mounted filesystem.
    --- ro, Mount the filesystem read-only.
    --- rw, Mount the filesystem read-write.
    --- user, Allow  an  ordinary  user to mount the filesystem.
    --- nouser Forbid an ordinary (i.e., non-root) user to mount the filesystem.  This is the default.
    --- defaults, Use default options: rw, suid, dev, exec, auto, nouser, and async.
    - fs_freq, This field is used for these filesystems by the dump(8) command to determine which filesystems need to be dumped.
    --- If set to 1 backups a partition, if set to 0 doesn't backup it.
    - fs_passno, This  field is used by the fsck(8) program to determine the order in which filesystem checks are done at reboot time.  
    --- The root filesystem should be specified with a fs_passno of 1, and other filesystems should have a fs_passno of 2.
    --- if set to 0 is no check.
    mount -a, umount -a, mounts and umounts all the disk devices located in /etc/fstab which it doesn't have the noauto option set. 
    /dev/xvdf1 /mnt/ ext4 default 0 0, mounts /dev/xvdf1 which it has an ext4 partition on /mnt with default mount options without dumping and no disk check. 

[ Working With Linux Swap ]
    Swap space in Linux is used when the amount of physical memory (RAM) is full. If the system needs more memory resources and the RAM is full, inactive pages in memory are moved to the swap space.
    - Swap space is located on hard drives, which have a slower access time than physical memory. 
    -  Swap should equal 2x physical RAM for up to 2 GB of physical RAM, and then an additional 1x physical RAM for any amount above 2 GB, but never less than 32 MB. 
    -  Swap space can be a dedicated swap partition (recommended), a swap file, or a combination of swap partitions and swap files. 
    dd if=/dev/zero of=~/swap.swp bs=1024 count=800k, creates a 800M  file full of zeros.
    mkswap, sets up a Linux swap area on a device or in a file.
    - The  device  argument  will  usually be a disk partition (something like /dev/sdb7) but can also be a file.
    mkswap ~/swap.swp, creates a swap area on ~/swap.swp
           swapon, swapoff - enable/disable devices and files for paging and swapping.
    swapon ~/swap.swp , enables swap.
    in /etc/fstab:
    - /root/swap.swp swap defaults, to mount persistently the swap device acrros reboots. 
    - free -m, to check if the swap space has been mounted.
    to use a disk for swap space:
    - mkswap /dev/xvdf, creates a swap disk /dev/xvdf
    swapon /dev/xvdf, enables /dev/xvdf swap
    - in /etc/fstab:
    --- /dev/xvdf  /  swap  defaults
    swapon -a | swapoff -a, to enable or disable all swap mounts on /etc/fstab

[ /media mount point ]
    /media, to mount usb, cd or dvd.

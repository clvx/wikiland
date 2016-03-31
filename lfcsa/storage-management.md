Storage Management
==================
    
List, Create, Delete and Modify Storage Partitions 
--------------------------------------------------
    
- `yum install gparted`, graphical interface partition tool.
- `fdisk -l`, lists all available disk on the system.
- `fdisk [device]`, opens a dialog-driven program for creation and manipulation
of partitions tables.
    - `m`, prints menu.
    - `l`, lists know partition types.
    - `n`, add a new partition.
        - `p`, primary partition.
        - `e`, extended.
            - Keep with the dialog program to finish the partition.
    - `p`, prints the partition table.
    - `v`, verifies the partition table.
    - `w`, writes changes.

Create, Migrate and Remove Physical/Logical/Virtual Volumes / Add New Partitions and Logical Volumes 
-----------------------------------------------------------------------------------------------------

- `mkfs -t [fs_type] [device]`, formats [device] to ext4.
- `mount -t [fs_type] [device] [mount_path]`, mounts a device specifying its filesystem.
- `umount [mount_path]`, unmounts a device.
    
Configure Systems to Mount File Systems at or During Boot 
---------------------------------------------------------

`/etc/fstab` - Configuration file used to permanently mount a disk.
fstab syntax:
- `#device|UUID|LABEL #mountpoint #filesystem_type #mount_options #dump #fsck`
- In `/etc/fstab` each drive can be referenced in different device files when 
is plugged or unplugged that's why using UUID to define how to mount a disk is 
a better option. 
    - 2 ways to obtain the UUID:
        1. using the blkid program which determines the type of content 
        (e.g. filesystem or swap) that a block device holds.
        2. ls -la /dev/disk/by-uuid/ and checking which uuid is linked to a 
        device file. 
    
Create and Assemble Volume Groups / Add or Extend Volumes and Filesystems / Assemble Volume and RAID Groups 
-----------------------------------------------------------------------------------------------------------
    
- LVM stands for Logical Volume Management: It is a system of managing logical 
volumes, or filesystems, that is much more advanced and flexible than the 
traditional method of partitioning a disk into one or more segments and 
formatting that partition with a filesystem.
    - Volumen Groups, a named collection of physical ang logical volumes.
    - Physical Volumes, corresponds to disks, they are block devices that provide 
    the space to store logical volumes.
    - Logical volumes, corresponds to partitions which hold a filesystem. Unlike
    partitions, logical volumes get names rather than numbers, they can span 
    across multiple disks, and do not have to be physycally contiguous.
        - `fdisk [device]`, opens a dialog-driven program for creation and manipulation
        of partitions tables.
            - `m`, prints menu.
            - `n`, add a new partition.
                - `p`, primary partition.
                - `e`, extended.
                    - Keep with the dialog program to finish the partition.
            - `p`, prints the partition table.
            - `l`, lists know partition types.
                - `8e`, for LVM.
            - `v`, verifies the partition table.
            - `w`, writes changes.
        - `pvcreate` [devices..], pvcreate initializes PhysicalVolume for later use by 
        the Logical Volume Manager (LVM)
        - `pvremove` [devices..],  wipes the label on a device so that LVM will no 
        longer recognise it as a physical volume.
        - `pvdisplay`, allows you to see the attributes of one or more physical volumes 
        like size space used for the volume group descriptor area and so on.
        - `vgcreate [volume_group_name] [devices...]`, creates a new volume group called
        volume_group_name using the specified devices.
        - `vgdisplay`, allows you to see the attributes of volume_group_name.
        - `vgrename [volume_group_name] [new_volume_group_name]`, renames a volume group.
        - `lvcreate --size [size] --name [logical_volume_group] [volume_group_name]`, 
        creates a new logical volume in a volume group by allocating logical extents 
        from the free  physical extent  pool  of  that  volume group.
        - `lvdisplay`, allows you to see the attributes of a logical volume like
        path, size, read/write status, snapshot information etc.
        - `mkfs -t [fs_type] [logical_volume_group]`, creates a fs_type partition.
        - `mount [logical_volume_group] [mount_path]`, mounts a logical volume group.
        - Extending a Logical Volume Group.
            - LOGICAL VOLUME GROUP MUST BE UNMOUNTED.
            - `vgextend [volume_group_name] [device...]`, extends the volume group.
            - `lvextend [logical_volume_path] [device..]`,  allows you to extend
            the size of a logical volume.
            - `resize2fs [logical_volume_path]`, resize a filesystem.

Create and Configure Swap Space 
-------------------------------

```
Amount of RAM in the system   Recommended swap space         Recommended swap space 
                                                             if allowing for hibernation
---------------------------   ----------------------------   ---------------------------
2GB of RAM or less            2 times the amount of RAM      3 times the amount of RAM
2GB to 8GB of RAM             Equal to the amount of RAM     2 times the amount of RAM
8GB to 64GB of RAM            0.5 times the amount of RAM    1.5 times the amount of RAM
64GB of RAM or more           4GB of swap space              No extra space needed
```
    - `fdisk [device]`, opens a dialog-driven program for creation and manipulation
        of partitions tables.
            - `m`, prints menu.
            - `n`, add a new partition.
                - `p`, primary partition.
                - `e`, extended.
                    - Keep with the dialog program to finish the partition.
            - `p`, prints the partition table.
            - `l`, lists know partition types.
                - `82`, for swap.
            - `v`, verifies the partition table.
            - `w`, writes changes.
    - `mkswap [device]` 
    - `swapon -v [device]`
    - `echo "UUID=[UUID-DEVICE] swap swap defaults 0 0" >> /etc/fstab`
        - To know the uuid device: `ls -la /dev/disk/by-uuid/`
    
Create and Configure Encrypted Partitions 
-----------------------------------------

-`grep -i config_dm_crypt /boot/config-$(uname -r)`, checks if system is configured
to support encrypted filesystems.
- `yum install cryptsetup`
- `apt-get install cryptsetup`
- `fdisk [device]`, opens a dialog-driven program for creation and manipulation
of partitions tables.
    - `m`, prints menu.
    - `n`, add a new partition.
        - `p`, primary partition.
        - `e`, extended.
            - Keep with the dialog program to finish the partition.
    - `p`, prints the partition table.
    - `l`, lists know partition types.
        - `82`, for swap.
    - `v`, verifies the partition table.
    - `w`, writes changes.
- `cryptsetup -y luksFormat [device]`
    - Enters a passphrase.
- `cryptsetup luksOpen [device] [encrypted_device_name]`, opens an encrypted device.
    - Enters passphrase.
- `mkfs -t [/dev/mapper/[encrypted_device_name] [device]`, it can only be 
formatted the mapper not the device.
- `mount [/dev/mapper/[encrypted_device_name] [mount_path]`, mounts an encrypted
device.
- `umount [mount_path]`
- `cryptsetup luksClose [encrypted_device_name]`

Create, Mount and Unmount Standard Linux Filesystems 
-----------------------------------------------------


- /etc/fstab. contains descriptive information about the filesystems the system 
can mount. 
    - fstab is only read by programs, and not written; 
    - it is the duty of the system administrator to properly create and maintain 
    this file. 
    - Each filesystem is described on a separate line.  
    - Fields on each line are separated by tabs or spaces.  
    - Lines starting  with  '#'  are comments.  
    - Blank lines are ignored.
- Syntax: `fs_spec  fs_file  fs_vfstype  fs_mntops  fs_freq  fs_passno`
- In /etc/fstab each drive can be referenced in different device files  when 
is plugged or unplugged that's why using UUID to define how to mount a disk is 
a better option. 2 ways to obtain the UUID:
    1. using the blkid program which determines the type of content 
    (e.g. filesystem or swap) that a block device holds.
    2. ls -la /dev/disk/by-uuid/ and checking which uuid is linked to a device file. 
    
Configure Systems to Mount Standard, Encrypted and Network File Systems on Demand 
----------------------------------------------------------------------------------
    
- NFS: `[NFS_SERVER_IP]:/[NFS_SHARE] [mount_path] nfs [mount_opts] [fs_freq] [fs_passno]`
- Samba: 
    - `echo "username=[user]" > [/path/to/credentials]/.smbcredentials`
    - `echo "password=[password]" >> [/path/to/credentials]/.smbcredentials`
    - `echo "\\[SAMBA_SERVER_IP]/[SAMBA_SHARE] [mount_path] cifs credentials=[/path/to/credentials]/.smbcredentials,[mount_ops] [fs_freq] [fs_passno]`

- `umount -a; mount -a`, umount and mount all devices on `/etc/fstab`

    
Diagnose and Correct Filesystem Problems 
----------------------------------------
    

• fsck: check and repair linux filesystems.
    o can only be run against unmounted filesystems.
    o can only be run by root/sudo users.
    o -a: (-p is current) automatically repair any issues that fsck runs into.
         most common issues are related to minor filesystem corruption or 
        filesystem cache flush issues, causes orphaned inodes.
         journaled filesystems (ext3/4) and extended attributes allow these 
        inodes to be deleted and files recreated during repair.
    
- fsck   /dev/xvdf, checks if there's any errors.
    - 0 – No errors.
    - 1 – Filesystem errors corrected
    - 2 – System should be rebooted
    - 4 – Filesystem errors left uncorrected
    - 8 – Operational error
    - 16 – Usage or syntax error
    - 32 – Fsck canceled by user request
    - 128 – Shared-library error
Design and Test Backup/Recovery Strategies - Part I 
---------------------------------------------------
    
- Image file: `dd if=[input_device] of=[output_file].img`
- ISO file: `dd if=[input_device] of=[output_file].iso`
    
Design and Test Backup/Recovery Strategies - Part II 
-----------------------------------------------------
    
- Image file: `dd if=[file].img of=[output_device]`
- ISO File: `mount -o loop [file].iso [mount_path]`


    

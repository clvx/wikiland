Managing MBR and GPT Partitions
===============================

MRB = Master Boot Record
========================
- MBR allows us to identify how and where to boot one or more operating systems.
- It is the first thing that loads after the BIOS during boot.
- Located in the first section of the partition(512 sector disk).
- Overwriting this set of blocks (the first 512) can cause our system not to boot.
- Was only created initially to deal with 1GB but currently is limited to 2TB disk sizes.
- Limited to four primary partitions, up to 2TB.
- MBR = 32 bit Base Blocks
- Uses fdisk to create partitions.

GPT = GUID Partition Table
- GUID = Globally Unique Identifier
==========================
- Up to 9.4ZB(Zetabytes) Partitions.
    - 1000GB = 1TB (Terabyte).
    - 1000TB = 1PB (Petabyte).
    - 1000PB = 1EB (Exabyte).
    - 1000EB = 1ZB (Zetabyte).
- GTP = 64 bit Base Blocks.
- 128 Unique Primary Partitions (GUID).
- Part of UEFI (Universal Extensible Firmware Interface) replacing BIOS(Basic Input Output System).
- Backwards compatible.
- Uses gdisk to create paritions.
- GPT Boot Record Secured = prevents booting issues by using protected mode boot records.

Managing MBR Partitions With fdisk
=================================

$sudo fdisk [device], opens a dialog-driven program for creation of partition tables.
n, adds a new partition
- partition type, p for primary, e extended. 
- partition number (up to 4)
- First sector (where to begin the partition)
- Last sector (where to end the partition)
t, changes a partition's system id
- partition number
- partition type by hex code
w, to write changes

$sudo mkfs -t [vfstype] [device]
$sudo partprobe [device], is a program that informs the operating system kernel of partition table changes.

Managing GPT Partitions With gdisk
==================================

$sudo gdisk [device], GPT fdisk (aka gdisk) is a text-mode menu-driven program for creation and manipulation of partition tables.
- It will automatically convert an old-style Master Boot Record (MBR) partition table or BSD disklabel stored without an MBR carrier partition to the newer Globally  Unique  Identifier  (GUID) Partition Table (GPT) format, or will load a GUID partition table,
n, adds a new partition
- partition number (up to 4)
- First sector (where to begin the partition)
- Last sector (where to end the partition)
- partition type by hex code
w, to write changes

$sudo mkfs -t [vfstype] [device]
$sudo partprobe [device], is a program that informs the operating system kernel of partition table changes.

ReiserFS and Btrfs File Systems
===============================

ReiserFS:
Overview:
    - General purpose filesystem
    - Jounaled (for recovery)
    - Supported by all major distributions
    - Stable
Features:
    - Metada only jounaling.
    - Does not support quota.
    - Online resizing(growth only, not shrinking, with or without LVM), in other words, change the size while it's mounted.
    - Internal fragmentation reduced by a method called "tail packing"
    - Performance compared to EXT2/3 with smaller files (4kb or less) was noticeably faster.

BtrFS:
Overview:
    - Stands for "B-tree File System"
    - Designed to address the lack of pooling, snapshot and checksums in other filesystems at the time.
    - Intended to be highly scalable in order to meet the growing filesystems of Linux.
    - In developing.

Features:
    - Self healing in some configurations as a result of "copy-on-write". 
        - copy-on-write or COW,f multiple callers ask for resources which are initially indistinguishable, you can give them pointers to the same resource. This function can be maintained until a caller tries to modify its "copy" of the resource, at which point a true private copy is created to prevent the changes becoming visible to everyone else. 
    - Full growth and shrink support for online filesystems.
    - Online defragmentation.
    - On balancing (moving objects between block devices to balance load).
    - Offline filesystem check (fsck with btrfs kernel support).
    - Snapshots (read-only) for rollback.
    - Checksum support for data AND metadata.
    - Out-ofband de-duplication support.
    - In place, onlince conversion supported from EXT3/4 filesystems!

Using Parted
============

$parted [device], is  a  program  to manipulate disk partitions.  It supports multiple partition table formats, including MS-DOS and GPT.  It is useful for creating space for new operating systems, reorganising disk usage, and copying data to new hard disks.

help
print, display the partition table, available devices, free space, all found partitions, or a particular partition.
mklabel LABEL-TYPE, create a new disklabel(partition table) - gpt or msdos on LABEL-TYPE. 
mkpart PART-TYPE [FS-TYPE] START END, makes a partition where PART-TYPE might be primary, logical or extended, FS-TYPE is one of the supported filesystem listed on /proc/filesystems, START and END are disk locations, such as 4GB or 10%.
quit, to exit the menu.

A Look at LVM (Logical Volume Manager)
======================================

LVM allows tthe creation of a layer of abstraction that is over the physical storage. This then allows the creation of "logical volumes". A single logical volume can span across multiple "physical" storage devices thus removing the limit of physical disk sizes. The configuration of the storage is separate or "abstracted" from the physical layer. Any physical storage configuration is hidden from the software configuration allowing the logical volume to be resize and moved without affecting the application.

Application -> Logical Volumes -> Volume Groups -> Physical Volumes 

- Easy to resize storage pools.
- Online data relocation
    - Move data while the system is active or rearrange data on disks (MBR to GPT).
- Increase throughput with disk stripping.
    - A logical volume can stripe data across two or more disks (faster i/o).
- Volume snapshots.



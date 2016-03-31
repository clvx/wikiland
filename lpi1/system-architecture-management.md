/sys, /proc, /dev and /var
==========================

• /dev
    ◦ everything in linux is a file or directory, even if they are unusual.
    ◦ /dev is a directory of special ‘device’ files that refer to the various components that are installed (and have an associated kernel module or native support) or could be installed (no module or built in kernel support for).
    ◦ commands can be piped to or take input from some special device files:
        ▪ cat somefilename.txt > /dev/null will copy the file contents to the void.
        ▪ cat /dev/random > somefile.txt will copy randomly generated content (using entropy) to the file named somefile.txt.
        ▪ cat somesnd.wav /dev/snd/mixer will play the sound file, unbuffered, directly to the current sound device.
• /var
    ◦ the place to look for various system items:
        ▪ cache
        ▪ logs
        ▪ mysql
        ▪ libraries
        ▪ default website installation location
• /proc
    ◦ following the ‘everything is a file’ convention established, this directory lists the currently running as well as information on various system components and configurations
        ▪ /proc/cpuinfo – information about CPU.
        ▪ /proc/meminfo – memory information.
        ▪ /proc/loadavg – average system load.
        ▪ /proc/version – current linux version.
    ◦ numbered subdirectories correspond to the PID for running processes.
        ▪ ps aux | grep command will give you a PID for that command.
        ▪ /proc/1234 will contain information for PID 1234 application, such as:
            • cwd – link to the current working directory of the process.
            • exe – link to the executable.
            • root – root process directory.
            • environ – environment variables.
• /sys
    ◦ directory of normal and special files that contains the kernel, firmware and other related files.
    ◦ sometimes referred to as a virtual filesystem that is used to export data from the kernel to ‘userspace’ applications – recently added functionality.
    ◦ references to multiple system configuration files, devices and special configurations related to your system.

- Linux treats everything on its system as if it were a file. 
- sysfs, is a virtual file system provided by Linux. sysfs provides a set of virtual files by exporting information about various kernel subsystems, hardware devices and associated device drivers from the kernel's device model to user spac
- sysfs, stores all the current  available devices in the system.
- procfs, provides information on the processes that are running in the system. 
- procfs, s a special filesystem in Unix-like operating systems that presents information about processes and other system information in a hierarchical file-like structure, providing a more convenient and standardized method for dynamically accessing process data held in the kernel than traditional tracing methods or direct access to kernel memory.
- /dev, contains special files that are direct hardware references to the components that are installed in the system.
- /dev/ttyX, is a special file, representing the terminal for the current process. So, when you echo 1 > /dev/tty, your message ('1') will appear on your screen. Likewise, when you cat /dev/tty, your subsequent input gets duplicated (until you press Ctrl-C).
- /dev/urandom, /dev/random, The character special files /dev/random and /dev/urandom (present since Linux 1.3.30) provide an interface to the kernel's random number generator.  The  random  number  generator  gathers environmental noise from device drivers and other sources into an entropy pool.  The generator also keeps an estimate of the number of bits of noise in the entropy pool.  From this entropy pool random numbers are created.
- /var, contains variables file and content which is expected to change constantly during the running life of the system.. 
- /var/log, contains log files.
- /var/spool, contains spools for processes that need them(cron, cups, mail, etc.). 

[ lsmod ]
=========
• Simple utility that lists all the currently enabled modules on your system.
• Basically formats the contents of the /proc/modules filesystem so that it is easier to read.
    ◦ similar to ‘modprobe –l’ but only listing actively loaded modules.
- lsmod, is  a  trivial  program which nicely formats the contents of the /proc/modules, showing what kernel modules are currently loaded.
- /proc/modules, This file displays a list of all modules loaded into the kernel. Its contents vary based on the configuration and use of your system.

[ lspci and lsusb ]
===================

• More specific utilities that will list both the existing PCI and USB components on a system.
• lspci:
    ◦ -v, -vv, -vvv – various levels of verbosity in reporting the devices in this system.
    ◦ -n – will show the PCI vendor and device codes as numbers, will not look up the values in the configuration listing.
    ◦ -x, -xxx, -xxxx – shows increasing levels of hexadecimal information regarding the device in the PCI, PCI-X and PCI-X 2.0 standards.
    ◦ -b – shows a ‘bus centric’ view, including IRQ information and addresses as found.
    ◦ -t – tree diagram by bus and type of all devices.
    ◦ -i filename – default file of /usr/share/hwdata/pci.ids is normally used to look up vendor:deviceid values and assign them a name, passing this parameter and a different file can override that information.
    ◦ -m – dump the information in ‘machine readable’ format, each field enclosed in quotes, for easy parsing via scripts or inserts into database.
• lsusb
    ◦ -v – verbose output.
    ◦ -t – tree diagram by bus and type, useful to display which USB devices are connected to which USB root or extended hubs.
    ◦ -d vendor:product – show devices with the vendor and product ID specified, shown in hexadecimal only.

- lspci, is a utility for displaying information about PCI buses in the system and devices connected to them.
- lsusb, is a utility for displaying information about USB buses in the system and the devices connected to them.
- lspci -n,  Show PCI vendor and device codes as numbers instead of looking them up in the PCI ID list.
- lpsci -v, Be verbose and display detailed information about all devices.
- lspci -x, Show  hexadecimal  dump of the standard part of the configuration space.
- lspci -b, Bus-centric  view.  Show all IRQ numbers and addresses as seen by the cards on the PCI bus instead of as seen by the kernel.
- lspci -t, shows bus infomation in a tree view
- lspci -s [domain],  Show only devices in the specified domain.
- /usr/share/hwdata/pci.ids, is is a repository of known ID's used in PCI devices: ID's of vendors, devices, subsystems and device classes. It is used in various programs to display full human-readable names instead of cryptic numeric codes.
- lspci -m, Dump PCI device data in a backward-compatible machine readable form.
- lsusb -v,  Tells  lsusb  to  be  verbose and display detailed information about the devices shown.
- lsusb -s [devnum], Show only devices in specified bus and/or devnum.  Both ID's are given in decimal and may be omitted.
- lsusb -t, Tells lsusb to dump the physical USB device hierarchy as a tree.

[ modprobe and insmod ]
=======================

• modprobe –l
    ◦ will list all ‘available’ modules on a system, not necessarily active, which is where lsmod comes in above.
• install a new module:
    ◦ modprobe [modulename]
        ▪ no output returned if successful.
        ▪ -v will attempt to force verbose output on error.
• lsmod [modulename]
    ◦ will confirm that loaded module above is now active.
• remove an existing module:
    ◦ modprobe –r [modulename]
        ▪ no output unless the module is not loaded, then message indicating such
            • modprobe = insmod
            • modprobe –r = rmmod

- modprobe, intelligently adds or removes a module from the Linux kernel: note that for convenience, there  is  no  difference  between  _  and  - in module names.  modprobe looks in the module directory /lib/modules/'uname -r' for all the modules and other files, except for the  optional  /etc/modprobe.conf  configuration  file  and  /etc/modprobe.d  directory.
- modprobe -l, is deprecated in modern distribution instead use lsmod.
- modeprobe -r [module], This option causes modprobe to remove rather than insert a module. If the modules it depends on are also unused, modprobe will try to remove them too
- modeprobe [module], adds a module.
- insmod [path_to_module], inserts a module, deprecated because is not a smart enough utility.

Grub Boot loader
================

- grub, default boot loader. 
- /etc/default/grub, grub configuration file for how your system uses grub.
- /etc/grub.d/, how you menuing system is buit.
- update-grub, regenerates the grub configuration file, and rediscovers all the images there are configured for the system.
- The menuing system, is a number of files based on the order they appear in /etc/grub.d/ rather than a single configuration file used to be that it was all contain in a file called /boot/grub/menu.lst and you can make your changes for your menu directly from that file and it will pick up in the next boot and show up in your menu.
- Revisar: https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/ch-Working_with_the_GRUB_2_Boot_Loader.html 


[ Differentiate and Optimize Storage and Input ]
================================================
- /dev/fdN, defines a floppy disk drive.
- /dev/sdaN, defines a sata disk drive.
- /dev/srN, defines a cdrom disk drive.
- /etc/fstab. contains descriptive information about the filesystems the system can mount. fstab is only read by programs, and not written; it is the duty of the system administrator to properly create and maintain this file. Each filesystem is described on a separate line.  Fields on each line are separated by tabs or spaces.  Lines starting  with  '#'  are comments.  Blank lines are ignored.
- - Syntax: fs_spec  fs_file      fs_vfstype    fs_mntops      fs_freq  fs_passno
- In /etc/fstab each drive can be referenced in different device files  when is plugged or unplugged that's why using UUID to define how to mount a disk is a better option. 2 ways to obtain the UUID:
- 1. using the blkid program which determines the type of content (e.g. filesystem or swap) that a block device holds.
- 2. ls -la /dev/disk/by-uuid/ and checking which uuid is linked to a device file. 

[ Differentiate and Demonstrate Hot and Cold Plug Devices ]
- Cold plug device, any device that can only be connected or disconnected when powered off.(CPU, memory, Non-USB Storage Devices, PCIe/PCI Expansion Cards).
- - Each of these devices will be present as a file(when working or recognized) in the special /dev directory.
- - ONLY the kernel itself can talk directly to hardware, through a module/driver or built in support.
- Hot Plug Device, are devices that can be connected and disconnected at any time and have either built in support or a loadable module available for them to function(USB Hard Drive, USB Memory Stick, Firewaire Devices).. 
- - Linux treats everything as a file or folder BUT each possible device that can be added or removed dynamically cannot be listed in a filesystem. 
- - A Hot Plug Device has an entry created for it in the /dev directory when it is detected, instead of cold plug device has a pre-existing entry in the /dev directory that CAN represent it if it is present.
- - 2 processes to manage Hot Plug Devices:
- --- HAL(Hardware Abstraction Layer), is responsible for picking up these Hot Plug Devices and reacting to them(recognizing and loading a module or logging it as unrecognized).
- --- Then DBUS(Desktop Bus), is resnponsible for telling other processes about the newly discovered device.
    
[ Determine Hardware Device Resources ]
=======================================
- procfs, is a virtual filesystem that contains the files and references to all the devices and resources on the computer.
- /proc/mounts, With the introduction of per-process mount namespaces in Linux 2.4.19, this file became a link to /proc/self/mounts, which lists the mount points of the process's own mount namespace.
- /proc/cpuinfo, This is a collection of CPU and system architecture dependent items, for each supported architecture a different list.
- /proc/iomem, I/O memory map, memory allocation.
- /proc/interrupts, This is used to record the number of interrupts per CPU per IO device.
- /proc/version, This string identifies the kernel version that is currently running. It includes the contents of /proc/sys/kernel/ostype, /proc/sys/kernel/osrelease and /proc/sys/kernel/version

[ Filesystem Hierarchy Standard ]
- /bin, contains commands that may be used by both the system administrator and by users, but which are required when no other filesystems are mounted (e.g. in single user mode). It may also contain commands which are used indirectly by scripts.
- /boot, This directory contains everything required for the boot process except configuration files not needed at boot time and the map installer. Thus /boot stores data that is used before the kernel begins executing user-mode programs.
- /dev, directory is the location of special or device files.
- /etc, hierarchy contains configuration files. A "configuration file" is a local file used to control the operation of a program; it must be static and cannot be an executable binary
- /etc/opt, Host-specific configuration files for add-on application software packages must be installed within the directory /etc/opt/<subdir>
- /etc/X11, is the location for all X11 host-specific configuration.
- /home,  User home directories.
- /lib,  /lib64, directory contains those shared library images needed to boot the system and run the commands in the root filesystem, ie. by binaries in /bin and /sbin.
- /media, This directory contains subdirectories which are used as mount points for removeable media such as floppy disks, cdroms and zip disks.
- /mnt, This directory is provided so that the system administrator may temporarily mount a filesystem as needed. The content of this directory is a local issue and should not affect the manner in which any program is run.
- /opt, /opt is reserved for the installation of add-on application software packages.
- /root, The root account's home directory may be determined by developer or local preference, but this is the recommended default location.
- /sbin, Utilities used for system administration (and other root-only commands) are stored in /sbin, /usr/sbin, and /usr/local/sbin. /sbin contains binaries essential for booting, restoring, recovering, and/or repairing the system in addition to the binaries in /bin. [18] Programs executed after /usr is known to be mounted (when there are no problems) are generally placed into /usr/sbin. Locally-installed system administration programs should be placed into /usr/local/sbin.
- /srv, contains site-specific data which is served by this system. 
- /tmp, directory must be made available for programs that require temporary files.  Programs must not assume that any files or directories in /tmp are preserved between invocations of the program.
- /usr, is the second major section of the filesystem. /usr is shareable, read-only data. That means that /usr should be shareable between various FHS-compliant hosts and must not be written to. Any information that is host-specific or varies with time is stored elsewhere.
- /usr/bin, Most user commands.
- /usr/include, This is where all of the system's general-use include files for the C programming language should be placed.
- /usr/lib includes object files, libraries, and internal binaries that are not intended to be executed directly by users or shell scripts
- /usr/local, hierarchy is for use by the system administrator when installing software locally. It needs to be safe from being overwritten when the system software is updated. It may be used for programs and data that are shareable amongst a group of hosts, but not found in /usr.
- /usr/sbin, This directory contains any non-essential binaries used exclusively by the system administrator. System administration programs that are required for system repair, system recovery, mounting /usr, or other essential functions must be placed in /sbin instead.
- /usr/share, hierarchy is for all read-only architecture independent data files
- /var, /var contains variable data files. This includes spool directories and files, administrative and logging data, and transient and temporary files. var is specified here in order to make it possible to mount /usr read-only.
- /var/cache, is intended for cached data from applications. Such data is locally generated as a result of time-consuming I/O or calculation. The application must be able to regenerate or restore the data.
- /var/lib, This hierarchy holds state information pertaining to an application or the system. State information is data that programs modify while they run, and that pertains to one specific host. Users must never need to modify files in /var/lib to configure a package's operation.  State information is generally used to preserve the condition of an application (or a group of inter-related applications) between invocations and between different instances of the same application. State information should generally remain valid after a reboot, should not be logging output, and should not be spooled data.
- /var/lock, Lock files should be stored within the /var/lock directory structure.
- /var/log, This directory contains miscellaneous log files. Most logs must be written to this directory or an appropriate subdirectory.
- /var/mail, The mail spool must be accessible through /var/mail and the mail spool files must take the form <username>. [41]
- /var/opt, Variable data of the packages in /opt must be installed in /var/opt/<subdir>
- /var/run, Run-time variable data.T his directory contains system information data describing the system since it was booted. Files under this directory must be cleared (removed or truncated as appropriate) at the beginning of the boot process.
- /var/spool, contains data which is awaiting some kind of later processing.

[ System Boot Process ]
=======================
- /var/log/dmesg, contains boot log information.
- Linux boot process:
1. System startup: BIOS/Bootmonitor.
2. Stage 1 Bootloader: Master Boot Record. Installed generally in sector 0 of the hard drive.  Identifies where the boot loader is installed. 
3. Stage 2 Bootloader: LILO, Grub, Defines where on the partition scheme the kernel exists.
4. User space starts, it runs the init process or process id 1.
- In grub to modify parameters: 
1. Press e in the kernel list to change the parameters.
2. Press e in the kernel image to modify parameters at boot time. 
3. Add or modify parameters as require like init=single or init=/bin/bash to enter in single mode on red hat derivates. 

[ Init and Telinit ]
====================
runlevels:
- init 1: single user mode.
- init 2: special movde.
- init 3: full user mode without gui.
- init 4: special mode.
- init 5: full user mode with gui.
- init 6: reboot
telinit [RUNLEVEL], may be used to change the system runlevel.

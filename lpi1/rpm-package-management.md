RPM Package Management 
======================

- RPM Package Naming Convention: rpm-package-name.versionumber-buildnumber.architecture.rpm
- RPM packages are built from CPIO archives.
    - To extract the files from an RPM package without installing the rpm use the program rpm2cpio.
        - man rpm2cpio for syntax.
    - CPIO program takes the -i flag to extract contents of the archive.
        - Step 1: rpm2cpio.
        - Step 2: cpio -i -make-directories < archivename.cpio
- Common RPM operations:
    - -h: Displays progress.
    - --nodeps: Don't check for package dependencies.
    - --test: checks the install operations for issues without installing.
    - --prefix path: sets path for installation.
    - -a: verifies all packages.
    - -i: displays package information.
    - -R: displays files and packages that the package depends on.
    - -l: display the contents/files of the package(important)
- Common RPM options:
    - -i: installs RPM package. Package names must be unique to system.
    - -U: upgrades or installs a NEW package.
    - -F: upgrades a package only if and older version exists.
    - -q: queries a package to determine if it is already installed on system.
    - -e: Uninstalls a package.
    - -b: builds binary package.
    - --rebuild: rebuilds a package.
    - --rebuilddb: rebuilds rpm database.
- rpm -qi: verifies that a package is installed.

- rpm - RPM Package Manager. 
- used by: RHLE, CentOS, Mandriva, SuSE, YellowDog
- yum - Yellowdog Updater Modified, is  an interactive, rpm based, package manager. It can automatically perform system updates, including dependency analysis and obsolete processing based on "repository" metadata. It can also perform installation of new packages, removal of old packages and perform queries  on the  installed and/or available packages among many other commands/services.
- packages must be unique in the system.
- rpm -ihv [package-name], installs a package displaying progress verbously. 
- rpm -Uvh, This  upgrades  or installs the package currently installed to a newer version.  This is the same as install, except all other version(s) of the package are removed after the new package is installed, displaying progress verbously.
- rpm -qi [package-name], queries information about a package and displays installation information. 
- rpm -q --list [package-list], list files in the package, all the files asociated with the package. 
- rpm -q --requires [package-name], lists all the package dependencies.
- rpm --rebuilddb, rebuilds rpm database.
- rpm --erase, -e, removes a package.
- rpm -qa, prints all the installed packages.
- rpm -F [package], upgrades a package only if an older version exists.
- rpm -qpl [package],  lists all files in a RPM package

YUM Software Management
=======================


- yum, Yellowdog updater Modified, is  an interactive, rpm based, package manager. It can automatically perform system updates, including dependency analysis and obsolete processing based on "repository" metadata. It can also perform installation of new packages, removal of old packages and perform queries  on the  installed and/or available packages among many other commands/services.
- /etc/yum.conf, configuration file for yum. Additional  configuration  files  are  also  read  from the directories set by the reposdir option (default is `/etc/yum.repos.d')
- yum update, If run without any packages, update will update every currently installed package.  If one or more  packages  or  package  globs  are specified,  Yum  will only update the listed packages.  While updating packages, yum will ensure that all dependencies are satisfied.
- yum check-update, checks if there's any update.
- yum install [package], installs a package.
- yum search [pattern], By default search will try searching just package names and summaries, but if that "fails" it will then try descriptions and url
- yum upgrade, upgrades a package.
- yum remove [package], Are used to remove the specified packages from the system as well as removing any packages which depend on the package being removed.
- yum info [package], displays summary information about a package.
- yum deplist [package], Produces  a  list  of  all dependencies and what packages provide those dependencies for the given packages.
- yum clean all, cleans all the cache. 
- yum list installed, lists all installed packages.
- yum autoremove [package], deletes a package and its configuration files.

yumdownloader & rpm2cpio
========================

- yumdownloader [package] - download RPM packages from Yum repositories.
- yumdownloader --resolver [package], When downloading RPMs, resolve dependencies and also download the required packages.
- rpm2cpio [package], rpm2cpio converts the .rpm file specified as a single argument to a cpio archive on standard out. If a '-' argument is given, an rpm stream is read from standard in.

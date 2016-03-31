Apt-Get Command Set
===================
• permissions
    ◦ easiest to run sudo or change to root level account before.
• sources.list
    ◦ contains the list of repositories that you can download content from.
    ◦ sources section list allows download of source code for packages.
    ◦ packages section allow the binary packages.
• apt-get update
    ◦ updates the repository list cache, making available packages for installation from any of those configured repositories.
• apt-get upgrade
    ◦ upgrades your distribution packages, i.e., if there are updates for packages you have installed then it will list and offer to install them.
• apt-get dist-upgrade
    ◦ will offer to upgrade your distribution from one version to another if another ‘released’ version is available, beta versions can also be installed but require a configuration change in the repos file.
• apt-get install
    ◦ this command will install whatever package(s) that you indicate directly following along with the dependencies for it.
• apt-get remove
    ◦ this command will remove whatever package(s) that you indicate directly following along with dependencies that are no longer needed by any other installed packages.
• apt-get source 
    ◦ this command will install whatever source package(s) that you indicate directly following.
• apt-get check
    ◦ will check to be sure all application dependencies have been installed for all packages.
• apt-get clean
    ◦ will clean the apt cache and require a run of the ‘apt-get update’ command to further install packages.
• apt-get autoremove
    ◦ will remove packages that are no longer needed for various reasons (upgrades,manual removal/uninstallation, etc) that did not get cleaned up as part of post-install.
• apt-get ... -q
    ◦ quietly complete the command, output suitable for logging, no progress indicators.
• apt-get ... -y
    ◦ answer affirmative to any necessary confirmation questions for install/remove/etc.
• apt-get ... -s
    ◦ simulates the installation/removal of the package(s) in question along with a list of the dependencies affected.
•  `apt-get download [package]`
    ◦ downloads a package only without dependencies.
- `apt-get changelog [package]`
    ◦ shows package changelog.

- package manager, allows search repositories and download programs to the system. 
- /etc/apt/sources.list, is designed to support any number of active sources and a variety of source media. The file lists one source per line, with the most preferred source listed first. The information available from the configured sources is acquired by apt-get update
- only trusted sources to improve security.
- sudo apt-get update; updates the repositories cache/information database.
- sudo apt-cache search [pattern],  looks up for a pattern.
- apt-get clean,  clean clears out the local repository of retrieved package files. It removes everything but the lock file from /var/cache/apt/archives/ and /var/cache/apt/archives/partial/.
- sudo apt-get autoclean,  Like clean, autoclean clears out the local repository of retrieved package files. The difference is that it only removes package files            that can no longer be downloaded, and are largely useless. This allows a cache to be maintained over a long period without it growing out of control.
- apt-get -s install [package],  performs a simulation of events that would occur but do not actually change the system.
- apt-get -y install [package],  Automatic yes to prompts; assume "yes" as answer to all prompts and run non-interactively.
- apt-get source [package], fetchs package source code. APT will examine the available packages to decide which source package to fetch. It will            then find and download into the current directory the newest available version of that source package while respecting the default release.
- apt-get dist-upgrade, dist-upgrade in addition to performing the function of upgrade, also intelligently handles changing dependencies with new versions of            packages; apt-get has a "smart" conflict resolution system, and it will attempt to upgrade the most important packages at the expense of            less important ones if necessary. The dist-upgrade command may therefore remove some packages. The /etc/apt/sources.list file contains a            list of locations from which to retrieve desired package files.
- apt-get upgrade, upgrade is used to install the newest versions of all packages currently installed on the system from the sources enumerated in /etc/apt/sources.list. It doesn't remove or install new packages.

Apt-Cache Package Management
============================

- apt-cache, allows create a repository information of all packages available through our /etc/sources.list file. 
- apt-get update,  update is used to resynchronize the package index files from their sources. The indexes of available packages are fetched from the            location(s) specified in /etc/apt/sources.list
- apt-cache stats, stats displays some statistics about the cache.
- apt-cache depends, shows a listing of each dependency a package has and all the possible other packages that can fulfill that dependency.
- apt-cache pkgnames [prefix], This command prints the name of each package APT knows. The optional argument is a prefix match to filter the name list.
- apt-cache unmet, displays a summary of all unmet dependencies in the package cache.
- apt-cache showpkg [package..], displays information about the packages

DPKG Command Set
================

• dpkg
    ◦ used to manually install individual *.deb packages outside of a repo download.
    ◦ note: this utility does NOT automatically install dependencies, although it will list those that are missing as part of the output.
        ▪ this is resolved by either:
            • running ‘apt-get install –f’ after attempted installation which will download and install the missing dependencies and then complete the post-installation script that failed earlier.
            • running ‘apt-get install package.deb’ will allow apt-get to scan for dependencies and install and configure them as part of the process.
• package downloads
    ◦ multiple methods to download packages outside of apt-get.
        ▪ http/https
        ▪ wget
• dpkg –i package.deb
    ◦ the actual installation command, again note, dependencies not included.
    ◦ be sure to understand if SUDO is required for the package installation to succeed, will be different for each package.
• dpkg –get-selections
    ◦ shows all installed packages on the system.
    ◦ when looking for a specific package, follow with ‘| grep text’ to filter.
• dpkg –L packagename
    ◦ lists all the files that were installed along with the package name as well as their location on the system.
• dpkg –C
    ◦ audits for partially installed packages.
• dpkg –remove packagename
    ◦ removes the referenced package, again note, dependencies no longer needed will NOT be removed.
• dpkg –purge packagename
    ◦ will purge the package, along with all configuration files related to that package during a removal.
• dpkg –reconfigure packagename
    ◦ will allow the reconfiguration, including configuration of the package referenced.

- dpkg, is  a tool to install, build, remove and manage Debian packages.
- sudo apt-get -f upgrade;  -f, --fix-broken, attempts to correct a system with broken dependencies in place. This option, when used with install/remove, can omit any packages to permit APT to deduce a likely solution. If packages are specified, these have to completely correct the problem.
- sudo dpkg -i, install a package.
- dpkg ---get-selections [package-name-pattern...],  Get list of package selections, and write it to stdout. Without a pattern, non-installed packages will not be shown.
- dpkg -L [package name],          List files installed to your system from package-name.
- dpkg-reconfigure [package-name], reconfigure an already installed package. 
- dpkg --remove [package-name], Remove an installed package. -r or --remove remove everything except conffiles. This may avoid having to reconfigure the  package  if it  is  reinstalled  later
- dpkg --purge [package-name], removes everything, including conffiles.
- dpgk -l [package-name-pattern], List packages matching given pattern.

Summary & Overview of aptitude and dselect
==========================================

• dselect
    ◦ high level package browser.
    ◦ allows selection and installation/removal of packages in a terminal using an ‘ncurses’ menu system (similar to the text browser ‘lynx’).
    ◦ installs with a simple ‘sudo apt-get install dselect’.
aptitude
    ◦ similar to dselect in that it is a high level package browser.
    ◦ allows a more familiar package selection and installation/removal of packages, using ‘ncurses’ but there are a large number of Gnome/KDE/general GUI managers that work with aptitude.
    ◦ aptitude update: will update sources.
    ◦ aptitude search: search for the package indicated.
    ◦ aptitude can be used as a replacement for ‘apt-get’ as it does do everything that ‘apt-get’ does, including install and manage dependencies.
    ◦ aptitude autoclean: same as apt-get.
    ◦ aptitude remove: same as apt-get.
    ◦ aptitude autoremove: same as apt-get.

- aptitude, high-level interface to the package manager.


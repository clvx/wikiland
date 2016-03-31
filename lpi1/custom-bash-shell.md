Customizing The Bash Shell
==========================

Environment Variables, Aliases And Shell Configuration Files
============================================================
TERM, terminal color.
SHELL, define shell for a user.
PATH, define comand path.
MAIL, mail spool for a user.
LANG, define language for a user.
PWD, current working directory for a user.
HOME, current home for a user.
USER, current user.
PS1, default bash prompt.
HOSTNAME, system hostname.
EDITOR, defines which editor bash will use.
export VAR=value, If a variable  name is followed by =word, the value of the variable is set to word.

~/.bash_history, contains all the commands that we've typed on the shell.
~/.bash_logout, perfoms whatever is inside of the script after logout is issued.
~/.bash_profile, stores configuration parameters for a users with an interactive shell only.
~/.bashrc, stores individual configuration parameters for this user for interactive and non-interactive shells.
/etc/bash.bashrc, stores global configuration parameters for all users for interactive and non-interactive shells.
/etc/profile, stores global configuration parameters for all users with an interactive shell only.

Modifying Bash Shell Configuration Files
========================================

An alias is a shortcut for a command line. 
$alias alias_var=alias_value
Add in ~/.bashrc, or /etc/bash.bashrc or /etc/bashrc  or /etc/profile or ~/.bash_profile to keep aliases persistent.

/etc/skel/, when a user it's created, it obtains default configuration files from /etc/skel directory copied into the user's home directory.

Learn How to Change The Bash Prompt
===================================

PROMPTING, When executing interactively, bash displays the primary prompt PS1 when it is ready to read a command, and the  secondary  prompt  PS2 when it needs more input to complete a command.  Bash allows these prompt strings to be customized by inserting a number of backslash  escaped special characters that are decoded as follows:
    \a     an ASCII bell character (07)
    \d     the date in "Weekday Month Date" format (e.g., "Tue May 26")
    \D{format}
           the format is passed to strftime(3) and the result is inserted into the prompt string; an  empty  format  results  in  a
           locale-specific time representation.  The braces are required
    \e     an ASCII escape character (033)
    \h     the hostname up to the first `.'
    \H     the hostname
    \j     the number of jobs currently managed by the shell
    \l     the basename of the shell's terminal device name
    \n     newline
    \r     carriage return
    \s     the name of the shell, the basename of $0 (the portion following the final slash)
    \t     the current time in 24-hour HH:MM:SS format
    \T     the current time in 12-hour HH:MM:SS format
    \@     the current time in 12-hour am/pm format
    \A     the current time in 24-hour HH:MM format
    \u     the username of the current user
    \v     the version of bash (e.g., 2.00)
    \V     the release of bash, version + patch level (e.g., 2.00.0)
    \w     the current working directory, with $HOME abbreviated with a tilde (uses the value of the PROMPT_DIRTRIM variable)
    \W     the basename of the current working directory, with $HOME abbreviated with a tilde
    \!     the history number of this command
    \#     the command number of this command
    \$     if the effective UID is 0, a #, otherwise a $
    \nnn   the character corresponding to the octal number nnn
    \\     a backslash
    \[     begin a sequence of non-printing characters, which could be used to embed a terminal control sequence into the prompt
    \]     end a sequence of non-printing characters


Bash Lists
==========

A  list  is a sequence of one or more pipelines separated by one of the operators ;, &, &&, or ||, and optionally terminated by one of ;, &, or <newline>

If a command is terminated by the control operator &, the shell executes the command in the background in a subshell.

Commands separated by a ; are executed sequentially; the shell waits for each command to terminate in turn.  The return status is the exit status of the last command executed.

$command1 && command2,  command2 is executed if, and only if, command1 returns an exit status of zero.
$command1 || command2, command2 is executed if and only if command1 returns a non-zero exit status.



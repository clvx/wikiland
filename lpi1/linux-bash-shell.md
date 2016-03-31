
Simple Commands & Shortcuts For The Linux Shell
===============================================

    time [command], meassures how long it takes to run a command.
    pwd, Print the full filename of the current working directory.
    exec [command], replaces the current program in the current process, without forking a new process. 
    - When program terminates it will terminate the shell.
    - We want the user to run a specific application program without access to the shell.
    - We want to use a different shell to the one in /etc/passwd.  'exec $SHELL' >> ~/.login, replaces the current shell with a new shell. 
    - Just to save processes. If we are calling prog1 -> prog2 -> prog3 -> prog4 etc. and never going back, then make each call an exec. It saves resources (not much, it has to be said. unless repeated) and makes shutdown simplier.
    HISTFILE, The name of the file in which command history is saved.  The default value is ~/.bash_history.   If  unset, the command history is not saved when an interactive shell exits.
    HISTFILESIZE, The maximum number of lines contained in the history file. When this variable is assigned a value, the history file is trun‐ cated, if necessary, by removing the oldest entries, to contain no more than that number of lines.

    Shell Shortcuts:
    - crtl + R - in shell allows you to search .history file. (pressing repeatedly will keep searching till you find the command your looking for).
    - crtl + P - Does the same as the up arrow.
    - crtl + N - does the same as the down arrow.
    - crtl + G terminates the search function (escape does the same thing).
    - Crtl + S - Searchs forward in the command history.
    - crtl + A - Move cursor to start of line.
    - crtl + E - Move cursor to end of line.
    - crtl +B - move backward within a line.
    - crtl + F - move forward within a line.
    - crtl +D - deletes characters and moves down the line.
    - crtl + K - deletes the entire line.
    - crtl + X + backspace - deletes all characters from cursors current position back.
    - crtl + T - transpose text moves character down the line.
    - ESC then c will convert the letter above the cursor to upper case.
    - ESC then u will convert the entire word to uppercase esc.
    - history –c will clear all of your history. Good for if your trying to hide command line passwords enetered.

    Each user home directory contains .bashrc and .profile as the main configuration files in bash.
    /etc/profile and /etc/bash.bashrc are the global customizations for all user shells.

Environment Variables, Redirection Operators & Data Pipes
=========================================================

    An environment variable is a named object that contains data used by one or more applications. In simple terms, it is a variable with a name and a value. 
    export VARIABLE=value, sets a temporary environment variable. 
    echo $VARIABLE, to use the variable value. 
    export VARIABLE='value with spaces'
    unset VARIABLE, unsets the variable value(wihout $).
    env, lists all the environment variables set in bash.
    >, redirects stdout 
    2>. redirects stderr
    >>, appends stdout
    2>>, appends stderr
    &>, redirects stdout and stderr
    |, pipes stdout as stdin

    clue: 2 represents standard error.

Manipulating Files
==================

    xargs [command], xargs reads items from the standard input, delimited by blanks (which can be protected with double or single quotes or a backslash) or newlines, and executes the command (default is  /bin/echo) one or more times with any initial-arguments followed by items read from standard input.  Blank lines on the standard input are ignored.
     cat [filename] - concatenate files and print on the standard output
    paste [file1] [file2], pastes the content of each line sequentiantlly corresponding lines from each filename, separated by tabs to stadout. 
    sort [filename], sorts the file content using the first field by default
    splits -l [n] [filename] [prefix], for each n lines splits creates a new file called prefixaa, prefixab, prefixXX, until it completes spliting all the content.  
    - default size to split is 1000 lines. 
    tr [pattern1] [pattern2] < input_file, translates a word  from pattern1 to pattern2 in a file. 
    uniq, Filter adjacent matching lines from INPUT (or standard input), writing to OUTPUT (or standard output).  With no options, matching lines are merged to the first occurrence.
    cat -n [filename], nl [filename], number all output lines.
    fmt - simple optimal text formatter.

File Viewing Commands For The Linux Bash Shell 
==============================================

    head [file], prints  the  first 10 lines of each FILE to standard output.
    head -n [n] [file], prins the first n lines of a file. 
    tail [file], prints the last 10 lines of each file to stdout.
    tail -n [n] [file], prints the last n lines of a file. 
    tail -f|--follow [filename], output appended data as the file grows;
    wc -l filename, counts how many lines filename has.
    wc -L filename, prints the longest line in a file. 
     Sed  is a stream editor.  A stream editor is used to perform basic text transformations on an input stream (a file or input        from a pipeline). 
    sed 's/pattern1/pattern2/' filename, subtitutes the first match of each of pattern1 for pattern2.
    sed 's/pattern1/pattern2/g' filename, subtitutes the all matches of of pattern1 for pattern2 in each line.

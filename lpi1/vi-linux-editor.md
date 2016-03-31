Vi Modes & The importance of Vi
===============================

Command Mode
------------
Command mode accepts commands which are usually in the form of individual letters such as a and i. 
You can use h,j,k,l to navigate files in similar as the up and down arrow keys. 

Insert Mode:
------------
Insert mode allows you to add/edit text inside of the file. As stated under command mode options above, there are different ways to insert into insert mode. Depending on what command is issued depends on how you enter, such as, replacing a word, starting line above or below cursos, etc.

Ex Mode:
--------
You enter ex mode by typing a : This will open on the bottom of the screen a command prompt starting with a : ex mode is used for saving and manipulating files. It is very powerful; you can even browse the Linux command line from this mode, load files into your file, and other powerful actions. You must be in command mode before entering ex mode.

- vim - Vi IMproved, a programmers text editor.
- vi modes: visual, command, insert.
- in command mode, use colon ":" to execute commands. 

Vi Commands and Usage
=====================
- h(left) j(down) k(up) l(right), to navigate in vi command mode. 
- shit + l or L, to navigate to the last line of a page.
- shift + h or H, to navigate to the first line of a page.
- shit + g or G, to navigate to the last line of a file.
- n + shift + g or nG, to navigate to a specific line.
- yy, copies the content of the current line. 
- p, pastes the buffer contents  on the bottom line of the current line. 
- p, pastes the buffer contents underneath  the current line.
- u, undos changes. 
- P, pastes the buffer contents above the current line.
- ny, copies n lines to buffer. 
- /pattern, looks for a pattern.
- - n, to find the next ocurrence in search mode. 
- - N, to find the previous ocurrence in search mode.
- dd, deletes the current line.
- ndd, deletes n lines. 
- ?pattern, searchs backwards. 
- ngg, moves cursor to the n line. 
- cc, meaning "change text" removes the "word" your cursor is on and opens insert mode.

- >Insert Mode
- i, on command mode to enter insert mode. 
- esc, to go back from insert mode to command mode.
- cw, enters to insert mode to change a word.
- cc, enters to insert mode to change a line.
- R, replaces text as we are inserting. 

- >exc mode, on command mode enters colon ":". 
- :%s/pattern/pattern/, subtitutes the first ocurrence in every line of the file.
- :%s/pattern/pattern/g, subtitutes every ocurrece(global change) in every line of the file.
- :q!, force quite.
- :q, quits if there are no changes to save. 
- :w, saves changes.
- :wq, saves and quits. 
- :![command], executes a shell command.
- :r [files], loads the contents of a file.

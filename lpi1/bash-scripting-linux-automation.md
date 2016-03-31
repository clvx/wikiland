Inroduction To Bash Scripting And Linux Automation
==================================================

Lesson: Hello Bash! Our First Bash Script
=========================================

bash - GNU Bourne-Again SHell
Bash  is  an sh-compatible command language interpreter that executes commands read from the standard input or from a file.
shebang, #!/bin/bash, If the program is a file beginning with #!, the remainder of the first line specifies an interpreter for the program. 

chmod +x script.sh, adds execute permissions to script.sh

```
#!/bin/bash

tar -cvfz backup.tar.gz /home/user
cp backup.tar.gz /tmp/
echo "Backup is complete"
```
PATH   The search path for commands.  It is a colon-separated list of directories in which the  shell  looks  for  commands. A  zero-length directory name in the value of PATH indicates the currentdirectory.


Running Basic Commands Inside A Bash Script
===========================================
$1, $2, $n, defines one or more command line arguments in a script.
-z string, True if the length of string is zero.

seq FIRST INCREMENT LAST, Print numbers from FIRST to LAST, in steps of INCREMENT.


```
#!/bin/bash

#findlist arg1 arg2 ..
#List all contents in a directory and write the ouput to a file named dir_list.txt
location=${1}
filename=${2}

if [ -z "$location" ]
then
    echo "please provide location"
    exit
fi

if [ -z "$filename" ]
then
    echo "please provide filename"
    exit
fi

ls ${location} >> ${filename}
echo "Script is complete and has indexed ${location}"
echo "###################################"
echo "Displaying contents of ${filename}"
echo "###################################"
cat ${filename}
```


Bash Variables and Script Arguments
==================================

{}, used to unambiguously identify variables.Interprets exactly what it is inside curly braces.
$#, displays number of arguments passed to the script.
(( )), provides aritmethic evaluation. 

```
#!/bin/bash
variable=hello
echo $variable
echo "prints hello"
echo ""
echo $variable12345
echo "prints nothing, because variable1234 is not set"
echo ""
echo ${variable}12345
echo "prints hello12345"

name=$1
username=$2

if (( $# == 0 ))
then
    echo "#####################"
    echo "pinehead [arg1] [arg2]"
    echo "arg1 is your name"
    echo "arg2 is your username"
fi
echo "Your name is ${name} and your username is ${username}" >> yourname.txt
```


Conditions in Bash Scripting
============================
!/bin/bash
#conditions in bash scripting
# [ means test [[ means new test using [ is same as using the command "test" to evaluate.
```
file=myscript

if test -f ${file}
then
    echo "$file is in fact a file"
fi

[ -f $file ] && echo "$file is also a file"

if [ -f $file] 
then 
    echo "third option is also a file"
fi
```

#single bracket if statements refered to as "test" brackets oldest and most compatibal "test"
#basic syntax have to quote strings cannot do file globbing

```
emptystring=""
if [ -z "$emptystring" ]
then
    echo "variable is empty"
else
    echo "Variable is not empty and is set to $emptystring"
fi

if [ "$emptystring" == "" ]
then
    echo "variable is empty"
else
    echo "Variable is not empty and is set to $emptystring"
fi
```
#flag conditions
#-gt = greater than
#-lt = less than
#-ge = greater than equal to
#-le = less than or equal to
#-eq = equal to
#-ne = not equalto
#-f = is file
#-d = is directory
#-l = is symlink

```
if [ 2 -gt 1 ]
then
    echo "two is greater than 1"
fi

if [ 2 -le 2 ]
then
    echo "two is greater than 1"
fi
```

#double test brackets [[ ]]
#[[ allows shell globbing which means an * will expand to literally anything 
#word splitting is prevented so you can omit placing quotes around string variables but it's not best practice

```
if [[ "$mystring" == *mmy* ]]
then
    echo "This determines if the string contains mmy anywhere in it"
fi

if [[ $mystring == *[sS]a* ]]
then
    echo " (notice no quotes) this determines if the string contains sa or Sa anywhere in it"
fi
```

#expanding files names using [[]]
```
#returns true if there is one single file in the current working directory that has .txt in it
if [ -a *.txt ]
then
    echo "* with single test brackets expands to the entire current working directory so it will error if more than 1 file exists"
    echo "there is at least one file that ends with .txt in the dir"
fi

#with double brackets the * is taken literally'then
if [[ -a *.txt ]] 
then
    echo "returns true only if there is a file name *.txt (literally name)"
fi
```

##double brackets allow for && and || 
## double brackets allow for regular expressions using =~ not to be covered in this course
#&& is and for [[ but single test -a also works
#|| is for or and -o for single bracket also works

```
if [[ 2 == 1 && 2 == 2 ]]
then
    echo "True"
else
    echo "False"
fi

if [[ 2 == 1 || 2 == 2 ]]
then
    echo "True"
else
    echo "False"
fi
```

#double parenthesis (( )) used primarly for number based condiations and allows use of >= operators
#Does not let you use flag conditions
#allows the use of && and || but not -a -o
#same as using the let command

Basic Bash Loops
================

Syntax:
#!/bin/bash 
  
#loops  
#for arg in [list]    
#do 
    #commands  
#done   
  
#while [ condtion ] 
#do 
    #commands  
#done   

```
#!/bin/bash
for file in `ls`
do
   echo "the file name is $file" 
done

for db in `echo show databases | mysql`
do
    echo $db
done

if [-f database_lis ]
then
    for db_name in `cat database_list`
    do
        echo create database $db_name | mysql 
    done
fi
```

#let, Each  arg  is an arithmetic expression to be evaluated.  If the last arg evaluates to 0, let returns 1; 0 is returned otherwise.
```
count=0
echo "we are counting to 10"
while [ $count -lt 10 ]
do
    let count=count+1
    echo "our current number is $count"
done
```

Practice Sccripts For Understanding Scripting And Linux Automation: Add Users
=============================================================================
Nada interesante


Functions And Case Expressions
==============================

Functions, allow to write code once and reuse it everytime needed. 
- Variables passed to a function are different from global variables
```
input=$1
input2=$2
function first {
    echo "this is the first function"
}

function second {
    echo "this is the second functions"
}

function input_fn {
    echo "The name you gave me is: $1"
}

first
second

name="clvx"
input_fn ${name}

case $input in
    1)
        first
    ;;
    2)
        second
    ;; 
    3)
        input_fn $input2   
    ;;
    *)
        echo "You didn't select a valid option"
    ;;
esac
```

Accepting User Input In a Script Using Read
===========================================

read, One  line  is read from the standard input, or from the file descriptor fd supplied as an argument to the -u option, and the first word is assigned to the first name, the second word to the second name, and so on, with leftover words and  their  intervening  separators  assigned to the last name. If there are fewer words read from the input stream than names, the remaining names are assigned empty values.
    -t timeout if the input is not given withing a certain time frame the script will move on.
    -n returns after reading n number of characters.
    -r Backslash does not act as an escape character but is instead considered part of the line.

```
echo "**********Todo script**********"
echo -n "what task would you like to add: "

read todo

if [ `grep $todo todo.txt | wc -l` -eq 1 ]
then
    echo "This is already in your list"
else
    echo $todo >> todo.txt
    echo "$todo has been added to your list"
fi
```

Practice Script: Add Users To MySQL From The /etc/passwd/ File
==============================================================
Nada interesante

Creating A Task Script With To Do Lists
=======================================
Nada interesante

Functions Part 2
================
function() { commands }, Another syntax to declare functions is using parenthesis at the end of function name.
```
first() {
    echo "this is the first function"
}

second() {
    echo "this is the second functions"
}

first
second
```

Perform Conditional Mailing To The Superuser
============================================
```
#!/bin/bash
mail -s "subject" < /path/to/body/message root
echo "Mail sent to root user"
```

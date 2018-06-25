# Branching Strategy

## Version Control

Version control is a system that records changes to a file or set of files over 
time so that you can recall specific versions later.

### Version Control Types

- Local copies: final.tar.gz final-1.tar.gz, final-latest.tar.gz.
- Centralized Version Control Systems: Subversion. 
    - Single server contains all the code.
    - Checks out latest snapshot.
- Distributed Version Control Systems: Git, Mercurial.
    - Full mirror of the repository including the history.
    - Thus, any client can become a server.

### How it works

Git thinks of its data more like a series of snapshots of a miniature filesystem. 
With Git, every time you commit, or save the state of your project, Git 
basically takes a picture of what all your files look like at that moment and 
stores a reference to that snapshot. To be efficient, if files have not changed,
 Git doesn’t store the file again, just a link to the previous identical file 
it has already stored. Git thinks about its data more like a stream of snapshots.

![CVS](1-deltas.png)
![GIT](2-snapshots.png)

- Git doesn’t need to go out to the server to get the history and display it for 
you — it simply reads it directly from your local database.

### Git Integrity

- Everything in Git is check-summed before it is stored and is then referred to 
by that checksum.
- The mechanism that Git uses for this checksumming is called a SHA-1 hash. 
This is a 40-character string composed of hexadecimal characters (0–9 and a–f) 
and calculated based on the contents of a file or directory structure in Git.
`24b9da6552252987aa493b52f8696cd6d3b00373`
- Git stores everything in its database not by file name but by the hash value 
of its contents.

### The Three States

Git has three main states that your files can reside in: *commited*, *modified*, and *staged*.

- Committed means that the data is safely stored in your local database.
- Modified mean that you have changed the file but have not committed it to your 
database yet.
- Staged means that you have marked a modified file in its current version to go
into your next commit snapshot.


The git directory is where Git stores the metadata and object datase for your project,
 and it's obtained when you *clone* a repository from another computer.

The working tree is a single checkout of one version of the project. These 
files are pulled out of the compressed database in the Git directory and placed
 on disk for you to use or modify.

![Git States](3-statges.png)

The basic git workflow goes something like this:

1. You modify files in your working tree.
2. You selectively stage just those changes, you want to be part of your next commit, 
which add *only* those changes to the staging area. 
3. You do a commit, which takes the files as they are in the staging area and 
stores that snapshot permanently to your Git directory.

### Git configuration

Git comes with a tool called git config that lets you get and set configuration
 variables that control all aspects of how Git looks and operates. These
 variables can be stored in three different places:

1. `/etc/gitconfig` file: Contains values applied to every user on the system
and all their repositories. If you pass the option `--system` to `git config`, 
it reads and writes from this file specifically.

2. `~/.gitconfig/` or `~/.config/git/config` file: User specific values applied 
to all repositories for that user. Configured passing `--global` to `git config`.

3. `.git/config` of whatever repo you are currently using: Specific to that single
repository. Configured passing `--local` to `git config`(default).

Each level overrides the previous one.

First thing is to configure user and email address.

```
git config --global user.name "Luis Michael"
git config --global user.email "me@email.com"
```

Checking your settings: `git config --list`

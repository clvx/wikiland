#Vim + Go + Frustration as a Service

Today I had to configure autocompletion in vim. It's super straightforward, just install some plugins:

    $#.vimrc
    "" Configuraciones Vundle.vim
    "git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    set nocompatible              
    filetype off                  
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'gmarik/Vundle.vim'
    Plugin 'fatih/vim-go'
    Plugin 'majutsushi/tagbar'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'mdempsky/gocode'
    call vundle#end()

Then, install some dependencies:

    $#Installing ctags
    $#Ubuntu
    $go install exuberant-ctags

    $#Mac
    $#brew install ctags
    
    $#Installing YouCompleteMe
    $cd ~/.vim/bundle/YouCompleteMe && \
        ./install.py --go-completer

    $#Installing gocode
    $go get -u github.com/mdempsky/gocode

It should be working by now, BUT there's [one little thing](https://github.com/fatih/vim-go/pull/1853) 
about `gocode`. It only looks for completion in `$GOPATH/pkg` and not source files. Hence, any desired 
completion needs to be compiled `go build [path]` or retrieved `go get -u [url]`.


After several hours of frustration I figured it out. 

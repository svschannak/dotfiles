#!/usr/bin/env bash

# Script that checks for some dependencies andruns 'rake install'
# if all dependencies are there
#
# author: Philipp Böhm

function check_dependency () {
    app=$1
    if [[ -z `which $app` ]]; then
        tput bold
        echo "'$app' not found"
        tput sgr0
        ARE_ALL_APPS_THERE=0
    else
        echo "'$app' was found (`which $app`)"
    fi
}

echo "Checking for dependencies ..."
apps="git zsh vim gvim ruby rake gem tmux"
ARE_ALL_APPS_THERE=1

for app in `echo $apps| tr ' ' '\n' `
do
    check_dependency $app
done

if [[ $ARE_ALL_APPS_THERE == 0 ]]; then
    echo "you should install them ..."
    echo ""
    echo "A list of package names for different distributions:"
    echo "Fedora: git-all zsh vim-enhanced vim-X11 ruby rubygems rubygem-rake tmux"
    echo "Ubuntu: git zsh vim vim-gnome ruby rubygems rake tmux"

    exit 1
fi

echo
echo "You have to install the following depending rubygems ..."
echo "tmuxinator backup"


# finally run the rake task that installs it
echo
echo "Running 'rake install' to complet the installation process ..."
rake install

# run other things that are needed to complete the install process
cd vim/bundle/vim-livereload/
rake

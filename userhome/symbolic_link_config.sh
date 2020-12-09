#!/bin/bash
set -euo pipefail
# TODO variable naming
#      should there be 'file', 'folder' or 'afile', 'afolder'?
# TODO add a debug option
#      plan to add a debug option, so that when writing the code,
#      it would be convenient to see variables.

backup_suffix=$(date +"%Y%m%d_%H_%M_%S")
# this script should be called inside the repo's root
repo_dir=$PWD

# DONE shell script function's name space?  local variable?
link_afile() {
    # e.g. repo/myconfig/.vim/xx.vim -> ~/.vim/xx.vim
    # $1 is the real file name
    # $2 is the destination for the symbolic link, i.e. its name
    # echo "\$1 is $1"
    # echo "\$2 is $2"
    local file=$1
    local dest=$2
    # DONE should mdir put here, or put at the caller?
    # decide to put here
    mkdir -p $(dirname dest)
    # remove the original symbolic link.  Design it.
    ## mind the order of the two conditions
    if [ -L $dest ]; then
        rm $dest
    fi
    # back up file
    if [ -f $dest ]; then
        # How to mark the region of variable names?
        # now use {}
        mv $dest ${dest}_${backup_suffix}
    fi
    ln -s $(realpath $file) $dest
}

# link config folder's content into destination
# usually, the upmost folder is a hidden folder, like '.vimrc'
link_afolder() {
    # e.g. repo/myconfig/.vimrc -> ~/.vimrc
    # or, repo/myconfig/dot.vimrc -> ~/.vimrc
    # write this using loop, instead of recursion
    # use bash globstar, introduced in version 4
    # $1 is the real folder name
    # $2 is the destination
    # echo "\$1 is $1"
    # echo "\$2 is $2"
    local folder=$1
    local dest=$2
    local file
    local inner_path
    mkdir -p $dest
    shopt -s globstar
    # DONE if 'file' is used in the caller after calling this function, this would bring trouble.
    # use local variables
    for file in $folder/**/*; do
        inner_path=$(realpath --relative-base=$folder $file)
        if [ -f $file ]; then
            link_afile $file $dest/$inner_path
        elif [ -d $file ]; then
            mkdir -p $dest/$inner_path
        fi
    done
    shopt -u globstar
}


link_config() {
    local file
    local folder=$1
    # create a folder in home directory, and '-p' would be fine with existent directory.
    mkdir -p $HOME/$folder
    for file in $folder/.[!.]*; do
        echo $file;
        if [ -f $file ]; then
            link_afile $file $HOME/$folder/$file
        elif [ -d $file ] && [ ! $(basename $file) == ".git" ]; then
            echo "$file is a non-git-repository folder"
            # link_config $file
            link_afolder $file $HOME/$file
        fi
    done
}

main() {
    link_config .
}

main

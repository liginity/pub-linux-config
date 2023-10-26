#!/bin/bash
set -euo pipefail
# TODO add a debug option
#      plan to add a debug option, so that when writing the code,
#      it would be convenient to see variables.

# idea (for a possible rewrite)
# 1. create symbolic links for configuration files.
#    example: a symbolic link at /home/user/.vimrc, pointing to the .vimrc in this repo.
# 2. for configuration files in a folder, for example, ~/.emacs.d, wait to decide.

timestamp_format="%Y%m%d-%H%M%S"
timestamp=$(date +"${timestamp_format}")
backup_suffix="${timestamp}"
# this script should be called inside the repo's root
#repo_dir=$PWD

# a wrapper function for ln, for making symbolic link.
# this function checks the presence of the LINK_NAME parameter.
link_one_file() {
    # example: repo/userhome/.vimrc -> ~/.vimrc
    # $1 is the real file name
    # $2 is the destination for the symbolic link, i.e. its name
    if [ $# -lt 2 ]; then
        printf "usage: link_one_file TARGET LINK_NAME\n" >&2
        exit 1
    fi

    local target="$1"
    local link_name="$2"

    # remove the original symbolic link if present.
    # mind the order of the two if conditions.
    if [ -L $link_name ]; then
        rm $link_name
    fi
    # back up file
    if [ -f $link_name ]; then
        mv $link_name ${link_name}-${backup_suffix}
    fi

    ln -s $(realpath $target) $link_name
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
            link_one_file $file $dest/$inner_path
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
            link_one_file $file $HOME/$folder/$file
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

# main
link_one_file "$@"

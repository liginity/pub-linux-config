#!/bin/bash
set -euo pipefail

# idea (for a possible rewrite)
# 1. (done) create symbolic links for configuration files.
#    example: a symbolic link at /home/user/.vimrc, pointing to the .vimrc in this repo.
# 2. for configuration files in a folder, for example, ~/.emacs.d, wait to decide.

timestamp_format="%Y%m%d-%H%M%S"
timestamp=$(date +"${timestamp_format}")
backup_suffix="${timestamp}"

# a wrapper function for ln, for making symbolic link.
# this function checks the presence of the LINK_NAME parameter.
link_one_file() {
    # example: repo/userhome/.vimrc <- ~/.vimrc
    # $1 is the real file name
    # $2 is the location for the symbolic link, i.e. its name
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

main() {
    files=(.bashrc .bash_aliases .vimrc .tmux.conf .gitconfig)
    for file in "${files[@]}"; do
        link_one_file $file ~/$file
    done
}

main

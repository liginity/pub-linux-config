#!/bin/bash
# set safe options
# set -veuo pipefail
set -euo pipefail
trap "echo 'error: Script failed: see failed command above'" ERR

RELATIVE_CONFIG_DIR="../../userhome"
REAL_CONFIG_DIR=$(realpath $RELATIVE_CONFIG_DIR)

sp="--------------------------------------------------------"
backup_stamp=$(date +"%m_%d_%Y_%Hh_%Mm")

link_basic() {
  # link only basic settings
  config_files=(.bashrc .vimrc .gitconfig .bash_aliases)
  echo "these files are to be linked to your home directory"
  for config_file in ${config_files[@]}; do
    echo "$config_file"
  done
  read -p "will you continue? [y/N(default)] " confirm
  if [[ $confirm == "" || $confirm == [nN] ]]; then
    exit 0
  fi
  # link files, with check
  # - check for symbolic links of the config files
  # - check for existence, and back up with time stamp
  for config_file in ${config_files[@]}; do
    config_file_fullpath=$HOME/$config_file
    echo $sp
    if [ -L $config_file_fullpath ]; then
      echo "$config_file_fullpath exists as a simbolic link, relink it"
      echo "ln -s -f $REAL_CONFIG_DIR/dot.$config_file $config_file_fullpath"
    elif [ -f $config_file_fullpath ]; then
      echo "$config_file_fullpath exists, back it up"
      echo "mv $config_file_fullpath "$config_file_fullpath"_$backup_stamp.backup"
      echo "ln -s $REAL_CONFIG_DIR/dot.$config_file $config_file_fullpath"
    fi
  done

}

usage() {
  echo "Link Configuration Files"
  echo "Usage bash $0 OPTION"
  echo ""
#   echo $sp
  echo "-h, --help           display help message and configuration info"
  echo "-s, --simple"
  echo "--public             link only basic settings"

}

config_info() {
  echo ""
  echo "$REAL_CONFIG_DIR is the absolute config path,"
  echo "which contains config files"
}



main() {
  if [ $# -gt 0 ]; then
    case $1 in
      -h|--help)
        usage
        config_info
        exit 0
        ;;
      -s|--simple|--public)
        link_basic
        exit 0
    esac
  else
    usage
    exit 1
  fi
}

main $@


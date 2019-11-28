#!/bin/bash
# set safe options
# set -veuo pipefail
set -euo pipefail
trap "echo 'error: Script failed: see failed command above'" ERR

RELATIVE_CONFIG_DIR="../../userhome"
REAL_CONFIG_DIR=$(realpath $RELATIVE_CONFIG_DIR)

sp="+----------+----------+----------+----------+----------+"

link_basic() {
  # link only basic settings
  config_files=(dot.bashrc dot.vimrc dot.gitconfig dot.bash_aliases)
  echo "these files are to be linked to your home directory"
  for config_file in ${config_files[@]}; do
    echo "$config_file"
  done
  read -p "will you continue? [y/N] " confirm
  if [[ $confirm == "" || $confirm == [nN] ]]; then
    exit 0
  fi
  echo "These files are going to be linked"
  echo "ln -s $REAL_CONFIG_DIR/dot.zshrc $HOME/.zshrc"
  echo "ln -s $REAL_CONFIG_DIR/dot.bashrc $HOME/.bashrc"
  echo "ln -s $REAL_CONFIG_DIR/dot.vimrc $HOME/.vimrc"
  ln -s $REAL_CONFIG_DIR/dot.zshrc $HOME/.zshrc
  ln -s $REAL_CONFIG_DIR/dot.bashrc $HOME/.bashrc
  ln -s $REAL_CONFIG_DIR/dot.vimrc $HOME/.vimrc
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


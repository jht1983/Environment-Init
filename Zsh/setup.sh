#!/bin/bash
function MYECHO(){
  echo -e "\033[44;37m$1\033[0m"
}

function usage(){
  MYECHO "usage: ./setup.sh 1 for CentOS 7"
  # MYECHO "usage: ./setup.sh 2 for Fedora 27"
  # MYECHO "usage: ./setup.sh 3 for Ubuntu 16.04"
  MYECHO "usage: ./setup.sh 4 for Debian 9"
  exit 1
}

function CheckYes(){
  condition=-100
  while (( $condition==-100 ))
  do
    echo -n "$1"
    read -t 5 in
    case $in in
    Yes|yes|Y|y|"") condition=1 ;;
    No|no|N|n) condition=0 ;;
    *) ;;
    esac
  done
  if [ $condition -eq 1 ]; then return 1;
  else return 0;
  fi
}

# init
if [ $# != 1 ]; then usage;
elif [ $1 = 1 ]; then __PKG__="sudo yum";     ## for CentOS 7
# elif [ $1 = 2 ]; then __PKG__="sudo dnf";     ## for Fedora 27    本脚本不再维护此方案
# elif [ $1 = 3 ]; then __PKG__="sudo apt";     ## for Ubuntu 16.04 本脚本不再维护此方案
elif [ $1 = 4 ]; then __PKG__="sudo apt";     ## for Debian 9
else usages;
fi

MYECHO "# ---------- Starting install zsh ---------- #"

$__PKG__ install -y zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

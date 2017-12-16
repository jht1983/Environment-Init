#!/bin/bash
function MYECHO(){
  echo -e "\033[44;37m$1\033[0m"
}

function usage(){
  MYECHO "usage: ./setup.sh for CentOS 7 & Debian 9"
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
source /etc/os-release

case "$ID $VERSION_ID" in
'debian 9')
    __CASE__=4
    __PKG__="sudo apt"
    ;;
'centos 7')
    __CASE__=1
    __PKG__="sudo yum"
    ;;
'ubuntu 16.04') # 本脚本不再维护此方案
    __CASE__=3
    __PKG__="sudo apt"
    ;;
'fedora 27')    # 本脚本不再维护此方案
    __CASE__=2
    __PKG__="sudo dnf"
    ;;
*)
    MYECHO "本机的系统不受支持"
    usage
    ;;
esac

__CUR__=$(cd `dirname $0`; pwd)

MYECHO "# ---------- Starting install zsh ---------- #"

$__PKG__ install -y zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

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

MYECHO "# ---------- 开始 配置 ---------- #"

## 1 配置 zsh
# 见 https://github.com/Will-Grindelwald/Environment-Init/tree/master/Zsh

## 2 配置 vim
# echo "installing 'Vim Customized by Ljc'"     # 作为主力 终端界面的 编辑器, 保证适用简洁高效
# $__PKG__ install -y vim ctags cscope astyle
# # install vimdoc@cn from vimcdoc.sourceforge.net
# # git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/Vim/setup && sh -x setup

# mkdir -p ~/.local/share/fonts
# mv fonts/* ~/.local/share/fonts
# rm -rf fonts
# curl -sLf https://spacevim.org/install.sh | bash

## 3 配置 VSCode

## 4 配置 Java
# 还是手动安装 Java 吧
# $__PKG__ install -y java-1.8.0-openjdk java-1.8.0-openjdk-src java-1.8.0-openjdk-javadoc java-1.8.0-openjdk-devel

## 5 配置 git 的 ssh keys 与 gpg keys

## 6 检测 ssh 无密码登录, 并输一遍 yes
ssh localhost

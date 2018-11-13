#!/bin/bash
function MYECHO(){
  echo -e "\033[44;37m$1\033[0m"
}

function usage(){
  MYECHO "usage: ./xiaomi.sh for ubuntu 18.04"
}

function CheckYes(){
  condition=-100
  while (( $condition==-100 ))
  do
    echo -n "$1"
    read -t 5 in
    case $in in
    Yes|yes|Y|y) condition=1 ;;
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
'ubuntu 18.04')
    __CASE__=3
    __PKG__="sudo apt"
    ;;
*)
    MYECHO "本机的系统不受支持"
    usage
    exit 1
    ;;
esac

__CUR__=$(cd `dirname $0`; pwd)

MYECHO "# ----------------- 配置 小米 办公 开发使用的工具 ----------------- #"

mioffice wifi
vpn
relay
浏览器 代理
xiaomi 邮箱
xiaomi 办公打印机
phabricator


MYECHO "# ------------ 1 主题 ------------ #"

MYECHO "# ------------ 2 字体加强 ------------ #"

MYECHO "# ------------ 3 面板 ------------ #"

MYECHO "# ------------ 4 设置 ------------ #"


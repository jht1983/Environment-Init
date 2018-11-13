#!/bin/bash
function MYECHO(){
  echo -e "\033[44;37m$1\033[0m"
}

function usage(){
  MYECHO "usage: ./ChangeTarget.sh <runlevel>"
  MYECHO "runlevel: 3 or 5"
  MYECHO "本脚本仅在 CentOS7 上验证过, 在 Debian 上有问题"
}

# init
source /etc/os-release

case "$ID $VERSION_ID" in
'centos 7')
    __CASE__=1
    __PKG__="sudo yum"
    ;;
'fedora 27')    # 本脚本不再维护此方案
    __CASE__=2
    __PKG__="sudo dnf"
    ;;
'ubuntu 16.04') # 本脚本不再维护此方案
    __CASE__=3
    __PKG__="sudo apt"
    ;;
'debian 9')
    __CASE__=4
    __PKG__="sudo apt"
    ;;
*)
    MYECHO "本机的系统不受支持"
    usage
    exit 1
    ;;
esac

if [ $__CASE__ != 1 ]; then
  MYECHO "本脚本仅在 CentOS7 上验证过, 在 Debian 上有问题"
  exit 1
fi

# 注意: 以下命令 要在真机上输入，不能在远程 ssh 上输入
case "$1" in
3)
  # 从 图形级别 切换到 命令行级别
  systemctl isolate multi-user.target
  # or
  # sudo init 3 # 旧时代的东西, 不确定稳定性
  # PS: Ubuntu 从 图形级别 切换到 命令行级别 时, 处于 Ctrl + Alt + F7, 按 Ctrl + Alt + F1-6, 切换到文字终端
  ;;
5)
  # 从 命令行级别 切换到 图形级别
  systemctl isolate graphical.target
  # or
  # sudo init 5 # 旧时代的东西, 不确定稳定性
  ;;
*)
  MYECHO "错误的操作"
  usage
  exit 1
  ;;
esac

# Centos 7 第一次进入图形模式要确认协议   依次输入 1 2 c c
# systemctl set-default graphical.target # 设置开机启动时的运行级别为 图形级别
# systemctl set-default multi-user.target # 设置开机启动时的运行级别为 命令行级别

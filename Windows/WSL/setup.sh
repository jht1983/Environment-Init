#!/bin/bash

# 基于 linux/setup.sh 修改

function MYECHO(){
  echo -e "\033[44;37m$1\033[0m"
}

function usage(){
  MYECHO "usage: ./setup.sh for debian 9 & centos 7"
  MYECHO "supports of ubuntu 16.04 & fedora 27 are deprecated"
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

__CUR__=$(cd `dirname $0`; pwd)

MYECHO "#------------- Part 0 网络配置 -------------#"

### 0.1 配置网络 IPV4 & IPV6 (IP + 网关)
# sudo sh -c "echo '' >> /etc/sysconfig/network-scripts/ifcfg-eth0"

### 0.2 DNS: 清华/Google 的 IPV6 DNS & 114 的 IPV4 DNS
# if [ $__CASE__ = 1 -o $__CASE__ = 2 -o $__CASE__ = 4 ]; then
#   sudo sh -c "sed -i '/^\[main\]$/a\dns=none' /etc/NetworkManager/NetworkManager.conf"
#   sudo systemctl restart NetworkManager.service
#   sleep 10s                                   ## 等待 NetworkManager 重启完成
#   sudo rm -rf /etc/resolv.conf
#   sudo sh -c "cat ./Net/dns > /etc/resolv.conf"
# elif [ $__CASE__ = 3 ]; then
#   sudo sh -c "cat ./Net/dns > /etc/resolvconf/resolv.conf.d/base"
#   sudo resolvconf -u
# fi

### 0.3 hosts 科学上网
# ./Net/ChangeHosts.sh

MYECHO "#----- Part 1 安装第三方仓库源 及 更新 -----#"

### 1.1 安装第三方仓库源
if [ $__CASE__ = 1 ]; then
  MYECHO "installing third-party repository for CentOS 7"
  MYECHO "installing EPEL"
  # EPEL see http://fedoraproject.org/wiki/EPEL
  $__PKG__ install -y epel-release
  # $__PKG__ install -y yum-axelget # yum 并行下载插件(在 EPEL 中), 不确定稳定性, 源好一样能跑满网速

  # rpmfusion see https://rpmfusion.org/
  # $__PKG__ localinstall -y --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm
  $__PKG__ localinstall -y --nogpgcheck https://mirrors.ustc.edu.cn/rpmfusion/free/el/rpmfusion-free-release-7.noarch.rpm https://mirrors.ustc.edu.cn/rpmfusion/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm

  # Other 1. elrepo see http://elrepo.org/tiki/tiki-index.php
  # sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
  # sudo rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm

  # Other 2. nux-dextop see https://li.nux.ro/repos.html
  # sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
elif [ $__CASE__ = 2 ]; then
  MYECHO "installing third-party repository for Fedora"
  # 1. rpmfusion see https://rpmfusion.org/
  # $__PKG__ install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  $__PKG__ install -y https://mirrors.ustc.edu.cn/rpmfusion/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.ustc.edu.cn/rpmfusion/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

  # 2. fedora 中文社区源, 里面有中国人常用的软件 see https://repo.fdzh.org/
  $__PKG__ config-manager --add-repo=http://repo.fdzh.org/FZUG/FZUG.repo
elif [ $__CASE__ = 3 ]; then
  MYECHO "nothing 1"
elif [ $__CASE__ = 4 ]; then
  MYECHO "nothing 2"
fi

### 1.2 切换镜像源
# 使用中科大的官方镜像源
# https://mirrors.tuna.tsinghua.edu.cn/
# https://lug.ustc.edu.cn/wiki/lug/services/mirrors
CheckYes "是否切换中科大镜像源?(y/n):"
if [ $? = 1 ]; then
  if [ $__CASE__ = 1 ]; then
    MYECHO "installing mirror repository for CentOS 7"
    sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
    sudo cp ./NewSource/CentOS-Base-ustc.repo /etc/yum.repos.d/CentOS-Base.repo

    # for EPEL
    sudo sed -e 's!^mirrorlist=!#mirrorlist=!g' \
         -e 's!^#baseurl=!baseurl=!g' \
         -e 's!//download\.fedoraproject\.org/pub!//mirrors.ustc.edu.cn!g' \
         -e 's!http://mirrors\.ustc!https://mirrors.ustc!g' \
         -i /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel-testing.repo
  elif [ $__CASE__ = 2 ]; then
    MYECHO "installing mirror repository for Fedora"
    sudo mv /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora.repo.bak
    sudo mv /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/fedora-updates.repo.bak
    sudo cp ./NewSource/fedora-ustc.repo /etc/yum.repos.d/fedora.repo
    sudo cp ./NewSource/fedora-updates-ustc.repo /etc/yum.repos.d/fedora-updates.repo
  elif [ $__CASE__ = 3 ]; then
    MYECHO "installing mirror repository for Ubuntu 16.04"
    sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo cp ./NewSource/ubuntu-sources-ustc.list /etc/apt/sources.list
  elif [ $__CASE__ = 4 ]; then
    MYECHO "installing mirror repository for Debian 9"
    sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo cp ./NewSource/debian-sources-ustc.list /etc/apt/sources.list
  fi
fi

### 1.3 刷新 & 更新
$__PKG__ clean all                            # 兼顾 yum apt 语法
MYECHO "系统更新"
if [ $__CASE__ = 1 -o $__CASE__ = 2 ]; then
  $__PKG__ makecache
  $__PKG__ -y update
elif [ $__CASE__ = 3 -o $__CASE__ = 4 ]; then
  $__PKG__ -y update
  $__PKG__ -y upgrade
fi
$__PKG__ clean packages                       # 兼顾 yum apt 语法

MYECHO "#-------------- Part 2 安装软件 --------------#"

MYECHO "基于特定系统的软件"
if [ $__CASE__ = 1 ]; then
  $__PKG__ groupinstall -y "Development Tools"
elif [ $__CASE__ = 2 ]; then
  $__PKG__ install -y https://dl.folkswithhats.org/fedora/$(rpm -E %fedora)/RPMS/folkswithhats-release.noarch.rpm # 会安装 fedy(中国人常用软件 的 软件中心)
elif [ $__CASE__ = 3 ]; then
  $__PKG__ install -y ubuntu-restricted-extras
elif [ $__CASE__ = 4 ]; then
  MYECHO "nothing 3"
fi

### 2.1 终端软件
MYECHO "终端软件"
MYECHO "installing 'vim-gtk git subversion curl cmake tree htop glances p7zip tmux mosh zsh'"
$__PKG__ install -y vim-gtk git subversion curl cmake tree htop glances p7zip tmux mosh zsh

MYECHO "unrar man-pages-zh-CN fuse-exfat exfat-utils ntfs-3g"
if [ $__CASE__ = 1 -o $__CASE__ = 2 ]; then
  # fuse-exfat exfat-utils 在 rpmfusion 源中!
  $__PKG__ install -y unrar man-pages-zh-CN fuse-exfat exfat-utils ntfs-3g
elif [ $__CASE__ = 3 ]; then
  $__PKG__ install -y unrar manpages-zh exfat-fuse exfat-utils ssh
elif [ $__CASE__ = 4 ]; then
  $__PKG__ install -y unrar-free manpages-zh exfat-fuse exfat-utils ssh
fi

### 2.2 Dev
MYECHO "autoconf automake"
$__PKG__ install -y autoconf automake

MYECHO "#--------------- Part 3 桌面 --------------#"

MYECHO "#-------------- Part 4 设置 --------------#"

### 4.1 改主机名 `hostnamectl set-hostname LJC`

### 4.2 终端提示符彩色显示
# echo 'export PS1="\[\e[32;1m\][\u@\h:\[\e[34;1m\]\w\[\e[32;1m\]]$>\[\e[0m\]"' >> ~/.bashrc
# sudo sh -c 'echo "export PS1=\"\[\e[32;1m\][\u@\h:\[\e[34;1m\]\w\[\e[32;1m\]]$>\[\e[0m\]\"" >> /root/.bashrc'
# 想改哪个用户的提示符, 就放到那个用户的 ~/.bashrc 中, 尽量不要动全局变量, 如 /etc/profile、/etc/bash.bashrc, 同时 ~/.bashrc 是最后读取的, 不会被 overwrite
# .vimrc同理

### 4.3 配置 ssh
# if [ $__CASE__ = 2 -o $__CASE__ = 3 ]; then ## 启动 ssh for Fedora 27 & Ubuntu 16.04
#   sudo systemctl enable sshd
#   sudo systemctl start sshd
# fi
# ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa; cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys; chmod 644 ~/.ssh/authorized_keys;

### 4.4 清理
$__PKG__ clean packages

MYECHO "完成!"

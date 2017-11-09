#!/bin/bash
function usage(){
  echo "usage: ./setup.sh 1 for CentOS 7"
  echo "usage: ./setup.sh 2 for Fedora 25"
  echo "usage: ./setup.sh 3 for Ubuntu 18.04"
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
elif [ $1 = 2 ]; then __PKG__="sudo dnf";     ## for Fedora 25
elif [ $1 = 3 ]; then __PKG__="sudo apt-get"; ## for Ubuntu 18.04
else usages;
fi

#------------ Part 0 网络配置 ------------#

### 0.1 配置网络 IPV4 & IPV6 (IP + 网关)
# sudo sh -c "echo '' >> /etc/sysconfig/network-scripts/ifcfg-eth0"

### 0.2 DNS: 清华/Google 的 IPV6 DNS & 114 的 IPV4 DNS
if [ $1 = 1 ]; then                           ## for CentOS 7
  sudo sh -c "echo 'nameserver 2001:da8::666' >> /etc/resolv.conf"
  sudo sh -c "echo 'nameserver 2001:4860:4860::8888' >> /etc/resolv.conf"
  sudo sh -c "echo 'nameserver 114.114.114.114' >> /etc/resolv.conf"
elif [ $1 = 3 ]; then                         ## for Ubuntu
  sudo sh -c "echo 'nameserver 2001:da8::666' >> /etc/resolvconf/resolv.conf.d/base"
  sudo sh -c "echo 'nameserver 2001:4860:4860::8888' >> /etc/resolvconf/resolv.conf.d/base"
  sudo sh -c "echo 'nameserver 114.114.114.114' >> /etc/resolvconf/resolv.conf.d/base"
  sudo resolvconf -u
fi

### 0.3 hosts 科学上网
# ./Net/ChangeHosts.sh

#----- Part 1 安装第三方仓库源 及 更新 -----#

### 1.1 安装第三方仓库源
if [ $1 = 1 ]; then                           ## for CentOS 7
  echo "installing third-party repository for CentOS 7"
  echo "installing EPEL"
  # EPEL see http://fedoraproject.org/wiki/EPEL
  $__PKG__ install -y epel-release
  # $__PKG__ install -y yum-axelget # yum 并行下载插件, 不确定稳定性, 源好一样能跑满网速

  # Other 1. rpmfusion see https://rpmfusion.org/
  # 使用 tuna 的源: https://mirrors.tuna.tsinghua.edu.cn/help/rpmfusion/
  # $__PKG__ localinstall -y --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm

  # Other 2. elrepo see http://elrepo.org/tiki/tiki-index.php
  # sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
  # sudo rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm

  # Other 3. nux-dextop see https://li.nux.ro/repos.html
  # sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
elif [ $1 = 2 ]; then                         ## for Fedora 25
  echo "installing third-party repository for Fedora"
  # 1. rpmfusion see https://rpmfusion.org/
  $__PKG__ install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

  # 2. fedora 中文社区源, 里面有中国人常用的软件 see https://repo.fdzh.org/
  $__PKG__ config-manager --add-repo=http://repo.fdzh.org/FZUG/FZUG.repo
elif [ $1 = 3 ]; then                         ## for Ubuntu
  echo "nothing"
fi

### 1.2 切换镜像源
# 使用清华/中科大的官方镜像源
# https://mirrors.tuna.tsinghua.edu.cn/
# https://lug.ustc.edu.cn/wiki/lug/services/mirrors
CheckYes "是否切换清华镜像源?(y/n):"
if [ $? = 1 ]; then
  if [ $1 = 1 ]; then                         ## for CentOS 7
    echo "installing mirror repository for CentOS 7"
    sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
    sudo cp ./NewSource/CentOS-Base-tuna.repo /etc/yum.repos.d/CentOS-Base.repo
    # sudo cp ./NewSource/CentOS-Base-ustc.repo /etc/yum.repos.d/CentOS-Base.repo

    # tuna 已经在 epel 的官方镜像列表里, 这里强制使用 tuna: https://mirrors.tuna.tsinghua.edu.cn/help/epel/
    sudo mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.bak
    sudo cp ./NewSource/CentOS-EPEL-tuna.repo /etc/yum.repos.d/epel.repo
  elif [ $1 = 3 ]; then                       ## for Ubuntu
    echo "installing mirror repository for Ubuntu"
    sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo cp ./NewSource/sources-tuna.list /etc/apt/sources.list
  fi
fi

### 1.3 刷新 & 更新
$__PKG__ clean all
if [ $1 = 1 ]; then                           ## for CentOS 7
  $__PKG__ makecache
  $__PKG__ -y update
elif [ $1 = 2 ]; then                         ## for Fedora 25
  $__PKG__ makecache
  $__PKG__ -y update
elif [ $1 = 3 ]; then                         ## for Ubuntu
  $__PKG__ -y update
  $__PKG__ -y upgrade
fi

#-------------- Part 2 安装软件 --------------#

if [ $1 = 1 ]; then                           ## for CentOS 7
  $__PKG__ groupinstall -y "Development Tools"
elif [ $1 = 2 ]; then                         ## for Fedora 25
  curl https://www.folkswithhats.org/installer | sudo bash;
fi

### 2.1 终端软件
echo "installing 'git subversion ssh curl cmake tree htop glances rar p7zip shutter tmux mosh zsh'"
$__PKG__ install -y git subversion ssh curl cmake tree htop glances rar p7zip shutter tmux mosh zsh

echo "installing 'man-zh'"
if [ $1 = 1 ]; then $__PKG__ install -y man-pages-zh-CN ## for CentOS 7
elif [ $1 = 2 ]; then $__PKG__ install -y man-pages-zh  ## for Fedora 25
elif [ $1 = 3 ]; then $__PKG__ install -y manpages-zh   ## for Ubuntu 18.04
fi

### 2.2 Dev
# $__PKG__ install -y gcc gcc-c++

# echo "protocol-buffer"
# $__PKG__ install -y protobuf-compiler

### 2.3 配置
# 配置 ssh
if [ $1 = 3 ]; then sudo sh -c "/etc/init.d/ssh start"; fi  # 启动 ssh for Ubuntu
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa; cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys; chmod 644 ~/.ssh/authorized_keys;
# ssh localhost # 无密码登录 ssh

# 配置 zsh
# wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/Zsh/setup && sh -x setup 1

# 配置 vim
# echo "installing 'Vim Customized by Ljc'"     # 作为主力 终端界面的 编辑器, 保证适用简洁高效
# $__PKG__ install -y vim ctags cscope astyle
# # install vimdoc@cn from vimcdoc.sourceforge.net
# # git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/Vim/setup && sh -x setup

# 配置 VSCode
if [ $1 = 3 ]; then                           ## for CentOS 7 or Fedora 25
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
  sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  $__PKG__ update
  $__PKG__ -y install code
else                                          ## for Ubuntu 18.04
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
  $__PKG__ check-update
  $__PKG__ -y install code
fi

# wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/VSCode/settings.json -P ~/.config/Code/User
# wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/VSCode/keybindings.json -P ~/.config/Code/User

# 配置 Java
# 还是手动安装 Java 吧
# $__PKG__ install -y java-1.8.0-openjdk java-1.8.0-openjdk-src java-1.8.0-openjdk-javadoc java-1.8.0-openjdk-devel

# 配置 git 的 ssh keys 与 gpg keys

#--------------- Part 3 美化 --------------#

### 3.1 GUI 桌面
# 为了统一安装效果、试用体验、配置成本, 在体验过诸多桌面后, 决定使用 Xfce & LXDE 作为 DE
# 其中 Xfce 作为常用 DE, Centos Fedora Debian Ubuntu 都支持
# 在计算节点上 安装 LXDE, 仅用于应急用, 不做美化
# LXDE 更轻量, Xfce 也很轻量，比 LXDE 美观一些
# 1. 为性能考虑, 决定使用轻量级 DE
# 2. Centos 仅可用 gnome kde xfce(来自 Fedora)
# 3. ubuntu 有 Lubuntu(OS+DE 占内存 330M) & Xubuntu(OS+DE 占内存 450M)
# 4. Debian 9 默认 DE 是 Xfce

# Ubuntu 安装时使用衍生版 Lubuntu or Xubuntu
# Debian 使用默认 DE: Xfce
# Centos/Fedora 安装 Xfce

#### 1. for Xfce
if [ $1 = 1 ]; then                           ## for CentOS 7
  CheckYes "install Xfce?(y/n):"
  if [ $? = 1 ]; then
    # 使用 CentOS 7 最小安装 再安装 Xfce, 没有中文字体，太麻烦, 先安 GNOME
    echo "installing Xfce"
    $__PKG__ groupinstall -y "GNOME Desktop" "Graphical Administration Tools" Xfce
  fi
fi

#### 2. for LXDE
# echo "nothing"

#### 3. for GNOME
# sudo dnf install gnome-tweak-tool
# sudo dnf install nautilus-open-terminal

### 3.2 GUI 软件
# $__PKG__ install -y terminator

# echo "installing 'gksu GUI 程序使用 sudo'"
# $__PKG__ install -y gksu

# echo "installing 'open-in-terminal 右键打开终端'"
# $__PKG__ install -y nautilus-open-terminal

### 3.3 字体加强
# https://github.com/FZUG/repo/wiki/%E9%85%8D%E7%BD%AE-Infinality-%E5%AD%97%E4%BD%93%E6%B8%B2%E6%9F%93%E5%A2%9E%E5%BC%BA

#-------------- Part 4 设置 --------------#

### 4.1 改主机名 `hostnamectl set-hostname LJC`

### 4.2 自定义命令别名
echo "source ~/.ljc_alias" >> ~/.ljcrc
echo "source ~/.ljcrc" >> ~/.bashrc

### 4.3 终端提示符彩色显示
echo 'export PS1="\[\e[32;1m\][\u@\h:\[\e[34;1m\]\w\[\e[32;1m\]]$>\[\e[0m\]"' >> ~/.bashrc
# sudo echo 'export PS1="\[\e[32;1m\][\u@\h:\[\e[34;1m\]\w\[\e[32;1m\]]$>\[\e[0m\]"' >> /root/.bashrc
# 想改哪个用户的提示符, 就放到那个用户的 ~/.bashrc 中, 尽量不要动全局变量, 如 /etc/profile、/etc/bash.bashrc, 同时 ~/.bashrc 是最后读取的, 不会被 overwrite
# .vimrc同理

#-------------- Part 5 TODO --------------#

# 以下命令 要在真机上输入，不能在远程 ssh 上输入
# systemctl isolate graphical.target # 从 命令行级别 切换到 图形级别
# systemctl isolate multi-user.target # 从 图形级别 切换到 命令行级别
# 第一次进入图形模式要确认协议   依次输入 1 2 c c
# systemctl set-default graphical.target # 设置开机启动时的运行级别

# 改锁屏壁纸

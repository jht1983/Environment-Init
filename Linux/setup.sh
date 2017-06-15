#!/bin/bash
function usage(){
  echo "usage: ./setup.sh 1 for CentOS 7"
  echo "usage: ./setup.sh 2 for Fedora 25"
  echo "usage: ./setup.sh 3 for Ubuntu 16.04"
  exit 1
}

# init
if [ $# != 1 ]; then usage;
elif [ $1 = 1 ]; then __PKG__="sudo yum";     ## for Cent OS 7
elif [ $1 = 2 ]; then __PKG__="sudo dnf";     ## for Fedora 25
elif [ $1 = 3 ]; then __PKG__="sudo apt-get"; ## for Ubuntu 16.04
else usages;
fi

#----- Part 1 安装第三方仓库源 及 更新 -----#

### 1.1 安装第三方仓库源
if [ $1 = 1 ]; then                           ## for Cent OS 7
  # 1. epel see http://fedoraproject.org/wiki/EPEL
  $__PKG__ install -y epel-release

  # 2. rpmfusion see https://rpmfusion.org/
  $__PKG__ localinstall -y --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm

  # 3. elrepo see http://elrepo.org/tiki/tiki-index.php
  sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
  sudo rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm

  # 4. nux-dextop see https://li.nux.ro/repos.html
  sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
  # check
  $__PKG__ clean all
  $__PKG__ makecache
  $__PKG__ repolist
elif [ $1 = 2 ]; then                         ## for Fedora 25
  # 1. rpmfusion see https://rpmfusion.org/
  $__PKG__ install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

  # 2. fedora 中文社区源，里面有中国人常用的软件 see https://repo.fdzh.org/
  $__PKG__ config-manager --add-repo=http://repo.fdzh.org/FZUG/FZUG.repo
  # check
  $__PKG__ clean all
  $__PKG__ makecache
  $__PKG__ repolist
fi

### 1.2 更新
$__PKG__ -y update
$__PKG__ upgrade
$__PKG__ autoremove

#-------------- Part 2 设置 --------------#

# 2.1 改锁屏壁纸

# 2.3 改主机名 `hostnamectl set-hostname LJC`

# 2.3 自定义命令别名
echo "source ~/.ljc_alias" >> ~/.ljcrc
echo "source ~/.ljcrc" >> ~/.bashrc

# 2.4 终端提示符彩色显示
echo 'export PS1="\[\e[32;1m\][\u@\h:\[\e[34;1m\]\w\[\e[32;1m\]]$>\[\e[0m\]"' >> ~/.bashrc
# sudo echo 'export PS1="\[\e[32;1m\][\u@\h:\[\e[34;1m\]\w\[\e[32;1m\]]$>\[\e[0m\]"' >> /root/.bashrc
# 想改哪个用户的提示符, 就放到那个用户的 ~/.bashrc 中, 尽量不要动全局变量, 如 /etc/profile、/etc/bash.bashrc, 同时 ~/.bashrc 是最后读取的, 不会被 overwrite
# .vimrc同理

# 2.5 突破 G(功)F(夫)W(网)
sudo cp /etc/hosts /etc/hosts.back
wget https://raw.githubusercontent.com/racaljk/hosts/master/hosts -O /tmp/hosts
sudo cp /etc/hosts.back /etc/hosts
sudo sh -c "cat /tmp/hosts >> /etc/hosts"
rm /tmp/hosts

# 2.6 installing 'dconf Editor 图形化系统配置编辑器'
echo "installing 'dconf Editor 图形化系统配置编辑器'"
$__PKG__ install -y dconf-editor

#--------------- Part 3 美化 --------------#

# for CentOS 7 最小安装
# sudo yum groupinstall "GNOME Desktop" "Graphical Administration Tools" "Development Tools"
# systemctl set-default graphical.target

# echo "installing 'open-in-terminal 右键打开终端'"
# $__PKG__ install -y nautilus-open-terminal

# echo "installing 'cairo-dock'"
# $__PKG__ install -y cairo-dock

if [ $1 != 1 ]; then                          ## for Fedora 25 & Ubuntu 1604
  echo "installing 'plank dock'"
  if [ $1 = 3 ]; then                         ## for Ubuntu 1604
    sudo add-apt-repository ppa:docky-core/stable
    $__PKG__ update
  fi
  $__PKG__ install plank
fi

if [ $1 = 2 ]; then                           ## for Fedora 25's GNOME
  echo "installing 'GNOME Tweak Tool GNOME 桌面定制工具'"
  $__PKG__ install -y gnome-tweak-tool
  # 设置 1. 桌面图标 2. 顶栏时钟 3. Dash to Dock 扩展(用 chrome 浏览器 + GNOME Shell Integration 扩展)？？？？？

  # 字体加强
  # https://github.com/FZUG/repo/wiki/%E9%85%8D%E7%BD%AE-Infinality-%E5%AD%97%E4%BD%93%E6%B8%B2%E6%9F%93%E5%A2%9E%E5%BC%BA
fi

# if [ $1 = 3 ]; then                           ## for Ubuntu's Unity
#   echo "配置 '点击应用程序 Launcher 图标即可最小化'"
#   gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true

#   echo "installing 'Unity Tweak Tool Unity 桌面定制工具'"
#   $__PKG__ install -y unity-tweak-tool

#   sudo add-apt-repository ppa:noobslab/themes
#   sudo add-apt-repository ppa:noobslab/icons
#   $__PKG__ update
#   $__PKG__ install -y flatabulous-theme
#   $__PKG__ install -y ultra-flat-icons
#   $__PKG__ install -y fonts-wqy-microhei
#   # 打开 unity-tweak-tool 软件, 修改主题为 Flatabulous, 图标为 Ultra-flat, 指针为 Dmz-black, 字体为 文泉驿等宽微米黑 Regular
# fi

#-------------- Part 4 软件 --------------#

# 终端软件
echo "installing 'gcc gcc-c++ git subversion ssh curl cmake tree htop glances rar p7zip shutter tmux mosh'"
$__PKG__ install -y gcc gcc-c++ git subversion ssh curl cmake tree htop glances rar p7zip shutter tmux mosh

echo "installing 'man-zh'"
if [ $1 = 1 ]; then $__PKG__ install -y man-pages-zh   ## for Cent OS 7
elif [ $1 = 2 ]; then $__PKG__ install -y man-pages-zh ## for Fedora 25
elif [ $1 = 3 ]; then $__PKG__ install -y manpages-zh  ## for Ubuntu 16.04
fi

# echo "zsh"
$__PKG__ install -y zsh
wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/Zsh/setup && sh -x setup 1

# 终端软件
$__PKG__ install -y terminator

## for Fedora 25
if [ $1 = 2 ]; then curl https://www.folkswithhats.org/installer | sudo bash; fi

# $__PKG__ install -y java-1.8.0-openjdk java-1.8.0-openjdk-src java-1.8.0-openjdk-javadoc java-1.8.0-openjdk-devel

# 配置 ssh
/etc/init.d/ssh start       # 启动 ssh
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa; cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys; chmod 644 ~/.ssh/authorized_keys; ssh localhost # 无密码登录 ssh

# 配置 git 的 ssh keys 与 gpg keys

# 配置 vim
# echo "installing 'Vim Customized by Ljc'"     # 作为主力 终端界面的 编辑器, 保证适用简洁高效
# $__PKG__ install -y vim ctags cscope astyle
# # install vimdoc@cn from vimcdoc.sourceforge.net
# # git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/Vim/setup && sh -x setup

# 配置 VSCode
# wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/VSCode/settings.json -P ~/.config/Code/User
# wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/VSCode/keybindings.json -P ~/.config/Code/User

# echo "protocol-buffer"
# $__PKG__ install -y protobuf-compiler

# echo "installing 'gksu GUI 程序使用 sudo'"
# $__PKG__ install -y gksu

#!/bin/bash

# 终端提示符彩色显示
echo 'export PS1="\[\e[32;1m\][\u@\h:\[\e[34;1m\]\w\[\e[32;1m\]]$>\[\e[0m\]"' >> ~/.bashrc
#sudo echo 'export PS1="\[\e[32;1m\][\u@\h:\[\e[34;1m\]\w\[\e[32;1m\]]$>\[\e[0m\]"' >> /root/.bashrc
# 想改哪个用户的提示符, 就放到那个用户的~/.bashrc中, 尽量不要动全局变量, 如/etc/profile、/etc/bash.bashrc, 同时~/.bashrc是最后读取的, 不会被overwrite
# .vimrc同理

echo "开始安装 git ssh cmake tree htop man-zh httpd"
sudo apt-get install git openssh cmake tree htop manpages-zh httpd
sudo yum install git openssh cmake tree htop man-pages-zh httpd
# 配置 git 的 ssh keys 与 gpg keys
# 配置 ssh
/etc/init.d/ssh start       # 启动ssh
cd ~; ssh-keygen -t rsa; cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys; ssh localhost # 无密码登录 ssh
echo 'alias t="tree -ah --du"' >> ~/.bashrc
#sudo echo 'alias t="tree -ah --du"' >> /root/.bashrc

echo "开始安装 Vim 套装"     # 作为主力 终端界面的 编辑器, 保证适用简洁高效
sudo apt-get install vim-gtk ctags cscope astyle
# install vimdoc@cn from vimcdoc.sourceforge.net
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
wget -q https://raw.githubusercontent.com/Will-Grindelwald/Linux-Configuration/master/Vim/setup && sh -x setup

# echo "zsh"
# sudo apt-get install zsh

# echo "开始安装 gksu"       # 使GUI程序使用sudo
# sudo apt-get install gksu

# echo "protocol-buffer"
# sudo apt-get install protobuf-compiler

# Hadoop&Hbase 安装见https://github.com/Will-Grindelwald/Coursework/tree/master/BDMS_2016_spring/hw1/安装与配置, 以下是将hadoop源码转成eclipse项目导入eclipse中
# sudo apt-get install g++ maven protobuf-compiler=2.5.0 cmake zlib1g-dev findbugs
# cd hadoop的源码目录
# cd ./hadoop-maven-plugins
# mvn install
# cd ../** 你想构建的项目目录
# mvn eclipse:eclipse -DskipTests

##################################
# Ubuntu

# echo "dconf Editor"        #系统配置编辑器
# sudo apt-get install dconf-editor

# Unity Tweak Tool

# echo "开始安装 在终端打开"
# sudo apt-get install nautilus-open-terminal

# echo "点击应用程序 Launcher 图标即可最小化"
# gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true

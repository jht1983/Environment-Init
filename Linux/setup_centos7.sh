#!/bin/bash

##################################
# For Cent OS 7
##################################

sudo yum update
sudo yum upgrade
sudo yum autoremove
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm
sudo rpm -ivh epel-release-7-8.noarch.rpm
sudo yum repolist
rm rpm -ivh epel-release-7-8.noarch.rpm

#### 1 软件

# 自定义命令别名
echo "source ~/.ljc_alias" >> ~/.ljcrc
echo "source ~/.ljcrc" >> ~/.bashrc

# 终端提示符彩色显示
echo 'export PS1="\[\e[32;1m\][\u@\h:\[\e[34;1m\]\w\[\e[32;1m\]]$>\[\e[0m\]"' >> ~/.bashrc
#sudo echo 'export PS1="\[\e[32;1m\][\u@\h:\[\e[34;1m\]\w\[\e[32;1m\]]$>\[\e[0m\]"' >> /root/.bashrc
# 想改哪个用户的提示符, 就放到那个用户的 ~/.bashrc 中, 尽量不要动全局变量, 如 /etc/profile、/etc/bash.bashrc, 同时 ~/.bashrc 是最后读取的, 不会被 overwrite
# .vimrc同理

# 常用软件
echo "installing 'git ssh cmake tree htop man-zh rar shutter'"
sudo yum install -y git openssh cmake tree htop man-pages-zh rar shutter

# 配置 ssh
/etc/init.d/ssh start       # 启动 ssh
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa; cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys; chmod 644 ~/.ssh/authorized_keys; ssh localhost # 无密码登录 ssh

# 配置 git 的 ssh keys 与 gpg keys

# 配置 vim
echo "installing 'Vim Customized by Ljc'"     # 作为主力 终端界面的 编辑器, 保证适用简洁高效
sudo yum install -y vim ctags cscope astyle
# install vimdoc@cn from vimcdoc.sourceforge.net
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/Vim/setup && sh -x setup

# 配置 VSCode
#wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/VSCode/settings.json -P ~/.config/Code/User
#wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/VSCode/keybindings.json -P ~/.config/Code/User

# echo "zsh"
sudo yum install -y zsh
wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/Zsh/setup && sh -x setup

# 为知笔记

# echo "protocol-buffer"
#sudo yum install -y protobuf-compiler

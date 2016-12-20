#!/bin/bash

# 终端提示符彩色显示
echo 'export PS1="\[\e[32;1m\][\u@\h:\[\e[34;1m\]\w\[\e[32;1m\]]$>\[\e[0m\]"' >> ~/.bashrc
#sudo echo 'export PS1="\[\e[32;1m\][\u@\h:\[\e[34;1m\]\w\[\e[32;1m\]]$>\[\e[0m\]"' >> /root/.bashrc
# 想改哪个用户的提示符, 就放到那个用户的 ~/.bashrc 中, 尽量不要动全局变量, 如 /etc/profile、/etc/bash.bashrc, 同时 ~/.bashrc 是最后读取的, 不会被 overwrite
# .vimrc同理

# 常用软件
echo "installing 'git ssh cmake tree htop man-zh'"
sudo apt-get install git ssh cmake tree htop manpages-zh
sudo yum install git openssh cmake tree htop man-pages-zh

# 配置 ssh
/etc/init.d/ssh start       # 启动 ssh
cd ~; ssh-keygen -t rsa -P ""; cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys; chmod 644 ~/.ssh/authorized_keys; ssh localhost # 无密码登录 ssh

# 配置 `t` 为 tree 的快捷命令
echo "alias t='tree -ah --du'" >> ~/.bashrc
#sudo echo "alias t='tree -ah --du'" >> /root/.bashrc

# 配置 ls 命令
echo "alias ll='ls -alF'" >> ~/.bashrc
echo "alias la='ls -A'" >> ~/.bashrc
echo "alias l='ls -CF'" >> ~/.bashrc

# 配置 git 的 ssh keys 与 gpg keys

# 配置 vim
echo "installing 'Vim Customized by Ljc'"     # 作为主力 终端界面的 编辑器, 保证适用简洁高效
sudo apt-get install vim ctags cscope astyle
sudo yum install vim ctags cscope astyle
# install vimdoc@cn from vimcdoc.sourceforge.net
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/Vim/setup && sh -x setup

# 配置 VSCode
cd ~/.config/Code/User
wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/VSCode/settings.json
wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/VSCode/keybindings.json
cd -

# echo "zsh"
#sudo apt-get install zsh

# echo "protocol-buffer"
#sudo apt-get install protobuf-compiler

##################################
# For Ubuntu

# echo "installing 'dconf Editor'"        # 系统配置编辑器
sudo apt-get install dconf-editor

# echo "installing 'Unity Tweak Tool'"    # Unity 桌面自定制工具
sudo apt-get install unity-tweak-tool

# echo "配置 '点击应用程序 Launcher 图标即可最小化'"
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true

# echo "installing 'gksu'"                # 使 GUI 程序使用 sudo
#sudo apt-get install gksu

# echo "installing 'open-in-terminal''"
#sudo apt-get install nautilus-open-terminal

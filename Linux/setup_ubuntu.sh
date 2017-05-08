#!/bin/bash

##################################
# For Ubuntu
##################################

sudo apt-get update
sudo apt-get upgrade
sudo apt autoremove

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
echo "installing 'git ssh cmake tree htop manpages-zh rar shutter tmux mosh'"
sudo apt-get install -y git ssh cmake tree htop manpages-zh rar shutter tmux mosh

# 配置 ssh
/etc/init.d/ssh start       # 启动 ssh
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa; cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys; chmod 644 ~/.ssh/authorized_keys; ssh localhost # 无密码登录 ssh

# 配置 git 的 ssh keys 与 gpg keys

# 配置 vim
echo "installing 'Vim Customized by Ljc'"     # 作为主力 终端界面的 编辑器, 保证适用简洁高效
sudo apt-get install -y vim ctags cscope astyle
# install vimdoc@cn from vimcdoc.sourceforge.net
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/Vim/setup && sh -x setup

# 配置 VSCode
#wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/VSCode/settings.json -P ~/.config/Code/User
#wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/VSCode/keybindings.json -P ~/.config/Code/User

# echo "zsh"
sudo apt-get install -y zsh
wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/Zsh/setup && sh -x setup

# 为知笔记
#sudo add-apt-repository ppa:wiznote-team
#sudo apt-get update
#sudo apt-get install -y wiznote

# echo "protocol-buffer"
#sudo apt-get install -y protobuf-compiler

#### 2 美化

# echo "installing 'Unity Tweak Tool'"    # Unity 桌面自定制工具
sudo apt-get install -y unity-tweak-tool

sudo add-apt-repository ppa:noobslab/themes
sudo add-apt-repository ppa:noobslab/icons
sudo apt-get update
sudo apt-get install -y flatabulous-theme
sudo apt-get install -y ultra-flat-icons
sudo apt-get install -y fonts-wqy-microhei
# 打开 unity-tweak-tool 软件, 修改主题为 Flatabulous, 图标为 Ultra-flat, 指针为 Dmz-black, 字体为 文泉驿等宽微米黑 Regular
sudo apt-get install cairo-dock cairo-dock-plug-ins
# 开机启动: Super + a 找到 `启动应用程序` 添加 Cairo-Dock `/usr/bin/cairo-dock`

# echo "installing 'gksu'"                # 使 GUI 程序使用 sudo
#sudo apt-get install -y gksu

#### 3 配置

# echo "installing 'dconf Editor'"        # 系统配置编辑器
sudo apt-get install -y dconf-editor

# echo "配置 '点击应用程序 Launcher 图标即可最小化'"
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true

# echo "installing 'open-in-terminal''"
#sudo apt-get install -y nautilus-open-terminal

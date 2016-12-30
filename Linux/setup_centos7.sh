#!/bin/bash

##################################
# For Cent OS 7
##################################

sudo yum update
sudo yum upgrade
sudo yum autoremove

#### 1 软件

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
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s /bin/zsh
sudo yum install -y autojump
mkdir -p ~/.oh-my-zsh/custom/plugins/incr
wget -q http://mimosa-pudica.net/src/incr-0.2.zsh -P ~/.oh-my-zsh/custom/plugins/incr/ -O incr.plugin.zsh
sed -i 's/plugins=(git)/plugins=(git autojump incr)/g' ~/.zshrc
# 要是使用 vim 命令补全有问题 1. rm ~/.zcom* 2. exec zsh 3. 重启终端
# 只要有提示 insecure directories, 运行 compaudit 找出 insecure directories, 然后去掉 组 的 写权限
# sudo -s 提示 insecure directories, chown -R root ~/.oh-my-zsh; chmod -R 755 ~/.oh-my-zsh

# 为知笔记

# echo "protocol-buffer"
#sudo yum install -y protobuf-compiler

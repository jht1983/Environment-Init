#!/bin/bash
function MYECHO(){
  echo -e "\033[44;37m$1\033[0m"
}

function usage(){
  MYECHO "usage: ./setup.sh for CentOS 7 & Debian 9"
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
    ;;
esac

__CUR__=$(cd `dirname $0`; pwd)

MYECHO "# ---------- 配置 zshrc ---------- #"

# 插件 autojump
$__PKG__ install -y autojump

# 插件 incr
mkdir -p ~/.oh-my-zsh/custom/plugins/incr
wget -q http://mimosa-pudica.net/src/incr-0.2.zsh -P ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/incr/
mv ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/incr/incr-0.2.zsh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/incr/incr.plugin.zsh

# 插件 zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 插件 zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# 插件 autoenv
git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv

# 主题
wget -q https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/Zsh/ljc.zsh-theme -P ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ljc"/g' ~/.zshrc

# 设置
sed -i '/# HIST_STAMPS="mm\/dd\/yyyy"/a\HIST_STAMPS="yyyy-mm-dd"' ~/.zshrc
sed -i '/# ENABLE_CORRECTION="true"/a\ENABLE_CORRECTION="true"' ~/.zshrc
sed -i '/# COMPLETION_WAITING_DOTS="true"/a\COMPLETION_WAITING_DOTS="true"' ~/.zshrc

# 我的自定义
sed -i '/source $ZSH\/oh-my-zsh.sh/a\\nsource ~/.ljcrc' ~/.zshrc

# 插件
# PS：incr 很酷炫，就是年久失修，有点不稳定 如在终端输入 echo $'hello world\x21' 终端会关闭？
# PS2：autoenv 插件在 centos 下有问题, 先禁掉
if [ $__CASE__ = 1 ]; then
  sed -i 's/^  git$/  autojump colored-man-pages colorize cp extract git history history-substring-search mosh rsync screen ssh-agent sudo web-search zsh-autosuggestions incr zsh-syntax-highlighting/g' ~/.zshrc
elif [ $__CASE__ = 4 ]; then
  sed -i 's/^  git$/  autoenv autojump colored-man-pages colorize cp extract git history history-substring-search mosh rsync screen ssh-agent sudo web-search zsh-autosuggestions incr zsh-syntax-highlighting/g' ~/.zshrc
fi

sed -i 's/^  git$/  autoenv autojump colored-man-pages colorize cp extract git history history-substring-search mosh rsync screen ssh-agent sudo web-search zsh-autosuggestions incr zsh-syntax-highlighting/g' ~/.zshrc

echo 'setopt HIST_IGNORE_DUPS' >> ~/.zshrc
echo "alias -s html='vim'
alias -s rb='vim'
alias -s py='vim'
alias -s js='vim'
alias -s c='vim'
alias -s java='vim'
alias -s txt='vim'
alias -s tar='x'
alias -s gz='x'
alias -s tgz='x'
alias -s bz2='x'
alias -s xz='x'
alias -s zip='x'
alias -s rar='x'" >> ~/.zshrc

# Wiki: https://github.com/robbyrussell/oh-my-zsh/wiki
# https://github.com/robbyrussell/oh-my-zsh/wiki/Cheatsheet
# https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins#web-search
# https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins-Overview

# 要是使用 vim 命令补全有问题 1. rm ~/.zcom* 2. exec zsh 3. 重启终端
# 只要有提示 insecure directories, 运行 compaudit 找出 insecure directories, 然后去掉 组 的 写权限
# sudo -s 提示 insecure directories, chown -R root ~/.oh-my-zsh; chmod -R 755 ~/.oh-my-zsh


take 看看 which take 就知道它有什么用了

巧用tab
自动完成

tab用到最多的就是自动完成,比如cd进入某个目录，可以输入该目录的中的几个字母，然后tab自动补全。
你不必输入整个目录名称，只需输入初始几个可以唯一区别与其他目录的字母，Zsh会自动匹配出剩余部分。
(cd敲太多是不是烦了？在oh-my-zsh中进入某个路径不需要带cd)

环境变量展开

在Zsh中，你可以按下tab键来展开shell中的环境变量值

kill命令补全

通常我们想要杀死某个进程，一般都要先ps下查看进程，然后kill杀掉。使用zsh可以键入 kill <tab> 就会列出所有的进程名和对应的进程号

命令参数补全

不用 man or --help

智能跳转
首先需要安装插件aotojump，zsh会自动记录你访问过的目录，通过 j + 目录名可以直接进行目录跳转，而且目录名支持模糊匹配和自动补全，例如你访问过Develop目录，输入j develo 即可正确跳转。

目录浏览和跳转：输入 d，即可列出你在这个会话里访问的目录列表，输入列表前的序号，即可直接跳转。

多窗口 history 共享

1: 使用 ** 作为下级目录的通配符:   通配符搜索：ls -l **/*.sh，可以递归显示当前目录下的 shell 文件，文件少时可以代替 find。使用 **/ 来递归搜索
$ ls **/*.pyc
foo.pyc bar.pyc lib/wibble.pyc
$ rm **/*.pyc
$ ls **/*.pyc
2: 在文件筛选中使用匹配模式:
$ ls *.(py|sh)
3: 在文件筛选中使用修饰符，如：(@) 限制只匹配符号链接：
$ ls -l *(@)
5: 也可以用制表符来自动补全命令选项：
$ python -[TAB]
6: 或者在kill的时候自动完成：
$ kill Dock[TAB]
7: 在制表符自动补全时，可以使用光标键（上下左右等）：
$ man zsh[TAB][DOWN][RIGHT][LEFT][UP]
8: 自动修改错误的输入：
$ pythn -V
zsh: correct 'pythn' to 'python' [nyae]? y
Python 2.7.1
9: 使用r来重复上一条命令，可以带替换方式！
$ touch foo.htm bar.htm
$ mv foo.htm foo.html
$ r foo=bar
mv bar.htm bar.html


-='cd -'
...=../..
....=../../..
.....=../../../..
......=../../../../..
1='cd -'
2='cd -2'
3='cd -3'
4='cd -4'
5='cd -5'
6='cd -6'
7='cd -7'
8='cd -8'
9='cd -9'
_=sudo
afind='ack -il'
alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
colorize=colorize_via_pygmentize
d='dirs -v | head -10'
ggpur=ggu
h=history
history='fc -il 1'
hsi='hs -i'
l='ls -CF'
la='ls -AF'
ll='ls -alF'
lsa='ls -lah'
md='mkdir -p'
please=sudo
po=popd
pu=pushd
rd=rmdir
rsync-copy='rsync -avz --progress -h'
rsync-move='rsync -avz --progress -h --remove-source-files'
rsync-synchronize='rsync -avzu --delete --progress -h'
rsync-update='rsync -avzu --progress -h'
t='tree -ah --du'
which-command=whence
x=extract

g=git
ga='git add'
gaa='git add --all'
gapa='git add --patch'
gau='git add --update'
gb='git branch'
gba='git branch -a'
gbd='git branch -d'
gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'
gbl='git blame -b -w'
gbnm='git branch --no-merged'
gbr='git branch --remote'
gbs='git bisect'
gbsb='git bisect bad'
gbsg='git bisect good'
gbsr='git bisect reset'
gbss='git bisect start'
gc='git commit -v'
'gc!'='git commit -v --amend'
gca='git commit -v -a'
'gca!'='git commit -v -a --amend'
gcam='git commit -a -m'
'gcan!'='git commit -v -a --no-edit --amend'
'gcans!'='git commit -v -a -s --no-edit --amend'
gcb='git checkout -b'
gcd='git checkout develop'
gcf='git config --list'
gcl='git clone --recursive'
gclean='git clean -fd'
gcm='git checkout master'
gcmsg='git commit -m'
'gcn!'='git commit -v --no-edit --amend'
gco='git checkout'
gcount='git shortlog -sn'
gcp='git cherry-pick'
gcpa='git cherry-pick --abort'
gcpc='git cherry-pick --continue'
gcs='git commit -S'
gcsm='git commit -s -m'
gd='git diff'
gdca='git diff --cached'
gdct='git describe --tags `git rev-list --tags --max-count=1`'
gdt='git diff-tree --no-commit-id --name-only -r'
gdw='git diff --word-diff'
gf='git fetch'
gfa='git fetch --all --prune'
gfo='git fetch origin'
gg='git gui citool'
gga='git gui citool --amend'
ggpull='git pull origin $(git_current_branch)'
ggpush='git push origin $(git_current_branch)'
ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
ghh='git help'
gignore='git update-index --assume-unchanged'
gignored='git ls-files -v | grep "^[[:lower:]]"'
git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
gk='\gitk --all --branches'
gke='\gitk --all $(git log -g --pretty=%h)'
gl='git pull'
glg='git log --stat'
glgg='git log --graph'
glgga='git log --graph --decorate --all'
glgm='git log --graph --max-count=10'
glgp='git log --stat -p'
glo='git log --oneline --decorate'
glog='git log --oneline --decorate --graph'
gloga='git log --oneline --decorate --graph --all'
glol='git log --graph --pretty='\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
glola='git log --graph --pretty='\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit --all'
glp=_git_log_prettily
glum='git pull upstream master'
gm='git merge'
gmom='git merge origin/master'
gmt='git mergetool --no-prompt'
gmtvim='git mergetool --no-prompt --tool=vimdiff'
gmum='git merge upstream/master'
gp='git push'
gpd='git push --dry-run'
gpoat='git push origin --all && git push origin --tags'
gpristine='git reset --hard && git clean -dfx'
gpsup='git push --set-upstream origin $(git_current_branch)'
gpu='git push upstream'
gpv='git push -v'
gr='git remote'
gra='git remote add'
grb='git rebase'
grba='git rebase --abort'
grbc='git rebase --continue'
grbi='git rebase -i'
grbm='git rebase master'
grbs='git rebase --skip'
grh='git reset HEAD'
grhh='git reset HEAD --hard'
grmv='git remote rename'
grrm='git remote remove'
grset='git remote set-url'
grt='cd $(git rev-parse --show-toplevel || echo ".")'
gru='git reset --'
grup='git remote update'
grv='git remote -v'
gsb='git status -sb'
gsd='git svn dcommit'
gsi='git submodule init'
gsps='git show --pretty=short --show-signature'
gsr='git svn rebase'
gss='git status -s'
gst='git status'
gsta='git stash save'
gstaa='git stash apply'
gstc='git stash clear'
gstd='git stash drop'
gstl='git stash list'
gstp='git stash pop'
gsts='git stash show --text'
gsu='git submodule update'
gts='git tag -s'
gtv='git tag | sort -V'
gunignore='git update-index --no-assume-unchanged'
gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
gup='git pull --rebase'
gupv='git pull --rebase -v'
gwch='git whatchanged -p --abbrev-commit --pretty=medium'
gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'

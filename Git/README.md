# Git

## 配置

git config --global core.quotepath false # 使 git 命令输出中的中文正确显示
git config --global core.autocrlf false # 提交检出均不转换 crlf -> lf
git config --global core.safecrlf true # 拒绝提交包含混合换行符的文件

git config --global user.email "ljclg_1516@foxmail.com"
git config --global user.name "Will Grindelwald"

配置 ssh: ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa; cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

## 使用

见 [blog](http://blog.lyogvce.me/2017-06/Git-Flow-And-Git-Command)

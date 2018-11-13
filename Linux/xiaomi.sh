#!/bin/bash
function MYECHO(){
  echo -e "\033[44;37m$1\033[0m"
}

function usage(){
  MYECHO "usage: ./xiaomi.sh for ubuntu 18.04"
}

function CheckYes(){
  condition=-100
  while (( $condition==-100 ))
  do
    echo -n "$1"
    read -t 5 in
    case $in in
    Yes|yes|Y|y) condition=1 ;;
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
'ubuntu 18.04')
    __CASE__=3
    __PKG__="sudo apt"
    ;;
*)
    MYECHO "本机的系统不受支持"
    usage
    exit 1
    ;;
esac

__CUR__=$(cd `dirname $0`; pwd)

MYECHO "# ----------------- 配置 小米 办公 开发使用的工具 ----------------- #"

mioffice wifi https://wiki.n.miui.com/pages/viewpage.action?pageId=59146091
vpn           https://v.mioffice.cn
relay         https://wiki.n.miui.com/pages/viewpage.action?pageId=39626128
浏览器 代理      http://infra.d.xiaomi.net/spark/userDoc/configure-web-proxy.html
xiaomi 邮箱     https://wiki.n.miui.com/pages/viewpage.action?pageId=58474335
xiaomi 办公打印机 https://wiki.n.miui.com/pages/viewpage.action?pageId=97006141&preview=%2F97006141%2F97006033%2F%E3%80%90%E6%89%93%E5%8D%B0%E6%9C%BA%E3%80%91%E6%89%93%E5%8D%B0%E6%9C%BA%E8%BF%9E%E6%8E%A5%E6%95%99%E7%A8%8B--Canon.pdf
phabricator     https://wiki.n.miui.com/pages/viewpage.action?pageId=3608126
SonarLint       https://wiki.n.miui.com/pages/viewpage.action?pageId=36339754
小米的代码规范    从git@git.n.xiaomi.com:xiaomi-commons/coding-standard.git检出coding standard文件，导入到编辑器中。（注意intellij导入checkstyle的jar包直接走file->import settings导入）。

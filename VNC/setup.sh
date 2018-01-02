#!/bin/bash
function MYECHO(){
  echo -e "\033[44;37m$1\033[0m"
}

function usage(){
  MYECHO "usage: ./setup.sh <num> for CentOS 7, display <num> for current user"
  MYECHO "usage: ./setup.sh       for Debian 9"
  exit 1
}

# init
source /etc/os-release

case "$ID $VERSION_ID" in
'centos 7')
    __CASE__=1
    __PKG__="sudo yum"
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

if [ $__CASE__ = 1 ]; then
  if [ $# != 1 ]; then usage; fi
fi

MYECHO "#--------------- 安装 VNC ---------------#"

if [ $__CASE__ = 1 ]; then

  # 1 install tigervnc tigervnc-server
  $__PKG__ install -y tigervnc tigervnc-server

  # 2 复制一份配置文件 给 1 号 display
  sudo cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:$1.service

  # 3 修改配置文件
  sudo sh -c "sed -i 's/^User=<USER>/User=will/g' /etc/systemd/system/vncserver@:$1.service"
  sudo sh -c "sed -i 's/^PIDFile=\/home\/<USER>\/.vnc\/%H%i.pid/PIDFile=\/home\/will\/.vnc\/%H%i.pid/g' /etc/systemd/system/vncserver@:$1.service"

  # 4 设置 可操作密码 仅观看密码
  MYECHO "输入 vnc 的 访问密码 及 仅观看密码"
  vncpasswd
  # echo '111111\n111111\ny\n123456\n123456\n' | vncpasswd

  # 5 删掉 /tmp/.X11-unix
  sudo rm -rf /tmp/.X11-unix

  # 6 加载服务
  sudo systemctl daemon-reload
  # sudo systemctl enable vncserver@:$1.service
  sudo systemctl start vncserver@:$1.service

  # 7 修改 远程桌面显示配置文件 然后重启服务
  echo "#!/bin/bash
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
startxfce4 &      # xfce
# gnome-session & # GNOME desktop
# startkde &      # kde desktop
# twm &           # Text interface
# exec /usr/bin/fluxbox" > ~/.vnc/xstartup
  sudo systemctl stop vncserver@:$1.service

  # 8 设置 防火墙
  sudo firewall-cmd --zone=public --add-port=$(echo "5900+$1" | bc)/tcp --permanent
  sudo firewall-cmd --reload

elif [ $__CASE__ = 4 ]; then

  # 1 install vnc4server
  $__PKG__ install -y vnc4server xtightvncviewer

  # 2 设置 可操作密码 仅观看密码
  MYECHO "输入 vnc 的 访问密码 及 仅观看密码"
  vncpasswd
  # echo '111111\n111111\ny\n123456\n123456\n' | vncpasswd

  # 3 修改 远程桌面显示配置文件
  echo "#!/bin/bash
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
startxfce4 &      # xfce
# gnome-session & # GNOME desktop
# startkde &      # kde desktop
# twm &           # Text interface
# exec /usr/bin/fluxbox" > ~/.vnc/xstartup

fi

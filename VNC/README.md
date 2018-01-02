# VNC

## Windows

* server: 安装 tightvnc 即可, 可配置 管理密码 仅观看密码 可操作密码
* client: realvnc 的 client 比较好用

## Linux

一键配置脚本

curl -sLf https://raw.githubusercontent.com/Will-Grindelwald/Environment-Init/master/VNC/setup.sh | bash -s -- 1

### CentOS 7

#### Step 1 install tigervnc tigervnc-server

```sh
sudo yum install -y tigervnc tigervnc-server
```

#### Step 2 配置 for CentOS 7

根据配置文件 /lib/systemd/system/vncserver@.service 文件自述

```sh
# The vncserver service unit file
#
# Quick HowTo:
# 1. Copy this file to /etc/systemd/system/vncserver@.service
# 2. Replace <USER> with the actual user name and edit vncserver
#    parameters appropriately
#   ("User=<USER>" and "/home/<USER>/.vnc/%H%i.pid")
# 3. Run `systemctl daemon-reload`
# 4. Run `systemctl enable vncserver@:<display>.service`
```

1. 复制一份 给 1 号 display

    ```sh
    sudo cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service
    ```

1. 编辑 /etc/systemd/system/vncserver@:1.service, 将 `User=<USER>` and `/home/<USER>/.vnc/%H%i.pid` 两处 `<USER>` 改为 要用 VNC 登陆的用户名

    ```sh
    sudo vi /etc/systemd/system/vncserver@:1.service
    ```

    ```sh
    [Unit]
    Description=Remote desktop service (VNC)
    After=syslog.target network.target

    [Service]
    Type=forking
    User=will                             # or root

    # Clean any existing files in /tmp/.X11-unix environment
    ExecStartPre=-/usr/bin/vncserver -kill %i
    ExecStart=/usr/bin/vncserver %i
    PIDFile=/home/will/.vnc/%H%i.pid      # or /root/.vnc/%H%i.pid
    ExecStop=-/usr/bin/vncserver -kill %i

    [Install]
    WantedBy=multi-user.target
    ```

1. **登录上面配置的用户**, 设置 可操作密码 仅观看密码

    ```sh
    vncpasswd
    ```

1. 删掉 /tmp/.X11-unix

    ```sh
    sudo rm -rf /tmp/.X11-unix
    ```

1. 设置服务自启(感觉没必要, 浪费资源)

    ```sh
    sudo systemctl daemon-reload
    sudo systemctl enable vncserver@:1.service
    sudo systemctl start vncserver@:1.service
    ```

1. 远程桌面显示配置文件 ~/.vnc/xstartup

    ```sh
    #!/bin/bash
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
    # exec /usr/bin/fluxbox
    ```

    重启 `sudo systemctl restart vncserver@:1.service`

1. 设置 防火墙

    ```sh
    # sudo firewall-cmd --zone=public --add-service=vnc-server # 不起作用
    sudo firewall-cmd --zone=public --add-port=5901/tcp --permanent
    sudo firewall-cmd --reload
    ```

PS: 要更多的用户连接，需要创建配置文件和开放端口。创建 vncserver@:2.service 并替换配置文件里的用户名和之后步骤里相应的文件名、端口号。请确保你登录 VNC 服务器用的是你之前配置 VNC 密码的时候使用的那个用户名。

PS: 第一个 VNC 服务会运行在5901（5900 + 1）端口上，之后的依次增加，运行在5900 + x 号端口上。其中 x 是指之后用户的配置文件名 vncserver@:x.service 里面的 x 。

PS: 同一个 display 是多人同时操作的, 但实体机的那个屏幕没法被共享出去, 与 windows 不同

#### Step 3 使用 for CentOS 7

开

```sh
sudo systemctl start vncserver@:1.service
# or
vncserver :1
```

关

```sh
sudo systemctl stop vncserver@:1.service
# or
vncserver -kill :1
```

PS: 指定分辨率, 可以加 -geometry 1366x768 类似参数, (可以指定多个分辨率, 以方便在客户端使用 xrandr 切换)

```sh
vncserver -kill :1               # 先关掉
vncserver -geometry 1920x1080 :1  # 再打开 带参数
```

### Debian 9

#### Step 1 install vnc4server

```sh
sudo apt install -y vnc4server
```

#### Step 2 配置 for Debian 9

1. 登录上面的用户, 设置 可操作密码 仅观看密码

    ```sh
    vncpasswd
    ```

1. 远程桌面显示配置文件 ~/.vnc/xstartup

    ```sh
    #!/bin/bash
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
    # exec /usr/bin/fluxbox
    ```

    重启 `sudo systemctl restart vncserver@:1.service`

PS: 第一个 VNC 服务会运行在5901（5900 + 1）端口上，之后的依次增加，运行在5900 + x 号端口上。

PS: 同一个 display 是多人同时操作的, 但实体机的那个屏幕没法被共享出去, 与 windows 不同

#### Step 3 使用 for Debian 9

```sh
vncserver :1        # 开
vncserver -kill :1  # 关
```

PS: 指定分辨率, 可以加 -geometry 1366x768 类似参数, (可以指定多个分辨率, 以方便在客户端使用 xrandr 切换)

```sh
vncserver -kill :1               # 先关掉
vncserver -geometry 1366x768 :1  # 再打开 带参数
```

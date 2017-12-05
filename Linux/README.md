# Linux

Linux 下的一些环境初始化

推荐:

* CentOS7 mini + Xfce 日常不开 GUI -> 作为服务器
* Debian 9 作为 GUI 使用

不推荐:

* fedora 更新太快, 正真好的稳定的技术都并入 CentOS 了
* Ubuntu 的技术一直以来变动太大(17.10 起 改用 Gnome)
* Deepin 国人的技术 且 离 Ubuntu 越来越远, 不看好

## CentOS7

默认已开启 ssh 且已安装 vmware tools

* 安装时配置好网络(安完了就不用在终端环境下配置网络了)
* 最小安装(or 最小安装 + 开发工具)
* <
* VMWare: 重启后, 先添加 一个桥接的网络适配器, 用 IPV6
* 用 WinSCP 拷入脚本, 运行脚本 ./setup.sh
* 修改运行级别, 见: ChangeTarget.sh
* 初始化桌面: 选 XFce
* 重启 再运行脚本 ./butify.sh
* 自动重启 运行脚本 ./configure.sh

## Debian 9

配置一个 IPV6 的网卡(下的快)(因为必须联网下语言包，否则安装完中文是方框), 再安装

安装选项:

* Debian desktop environment
* Xfce
* SSH server
* standard system utilities

* 编辑 /etc/apt/sources.list, 移除 cd-rom 源
* 先安装 sudo: apt install sudo + vi /etc/sudoers + `<username> ALL=(ALL) ALL` + :wq! 强制保存
* 重启后, 先安 vmware tools, 再重启
* <
* 拷入脚本, 运行脚本 ./setup.sh 然后 ./butify.sh
* 自动重启 运行脚本 ./configure.sh

## Fedora 27

默认未开启 ssh 但已安装 vmware tools

* 标准安装
* <
* 添加 一个桥接的网络适配器, 用 IPV6
* 拷入脚本, 运行脚本 ./setup.sh
* 初始化桌面: 选 XFce
* 运行脚本 ./butify.sh
* 自动重启 运行脚本 ./configure.sh

## Ubuntu/Xubuntu/Lubuntu 16.04

    PS: Ubuntu 18.04 是一个重大更新的 LTS, 大部分设置都变了！不向前兼容！
    放弃 Unity 使用 Gnome, 使用 Wayland。
    GDM 也替换 LightDM 成为了默认的显示管理器。并且现在登录屏使用 1 号虚拟终端，而不是之前的 7 号虚拟终端。
    设置 DNS 的方法又变了
    似乎比 Unity 快且稳定

默认未安装 ssh 且未安装 vmware tools

* 断网安装: 安装时会下载, 慢死
* VMWare: 重启后, 先安 vmware tools, 再重启
* <
* 拷入脚本, 添加两个网络适配器: NAT & 桥接, IPV4 & IPV6, 运行脚本 ./setup.sh
* 安装语言支持
* 运行脚本 ./butify.sh
* 自动重启 运行脚本 ./configure.sh

## 桌面选择

候选: KDE Plasma 5、Gnome 3、XFCE 4、lxde/lxqt、Deepin、mate/gnome-classic、cinnamon、Budgie

1. 为性能考虑, 决定使用轻量级 DE
1. Centos 仅可用 Gnome KDE mate Xfce(来自 epel) fedora 可用的更多
1. Debian 9 默认 DE 是 Xfce, 可选 KDE Gnome LXDE mate
1. Ubuntu 全可用, 且有风味版 Lubuntu Xubuntu Kubuntu(做的差劲) UbuntuMate UbuntuBudgie

为了统一安装效果、试用体验、配置成本, 在体验过诸多桌面后, 决定使用 Xfce(主) & LXDE(次) 作为 DE

| OS+DE:       | 安装时下载 | 空载占内存 |
| --- | --- | --- |
| Debian+LXDE  | (1172个包) | (286M) |
| Debian+Xfce  | (1169个包) | (311M) |
| Debian+Gnome | (1501个包) | (630M?) |
| CentOS+Gnome |           | (570M) |
| Debian+KDE   | (1666个包) | (570M) |
| Deepin       |           | (950M) |

其中 Xfce 作为常用 DE, Centos Fedora Debian Ubuntu 都支持
在 Debian/Ubuntu 计算节点上, 需要极端性能考虑安装 LXDE, 仅用于应急, 不做美化
Xfce 比 LXDE 重一点点, 美观许多

方案一: Debian + 默认 DE: Xfce
方案二: Centos mini + Xfce
方案三: Lubuntu(弃用, 真要用 LXDE 就用 Debian + LXDE)
采用 标准安装+桌面 而不是 风味版 的原因: 标准安装最稳定; 大多 GUI 程序为 Gnome/KDE 设计，有了标准安装中的 Gnome 会稳定些

#!/bin/bash
function MYECHO(){
  echo -e "\033[44;37m$1\033[0m"
}

function usage(){
  MYECHO "usage: ./butify.sh for CentOS 7 & Debian 9 & ubuntu 18.04"
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
'centos 7')
    __CASE__=1
    __PKG__="sudo yum"
    ;;
'fedora 27')    # 本脚本不再维护此方案
    __CASE__=2
    __PKG__="sudo dnf"
    ;;
'ubuntu 18.04')
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
    exit 1
    ;;
esac

__CUR__=$(cd `dirname $0`; pwd)

MYECHO "# ----------------- Starting 美化 ----------------- #"

MYECHO "# ------------ 1 主题 ------------ #"

# 安装方法: sudo cp -r 到 /usr/share/themes 即可
# 外观主题选择: Adapta(低分屏选 Adapta-Eta)
# 窗口管理器主题: numix

if [ $__CASE__ = 3 ]; then
  gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
fi

MYECHO "# -------- 1.0 Adapta -------- #"
# https://github.com/adapta-project/adapta-gtk-theme
if [ $__CASE__ = 1 ]; then # CentOS 7 编译要求的包不同！
  $__PKG__ install -y autoconf automake inkscape sassc libglib2.0-dev libsass0 libxml2-utils pkg-config parallel gdk-pixbuf2-devel
elif [ $__CASE__ = 3 ]; then
  $__PKG__ install -y inkscape libgdk-pixbuf2.0-dev libglib2.0-dev libxml2-utils pkg-config sassc parallel
elif [ $__CASE__ = 4 ]; then
  $__PKG__ install -y autoconf automake inkscape sassc libgdk-pixbuf2.0-dev libglib2.0-dev libsass0 libxml2-utils pkg-config parallel
fi
# git clone https://github.com/adapta-project/adapta-gtk-theme.git
tar xzf adapta-gtk-theme.tar.gz
cd adapta-gtk-theme
./autogen.sh --enable-parallel --enable-chrome
make
sudo make install
cd $__CUR__
rm -rf adapta-gtk-theme adapta-gtk-theme.tar.gz

MYECHO "# -------- 1.1 numix -------- #"
# https://github.com/numixproject/numix-gtk-theme 总体 略显老旧
$__PKG__ install -y numix-gtk-theme

### 1.2 arc-theme
# https://github.com/horst3180/arc-theme 稍微单调了点
# $__PKG__ install -y arc-theme

### 1.3 Flatabulous
# https://github.com/anmoljagetia/Flatabulous 在 Xfce 上兼容不好
# only for Ubuntu 安装方法见 github

# 还有这个不错(仅用于gnome) https://github.com/nana-4/materia-theme

MYECHO "# ------------ 2 图标 ------------ #"

# 安装方法: sudo cp -r 到 /usr/share/icons 即可
# 选择: Flat-Remix

MYECHO "# -------- 2.0 Flat-Remix -------- #"
# https://github.com/daniruiz/Flat-Remix 不错
tar xzf Flat-Remix.tar.gz
sudo cp -r ./Flat-Remix/Fl* /usr/share/icons
rm -rf Flat-Remix Flat-Remix.tar.gz

### 2.1 ultra-flat-icons
# https://www.gnome-look.org/p/1171748/ 图标有点少

### 2.2 numix-icon-theme
# https://github.com/numixproject/numix-icon-theme 有点老派
# $__PKG__ install -y numix-icon-theme

### 2.3 numix-icon-theme-circle
# https://github.com/numixproject/numix-icon-theme-circle numix-icon 圆形变种

### 2.4 numix-icon-theme-square
# https://github.com/numixproject/numix-icon-theme-square numix-icon 方形变种

MYECHO "# ------------ 3 字体加强 ------------ #"

# 字体安装方法:
# Step 1 将字体文件夹 sudo cp -r 到 /usr/share/fonts
# Step 2 将字体文件夹中的文件权限改为 755, 使非 root 用户可以使用 `sudo chmod 755 *`
# Step 3 在字体文件夹目录下, 依次执行下列命令
# ```
# sudo mkfontscale # 如果提示 mkfontscale: command not found，则需要安装 apt-get install ttf-mscorefonts-installer
# sudo mkfontdir
# sudo fc-cache -fv # 如果提示 fc-cache: command not found，则需要安装 apt-get install fontconfig
# ```

# PS1: 字体大小 & DPI 很重要
# PS2: 折腾 Infinality？ https://github.com/FZUG/repo/wiki/%E9%85%8D%E7%BD%AE-Infinality-%E5%AD%97%E4%BD%93%E6%B8%B2%E6%9F%93%E5%A2%9E%E5%BC%BA
# PS3: 特定程序的字体要单独改 浏览器 编辑器

MYECHO "# ----- 3.0 Noto sans, Noto serif, Noto mono ----- #"
if [ $__CASE__ = 1 ]; then
  $__PKG__ install -y google-noto-cjk-fonts
elif [ $__CASE__ = 3 ]; then # ubuntu 18.04 安装完扩展包就有了
  MYECHO "nothing 1"
elif [ $__CASE__ = 4 ]; then # Debian 9 自带
  MYECHO "nothing 1"
fi

MYECHO "# -------- 3.1 Source Sans Pro -------- #"
if [ $__CASE__ = 1 ]; then
  $__PKG__ install -y adobe-source-code-pro-fonts
elif [ $__CASE__ = 3 -o $__CASE__ = 4 ]; then # Ubuntu 1804、Debian 9 手动安装
  tar xzf Souce\ Code\ Pro.tar.gz
  sudo cp -r ./Souce\ Code\ Pro/ /usr/share/fonts
  cd /usr/share/fonts/Souce\ Code\ Pro/
  sudo chmod 755 *
  sudo mkfontscale
  sudo mkfontdir
  sudo fc-cache -fv
  cd $__CUR__
  rm -rf Souce\ Code\ Pro/ Souce\ Code\ Pro.tar.gz
fi

### 3.2 文泉驿微米黑
# 已经过时了！

MYECHO "# ------------ 4 面板 ------------ #"

MYECHO "# -------- 4.0 面板插件 -------- #"
if [ $__CASE__ = 1 ]; then
  $__PKG__ install -y xfce4-whiskermenu-plugin xfce4-battery-plugin xfce4-clipman-plugin xfce4-datetime-plugin xfce4-netload-plugin xfce4-wavelan-plugin xfce4-screenshooter-plugin
  # $__PKG__ install -y xfce4-timer-plugin # 并没有
elif [ $__CASE__ = 4 ]; then # Debian 9 自带这几个
  MYECHO "nothing 2"
fi

# 查看仓库里都有哪些面板插件
# sudo apt search xfce4-.*-plugin
# sudo yum search xfce plugin

### 4.1 面板配置(见下一节)

MYECHO "# ------------ 5 设置 ------------ #"

MYECHO "# ------- 5.1 改英文目录名 ------- #"

if [ $__CASE__ = 1 -o $__CASE__ = 4 ]; then # CentOS 7 Debian 9
  sed -e 's/桌面/Desktop/g' \
    -e 's/下载/Downloads/g' \
    -e 's/模板/Templates/g' \
    -e 's/公共/Public/g' \
    -e 's/文档/Documents/g' \
    -e 's/音乐/Music/g' \
    -e 's/图片/Pictures/g' \
    -e 's/视频/Videos/g' \
    -i ~/.config/user-dirs.dirs
  mv ~/桌面 ~/Desktop
  mv ~/下载 ~/Downloads
  mv ~/模板 ~/Templates
  mv ~/公共 ~/Public
  mv ~/文档 ~/Documents
  mv ~/音乐 ~/Music
  mv ~/图片 ~/Pictures
  mv ~/视频 ~/Videos
  # 注销后生效 还要删除一个 `桌面` 文件夹
elif [ $__CASE__ = 3 ]; then   # for ubuntu 18.04
  export LANG=en_US
  xdg-user-dirs-gtk-update # 在弹出的窗口中询问是否将目录转化为英文路径, 同意并关闭.
  export LANG=zh_CN
fi

# Ubuntu 另有方法

MYECHO "# ------- 5.2 改壁纸 ------- #"

if [ $__CASE__ = 1 -o $__CASE__ = 4 ]; then # CentOS 7 Debian 9
  mv Desktop.jpg .config/
elif [ $__CASE__ = 3 ]; then
  mkdir ~/Picture/Wallpapers
  mv Desktop.jpg ~/Picture/Wallpapers
fi

MYECHO "# ---- 5.3 配置 终端模拟器 ---- #"

# 1. ubuntu
# 1.1 未验证?安装 dconf-tools 找到 /org/gnome/desktop/applications/terminal 修改
# exec terminator
# exec-arg -e
# 1.2 ubuntu 自带快捷键 Ctrl+Alt+T
# 2. Centos7 Gnome
# 2.1 未验证?安装 gconf-editor 找到 /desktop/gnome/applications/terminal 修改
# exec terminator
# exec-arg -e
# 2.2 设置 -> 键盘 滑到最下面 添加 `名称 Terminal 命令 terminator 快捷键 Ctrl+Alt+T`
# 3. Centos7 Xfce / Xubuntu
# 3.1 设置 -> 首选应用程序 -> 实用程序 -> 终端模拟器 设为 其它 terminator
# 3.2 设置 -> 键盘 -> 应用程序快捷键 添加 `命令 terminator 快捷键 Ctrl+Alt+T`

# 拷入配置文件
mv terminator ~/.config/terminator

MYECHO "# ------- 5.4 配置 桌面 ------- #"

# for xfce4
# PS: 所有设置都保存在 ~/.config/ 下, 可以将配置文件保存以重复设置
#
# 窗口管理器
#
# * 样式 主题 Numix 标题字体 noto sans cjk sc Regular 10
# * 键盘 <全屏 F11> <移动窗口至上/下一个工作区 Shift+Ctrl+Alt+左/右> <显示桌面 Super+D>
# * 高级 勾选`窗口吸附至其他窗口`
#
# 窗口管理器微调
#
# * 工作区 取消选择 `使用滚轮切换工作区`
# * 合成器 不活动窗口的不透明度 0.8左右
#
# 面板
#
# * 删掉 面板1
# * 面板2
#     * 显示 尺寸: 行大小 42 长度 100
#     * 外观 Alpha 70
#     * 项目
#         * 默认的全删掉
#         * 添加 Clipman DateTime PulseAudio Whisker (Wavelan查看器) (定时器) 窗口按钮 窗口菜单 3个分隔符 通知区域 网络监视器
#         * 排序 Whisker 分隔符 窗口菜单 分隔符 窗口按钮 分隔符 (定时器) Clipman (Wavelan查看器) PulseAudio 通知区域 网络监视器 DateTime
#         * 插件设置
#             * Whisker
#                 * 调一下大小
#                 * 外观: 图标和标题 标题: Start 勾选`显示层级菜单`
#                 * 行为: 勾选`悬浮鼠标以切换` `面板按钮旁放置类目`
#             * 窗口菜单 布局: 箭头 显示工作区动作
#             * 窗口按钮 窗口组: 总是 勾选`停在按钮上时绘制窗口边框`
#             * 所有分隔符 透明 最后一个分隔符 扩展
#             * 通知区域 像素 28 取消选择 `显示边框`
#             * 网络监视器 取消选择 `要显示的文字` 设备 形如 ens33 的设备号
#             * DateTime 先时间后日期 字体: Source Code Pro Bold 15(Debian)/11(CentOS)
#
# 外观
#
# * 样式 Adapta/Adapta-Eta(低分屏)
# * 图标 Flat Remix
# * 字体加强
#     * 选择字体 noto sans cjk sc Regular 12
#     * 启用抗锯齿 全部(Debian)/微略(CentOS) RGB?
#     * DPI 根据 http://pxcalc.com/ 计算的设
#
# 文件管理器
#
# * 显示
#     * 勾选 `以二进制格式显示文件大小`
#     * 格式 `2017-01-01 00:00:00`
# * 视图 位置选择器: 路径栏样式
#
# 桌面
#
# * 壁纸
# * 菜单 取消选择 `右击包含应用程序菜单`
# * 图标 大小 80 默认图标 取消选择 `主文件夹` `文件系统`
#
# 键盘 - 快捷键
#
# | 快速启动器 | xfce4-appfinder                    | Super+R |
# | 终端      | exo-open --launch TerminalEmulator | Ctrl+Alt+T |
# | 文件浏览器 | exo-open --launch FileManager      | Super+1 Super+E |
# | 网络浏览器 | exo-open --launch WebBrowser       | Super+2 Super+W |
# | 锁屏      | xflock4                            | Super+L |
# | 全屏截图   | xfce4-screenshooter -f             | Print |
# | 窗口截图   | xfce4-screenshooter -w             | Alt+Print |
# | 矩形截图   | xfce4-screenshooter -r             | Shift+Print |

if [ $__CASE__ = 1 -o $__CASE__ = 4 ]; then # CentOS 7 Debian 9
  rm -rf ~/.config/xfce4
  if [ $__CASE__ = 1 ]; then
    mv xfce4-centos7 ~/.config/xfce4
  elif [ $__CASE__ = 4 ]; then
    mv xfce4-debian ~/.config/xfce4
  fi
  sudo reboot
  # 若失败, 再次替换 ~/.config/xfce4 迅速重启
fi

if [ $__CASE__ = 3 ]; then
  MYECHO "ubuntu 1804 须手动使用 gnome-tweak-tool 改变壁纸、主题、字体、电池百分比、时钟日历"

  #  设置
  #    区域和语言  设置 语言
  #    通用辅助功能 大号文本 光标大小
  #    电源       不自动挂起 电源按钮功能
  #    日期时间    自动设置时区
  #    键盘       快捷键
  #
  #  优化
  #    外观   主题 Adapta, 光标 DMZ-Black, 图标 Flat-Remix, 背景&锁屏
  #    字体   noto sans cjk sc Regular
  #    工作区  工作区包括附加显示器
  #    开机启动程序 redshift vera。。。
  #    扩展    。。。
  #    电源   笔记本盖子关闭时 不挂起
  #    窗口   标题栏按钮 左？
  #    顶栏   电池 百分比, 始终 +日期&秒&周数

fi



| 类型 | 软件 |
| --- | --- |
| 浏览器        | chrome |
| 输入法        | 搜狗输入法 fcitx-pinyin sunpinyin |
| 视频播放器    | vlc |
| 音频          | 网易云音乐 |
| 文件比较      | meld kdiff |
| 文件浏览器    | dolphin |
| 虚拟机        | kvm vmware vbox |
| office 软件   | libreoffice wps |
| 桌面工具      | plank cairo-dock（plank 轻量些，cairo-dock 就有点夸张了，感觉有了这个原生的面板都可以不要了，gnome，lxde，mate 的用户可以考虑下） |
| 键鼠共享      | synergy |
| 翻译          | 有道词典（支持屏幕取词） |
| 各种解码器     | ffmpeg sudoyum install ffmpeg-libs gstreamer-ffmpeg libmatroska xvidcore libdvdread libdvdnav |
| 其他          | wine ss-qt5 |

# 为知笔记
#sudo add-apt-repository ppa:wiznote-team
#sudo apt-get update
#sudo apt-get install -y wiznote

Libreoffice 中文语言包
yum install -y libreoffice-langpack-zh-Hans*

yum-axelget 是 EPEL 提供的一个 yum 插件 大大提高了软件的下载速度
yum -y install yum-axelget
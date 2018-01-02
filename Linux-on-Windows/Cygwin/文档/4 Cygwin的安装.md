# Cygwin的安装

1.1 2.1. Cygwin是可以在Windows下执行的Linux运行环境
本来我是安装了Linux10，但是使用过程中还是需要经常回到windows查看一些文档啊、拷贝一些文件啊，太烦了，所以呢还是决定把Cygwin搞起来，这样在windows下工作就方便多了。
Cygwin的安装有两种方法：
一种是直接在线安装，这是按配置需要下载的，但是下载的东西会很多很大，400M左右，需要的时间比较长。
第二种是先到macraigor下载一个安装包，60多M，下载速度很快。安装选项也简单。然后再执行在线安装，安装Ncurses libraries就可以了。
我开始使用第一种方法，搞了几天，重复了很多次，可老是安装不好，最后还是用第二种方法搞定的。
1.2 2.2. 下载
1.2.1 2.2.1. CYGWIN(2.0.0)
See document: [http://www.macraigor.com/full_gnu.htm](http://www.macraigor.com/full_gnu.htm) <[http://www.macraigor.com/full_gnu.htm](http://www.macraigor.com/full_gnu.htm)> 
60M.下载速度很快，我用ADSL下载速度达到70多K，比一般下载得快多了，不过我是后半夜下载的。：）
1.3 2.3. 安装
从macraigor下载的Cygwin2.0直接安装就可以了，安装过程很简单。但是似乎缺少一个组件Ncurses libraries，在make menuconfig的时候会报错，需要执行在线安装的步骤添加这个组件。
1.4 2.4. 在线安装
1.4.1 2.4.1. 下载setup.exe
See document: [www.cygwin.com](http://www.cygwin.com/) <[outbind://1/www.cygwin.com](outbind://1/www.cygwin.com)> 
登陆[www.cygwin.com](http://www.cygwin.com/)，页面上有一个Install Cygwin Now的连接，是一个setup.exe文件，直接打开也可以，推荐下载下来，存到一个目录里，这样可以把文件下载下来，以后安装就方便了。
1.4.2 2.4.2. 安装选项
必须安装的子目录（sub category）: （把子目录旁边的”default”用鼠标点一下，直到变成”install”）
Archive
Base
Devel：包括gcc、make等编译工具
Libs
Net
DEShells
Utils: 包括bzip2等实用工具
如果是已经从macraigor下载安装了Cygwin,那么选择安装 Devel下的libncurses-devel一项就可以了。
大家可选择较快的下载地址，我是用的[mirrors.rcn.net](http://mirrors.rcn.net/)，下载速度在20k左右。
必须通过cygwin提供的setup.exe进行安装，可根据安装提示一步一步进行，提供通过internet安装方式或本地安装方式。建议把cygwin整个安装包下载到本地再进行本地安装比较方便。如果无特殊需求，可简单按它的缺省安装方式安装最少数量的软件包。建议不要安装到c:\下。cygwin的问题和解答可参考cygwin FAQ。
1.5 设置
1.5.1 批处理文件
在自己生成交叉编译器之前，首先对Cygwin进行一些设置。假设Cygwin安装在e目录下，在打开Cygwin窗口之前，进入到E：＼Cygwin目录。在这个目录下，有一个文件名为Cygwin．bat的批处理文件，编辑该文件，在第一行后加入set CYGWIN=title ntea，这是因为Cygwin的启动批处理文件需要启动Unix文件系统模拟。修改完毕且保存后退出。
1.5.2 SH链接
运行cygwin,在根目录下输入，cd bin 
mv sh.exe sh-original.exe 
ln –s bash.exe sh.exe 
现在对cygwin的修改搞定
1.6 2.5. 运行
从程序组或者桌面启动Cygwin。
输入：
cd /
ls
能列出目录说明就ok了。
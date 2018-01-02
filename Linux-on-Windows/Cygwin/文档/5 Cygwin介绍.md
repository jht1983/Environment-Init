# Cygwin介绍

Cygwin是一个用于在Windows上模拟Linux环境的软件。它可以作为那些虚拟机软件的一个部分替代品。之所以将它排在第一个来介绍，是因为它实在给我帮了很大的忙。

运行Cygwin后，你会得到一个类似Linux的Shell环境，在其中你可以使用绝大部分Linux软件和功能。如Gcc,Make,Vim,Emacs等等。总之如果你想使用某个Linux下的功能，而windows上又找不到好的替代品的话，你就可以用Cygwin。我使用的最频繁的是Gcc和Make。我经常用它们来编译一些我从网上下载的开源的工程。这些工程在Windows上编译往往很麻烦。我也用它做过X Server来连接一台真正的Linux服务器，用来测试一个用tcl/tk编写的跨平台的用户界面程序。下面，我逐步介绍Cygwin的基本用法。

## 使用

安装完成后，在桌面上会有一个Cygwin的图标，双击它，会出现一个windows的命令窗口，过一会，你就会见到熟悉(或者陌生)的 Linux的Shell界面。试一试ls ，是不是可以工作了？

从今往后，你就可以自由的在windows下使用Linux的软件了。基本上你能用到，cygwin都有。如果你要开发可以在两个平台上运行的程序， cygwin也是你前期试验的好地方。从互联网上下载的各种开源代码，也可以在Cygwin里编译，运行，调试。下面介绍一些使用技巧,更多地还要靠大家自己探索拉！

使用Cygwin访问windows的文件
Cygwin安装后，其根目录位于你的安装目录下。所以使用cd /，只能访问到你的安装目录，要访问硬盘上的其他文件，可以使用mount:
mount D:/testdir ~/testdir
这样，你就可以在~/testdir里访问到D:/testdir里的内容了。

使用Cygwin作为X Server
现在的Linux服务器一般都提供X，要从Windows上使用Linux的X，需要在Windows上运行一个X Server。有一些专门为windows开发的软件可以做这个，但是Cygwin自带的X server就可以胜任。下面举例说明如何使用：
首先你必须安装X11包，然后运行Cygwin shell，输入x&。这时候你的桌面上出出现一个布满斜纹大窗口，这就是我们的X server了，回头Linux机器上的X 程序就会显示在这里：

 
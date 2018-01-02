# Cygwin的使用方法

由于自己的项目需要使用Linux内核，所以自己在windows下安装了一个Linux虚拟机！自己实在忍受不了这种速度，随想用cygwin进行替代，毕竟我只是使用Linux内核的部分命令就好。今天下午进行了实验，效果不错，从网上找到了这篇文章，做为cygwin的入门文章！写的不错，enjoy it！

**原文如下：**

By EnterBD[BCT]
QQ:4791821
E-Mail:Taynni@Gmail.com
欢迎转载和指出错误,但请保留以上信息,谢谢.
0:简介
1:下载和安装
2:使用
简介
Cygwin是一个运行于Windows下的免费的UNIX的子系统,使用一个Dll(动态链接库)来
实现,这样,我们可以开发出Cygwin下的UNIX工具,使用这个DLL运行在Windows下,大家可以想
一下,你在运行Windows的同时,也可以使用VI,BASH,TAR,SED等UNIX下的工具,不是很好吗?这个VM
虚拟机有很相同的原理,但是VM是虚拟多个,而Cygwin是同时使用Windows和UNIX,很爽吧,这样
对于那些在Windows和Unix下移植的程序来说是比较简单的事情了.
一:下载和安装
其下载安装程序在[Http://www.cygwin.com,下载安装程序以后,运行,然后会要你选择是通过什么方](http://www.cygwin.com,%E4%B8%8B%E8%BD%BD%E5%AE%89%E8%A3%85%E7%A8%8B%E5%BA%8F%E4%BB%A5%E5%90%8E,%E8%BF%90%E8%A1%8C,%E7%84%B6%E5%90%8E%E4%BC%9A%E8%A6%81%E4%BD%A0%E9%80%89%E6%8B%A9%E6%98%AF%E9%80%9A%E8%BF%87%E4%BB%80%E4%B9%88%E6%96%B9/)
式进行下载安装所需要的文件,有三种方式,Http.Ftp.本地,我建议你首先通过Http和Ftp把安装所需要的
文件全部下回来以后选择本地安装比较好,在线安装比较慢,会是一个很长的等待,虽然所需要的文件
不大,但是全部安装的话会是4G大小,还是有选择性的安装吧,在安装界面,有Prev(老版本),Curr(当前版本)
Exp(最新版本测试版本),苹果这里建议你选择Curr,然后你单击View按钮,这样你可以在可以使用的安装
文件之间进行选择性的安装,如果你真的想全部安装的话,那么左键点击一下最上面的All,然后看到
INSTALL,这样选择了全部,进行全部安装便可以了,安装完以后,会在桌面产生一个图标,双击这个图标,
呵呵,你便可以使用Cygwin了.关于安装的具体参数方法,网络上有比较详细的介绍,我就不罗嗦了.
PS:下载方面我建议如下:你可以下载以下几个版本的Cygwin:

您现在可以使用Cygwin.cn的镜像，详情请参考[安装]
原始站: [http://sources.redhat.com/cygwin/;](http://sources.redhat.com/cygwin/;) 
印地安那大学的免安砚光盘cygwin, 叫做 XLiveCD:[http://xlivecd.indiana.edu/](http://xlivecd.indiana.edu/) , 
USA, Indiana [ftp://ftp.ussg.indiana.edu/pub/xlivecd/xlivecd-20041201.iso](ftp://ftp.ussg.indiana.edu/pub/xlivecd/xlivecd-20041201.iso) 
Mirrors: 
Belgium, Geel [ftp://sin.khk.be/mirror/xlivecd/xlivecd-20041201.iso](ftp://sin.khk.be/mirror/xlivecd/xlivecd-20041201.iso) 
Germany, Bochum [ftp://linux.rz.ruhr-uni-bochum.de/xlivecd/xlivecd-20041201.iso](ftp://linux.rz.ruhr-uni-bochum.de/xlivecd/xlivecd-20041201.iso) 
Germany, Bochum [http://linux.rz.ruhr-uni-bochum.de/download/xlivecd/xlivecd-20041201.iso](http://linux.rz.ruhr-uni-bochum.de/download/xlivecd/xlivecd-20041201.iso) 
Sweden, Ume? [http://ftp.acc.umu.se/mirror/xlivecd/xlivecd-20041201.iso](http://ftp.acc.umu.se/mirror/xlivecd/xlivecd-20041201.iso) 
USA, Wisconsin [ftp://xlivecd.mirrors.tds.net/pub/xlivecd/xlivecd-20041201.iso](ftp://xlivecd.mirrors.tds.net/pub/xlivecd/xlivecd-20041201.iso) 
USA, Georgia [ftp://ftp.gtlib.cc.gatech.edu/pub/XLiveCD/xlivecd-20041201.iso](ftp://ftp.gtlib.cc.gatech.edu/pub/XLiveCD/xlivecd-20041201.iso) 
USA, Georgia [http://ftp.gtlib.cc.gatech.edu/pub/XLiveCD/xlivecd-20041201.iso](http://ftp.gtlib.cc.gatech.edu/pub/XLiveCD/xlivecd-20041201.iso) 
苹果提示:USA, Wisconsin [ftp://xlivecd.mirrors.tds.net/pub/xlivecd/xlivecd-20041201.iso](ftp://xlivecd.mirrors.tds.net/pub/xlivecd/xlivecd-20041201.iso)
这个下载速度快 
Shelley Yen 的cygnuwin : [ftp://ftp.tceb.edu.tw/pub/free_software/cygnuwin/](ftp://ftp.tceb.edu.tw/pub/free_software/cygnuwin/) 
[ftp://ftp.tcc.edu.tw/iso/cygwin/cyg+gnu.iso](ftp://ftp.tcc.edu.tw/iso/cygwin/cyg+gnu.iso)(cygwin 与 gnuwin 的合成版本)
老古开发网:[ftp://ic.laogu.com/down/cygwin.rar](ftp://ic.laogu.com/down/cygwin.rar)
[http://soft.laogu.com/down/cygwin.rar](http://soft.laogu.com/down/cygwin.rar) (均为05年3月版本)
苹果提示:这个站点是高人站点,比较NB,呵呵,喜欢单片机的朋友有福气,超级多 的下载资料等着你,包含*NIX下的东西...
其他的镜像站点:[http://cygwin.com/mirrors.html](http://cygwin.com/mirrors.html)
苹果自己也下载了最新版本的Cygwin，但是偶没有空间，真的需要的话，请哪位好心人提供空间
偶可以上传上去，联系请加偶的QQ:4791821，或者给偶发邮件:Taynni@gmail.com注明一下就可以了. 
二:使用
使用上的方便性很是不错，启动Cygwin以后，会在Windows下得到一个Bash Shell，由于Cygwin是以
Windows下的服务运行的，所以很多情况下和在Linux下有很大的不同，这点上，苹果建议你多理解下这个
工作环境。我们开始使用Cygwin吧，比如PS，相当于Windows下的TM(任务管理器)，呵呵，直接Ps的话
那么得到的会是Cygwin下的Shell的进程如下
Taynni-417@ENTERBD-417 ~
$ ps
PID PPID PGID WINPID TTY UID STIME COMMAND
2212 1 2212 2212 con 1003 01:54:29 /usr/bin/bas
3384 2212 3384 3232 con 1003 01:59:24 /usr/bin/ps
如果这个时候你需要在Cygwin下显示Windows下的进程你可以在PS后面加上参数-aW，
PS的相关用法:

Quote 
Usage ps [-aefl] [-u uid]
-f = show process uids, ppids
-l = show process uids, ppids, pgids, winpids
-u uid = list processes owned by uid
-a, -e = show processes of all users
-s = show process summary
-W = show windows as well as cygwin processes

很容易看懂吧，呵呵
有点不一样的地方，我想大家一定想知道在Cygwin下怎么访问Windows下的内容了，
呵呵，首先使用DF命令直接查看下本地驱动器，呵呵，很容易了吧，显示的内容
如下:

Quote 
Taynni-417@ENTERBD-417 ~
$ df
Filesystem 1k-blocks Used Available Use% Mounted on
e:\cygwin\bin 10231384 4844432 5386952 48% /usr/bin
e:\cygwin\lib 10231384 4844432 5386952 48% /usr/lib
e:\cygwin 10231384 4844432 5386952 48% /
c: 5106676 1240312 3866364 25% /cygdrive/c
d: 10239408 6560328 3679080 65% /cygdrive/d
e: 10231384 4844432 5386952 48% /cygdrive/e
f: 6333252 4065564 2267688 65% /cygdrive/f
g: 7150972 4672724 2478248 66% /cygdrive/g

如上便是我的硬盘的全部了，在后面的/cygdrive/c便是C盘了，然后/cygdrive/d便是D盘了
这样的话，想进D盘便可以这样进，呵呵

Quote 
Taynni-417@ENTERBD-417 ~
$ cd /cygdrive/d
Taynni-417@ENTERBD-417 /cygdrive/d
$ ls -l
ls: pagefile.sys: Permission denied
total 0
drwxr-xr-x 9 Taynni-4 None 0 Aug 31 20:56 Book
drwxr-xr-x 2 Taynni-4 None 0 Aug 23 05:24 Ftproot
drwxr-xr-x 30 Taynni-4 None 0 May 10 23:38 HACKER
drwxr-xr-x 11 Taynni-4 None 0 Feb 1 2005 JIAOXUE
drwxr-xr-x 8 Taynni-4 None 0 Jan 3 2005 Local Settings
dr-xr-xr-x 24 Taynni-4 None 0 Oct 16 2004 My Documents
drwxr-xr-x 12 Taynni-4 None 0 May 14 16:48 Mywww
drwxr-xr-x 2 Taynni-4 None 0 Jun 29 2004 Recycled
drwxr-xr-x 3 Taynni-4 None 0 Aug 22 04:44 SECBOOK
drwxr-xr-x 6 Taynni-4 None 0 Feb 28 2005 TaynniCHX
drwxr-xr-x 15 Taynni-4 None 0 Mar 30 01:04 TaynniGZ
drwxr-xr-x 12 Taynni-4 None 0 May 11 01:30 TaynniH
drwxr-xr-x 15 Taynni-4 None 0 Mar 12 04:27 TaynniYM
drwxr-xr-x 6 Taynni-4 None 0 Dec 13 2004 Taynniwww
drwxr-xr-x 8 Taynni-4 None 0 Aug 31 20:55 Word
Taynni-417@ENTERBD-417 /cygdrive/d
$
在Cygwin下还可以运行Windows下的程序，如下:
Taynni-417@ENTERBD-417 ~
$ cmd.exe
Microsoft Windows XP [Version 5.1.2600]
(C) Copyright 1985-2001 Microsoft Corp.
e:\cygwin\home\Taynni-417>d:
D:\>cd hacker
D:\HACKER>cd tools
D:\HACKER\Tools>cd pstools
D:\HACKER\Tools\Pstools>ls
pdh.dll pskill.exe pspasswd.exe
Psinfo.exe psexec.exe pslist.exe psservice.exe
Pstools.chm psfile.exe psloggedon.exe psshutdown.exe
README.TXT psgetsid.exe psloglist.exe pssuspend.exe
D:\HACKER\Tools\Pstools>exit
Taynni-417@ENTERBD-417 ~
$

很明显的，直接输入CMD.EXE便可以得到一个本机CMDSHELL，这样你想运行什么程序都可以了
退出到Cygwin的Bash shell需要使用exit命令，很方便吧，呵呵
在Cygwin下还可以进行编译程序，比如C和perl，当然，你也可以借助ActivePy，这个东西也很不错
也是一个仿真器，在Windows下模拟perl的解释器.
对于一个系统而言，没有相应的系统工具是不可能的，在Cygwin下拥有的UNIX工具基本上够你使用
了。当然，这需要你安装完整的Cygwin包，我的机子上就安装了完整的，比较大，如果硬盘允许，苹果建
议你完整安装!像grep，cut，sed，strings，strace，md5sum，diff，patch，ssh，xxd，等等工具
你都可以进行安装和使用，如果你真的不知道应该怎么用这些工具，其实苹果很多也不会，只要去接触
你就会了！！！没有不会使用的东西，只有你愿意不愿意去使用而已！说笑了,言归正传，请使用
所要使用的命令 --help获取帮助，如下所示:比如我不知道md5sum做什么用的
（这个命令是用于效验文件md5值的，主要是为了文件的完整性和安全性）

Quote 
Taynni-417@ENTERBD-417 ~
$ md5sum --help
Usage: md5sum [OPTION] [FILE]...
or: md5sum [OPTION] --check [FILE]
Print or check MD5 (128-bit) checksums.
With no FILE, or when FILE is -, read standard input.
-b, --binary read files in binary mode (default on DOS/Windows)
-c, --check check MD5 sums against given list
-t, --text read files in text mode (default)
The following two options are useful only when verifying checksums:
--status don't output anything, status code shows success
-w, --warn warn about improperly formated checksum lines
--help display this help and exit
--version output version information and exit
The sums are computed as described in RFC 1321. When checking, the input
should be a former output of this program. The default mode is to print
a line with checksum, a character indicating type (`*' for binary, ` ' for
text), and name for each FILE.
Taynni-417@ENTERBD-417 ~
$

基本使用上应该没有多大的问题了，文章因为我偷懒，也是不知道该怎么写才可以帮助大家
我很苦恼的是，并没有人给我意见，所以先写这么点吧，如果你有问题的话，请加我的qq或者
给我邮件，大家可以讨论，不是么？
下面给出一些关于Cygwin的资料:
1:[http://www.isi.edu/nsnam/ns/ns-cygwin.html](http://www.isi.edu/nsnam/ns/ns-cygwin.html)
2:[http://pigtail.net/LRP/printsrv/cygwin-sshd.html](http://pigtail.net/LRP/printsrv/cygwin-sshd.html)
3:[http://kde-cygwin.sourceforge.net/](http://kde-cygwin.sourceforge.net/)
4:[http://x.cygwin.com/](http://x.cygwin.com/)
5:[http://chinyi.ncit.edu.tw/~peterju/cygwin.html](http://chinyi.ncit.edu.tw/~peterju/cygwin.html)
6:[http://cygnome.sourceforge.net/](http://cygnome.sourceforge.net/)
[http://xlivecd.indiana.edu/](http://xlivecd.indiana.edu/)
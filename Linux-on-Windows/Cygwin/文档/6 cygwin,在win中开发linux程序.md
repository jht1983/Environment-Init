# cygwin,在win中开发linux程序

cygwin,在win中开发linux程序 
作者：乾坤一笑 CSDN (2005-04-06 17:17:39) 
很多用windows的朋友不习惯于用linux的开发环境。虽然很乐意尝试一下，但是往往怕 linux系统打乱了自己的正常生活：1〉装linux系统把windows系统给搞坏了，导致自己无法正常生活；2>linux开发上手太难，写出第一个helloworld不亚于java的难度，环境配置摸不着头脑。对于此，我的看法是：路不管平还是陡，终归你要走的，如果你愿意投入到linux开发的社群中来，不会安装linux系统，不会配置工作环境是不能想象的。(事实上，确实要了解很多东西的原理，不然很难排错：诸如，硬盘引导器的引导原理、分区结构原理及linux分区结构和文件系统、环境变量的设置、种类繁多的压缩包安装包的解压安装方法、用户管理权限管理等常用命令、以至于驱动安装系统中文化等等异常琐碎的东东)。

本文试图跳过这个难走的步骤，启用一个win环境下的linux仿真器（和linux下面的命令行开发环境基本一致），用短短的20分钟的时间，教你做出一个纯正的linux下gcc编译的helloworld。就象是买点心前先尝尝味道，不也是一件很愉快的事情么？(注：cygwin事实上不仅有此模拟功能，它也是移植unix<-->win程序的一个很有效的工具，也有人用它来做嵌入式系统开发)

一、cygwin是什么？
   这个问题你最好google一下"cygwin的历史",或许能够获得更为详尽的答案。简而言之，cygwin是一个在windows平台上运行的 linux模拟环境，是cygnus solutions公司开发的自由软件（该公司开发了很多好东西，著名的还有eCos，不过现已被Redhat收购）。插一句废话，很多朋友不明白 linux和unix的区别和联系，在此也简要介绍一下。UNIX是一个注册商标，是要满足一大堆条件并且支付可观费用才能够被授权使用的一个操作系统; linux是unix的克隆版本，是由其创始人Linus和诸多世界知名的黑客手工打造的一个操作系统。为什么linux和unix之间有很多软件可以很轻松的移植？因为linux也满足POSIX规范,所以在运行机制上跟unix相近。   
   以下引用网上的一段话（出处：http://blog.csdn.net/glock18/archive/2004/07/10/38275.aspx），
用于说明cygwin的工作机制：cygnus当初首先把gcc，gdb，gas等开发工具进行了改进，使他们能够生成并解释win32的目标文件。然后，他们要把这些工具移植到windows平台上去。一种方案是基于win32 api对这些工具的源代码进行大幅修改，这样做显然需要大量工作。因此，他们采取了一种不同的方法——他们写了一个共享库(就是cygwin dll)，把win32 api中没有的unix风格的调用（如fork,spawn,signals,select,sockets等）封装在里面，也就是说，他们基于 win32 api写了一个unix系统库的模拟层。这样，只要把这些工具的源代码和这个共享库连接到一起，就可以使用unix主机上的交叉编译器来生成可以在 windows平台上运行的工具集。以这些移植到windows平台上的开发工具为基础，cygnus又逐步把其他的工具（几乎不需要对源代码进行修改，只需要修改他们的配置脚本）软件移植到windows上来。这样，在windows平台上运行bash和开发工具、用户工具，感觉好像在unix上工作。关于cygwin实现的更详细描述，请参考http://cygwin.com/cygwin-ug-net/highlights.html

二、cygwin的安装。
  cygwin的安装文件很容易通过google找到。目前国内的网站上有"网络安装版"和"本地安装版"两种。标准的发行版应该是  网络安装版。两者并无大不同，下面介绍一下安装的过程。

  step1. 下载后，点击安装文件(setup.exe)进行安装，第一个画面是GNU版权说明，点"下一步(N)—>"，
进入安装模式选择画面。

  step2. 安装模式有"Install from Internet"、"Download form Internet"、
"Install from Local Directory" 三种。"Install form Internet"就是直接从internet上装，适用于网速较快的情况。如果你和我一样网速不是很快，或者说装过之后想把下载的安装文件保存起来，下次不再下载了直接安装，就应该选择"Download form Internet"，下载安装的文件（大约40M左右）。
事实上，所谓的"本地安装版"，也是别人从网上下载全部文件后打的包(适用于中国国情嘛^_^)
  step3. 接下来是选择安装目的路径和安装源文件所在的路径，之后就进入了选择安装包所在的路径。
注意了阿，这里可是重头戏。我第一安装的时候就是没有看清这一步，结果没有把gcc装进去，导致没法编译文件。
   + All  Default
      + Admin Default
       ....
      + Devel   Default
      + Editors Default
      ....
如上图所示，你在这个TreeView的某个节点上双击，就可以改变它的状态，如Default、Install、Uninstall、Reinstall四种状态。默认的都是Default状态，很多工具的默认状态都是不安装。
在这里我选择了在All这一行上后面的Default上点Install，全部安装，以免后患。（注意：这里的树形控件和win下面的不同，你试试点在All上点 和 在All这一行后面的Default上点，会有不同的响应）

  step4. 点下一步，安装成功。它会自动在你的桌面上建立一个快捷方式。

  好了，下面就开始我的linux旅程了。双击cygwin的快捷方式进入系统。
首先介绍几个简单的linux命令。
pwd   显示当前的路径
cd    改变当前路径，无参数时进入对应用户的home目录
ls    列出当前目录下的文件。此命令有N多参数，比如ls -al
ps    列出当前系统进程
kill  杀死某个进程
mkdir 建立目录
rmdir 删除目录
rm    删除文件
mv    文件改名或目录改名
man   联机帮助
less  显示文件的最末几行

由于linux下面的命令大多都有很多参数，可以组合使用。所以，每当你不会或者记不清楚改用那个参数，那个开关的时候，可以用man来查找，比如，我想查找ls怎么使用，可以键入
$  man ls
系统回显信息如下：
LS(1)                          FSF                          LS(1)
NAME
       ls - list directory contents
SYNOPSIS
       ls [OPTION]... [FILE]...
DESCRIPTION
       List information about the FILEs (the current directory by
       default).  Sort entries alphabetically if none of -cftuSUX
       nor --sort.
       -a, --all
             do not hide entries starting with .
       -A, --almost-all
             do not list implied . and ..
       -b, --escape
             print octal escapes for nongraphic characters
       --block-size=SIZE
             use SIZE-byte blocks
:
很全是吧，嘿嘿。

好了，多说无意，让我们
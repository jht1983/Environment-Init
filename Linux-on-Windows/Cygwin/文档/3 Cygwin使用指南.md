# Cygwin使用指南

cygwin是一个在windows平台上运行的unix模拟环境，是cygnus
solutions公司开发的自由软件（该公司开发了很多好东西，著名的还有eCos，不过现已被Redhat收购）。它对于学习unix/linux操
作环境，或者从unix到windows的应用程序移植，或者进行某些特殊的开发工作，尤其是使用gnu工具集在windows上进行嵌入式系统开发，非
常有用。随着嵌入式系统开发在国内日渐流行，越来越多的开发者对cygwin产生了兴趣。本文将对其作一介绍。

根据cygwin user guide翻译整理，希望对大家有所帮助。有错误清指出。

1 引言
cygwin
是一个在windows平台上运行的unix模拟环境，是cygnus
solutions公司开发的自由软件（该公司开发了很多好东西，著名的还有eCos，不过现已被Redhat收购）。它对于学习unix/linux操
作环境，或者从unix到windows的应用程序移植，或者进行某些特殊的开发工作，尤其是使用gnu工具集在windows上进行嵌入式系统开发，非
常有用。随着嵌入式系统开发在国内日渐流行，越来越多的开发者对cygwin产生了兴趣。本文将对其作一介绍。

2 机理
cygnus
当初首先把gcc，gdb，gas等开发工具进行了改进，使他们能够生成并解释win32的目标文件。然后，他们要把这些工具移植到windows平台上
去。一种方案是基于win32
api对这些工具的源代码进行大幅修改，这样做显然需要大量工作。因此，他们采取了一种不同的方法——他们写了一个共享库(就是cygwin
dll)，把win32
api中没有的unix风格的调用（如fork,spawn,signals,select,sockets等）封装在里面，也就是说，他们基于
win32
api写了一个unix系统库的模拟层。这样，只要把这些工具的源代码和这个共享库连接到一起，就可以使用unix主机上的交叉编译器来生成可以在
windows平台上运行的工具集。以这些移植到windows平台上的开发工具为基础，cygnus又逐步把其他的工具（几乎不需要对源代码进行修改，
只需要修改他们的配置脚本）软件移植到windows上来。这样，在windows平台上运行bash和开发工具、用户工具，感觉好像在unix上工作。
关于cygwin实现的更详细描述，请参考[http://cygwin.com/cygwin-u...](http://cygwin.com/cygwin-ug-net/highlights.html)

(cygwin.com在电信ADSL似乎被屏蔽了，不知道原因。)
3 安装设置cygwin
3.1 安装
要安装网络版的cygwin，可以到[http://cygwin.com](http://cygwin.com/)，点击"Install Cygwin Now!"。这样会先下载一个叫做setup.exe的GUI安装程序，用它能下载一个完整的cygwin。按照每一屏的指示可以方便的进行安装。
3.2 环境变量
开始运行bash之前，应该设置一些环境变量。cygwin提供了一个.bat文件，里面已经设置好了最重要的环境变量。通过它来启动bash是最安全的办法。这个.bat文件安装在cygwin所在的根目录下。 可以随意编辑该文件。
CYGWIN变量用来针对cygwin运行时系统进行多种全局设置。开始时，可以不设置CYGWIN或者在执行bash前用类似下面的格式在dos框下把它设为tty 
C:\> set CYGWIN=tty notitle glob

PATH
变量被cygwin应用程序作为搜索可知性文件的路径列表。当一个cygwin进程启动时，该变量被从windows格式(e.g.
C:\WinNT\system32;C:\WinNT)转换成unix格式(e.g.,
/WinNT/system32:/WinNT)。如果想在不运行bash的时候也能够使用cygwin工具集，PATH起码应该包含x:\cygwin
\bin，其中x:\cygwin 是你的系统中的cygwin目录。
HOME变量用来指定主目录，推荐在执行bash前定义该变量。当
cygwin进程启动时，该变量也被从windows格式转换成unix格式，例如，作者的机器上HOME的值为C:\（dos命令set
HOME就可以看到他的值，set HOME=XXX可以进行设置），在bash中用echo $HOME看，其值为/cygdrive/c.
TERM变量指定终端型态。如果美对它进行设置，它将自动设为cygwin。
LD_LIBRARY_PATH被cygwin函数dlopen()作为搜索.dll文件的路径列表，该变量也被从windows格式转换成unix格式。多数Cygwin应用程序不使用dlopen,因而不需要该变量。 
3.3 改变cygwin的最大存储容量
Cygwin
程序缺省可以分配的内存不超过384
MB(program+data)。多数情况下不需要修改这个限制。然而，如果需要更多实际或虚拟内存，应该修改注册表的
HKEY_LOCAL_MACHINE或HKEY_CURRENT_USER区段。田家一个DWORD键heap_chunk_in_mb并把它的值设为
需要的内存限制，单位是十进制MB。也可以用cygwin中的regtool完成该设置。例子如下：
regtool -i set /HKLM/Software/Cygnus\ Solutions/Cygwin/heap_chunk_in_mb 1024
regtool -v list /HKLM/Software/Cygnus\ Solutions/Cygwin

4 使用cygwin
这一段讲一下cygwin和传统unix系统的不同之处。
4.1 映射路径名
4.1.1 引言
cygwin
同时支持win32和posix风格的路径，路径分隔符可以是正斜杠也可以是反斜杠。还支持UNC路径名。（在网络中，UNC是一种确定文件位置的方法，
使用这种方法用户可以不关心存储设备的物理位置，方便了用户使用。在Windows操作系统，Novell
Netware和其它操作系统中，都已经使用了这种规范以取代本地命名系统。在UNC中，我们不用关心文件在什么盘（或卷）上，不用关心这个盘（或卷）所
在服务器在什么地方。我们只要以下面格式就可以访问文件：
\服务器名\共享名\路径\文件名
共享名有时也被称为文件所在卷或存储设备的逻辑标识，但使用它的目的是让用户不必关心这些卷或存储设备所在的物理位置。）
符合posix标准的操作系统（如linux）没有盘符的概念。所有的绝对路径都以一个斜杠开始，而不是盘符（如c:）。所有的文件系统都是其中的子目录。例如，两个硬盘，其中之一为根，另一个可能是在/disk2路径下。
因
为许多unix系统上的程序假定存在单一的posix文件系统结构，所以cygwin专门维护了一个针对win32文件系统的内部posix视图，使这些
程序可以在windows下正确运行。在某些必要的情况下，cygwin会使用这种映射来进行win32和posix路径之间的转换。
4.1.2 cygwin mount表
cygwin
中的mount程序用来把win32盘符和网络共享路径映射到cygwin的内部posix目录树。这是与典型unix
mount程序相似的概念。对于那些对unix不熟悉而具有windows背景的的人来说，mount程序和早期的dos命令join非常相似，就是把一
个盘符作为其他路径的子目录。
路径映射信息存放在当前用户的cygwin mount表中，这个mount table
又在windows的注册表中。这样，当该用户下一次登录进来时，这些信息又从注册表中取出。mount
表分为两种，除了每个用户特定的表，还有系统范围的mount表，每个cygwin用户的安装表都继承自系统表。系统表只能由拥有合适权限的用户
（windows nt的管理员）修改。
当前用户的mount表可以在注册表"HKEY_CURRENT_USER/Software/Red Hat, Inc./Cygwin/mounts v" 下看到。系统表 
存在HKEY_LOCAL_MACHINE下。
posix
根路径/缺省指向系统分区，但是可以使用mount命令重新指向到windows文件系统中的任何路径。cygwin从win32路径生成posix路径
时，总是使用mount表中最长的前缀。例如如果c:被同时安装在/c和/，cygwin将把C:/foo/bar转换成/c/foo/bar.
如果不加任何参数地调用mount命令，会把Cygwin当前安装点集合全部列出。在下面的例子中，c盘是POSIX根，而d盘被映射到/d。本例中，根是一个系统范围的安装点，它对所有用户都是可见的，而/d仅对当前用户可见。
c:\> mount
f:\cygwin\bin on /usr/bin type system (binmode)
f:\cygwin\lib on /usr/lib type system (binmode)
f:\cygwin on / type system (binmode)
e:\src on /usr/src type system (binmode)
c: on /cygdrive/c type user (binmode,noumount)
e: on /cygdrive/e type user (binmode,noumount)
还可以使用mount命令增加新的安装点，用umount删除安装点。
当Cygwin
不能根据已有的安装点把某个win32路径转化为posix路径时，cygwin会自动把它转化到一个处于缺省posix路径/cygdrive下的的一
个安装点. 例如，如果Cygwin 访问Z:\foo，而Z盘当前不在安装表内，那么Z:\将被自动转化成/cygdrive/Z.
可以给每个安装点赋予特殊的属性。自动安装的分区显示为“auto”安装。安装点还可以选择是"textmode"还是 "binmode"，这个属性决定了文本文件和二进制文件是否按同样的方式处理。
4.1.3 其他路径相关信息
cygpath工具提供了在shell脚本中进行win32-posix路径格式转换的能力。
HOME, PATH,和LD_LIBRARY_PATH环境变量会在cygwin进程启动时自动被从Win32格式转换成了POSIX格式(例如，如果存在从该win32路径到posix路径的安装，会把c:\cygwin\bin转为/bin)。
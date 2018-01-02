# Cygwin vs minGW

## 1. 简介

### 1.1 Cygwin

Cygwin 提供运行于 Windows 平台的类 Unix 环境（以 GNU 工具为代表），为了达到这个目的，**Cygwin 提供了一套抽象层 dll，用于将部分 Posix 调用转换成 Windows 的 API 调用**，实现相关功能。这里面最典型的，最基本的模拟层就是那个 cygwin1.dll。随着 Linux 系统的发展壮大，目前的 Cygwin 已经不仅仅提供 POSIX 兼容，因此也顺带多了更多模拟层的依赖关系。

由于它的模拟层实现了相当良好的 Posix 兼容，人们试着将许多重要的 Linux/BSD 应用移植到了 Cygwin 下，使得 Cygwin 越来越大，功能也越来越丰富，以至于目前很多人直接把将 Linux 应用移植到 Windows 平台的任务都交给了 Cygwin（当然，这种移植并非原生）。事实上，Cygwin 诞生之初，本就是想通过 GCC 编译出 Windows 应用来，因为 bootstrap GCC 而顺带搞了一坨别的东西过来，最后发展到现在的。

小结：Cygwin 是运行于 Windows 平台的 POSIX“子系统”，**将 win32 api 封装成 unix api，在 win 上模拟了 linux 的接口，提供 Windows 下的类 Unix 环境**，并提供将部分 Linux 应用 “移植” 到 Windows 平台的开发环境的一套软件。

### 1.2 MinGW

MinGW，Minimalist GNU for Windows，**目的是让 Windows 用户可以用上 GNU 工具，比如 GCC**。**它主要提供了针对 win32 应用的 GCC 等工具，以及对等于 Windows SDK（的子集）的头文件和用于 MinGW 版本 链接器 的库文件（so、a 等，而不是 VC 的 lib）。**

MinGW 能够编译不包含 MFC 的、以 WinSDK 为主的 Windows 应用，并且**编译出来的应用不依赖于第三方的模拟层支持，其运行时为大部分 Windows 标配的 msvcrt（故称原生 Windows 应用）**。除此之外，MinGW 也支持 GCC 支持的其他语言。

因为这些原因，MinGW 被许多 Linux 上发展起来的开发工具选择为 Windows 版本的默认编译器，例如 CodeBlocks，DevC++。

小结：MinGW 是用于进行 Windows 应用开发的 GNU 工具链（开发环境），它的编译产物一般是原生 Windows 应用。虽然它本身不一定非要运行在 Windows 系统下（是的 MinGW 工具链也存在于 Linux、BSD 甚至 Cygwin 下）。

### 1.3 MinGW-w64

MinGW-w64，前面提到的 MinGW，是针对 32 位 Windows 应用开发的。而且由于版本问题，不能很好的支持较新的 Windows API。MinGW-W64 则是**新一代的 MinGW，支持更多的 API，支持 64 位应用开发，甚至支持 32 位 host 编译 64 位应用以及反过来的 “交叉” 编译**。除此之外，它本身也有 32 位和 64 位不同版本，其它与 MinGW 相同。

### 1.4 MSYS

MSYS，MinGW 开发者**从比较旧的 Cygwin 创建了一个分支，也用于提供类 Unix 环境**。但与 Cygwin 的大而全不同，MSYS 是冲着**小巧玲珑**的目标去的，**是用于辅助 Windows 版 MinGW 进行命令行开发的配套软件包，主要以基本的 Linux 工具为主，大小在 200M 左右，并且没有多少扩展能力**。提供了部分 Unix 工具以使得 MinGW 的工具使用起来方便一些。如果不喜欢庞大的 Cygwin，而且使用不多，可以试试。不过喜欢完整体验、不在乎磁盘占用等等，还是推荐 Cygwin 而不是 MSYS。

### 1.5 MSYS2

MSYS2，由于 MinGW 万年不更新，MSYS 更是，Cygwin 的许多新功能 MSYS 没有同步过来，于是 Alex 等人建立了**新一代的 MSYS 项目**。仍然是 fork 了 Cygwin（较新版），但有个更优秀的包管理器 pacman，有活跃的开发者跟用户组，有大量预编译的软件包（虽然肯定没有 Cygwin 多），对于不喜欢庞大的 Cygwin 的用户而言，可以试试 msys2。

## 2. 区别与联系

### 2.1 联系

均提供了部分 Linux 下的应用。另，MinGW 作为 Cygwin 下的软件包，可以在 Cygwin 上运行（即：有 Cygwin 版 MinGW）。

### 2.2 区别

#### 2.2.1 用途

Cygwin/MSYS/MSYS2 是在 win 上模拟 POSIX 系统，可以让 Linux 应用源码在 Windows 上跑起来。一般作为**提供 Linux 命令行环境的 Shell** or **将 Linux 应用一直到 win 上（通过 Cygwin DLL 调用 windows api 运行）**。

MinGW 是让 Windows 用户可以用上 GNU 工具，比如 GCC。一般作为**开发 Windows 应用的开发环境（用 GCC 作编译器）**（即 VS 代替者）。

#### 2.2.2 从能力上说

如果程序只用到 C/C++ 标准库，可以用 MinGW 或 Cygwin 编译。
如果程序还用到了 POSIX API，则只能用 Cygwin 编译。

#### 2.2.3 从依赖上说

程序经 MinGW 编译后可以直接在 Windows 上面运行。
程序经 Cygwin 编译后运行，需要依赖 Cygwin 附带的 cygwin1.dll。

#### 2.2.4 PS

Cygwin、MSYS/MSYS2 和 Git for Windows（Git bash） 里各有一套 Cygwin DLL 而且互不兼容。

## 安装

Cygwin：下最新版安装即可。

MinGW*：MinGW、MSYS 年久失修，MinGW-w64 更新还可以，但打包不及时，推荐第三方打包版：**MinGW Distro**（目前最新最全）、MSYS2（内部打包了MinGW-w64，在 github 上）、TDM-GCC（好久没更了）

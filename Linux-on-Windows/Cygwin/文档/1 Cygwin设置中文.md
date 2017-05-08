# Cygwin设置中文

cygwin\home\username\.bashrc

\# 让ls和dir命令显示中文和颜色 
alias ls='ls --show-control-chars --color' 
alias dir='dir -N --color' 
\# 设置为中文环境，使提示成为中文 
export LANG="zh_CN.GBK" 
\# 输出为中文编码 
export OUTPUT_CHARSET="GBK"

cygwin\home\username\.inputrc

\# 可以输入中文 
set meta-flag on 
set output-meta on 
set convert-meta off 
\# 忽略大小写 
set completion-ignore-case on

Cygwin工具是GNU工具在WIN32平台上的移植版本，它尽可能地遵循POSIX标准。其中包括C/C++编译器GCC，textutils，fileutils，bash等等。本文将阐述如何在Cygwin(B20)中使用中文。

Cygwin通过cygnus.bat（位于X:\cygnus\cygwin-b20）启动bash，内容如下： @ECHO OFF
SET MAKE_MODE=UNIX
SET PATH=c:\cygnus\CYGWIN~1\H-I586~1\bin;%PATH%
bash

在其中加入（bash之前）一句： set HOME=X:\homename

X:为盘符，\homename为已存在的目录名，例如C:\myHome。bash将到X:\homename目录下寻找初始化文件。 缺省情况下，bash命令行不能输入汉字，必须在X:\homename目录下建立文件.inputrc，内容如下： set meta-flag on
set convert-meta off
set output-meta on这几行主要是实现命令行上实现汉字的输入以及显示。 比如想输入汉字的文件名等等。

注意：在Cygwin-B20中.inputrc必须为UN*X文件格式。
bash在Windows 9X中不能接受来自DOS窗口的汉字输入。

为了让less命令显示汉字在X:\homename\.bashrc中加入： export LESSCHARSET=latin1

这个是cmd窗口属性的问题。
要修改注册表才能解 决问题：
有两种方法，第二种比较简单。

方法一：

Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Console\%SystemRoot%_system32_cmd.exe]
"CodePage"=dword:000003a8

小说明一下：
十六进制"000003a8"或十进制"936"，表示“936 (ANSI/OEM - 简体中文 GBK)”。
十 六进制"000001b5"或十进制"437"，表示“437 (OEM - 美国)

方法二：

同时使用：
[HKEY_CURRENT_USER\Console\%SystemRoot%_system32_cmd.exe]
在 注册表里面这个东西估计是运行过英文环境的程序导致的。
删掉这个注册表，cmd就回到中文环境了。
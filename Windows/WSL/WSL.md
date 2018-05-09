# WSL

目前可用 五个 发行版：ubuntu debian OpenSUSE SLES kali，将来还会有fedora，etc

我选 debian

## 陪 root 密码

```sh
sudo passwd
```

## 注意

### 1 不要在 windows 环境下改变 linux 文件

从 Windows 创建 / 更改 Linux 文件可能会导致数据损坏和 / 或损坏您的 Linux 环境，要求您卸载并重新安装发行版！

Linux 文件是指 `C:\Users\<user_name>\AppData\Local\Packages\TheDebianProject.DebianGNULinux_76v4gfsz19hv4` 下的所有文件

`C:\Users\<user_name>\AppData\Local\Packages\TheDebianProject.DebianGNULinux_76v4gfsz19hv4\LocalState\rootfs\home\<user_name>` 是 debian 下的 home 目录

原因：文件元数据表示因操作系统而异：Windows 文件元数据与 Linux 文件元数据不同。更多见 [Do not change Linux files using Windows apps and tools](https://blogs.msdn.microsoft.com/commandline/2016/11/17/do-not-change-linux-files-using-windows-apps-and-tools/)

在 linux 环境(WSL)下改变 windows 文件 是可以的！

1. windows 驱动器 /mnt/c /mnt/d ...
1. 当 linux apps/tools 没有权限访问 /mnt 时，使用符号链接

    ln -s "/mnt/c/Users/<Windows User>/Documents/Projects" /home/<Linux User>/Projects

### 2 linux GUI

该项目的设计目标不是支持Linux GUI，虽然有民间大神实现了，但不推荐

當最後一個 bash.exe 結束的時候，就會把所有 WSL 的程序（包含背景執行的）結束，因此當有背景執行的 WSL 程式時，記得不要把所有的 bash.exe 都關掉。
因為 WSL 沒有 systemd，因此裝在系統上的服務不會自己開起來，要手動的打開
sudo service XXX-service start

## 管理配置 WSL

wslconfig.exe

https://docs.microsoft.com/zh-cn/windows/wsl/wsl-config

## WSL 技術原理/Blog

https://blogs.msdn.microsoft.com/wsl/

ssh server
跟 Windows 10 內建的 ssh server 衝突，所以記得要改 port 或是關 Windows 10 的 ssh 功能
安裝 ssh-server
sudo apt install openssh-server
修改【/etc/ssh/sshd_config】內的這些東西
AllowUsers <yourusername>
PasswordAuthentication yes
UsePrivilegeSeparation no
然後要手動啟動 ssh-server 他
sudo service ssh --full-restart


默认系统中提示音非常烦人，可以通过配置 $HOME/.inputrc 去除

echo "set bell-style none" > $HOME/.inputrc





例如我的 Python 在 Windows 的环境路径在 C:\Users\kevin\AppData\Local\Programs\Python\Python36\

那么在 Linux 里执行以下命令加进来即可。

export PATH=$PATH:/mnt/c/Users/kevin/AppData/Local/Programs/Python/Python36
当给你需要执行 Windows 上的 Python 时，可以使用以下命令

python.exe file_name.py
官方也对这部分内容进行了详细的解释。

因此如果你安装了 Visual Studio Code 那么也可以直接在 Linux 的 Bash 里使用 code . 的方式直接打开目录进行编辑。

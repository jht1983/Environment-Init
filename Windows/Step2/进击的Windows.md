# 进击的 Windows

## 1. 设置

* 系统
    * 夜灯
    * 缩放
    * 睡眠
    * 不切换平板模式
    * 远程桌面
    * 电脑名称
* 个性化
    * 颜色
    * 开始
    * 任务栏 - peek
* 账户
    * 登录选项 - PIN
    * 同步
* 游戏
    * 全关掉
* 轻松使用
    * 键盘
    * 鼠标
* 隐私
    * 后台应用
* 文件浏览器 - 查看 选项卡
    * 勾选: 复选 & 文件扩展名 & 隐藏
    * 选项:
        * 常规: 此电脑
        * 查看: 勾选 登录时还原上一个文件夹
* 将想要启动自动运行的程序放入系统 "启动" 文件夹: %APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup

## 2. Win8／10 离线安装 .net 3.5

1. 挂载 Win8／10 的 ISO
1. 右击开始菜单(win + X), 选择 命令提示符(管理员)
1. 输入如下命令:

```cmd
# 对于 Win8:
dism.exe /online /enable-feature /featurename:NetFX3 /Source:F:\sources\sxs
# 对于 Win10:
Dism /online /enable-feature /featurename:NetFX3 /All /Source:F:\sources\sxs /LimitAccess
```

注意: 这里的盘符 F 是加载 ISO 的虚拟光驱盘符, 视情况而定.

## 3. Win 10 远程桌面

1. 将 远程桌面/termsrv.dll 文件, 替换 C:\windows\system32\ 下的同名文件即可, 如果需要权限 -> 见 `一键获取_TrustedInstaller_权限.reg`
1. 启动允许远程桌面访问: "系统属性" -> "远程设置", 在"远程桌面"那打勾. 并添加可以连接到此计算机的用户.
1. 设置限制连接数: 运行 Win + R -> "gpedit.msc" -> "计算机配置" -> "管理模板" -> "Windows组件" -> "远程桌面服务" -> "远程桌面会话主机" -> "连接" -> "限制连接的数量"
1. 取消限制每个用户只能进行一个会话: 运行 Win + R -> "gpedit.msc" -> "计算机配置" -> "管理模板" -> "Windows组件" -> "远程桌面服务" -> "远程桌面会话主机" -> "连接" -> "将远程桌面服务用户限制到单独的远程桌面服务会话" 禁用(PS: 貌似不管用)

系统属性 – 高级 – 性能 – 设置

## 4. 突破 G(功)F(夫)W(网)

* hosts: https://raw.githubusercontent.com/racaljk/hosts/master/hosts
* ss
* VPN
* 代理

## 5. Chrome 强制 http 定向到 https

在使用 Hosts 访问某些网站的时候, 通常必须使用 HTTPS 的方式才能正常打开, 但某些时候这些网站内部还有 HTTP 的链接, 需要手动修改, 颇为麻烦, 本文介绍一种在 Chrome 下自动转化 HTTP 为 HTTPS 方式的方法. 只需几个简单的步骤即可:

1. 打开 Chrome, 在地址栏键入 `Chrome://net-internals/`
1. 在 HSTS 选项卡下的 Domain 中输入要实现强制转换的域名地址(不带 https 的地址), 比如 Twitter.com, plus.google.com 等
1. 最后勾选上 Include subdomains, 这样可以确保所有二级域名都被重定向到 https, 比如 search.twitter.com.
1. 点击 Add

例如:

* 输入 webcache.googleusercontent.com, 即可强制 `Google 快照` 以 HTTPS 方式打开.
* 输入 google.com, 即可强制 `Google` 以 HTTPS 方式打开(包括 Google Scholar).

## 6. Windows 字体美化

windows 在许多地方使用字体 Consolas, 作为英文确实不错, 若要显示中文就调用 新宋体 了, 下面使用字体链接让中文使用 思源黑体(或 雅黑)。

### 1. 字体链接

可以到 `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts` 查看字体名称, 注意大小写, 不包含 "(TrueType)"

找到注册表中的 `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink`

添加 `多字符串值`, 键: Consolas(也可以改任何你想用的字体), 值:

```bat
:: 思源黑体, 但不可用, 似乎是因为改字体不支持
SourceHanSans-Regular.ttc,Source Han Sans Regular,128,96
SourceHanSans-Regular.ttc,Source Han Sans Regular

:: 神秀CC, 神秀是中文是基于思源黑体, CC是终端兼容的, 即显示效果基本是思源黑体
inziu-iosevkaCC-SC-regular.ttf,Inziu IosevkaCC SC,128,96
inziu-iosevkaCC-SC-regular.ttf,Inziu IosevkaCC SC

:: 雅黑, 个人认为比思源黑体差点
MSYH.TTC,Microsoft YaHei,128,96
MSYH.TTC,Microsoft YaHei
```

Why 这样设置？

    其中 “128,96” 称作缩放因子（scaling factor）。
    根据 MSDN 上的相关文档, 两种主要的图形显示技术 GDI 以及 GDI + 在搜索 Fontlink 键值时所用的语法有所不同。简单来说, GDI 只会选用那些给出缩放因子的项目, 相反的, GDI + 会自动忽略那些带缩放因子参数的项目。这也就是说, 如果想让所增加的连接字体能同时被 GDI 和 GDI + 调用, 我们必须在 Fontlink 的键值中增加两行：一行有缩放印子给 GDI, 一行没有给 GDI+。

    关于缩放因子是如何被使用的, 或者我们应该如何设置缩放因子, 我找不到任何有用的信息。现在只知道, 如果缩放因子设成 “128,96” 的话, 该字体不会被缩放。而在我的测试中发现, 这样的话, 中文比英文显得有点高, 需要把雅黑中文字体缩小一点。

    为了使得新的 Fontlink 注册表设置生效, 我们需要在 Windows 注销并再次登录即可。并不需要重启电脑！

    缩放因子如何影响显示效果的？我希望能够弄清楚这两个整数是如何被使用的。可惜我找不到任何有用的信息。所有能在网上找到的信息都没有提到具体这两个缩放因子是如何被使用的。而且经过测试后我发现, 有些网页上建议把缺省的数值, 128 和 96, 分别乘以一个相同的数, 然后把结果作为缩放因子写入 Fontlink 的键值中。这让我感到十分困惑, 因为以我自己现有对缩放因子的理解, 对两个缺省的数值乘以一个相同的数是不会产生任何不同效果的。

    如前所述, 我找不到任何关于这两个缩放因子的详细资料, 唯一能找到的相关信息就是开源软件 gdipp 的一个源程序文件。在这个文件里, Fontlink 里定义的两个缩放因子被用来以如下方式计算另外一个缩放参数：

        new_info.scaling = (factor1 / 128.0) * (96.0 / factor2);

    这至少说明如果给连个缺省的缩放因子乘以一个相关的系数是不会产生任何不同的效果的。根据上面这个公式, 以及一些试验结果, 我觉得我们至少可以对 Fontlink 中的缩放因子做出如下一些推断：

    把缩放因子的缺省数值乘以一个相同的数值后并不会导致文本输出后的结果

    我做了几个测试, 比较把缩放因子设成如下各种数值后的显示效果：

    128,100, 或 122, 96。显示结果一样。
    128,128, 或 64,64。显示结果一样。
    128,72, 或 171,92。显示结果一样。

    在我的 20 英寸显示器上, Windows 10 的分辨率设为 1920×1080。如果使用缺省缩放因子, 中文会显得比英文高一点, 所以我需要把缩放因子设成 “128,100” 或者 “122,96” 以缩小中文。

总结：使用 Fontlink 技术, 一个主字体和多个其它字体连接起来, 完美显示多种语言的文本。所连接字体可能和主字体的显示大小不匹配。所以有时我们需要在设置 Fontlink 时设定相应的缩放因子以达到更好的显示效果。

### 2. 修改 CMD & PowerShell 字体

通过`添加字体选项` 的方法不行了。

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Console\TrueTypeFont`

`之前是看注册表指定, 现在是看字体文件 OS/2.ulCodePageRange 指定, fallback 能不用就不用。` 所以这个方法现在无法让不支持终端的字体出现在 CMD 窗口的属性里。如 Source Code Pro、思源黑体。所以还是用 Consolas, 再做字体映射。

#### 方案一

打开 CMD/PowerShell, 运行 `chcp 65001`, 右键标题栏 --> 属性 --> 字体选 Consolas, 关闭 CMD。

当下一次运行 CMD/PowerShell 时, `chcp` 还是 936, 但字体却是 Consolas 了。跳到 [Step 2](#Step-2-设置字体) 调整 Consolas 中文显示。

#### 方案二

永久性修改 CMD 代码页为 UTF-8

```bat
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Console\%SystemRoot%_system32_cmd.exe]
"CodePage"=dword:0000fde9
```

此时用 Win + R 启动的 CMD 可以每次启动都是 UTF-8, 但直接运行 C:\Windows\System32\cmd.exe 不行。

且使用了 UTF-8, 命令输出就默认英文了。

可以这样弥补

```bat
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor]
"Autorun"="chcp 936 1>nul"
```

这样 Win + R 启动的 CMD 启动后自动切换回 936

还是建议使用 方案一。

而对 PowerShell

```bat
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Console\%SystemRoot%_System32_WindowsPowerShell_v1.0_powershell.exe]
"CodePage"=dword:0000fde9

[HKEY_CURRENT_USER\Console\%SystemRoot%_SysWOW64_WindowsPowerShell_v1.0_powershell.exe]
"CodePage"=dword:0000fde9
```

没用。。。

## 7. 终端

### 1. CMD & PowerShell

先运行 `chcp 65001`, 右键标题栏 --> 属性

* 字体: Consolas 22(这个大小个人感觉正合适, 但按这个大小设置了, 以后每次进属性设置会提示"点的大小应介于5和72之间") (参考[字体美化](#6-Windows-字体美化))
* 布局
    * 屏幕缓冲区: 宽70 高9000, 勾选 调整大小时对输出的文本换行
    * 窗口大小: 70 * 25
* 颜色
    * 屏幕背景 RGB 0, 0, 0
    * 屏幕文字 RGB 238, 237, 240
    * 85% 透明

PS: 可以同时改默认值(右键标题栏 --> 默认值)

### 2. Git Bash

* Looks: transparency: med
* Text: Font: Consolas 14, Locate: zh_CN, CharacterSet: UTF-8
* Windows: Size: 70 25
* `git config --global core.quotepath false` 使 git 命令输出中的中文正确显示

配置 ssh: ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa; cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

## 8. 软件

### 1. Wox

#### 1 plugins

wpm install Clipboard History
wpm install 有道翻译
wpm install Wox.Plugin.ProcessKiller
wpm install Close Screen
wpm install Weather.Open

wpm install IP Address
wpm install Need
wpm install Dash.Doc
wpm install PluginsList
wpm install Wox.Plugin.Github
wpm install Wox.Plugin.Macros

#### 2 settings

1. 最大结果数：7 & 失去焦点时自动隐藏 & 全屏下忽略热键
1. 插件配置
    1. 程序：添加 自定义的 links 文件夹
    1. 网页搜索
        1. google URL 改为：https://www.google.com.hk/search?q={q}
        1. wiki URL 改为 https://zh.wikipedia.org/wiki/{q}
        1. 添加 知乎 https://www.zhihu.com/search?type=content&q={q}
    1. 命令行：取消替换 Win+R
    1. Weather.Open: 触发关键词改为 weather
1. 主题
    1. BlurBlack
    1. 字体：YaHei UI
1. 添加快捷键：Alt + C --> cb (用于 Clipboard History 插件)
1. hosts 将 C:\Windows\System32\drivers\etc\hosts 置顶

### 2. WGestures

禁用 触发角 & 摩擦边

## 额外

### 1. 常用 环境变量 路径

| 环境变量 | 路径 |
| --- | --- |
| %HOMEPATH% / %USERPROFILE%        | C:\Users\<用户名> |
| %LOCALAPPDATA%                    | C:\Users\<用户名>\AppData\Local |
| %TEMP% / %TMP%                    | C:\Users\<用户名>\AppData\Local\Temp |
| %APPDATA%                         | C:\Users\<用户名>\AppData\Roaming |
| %PUBLIC%                          | C:\Users\Public |
| %HOMEDRIVE% / %SystemDrive%       | C:\ |
| %ALLUSERSPROFILE% / %PROGRAMDATA% | C:\ProgramData |
| %PROGRAMFILES%                    | C:\Program Files |
| %COMMONPROGRAMFILES%              | C:\Program Files\Common\Files |
| %PROGRAMFILES(X86)%               | C:\Program Files (x86) |
| %COMMONPROGRAMFILES(x86)%         | C:\Program Files (x86)\Common\Files |
| %WINDIR% / %SystemRoot%           | C:\Windows |
| %COMSPEC%                         | C:\Windows\System32\cmd.exe |

### 2. 关闭 Win10 自动更新

1. 首先, 按 Win+R 调出运行, 输入"gpedit.msc"点击"确定", 调出"本地组策略编辑器".
1. "计算机配置" --> "管理模板" --> "windows组件" --> "windows更新 ".
1. 在右面找到"配置自动更新", 并双击.
1. 选择"已禁用", 点击"确定".
1. 关掉"本地组策略编辑器", 重启电脑.

另加(更保险)：

1. 按 Win+R 调出运行, 输入"services.msc"点击"确定", 调出"服务管理". 找到 Windows Update 服务
1. 禁用 & 恢复 - 失败 - 无操作

### 3. 彻底禁用 Windows 10 系统的 OneDrive 组件

以下教程适用于 Windows 10 专业版和企业版:

1. Win + R --> gpedit.msc 打开本地组策略编辑器;
1. 计算机配置 --> 管理模板 --> Windows 组件 --> OneDrive;
1. 双击`禁止使用 OneDrive 进行文件存储`, 勾选`已启用`, `确定`离开;
1. 任务管理器 --> 启动, 将 Microsoft OneDrive 禁用;

以下教程适用于 Windows 10 家庭版:

1. 由于家庭版无法使用本地组策略功能因此需借助注册表, Win + R --> regedit 打开注册表编辑器;
1. 依次展开`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows`并查看是否有`OneDrive`, 如果没有则右键`Windows`选择新建项: OneDrive;
1. 然后右键 OneDrive 文件夹选择新建`DWORD 32` key: DisableFileSyncNGSC, value: 1;
1. 任务管理器 --> 启动, 将 Microsoft OneDrive 禁用;

去除文件资源管理器窗口左侧的 OneDrive 图标

* 打开注册表编辑器, 定位至：HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}
* 在右侧窗口中找到 System.IsPinnedToNameSpaceTree, 双击该值打开编辑窗口, 把数值数据由 1 修改为 0 即可(可能需要重启系统才能生效)。

PS：不过该方法只是隐藏了 OneDrive 图标, OneDrive 其实并没有卸载, 你在文件资源管理器地址栏中输入 onedrive, 回车即可打开 OneDrive；或者你用 Cortana 小娜搜索 onedrive 也可以打开。以后想要重新显示 OneDrive 图标的话, 只需把数值数据重新修改回 1 即可。

### 4. Windows 技巧 之 启用_Windows_Linux_子系统

系统要求: Windows 10 Version 1607 以上 & 专业版以上

1. 进入 Windows 10 设置 - 更新与安全 - 针对开发人员 - 勾选 `开发人员模式` 并重启设备
1. 打开 控制面板 - 程序与功能 - 启用或关闭 Windows 功能, 勾选 `适用于 Linux 的 Windows 子系统(Beta)` 并点击确定
1. 打开管理员模式的命令提示符并输入 bash 回车, 然后输入 Y 下载 Ubuntu, 下载完成后按提示创建 UNIX 默认<用户名>并输入密码(输入密码是不显示 * 的, 输入完成直接回车即可)

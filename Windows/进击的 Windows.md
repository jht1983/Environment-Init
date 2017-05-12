# 进击的 Windows

## 1. 设置

* 系统
    * 夜灯
    * 睡眠
    * 不切换平板模式
    * 电脑名称
* 个性化
    * 颜色
    * 开始
    * 任务栏
* 账户
    * 登录选项
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
* 将想要启动自动运行的程序放入系统 "启动" 文件夹: %APPDATA%Microsoft\Windows\Start Menu\Programs\Startup

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

## 5. Chrome 强制_http_定向到_https

在使用 Hosts 访问某些网站的时候, 通常必须使用 HTTPS 的方式才能正常打开, 但某些时候这些网站内部还有 HTTP 的链接, 需要手动修改, 颇为麻烦, 本文介绍一种在 Chrome 下自动转化 HTTP 为 HTTPS 方式的方法. 只需几个简单的步骤即可:

1. 打开 Chrome, 在地址栏键入 `Chrome://net-internals/`
1. 在 HSTS 选项卡下的 Domain 中输入要实现强制转换的域名地址(不带 https 的地址), 比如 Twitter.com, plus.google.com 等
1. 最后勾选上 Include subdomains, 这样可以确保所有二级域名都被重定向到 https, 比如 search.twitter.com.
1. 点击 Add

例如:

* 输入 webcache.googleusercontent.com, 即可强制 `Google 快照` 以 HTTPS 方式打开.
* 输入 google.com, 即可强制 `Google` 以 HTTPS 方式打开(包括 Google Scholar).

## 6. 软件

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
    1. 网页搜索
        1. google URL 改为：https://www.google.com.hk/search?q={q}
        1. wiki URL 改为 https://zh.wikipedia.org/wiki/{q}
        1. 添加 知乎 https://www.zhihu.com/search?type=content&q={q}
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

1. 首先, 按Win+R调出运行, 输入"gpedit.msc"点击"确定", 调出"本地组策略编辑器".
1. "计算机配置" --> "管理模板" --> "windows组件" --> "windows更新 ".
1. 在右面找到"配置自动更新", 并双击.
1. 选择"已禁用", 点击"确定".
1. 关掉"本地组策略编辑器", 重启电脑.

### 3. Windows 技巧 之 启用_Windows_Linux_子系统

系统要求: Windows 10 Version 1607 以上 & 专业版以上

1. 进入 Windows 10 设置 - 更新与安全 - 针对开发人员 - 勾选 `开发人员模式` 并重启设备
1. 打开 控制面板 - 程序与功能 - 启用或关闭 Windows 功能, 勾选 `适用于 Linux 的 Windows 子系统(Beta)` 并点击确定
1. 打开管理员模式的命令提示符并输入 bash 回车, 然后输入 Y 下载 Ubuntu, 下载完成后按提示创建 UNIX 默认<用户名>并输入密码(输入密码是不显示 * 的, 输入完成直接回车即可)

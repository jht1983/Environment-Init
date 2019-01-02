# IDEA

## InteliJ

### 1 安装

IntelliJ主题 + 创建图标 + 创建脚本 + 默认插件 + scala插件

激活码 + `0.0.0.0 account.jetbrains.com`

### 2 配置

外观 - 外观 - 自定义字体 Noto sans cjk sc

Editor - 字体 source code pro 16

忽略大小写设置 Editor - General - Code Completion  取消勾选 Match case

配置文件 utf-8 Editor - File Encodins  Properties 勾选 native-to-ascii 转换

自动参数提示 Editor-General-Code Completion  Patameter Info 三项全选

Editor - General - Editor Tabs  limit: 20

视图 显示工具栏 不显示导航栏

### 3 快捷键

redo           Ctrl + Y
deleteline     Ctrl + D
formatcode     Ctrl + Shift + F
replace...     Ctrl + H
back           Alt + <-
forward        Alt + ->
moveline       Alt + up/down
fullscreen     F11
close          Ctrl + W
reopen         Ctrl + E
splitv         Ctrl + \
codecomplete   Alt + /

#### 3.1 编辑

| 快捷键                  | 自定义键              | 功能 |
| ---------------------- | -------------------- | --- |
| Ctrl + Space           | Ctrl + Space         | 基本补全 |
| Ctrl + Shift + Space   |                      | 智能类型补全 |
| Alt + Insert           |                      | 自动代码生成(构造,getter,setter...) |
| Ctrl + J               |                      | 插入自定义动态代码模板(for,where) |
| Ctrl + Shift + Enter   |                      | 补全当前行(右括号,分号) |
| ---------------------- | -------------------- | --- |
| Ctrl + Alt + L         | Ctrl + Shift + F     | 格式化 |
| Ctrl + Alt + O         |                      | 整理 import |
| ---------------------- | -------------------- | --- |
| Ctrl + H               |                      | 显示当前类的继承结构 |
| Ctrl + O               |                      | 选择可重写的方法 |
| Ctrl + I               |                      | 选择可继承的方法 |
| Ctrl + P               |                      | 方法参数提示(在括号里按) |
| Ctrl + Q               |                      | 光标所在的类名/方法名/变量等上面(也可以在提示补充的时候按)，显示文档内容 |
| ---------------------- | -------------------- | --- |
| Ctrl + Shift + Z       | Ctrl + Y             | 撤销 |
| Ctrl + W               | Ctrl + D             | 删除一行 |

F2/Shift+F2移动到有错误的代码，Alt+Enter快速修复

双击shift

#### 3.2 搜索

| 快捷键                  | 自定义键              | 功能 |
| ---------------------- | -------------------- | --- |
| Ctrl + F               |                      | 查找 |
| Ctrl + R               | Ctrl + H             | 替换 |
| F3/Shift + F3          |                      | 上/下一匹配项 |
| Ctrl + F12             |                      | 搜索方法 |
| Ctrl + N               |                      | 按类名搜索类 |
| Ctrl + Shift + N       |                      | 搜索文件 |
| Alt + Shift + 7        |                      | 搜索所有引用处 |
| Ctrl + Shift + F       |                      | 全局搜索 |

#### 3.3 跳转

| 快捷键                  | 自定义键              | 功能 |
| ---------------------- | -------------------- | --- |
| Ctrl + Shift + H       |                      | 显示方法层次 |
| Ctrl + Q               |                      | 显示类、方法说明 |
| Ctrl + B               |                      | 跳到方法定义处 |
| Ctrl + Alt + B         |                      | 跳到方法实现处 |
| Alt + Up/Down          |                      | 跳到上/下一方法 |
| Ctrl + G               |                      | 跳到指定行 |
| Ctrl + U               |                      | 前往当前光标所在的方法的父类的方法 / 接口定义 |
| Ctrl + B               |                      | 进入光标所在的方法/变量的接口或是定义处，等效于 Ctrl + 左键单击 |
| Alt + Shift + Up/Down  | Alt + <-/->          | 焦点前后移动 |

#### 3.4 重构

| 快捷键                  | 自定义键              | 功能 |
| ---------------------- | -------------------- | --- |
| Shift + F6             |                      | 改名 |

#### 3.5 运行

| 快捷键                  | 自定义键              | 功能 |
| ---------------------- | -------------------- | --- |
| Alt + Shift + F10      |                      | 启动运行 |
| Alt + Shift + F9       |                      | 启动调试 |
| Ctrl+F2                |                      | 停止 |
| F7                     |                      | 单步进入 |
| F8                     |                      | 单步跳过 |
| F9                     |                      | 跳过 |
| Alt + F8               |                      | 执行选中语句 |

#### 3.6 窗口

| 快捷键                  | 自定义键              | 功能 |
| ---------------------- | -------------------- | --- |
| Ctrl + Tab             |                      | 切换窗口 |
| Ctrl + E               | 待换                  | 显示最近打开的文件记录列表 |
| Ctrl + +               |                      | 展开代码 |
| Ctrl + -               |                      | 折叠代码 |
| Ctrl + [               |                      | 移动光标到当前所在代码的花括号开始位置 |
| Ctrl + ]               |                      | 移动光标到当前所在代码的花括号结束位置 |

### 4 插件

| 插件名称 | 功能 | 说明 |
| --- | --- | --- |
| FindBugs       |  |  |
| Jrebel         | 热部署插件 (去官网申请激活码就行) | 首次使用会让开启 automatic compilation (setting-jrbel-advanced-enable automatic compilation) |
| Key Promoter X | Key Promoter 的新版 |  |
| Alibaba Java Code Guidelines |  |  |
| Sonar          |  |  https://wiki.n.miui.com/pages/viewpage.action?pageId=36339754 |
| CodeGlance     |  |  |
| Maven Helper   |  |  |
| AceJump        |  |  |

## pycharm 配置

### 1 安装

IntelliJ主题 + 创建图标 + 创建脚本 + markdown插件 + bash插件

激活码 + `0.0.0.0 account.jetbrains.com`

### 2 配置

界面字体 Noto sans cjk sc

editor 字体 source code pro 16

### 3 快捷键

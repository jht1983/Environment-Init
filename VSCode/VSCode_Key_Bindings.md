# VSCode

## Part 1 Key Binding

**官方快捷键: <https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf>**

**Ctrl + P : 操作模式, 再输"?", 可以看见`所有可进行的操作`**  
**Ctrl + Shift + P / F1 : 命令模式(显示所有命令 & 快捷键) <=> Ctrl + P 进入操作模式, 再输">"**

### 通用

| Key | Value |
| --- | ----- |
| Ctrl + N/W/E :          | 新建/关闭/重新打开 `Tab` |
| Ctrl + Shift + N/W :    | 新建/关闭 `窗口` |
| Ctrl + 单击 :           | 在新 Tab 组打开文件 |
| Ctrl + Z/Y/A/O/S :      | Normal |
| Ctrl + X/C/V/D :        | 无选中则对整行操作 |
| Ctrl + F/H :            | \*: 1 or 多个; ?: 1个; \*\*: 任意个; {}: 一组条件; []: range |
| F2 / F11 :              | 重命名/全屏 |
| F3 / Shift + F3 :       | `查找` 时选择上/下一个 |
| Alt + 左/右 :           | `焦点` 的前进/后退 |
| Alt + 上/下 :           | 上/下 `移行` |
| Alt + 上/下 :           | 在搜索中: 上/下一搜索项 |
| Shift + Alt + 上/下 :   | 向上/下复制一行 |
| Ctrl + 上/下 :          | `屏幕` 向上/下移一行 |

### 高效

| Key | Value |
| --- | ----- |
| Ctrl + Shift + L :      | 同时 `选中` 所有匹配, 用于批量修改 (<=> 选中一个目标, 按Ctrl + F2)(不跨文件) |
| Alt + Enter :           | 在 Ctrl + F 中立刻选中所有的匹配结果 |
| Alt + 单击 :            | 添加 `光标` (多光标), 用于批量修改 |
| Ctrl + Shift + F/H :    | 高级( `全局` )搜索/替换 |
| Shift + Alt :           | 块 `选择` |
| Shift + Alt + F :       | 代码 `格式化` |
| Ctrl+K Ctrl+F :         | 格式化选择区域 |
| Ctrl + . :              | Quick Fix |
| Ctrl + Space :          | 触发 `建议` |
| Ctrl + Shift + Space :  | 触发参数 `提示` |
| Ctrl + / :              | 触发行 `注释` (== Ctrl+K Ctrl+C & Ctrl+K Ctrl+U) |
| Shift + Alt + A :       | 触发块 `注释` |
| Ctrl + [ / ] :          | 减少/增加 `缩进` |
| Ctrl + Shift + [ / ] :  | `折叠` /展开 |
| Ctrl + Shift + \ :      | 匹配 `括号` 的跳转 |
| F12 :                   | 转到 `定义` (只有一个的时候) |
| Alt + F12 :             | 预览 `定义` (不跳过去) |
| Ctrl + K F12 :          | 在侧边打开 `定义` |
| Shift + F12 :           | 查看 `引用` |

### Quick Box

| Key | Value |
| --- | ----- |
| Ctrl + P :              | `操作模式` / `转到` 文件, 再输入"?", 可以看见`所有可进行的操作` |
| Ctrl + Shift + P / F1 : | `命令模式` (显示所有命令 & 快捷键) <=> **Ctrl + P 进入操作模式, 再输">"** |
| Ctrl + G :              | `转到` 行 <=> **Ctrl + P 进入操作模式, 再输":"** |
| Ctrl + T :              | `显示` 所有符号(本工作空间) <=> **Ctrl + P 进入操作模式, 再输"#"** |
| Ctrl + Shift + O :      | `转到` 符号(本文件) <=> **Ctrl + P 进入操作模式, 再输"@"或"@:"** |

### 用得少

| Key | Value |
| --- | ----- |
| Ctrl + Enter / Ctrl + Shift + Enter : | 当前行下/上边插入一行 |
| Shift + Alt + 左/右 :                 | 收缩/扩大选择的部分 |
| Ctrl + K Ctrl + I :                   | 显示悬停 |
| Ctrl + K Ctrl + X :                   | 删除拖尾的空格 |
| Ctrl + Shift + J :                    | Toggle Search Details ??? |

### 界面 相关

| Key | Value |
| --- | ----- |
| Ctrl + B/J :                      | `侧边栏` 开关/ `底部面板` 开关 |
| Ctrl + Shift + E/F/G/D/X :        | `侧边栏` 5 大功能(在 Bar 打开的情况下) |
| Ctrl + Shift + U/M/Y :            | 输出面板, 错误面板, 调试控制台 |
| Ctrl + Shift + C :                | 在此处打开 `命令提示符` |
| Ctrl + ` :                        | 打开集成的 Terminal |
| Ctrl + M :                        | 激活按 Table 键移动 `焦点` |
| Ctrl + 0 :                        | `聚焦` 在 Bar |
| Ctrl + \ :                        | 将当前 Tab 在新 Tab 组中打开 |
| Ctrl + K 左/右                    | Tab 组左/右移动(不连续) |
| Ctrl + 1 / 2 / 3 :                | `Tab组` 左 / 中 / 右 切换 |
| Ctrl + PgUp/PgDwn :               | `Tab` 左右切换 |
| Ctrl + Shift + PgUp/PgDwn :       | 将 `Tab` 向左右移动 |
| Ctrl + Tab / Ctrl + Shift + Tab : | `Tab` 向前/后导航 |

### Debug & Tasks

| Key | Value |
| --- | ----- |
| F5 :                | start & pause & continue |
| Shift + F5 :        | stop |
| Ctrl + Shift + F5 : | 重启 |
| Ctrl + F5 :         | 开始执行(不调试) |
| F8 / Shift + F8 :   | 转到下/上一个错误和警告 |
| F9 :                | 触发设 `断点` |
| F10 / Shift + F10 : | `单步` 跳过 / `单步` 后退 |
| F11 / Shift + F11 : | `单步` 进入 / `单步`跳出 |
| Ctrl + Shift + B :  | 运行生成任务 |
| Shift + Enter :     | 在调试控制台中多行输入 |

### Markdown 相关

| Key | Value |
| --- | ----- |
| Ctrl + Shift + V :  | 新建 `预览` 页(Markdown) |
| Ctrl + K V :        | 打开侧边的 `预览` (Markdown) |

### C/C++ Ext

| Key | Value |
| --- | ----- |
| F4 :                | 切换.c\.h文件 |

## Part 2 Extension

在用

| ItemName | Introduction |
| -------- | ------------ |
| beautify            | Beautify javascript, JSON, CSS, and HTML code |
| cpptools            | C/C++ 支持(code-editing, debugging) |
| debugger-for-chrome | Debug your JavaScript code in the Chrome browser, or any other target that supports the Chrome Debugger protocol |
| vscode-eslint       | Integrates ESLint into VS Code |
| githistory          | View git log, file or line history |
| vscode-markdownlint | Markdown linting and style checking for Visual Studio Code |
| python              | Linting, Debugging (multi-threaded, remote), Intellisense, auto-completion, code formatting, snippets, and more |
| tslint              | TSLint for Visual Studio Code |
| vscode-icons        | icons for VSCode |

备选

| ItemName | Introduction |
| -------- | ------------ |
| vscode-clang        | Completion and Diagnostic for C/C++/Objective-C using Clang |
| vim                 | Vim 模拟 |
| latex               | LaTeX - colorizer, grammar and snippets |
| cmake               | CMake 语法支持 |
| Spell               | Detect mistakes as you type and suggest fixes - great for Markdown or any text file |
| xml                 | XML Formatting, XQuery, and XPath Tools for Visual Studio Code |
| markdown-pdf        | convert Markdown file to pdf, html, png or jpeg file. |
| markdown-toc        | Generate TOC (table of contents) of headlines from parsed markdown file |
| vscode-todo         | Lists todo |
| Align               | align text like the atom-alignment package |

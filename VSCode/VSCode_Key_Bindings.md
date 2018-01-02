# VSCode Key Binding

**官方快捷键: <https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf>**

**Ctrl + P : 操作模式, 再输"?", 可以看见`所有可进行的操作`**  
**Ctrl + Shift + P / F1 : 命令模式(显示所有命令 & 快捷键) <=> Ctrl + P 进入操作模式, 再输">"**

以下是我的快捷键, 有许多是我自定义的, 需要配合[我的自定义快捷键文件](keybindings.json)使用.

## 通用

| Key | Value |
| --- | ----- |
| Ctrl + N/W/E                         | 新建/关闭/重新打开 `Editor` |
| Ctrl + Shift + N/W                   | 新建/关闭 `窗口` |
| Ctrl + Z/Y/A/S/O                     | Normal |
| Ctrl + X/C/V                         | Normal, 无选中则对整行操作 |
| Ctrl + D                             | 删除一行/选中区所在行 |
| Ctrl + F/H                           | \*: 1 or 多个; ?: 1个; \*\*: 任意个; {}: 一组条件; []: range |
| F2 / F11                             | 重命名/全屏 |
| F3 / F4                              | 选中文本 / `查找` / `全局查找` (Ctrl+Shift+F) 时, 上/下一个匹配项 |
| F3 / F4                              | 左右切换 `Editor` |
| F3 / F4                              | 差异编辑器中, 导航 上/下一个 差异 |
| Alt + ←/→                            | `焦点` 的前进/后退 |
| Alt + ↑/ ↓                           | 上/下 `移行` |
| Alt + ↑/ ↓                           | 在查找(Editor 全局 终端)中使用, 可以切换上/下一个查找词 |
| Shift + Alt + ↑/↓                    | 向上/下复制一行 |
| Ctrl + ↑/↓                           | `屏幕` 向上/下滚动一行 |
| Ctrl + Home / End                    | 滚动到顶部/底部 |
| Ctrl + Enter / Ctrl + Shift + Enter  | 当前行下/上面插入一行 |
| Alt + Z                              | 切换折行 |

## 高效

| Key | Value |
| --- | ----- |
| Shift + Alt + ←/→                    | 收缩/扩大选择的部分 |
| Ctrl + I                             | 选择当前行 |
| Shift + Alt                          | 块 `选择` |
| Ctrl + Shift + L                     | 同时 `选中` 所有匹配, 用于批量修改 (<=> 选中一个目标, 按 Ctrl + F2)(不跨文件) |
| Alt + Enter                          | 在 Ctrl + F 中立刻 `选中` 所有的匹配结果(正则匹配用上一条不行) |
| Alt + 单击                           | 添加 `光标` (多光标), 用于批量修改 |
| Ctrl + K Ctrl + X                    | 删除拖尾的空格 |
| --------------------                 | -------------------- |
| Ctrl + Shift + F/H                   | 高级( `全局` )搜索(编辑区无选择时)/替换 |
| Ctrl + Shift + F                     | 选择区域代码 `格式化`(编辑区有选择时) |
| *Ctrl + .                             | 显示修复信息(quick fix) |
| *Alt + /                              | 触发 `建议` or 参数 `提示`|
| Ctrl + /                             | 触发行 `注释` |
| Ctrl + Shift + /                     | 触发块 `注释` |
| Ctrl + [ / ]                         | 减少/增加 `缩进` |
| Ctrl + Shift + [ / ]                 | `折叠` /展开 |
| Ctrl + Shift + \                     | 匹配 `括号` 的跳转 |
| --------------------                 | -------------------- |
| F12                                  | 转到 `定义` (只有一个的时候) |
| Alt + F12                            | 预览 `定义` (不跳过去) |
| Ctrl + K F12                         | 在侧边打开 `定义` |
| Shift + F12                          | 查看 `引用` |
| --------------------                 | -------------------- |
| Shift + Alt + Z                      | Zen 模式 |

## Quick Box

| Key | Value |
| --- | ----- |
| Ctrl + P                             | `操作模式` / `转到` 文件, 再输入"?", 可以看见`所有可进行的操作` |
| Ctrl + Shift + P / F1                | `命令模式` (显示所有命令 & 快捷键) <=> **Ctrl + P 进入操作模式, 再输">"** |
| Ctrl + G                             | `转到` 行 <=> **Ctrl + P 进入操作模式, 再输":"** |
| Ctrl + T                             | `显示` 所有符号(本工作空间) <=> **Ctrl + P 进入操作模式, 再输"#"** |
| Ctrl + Shift + O                     | `转到` 符号(本文件) <=> **Ctrl + P 进入操作模式, 再输"@"或"@:"** |
| Ctrl + Q                             | View Picker |

## 界面 相关

| Key | Value |
| --- | ----- |
| Ctrl + B/J                           | `侧边栏` 开关/ `底部面板` 开关 |
| Ctrl + Shift + E/F/G/D/X             | `侧边栏` 5 大功能 |
| Ctrl + Shift + M/U/Y                 | `底部面板` 四个功能之前三: 错误面板, 输出面板, 调试控制台 |
| Ctrl + Alt + T                       | `底部面板` 四个功能之后一: 打开 `集成终端` |
| Ctrl + Shift + C                     | 在此处打开 `外部终端` |
| Ctrl + L                             | 集成终端中的 `清屏` |
| Ctrl + M                             | 激活按 Table 键移动 `焦点` |
| -------------------------------      |  |
| Shift + Alt + 1                      | 切换 Editor 组布局(水平/竖直) |
| Ctrl + 单击                          | 在 `新 Editor 组` 打开文件 |
| Ctrl + \                             | 将当前 Editor 在 `新 Editor 组` 中打开(拆分编辑器) |
| Ctrl + 1 / 2 / 3                     | `Editor 组` 左 / 中 / 右 切换 |
| Ctrl + K ←/→                         | `Editor 组` 向左/右移动(一次) |
| Ctrl + Shift + PgUp / PgDown         | `Editor` 向左/右移动(一次) |
| F3 / F4                              | 左右切换 `Editor` |
| Ctrl + \` / Ctrl + Shift + \`        | `Editor` 按浏览历史向前/后导航 |

## Debug & Tasks

| Key | Value |
| --- | ----- |
| F5                                   | start & pause & continue |
| Shift + F5                           | stop |
| Ctrl + Shift + F5                    | 重启 |
| Ctrl + F5                            | 开始执行(不调试) |
| F8 / Shift + F8                      | 转到下/上一个错误和警告 |
| F9                                   | 触发设 `断点` |
| F10 / Shift + F10                    | `单步` 跳过 / `单步` 后退 |
| F11 / Shift + F11                    | `单步` 进入 / `单步`跳出 |
| Ctrl + K Ctrl + I                    | 显示悬停 |
| Ctrl + Shift + B                     | 运行生成任务 |
| Shift + Enter                        | 在调试控制台中多行输入 |

## Markdown 相关

| Key | Value |
| --- | ----- |
| Ctrl + Shift + V                     | 新建 `预览` 页(Markdown) |
| Ctrl + K V                           | 打开侧边的 `预览` (Markdown) |

## Emmet

https://docs.emmet.io/cheat-sheet/

## C/C++ Ext

| Key | Value |
| --- | ----- |
| F4                                   | 切换.c\.h文件 |

## 更多技巧

https://code.visualstudio.com/docs/getstarted/tips-and-tricks

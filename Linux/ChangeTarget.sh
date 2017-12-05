# 注意: 以下命令 要在真机上输入，不能在远程 ssh 上输入

# 从 命令行级别 切换到 图形级别
# systemctl isolate graphical.target
# or
# sudo init 5 # 旧时代的东西, 不确定稳定性

# 从 图形级别 切换到 命令行级别
# systemctl isolate multi-user.target
# or
# sudo init 3 # 旧时代的东西, 不确定稳定性
# PS: Ubuntu 从 图形级别 切换到 命令行级别 时, 处于 Ctrl + Alt + F7, 按 Ctrl + Alt + F1-6, 切换到文字终端

# Centos 7 第一次进入图形模式要确认协议   依次输入 1 2 c c
# systemctl set-default graphical.target # 设置开机启动时的运行级别为 图形级别
# systemctl set-default multi-user.target # 设置开机启动时的运行级别为 命令行级别

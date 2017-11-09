# 以下命令 要在真机上输入，不能在远程 ssh 上输入
# systemctl isolate graphical.target # 从 命令行级别 切换到 图形级别
# systemctl isolate multi-user.target # 从 图形级别 切换到 命令行级别
# 第一次进入图形模式要确认协议   依次输入 1 2 c c
# systemctl set-default graphical.target # 设置开机启动时的运行级别
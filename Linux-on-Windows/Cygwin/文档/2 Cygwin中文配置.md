# Cygwin中文配置

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
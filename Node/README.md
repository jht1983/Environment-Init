# Node

简单的说: Node.js 就是运行在服务端的 JavaScript, Node.js 是一个基于 Chrome JavaScript V8引擎建立的一个平台.

**下载地址:** [https://nodejs.org/en/download/](https://nodejs.org/en/download/)

## Windows

下载安装即可

## Linux

* 下载 Node LTS(长期支持版) linux 平台预编译版本 node-v6.9.1-linux-x64.tar.xz
* 解压: `tar xJf node-v6.9.1-linux-x64.tar.xz`
* 配置环境变量: 在 /etc/profile (or ~/.bashrc) 添加如下内容, 然后 重新登陆 或 source /etc/profile (or ~/.bashrc)

```bash
export NODE_HOME=/usr/local/node-v6.9.1-linux-x64
export PATH=$NODE_HOME/bin:$PATH
```

* 验证:

```bash
$ node -v
v6.9.1
```

Node 部署就完成了.

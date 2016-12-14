# Tomcat

官网: http://tomcat.apache.org/

**PS**: windows & linux 一样

关于 Tomcat 安装方面的重要文档是 http://tomcat.apache.org/tomcat-8.0-doc/RUNNING.txt or https://translate.google.com.hk/translate?act=url&hl=zh-CN&ie=UTF8&prev=_t&sl=en&tl=zh-CN&u=http://tomcat.apache.org/tomcat-8.0-doc/RUNNING.txt

1. 首先要安装有 Java
2. 下载->解压
3. 配置环境变量: 在 /etc/profile (or ~/.bashrc) 添加如下内容, 然后 重新登陆 或 source /etc/profile (or ~/.bashrc)

```bash
export CATALINA_HOME=/usr/local/apache-tomcat-7.0.65
export PATH=$PATH:$CATALINA_HOME/bin
```

4. 验证

* 启动 Tomcat

Tomcat 可以通过执行以下命令之一启动:

```bash
  On Windows:
      %CATALINA_HOME%\bin\startup.bat
    or
      %CATALINA_HOME%\bin\catalina.bat start
  On *nix:
      $CATALINA_HOME/bin/startup.sh
    or
      $CATALINA_HOME/bin/catalina.sh start
```

启动后, Tomcat 包含的默认 Web 应用程序可通过 `http://localhost:8080/` 访问

* 关闭 Tomcat

Tomcat 可以通过执行以下命令之一关闭:

```bash
  On Windows:
      %CATALINA_HOME%\bin\shutdown.bat
    or
      %CATALINA_HOME%\bin\catalina.bat stop
  On *nix:
      $CATALINA_HOME/bin/shutdown.sh
    or
      $CATALINA_HOME/bin/catalina.sh stop
```

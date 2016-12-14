# JDK

## Windows

* `JAVA_HOME`: 指明 JDK 安装路径, 此路径下包括 lib, bin, jre 等文件夹

```
C:\Program Files\Java\jdk1.8.0_60
```

* `Path`: 使得系统可以在任何路径下识别 java 命令

```
;%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin
```

* `CLASSPATH`: java 加载类(class or lib)路径, 只有类在 classpath 中, java 才能找到

```
.;%JAVA_HOME%\bin;%JAVA_HOME%\lib
(要加.表示当前路径)
```

## Linux

* 配置环境变量: 在 /etc/profile (or ~/.bashrc) 添加如下内容, 然后 重新登陆 或 source /etc/profile (or ~/.bashrc)

```bash
export JAVA_HOME=/usr/local/java/jdk1.8.0_102 ### 要改哦!
export JRE_HOME=$JAVA_HOME/jre
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib
export PATH=$PATH:$JAVA_HOME/bin
```

* 执行如下内容, 彻底替换 openJDK

```bash
sudo update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 300
sudo update-alternatives --install /usr/bin/jar jar $JAVA_HOME/bin/jar 300
sudo update-alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 300
sudo update-alternatives --install /usr/bin/javah javah $JAVA_HOME/bin/javah 300
sudo update-alternatives --install /usr/bin/javap javap $JAVA_HOME/bin/javap 300
sudo update-alternatives --config java
```

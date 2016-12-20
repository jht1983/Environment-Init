# JDK

## Windows

* `JAVA_HOME`: 指明 JDK 安装路径, 此路径下包括 lib, bin, jre 等文件夹

```bash
C:\Program Files\Java\jdk1.8.0_60
```

* `Path`: 使得系统可以在任何路径下识别 java 命令

```bash
;%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin
```

* `CLASSPATH`: java 加载类(class or lib)路径, 只有类在 classpath 中, java 才能找到

```bash
.;%JAVA_HOME%\bin;%JAVA_HOME%\lib
(要加.表示当前路径)
```

## Linux

### 1 安装 JDK

#### 1.1 用 tar.gz 包安装

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

#### 1.2 用 yum, apt-get 命令安装

```bash
sudo yum install java-1.8.0-openjdk-devel.x86_64
echo "export JAVA_HOME=/usr/lib/jvm/java" >> ~/.bashrc
```

### 2 卸载 JDK

先查找安装的 JDK 在哪个目录

```bash
echo $JAVA_HOME
which java
```

#### 2.1 用 tar.gz 包安装的

用 tar.gz 包安装的一般可以通过 `$echo JAVA_HOME` 找到安装路径

* 删除解压的 JDK 文件

```bash
sudo rm -rf /usr/local/java/jdk1.8.0_102
```

* 修改环境变量: 删除 /etc/profile 中关于 JDK 的环境变量设定

* 更新 profile 配置文件

```bash
source /etc/profile  
```

#### 2.2 用 rpm, deb 包 或用 yum, apt-get 命令安装的

用 rpm, deb 包 或用 yum, apt-get 命令安装的一般可以通过 `which java` 找到安装路径, 一般是 `/usr/lib/jvm/java` 所链接的位置(CentOS下)

```bash
sudo yum remove java-1.8.0-openjdk-devel.x86_64
```

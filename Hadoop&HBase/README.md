# Hadoop (附: HBase)

## 1 伪分布式部署

### 1.1 前置

* 安装 JDK: sun JDK or openJDK `sudo yum install java-1.8.0-openjdk-devel.x86_64`
* 本机对本机能够 ssh 免密码登陆

配置 Hadoop 伪分布式需要本机对本机能够免密登陆, 将 ssh 公钥文件 id_rsa.pub 的内容追加到 authorized_keys 中即可

```bash
sudo apt-get install ssh                         # 安装 ssh
/etc/init.d/ssh start                            # 启动 ssh

cd ~                                             # 最好在要配置的用户的家目录下
ssh-keygen -t rsa -P ""                          # 生成 rsa 密钥对, 也可以选 dsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys  # id_rsa.pub 是公钥, id_rsa 是私钥
chmod 644 ~/.ssh/authorized_keys                 # 修改权限
ssh localhost                                    # 验证, 第一次要输入 'yes' 确认加入 the list of known hosts
```

### 1.2 下载与解压

下载: http://hadoop.apache.org/releases.html

```bash
tar xzf hadoop-2.7.3.tar.gz -C /home/bigdata
```

### 1.3 配置环境变量: 在 /etc/profile (or ~/.bashrc) 添加如下内容, 然后 重新登陆 或 source /etc/profile (or ~/.bashrc)

```bash
export HADOOP_HOME=/usr/local/hadoop-2.7.3
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

export CLASSPATH=$CLASSPATH:`$HADOOP_HOME/bin/hadoop classpath --glob`
```

### 1.4 更改所属权

因为是安装到 `/usr/local` 目录下, 所以要对用户账户赋予所属权, 若是安装到用户目录下则不用

```bash
sudo chown -R will:will $HADOOP_HOME
```

### 1.5 配置 Hadoop

#### 1.5.1 HDFS

##### 1.5.1.1 配置文件

* `$HADOOP_HOME/etc/hadoop/core-site.xml`

```bash
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
        <description>配置 NameNode 的 URI, 位置为主机的 9000 端口</description>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/home/bigdata/work/hdfs</value>    -------------自己设!
        <description>配置 hadoop 的 tmp 目录的根位置, 最好配置, 如果在新增节点或者其他情况下莫名其妙的 DataNode 启动不了, 就删除此 tmp 目录即可. 不过如果删除了 NameNode 机器的此目录, 那么就需要重新执行 HDFS 格式化的命令.</description>
    </property>
</configuration>
```

* `$HADOOP_HOME/etc/hadoop/hdfs-site.xml` HDFS 的配置文件

```bash
<configuration>
    <property>
        <name>dfs.http.address</name>
        <value>localhost:50070</value>
        <description>配置 HDFS 的 http 的访问位置</description>
    </property>
    <property>
        <name>dfs.namenode.secondary.http-address</name>
        <value>localhost:50090</value>
    </property>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
        <description>配置文件块的副本数, 不能大于从机的个数. 伪分布式就配置为 1</description>
    </property>
</configuration>
```

还可以配置

* dfs.namenode.name.dir 在本地文件系统上, NameNode 永久存储命名空间和事务日志的路径. 如果这是以逗号分隔的目录列表, 那么将在所有目录中复制名称表, 以实现冗余.
* dfs.datanode.data.dir 在本地文件系统上, DataNode 存储文件块的路径. 如果这是以逗号分隔的目录列表, 则数据将存储在所有命名目录中, 通常在不同的设备上.

##### 1.5.1.2 hdfs init

在 shell 中执行: `hdfs namenode -format`

##### 1.5.1.3 启动与关闭

* 启动

```bash
start-dfs.sh
```

然后打开页面验证 hdfs 安装成功: http://localhost:50070/

* 关闭

```bash
stop-dfs.sh
```

#### 1.5.2 Yarn

##### 1.5.2.1 配置文件

* `$HADOOP_HOME/etc/hadoop/yarn-site.xml`

```bash
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.resourcemanager.webapp.address</name>
        <value>localhost:8088</value>
    </property>
    <property>
        <name>yarn.resourcemanager.hostname</name>
        <value>localhost</value>
    </property>
</configuration>
```

* `$HADOOP_HOME/etc/hadoop/mapred-site.xml` 先把模板文件复制一份

```bash
cp mapred-site.xml.template mapred-site.xml
```

配置如下

```bash
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property>
        <name>mapreduce.jobhistory.address</name>
        <value>localhost:10020</value>
    </property>
    <property>
        <name>mapreduce.jobhistory.webapp.address</name>
        <value>localhost:19888</value>
    </property>
</configuration>
```

##### 1.5.2.2 检查

启动 yarn

```bash
start-yarn.sh
```

然后打开页面验证 yarn 安装成功: http://localhost:8088/

## 2 分布式部署

1 台 master, 2 台 slave

| 机器名 | IP 地址 | 作用 |
|--------|---------------|----------------------|
| master | 192.168.1.170 | NameNode, JobTracker |
| slave1 | 192.168.1.171 | DataNode, TaskTracker |
| slave2 | 192.168.1.172 | DataNode, TaskTracker |
| slave3 | 192.168.1.173 | DataNode, TaskTracker |

### 2.1 前置

* 安装 JDK: sun JDK or openJDK `sudo yum install java-1.8.0-openjdk-devel.x86_64`
* IP 映射: 配置每台机器的 /etc/hosts 保证各台机器之间通过机器名可以互访
* master 机对 slave 机能够 ssh 免密码登陆: 将 master 机的 ssh 公钥文件 id_rsa.pub 的内容追加到 authorized_keys 中即可

在 master 机上

```bash
cd ~                                                # 最好在要配置的用户的家目录下
ssh-keygen -t rsa -P ""                             # 生成 rsa 密钥对, 也可以选 dsa

scp ~/.ssh/id_rsa.pub username@slave1:~/master.pub  # 将 master 机公钥文件 id_rsa.pub 传送到两个从机
scp ~/.ssh/id_rsa.pub username@slave2:~/master.pub
scp ~/.ssh/id_rsa.pub username@slave3:~/master.pub
```

在 slave 机上

```bash
cat ~/master.pub >> ~/.ssh/authorized_keys
chmod 644 ~/.ssh/authorized_keys                 # 修改权限
ssh master                                       # 验证, 第一次要输入 'yes' 确认加入 the list of known hosts
```

### 2.2 下载与解压

下载: http://hadoop.apache.org/releases.html

```bash
tar xzf hadoop-2.7.3.tar.gz -C /home/bigdata
```

### 2.3 配置环境变量: 在 /etc/profile (or ~/.bashrc) 添加如下内容, 然后 重新登陆 或 source /etc/profile (or ~/.bashrc)

**四台机器上都要做**

```bash
export HADOOP_HOME=/home/bigdata/hadoop-2.7.3
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

export CLASSPATH=$CLASSPATH:`$HADOOP_HOME/bin/hadoop classpath --glob`
```

### 2.4 更改所属权

若是安装到 `/usr/local` 目录下, 要对用户账户赋予所属权

```bash
sudo chown -R will:will $HADOOP_HOME
```

### 2.5 配置 Hadoop

四台机器的配置完全一样, 只需配置完一台, 再复制到其余三台机器上就行

#### 2.5.1 HDFS

##### 2.5.1.1 配置文件

* `$HADOOP_HOME/etc/hadoop/hadoop-env.sh` hadoop 运行环境配置, 修改如下位置

```bash
export JAVA_HOME=/usr/lib/jvm/java
```

* `$HADOOP_HOME/etc/hadoop/core-site.xml`

```bash
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://master:9000</value>
        <description>配置 NameNode 的 URI, 位置为主机的 9000 端口</description>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/home/bigdata/work/hdfs</value>    -------------自己设!
        <description>配置 hadoop 的 tmp 目录的根位置, 最好配置, 如果在新增节点或者其他情况下莫名其妙的 DataNode 启动不了, 就删除此 tmp 目录即可. 不过如果删除了 NameNode 机器的此目录, 那么就需要重新执行 HDFS 格式化的命令.</description>
    </property>
</configuration>
```

* `$HADOOP_HOME/etc/hadoop/hdfs-site.xml` HDFS 的配置文件

```bash
<configuration>
    <property>
        <name>dfs.http.address</name>
        <value>master:50070</value>
        <description>配置 HDFS 的 http 的访问位置</description>
    </property>
    <property>
        <name>dfs.namenode.secondary.http-address</name>
        <value>master:50090</value>
    </property>
    <property>
        <name>dfs.replication</name>
        <value>3</value>
        <description>配置文件块的副本数, 不能大于从机的个数, 一般设为 3</description>
    </property>
</configuration>
```

PS: 还可以配置下面两个属性

* dfs.namenode.name.dir 在本地文件系统上, NameNode 永久存储命名空间和事务日志的路径. 如果这是以逗号分隔的目录列表, 那么将在所有目录中复制名称表, 以实现冗余.
* dfs.datanode.data.dir 在本地文件系统上, DataNode 存储文件块的路径. 如果这是以逗号分隔的目录列表, 则数据将存储在所有命名目录中, 通常在不同的设备上.

* `$HADOOP_HOME/etc/hadoop/slaves`

```bash
# 设置从节点 hostname, 一行一个
slave1
slave2
slave3
```

##### 2.5.1.2 hdfs init

第一次启动HDFS时, 必须格式化, 在 shell 中执行: `hdfs namenode -format`

##### 2.5.1.3 启动与关闭

* 启动

```bash
start-dfs.sh
```

然后打开页面验证 hdfs 安装成功: http://localhost:50070/

* 关闭

```bash
stop-dfs.sh
```

#### 2.5.2 Yarn

##### 2.5.2.1 配置文件

* `$HADOOP_HOME/etc/hadoop/yarn-env.sh` yarn 运行环境配置, 修改如下位置

```bash
export JAVA_HOME=/usr/lib/jvm/java
```

* `$HADOOP_HOME/etc/hadoop/yarn-site.xml`

```bash
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.resourcemanager.webapp.address</name>
        <value>master:8088</value>
    </property>
    <property>
        <name>yarn.resourcemanager.hostname</name>
        <value>master</value>
    </property>
</configuration>
```

* `$HADOOP_HOME/etc/hadoop/mapred-site.xml` 先把模板文件复制一份

```bash
cp mapred-site.xml.template mapred-site.xml
```

配置如下

```bash
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property>
        <name>mapreduce.jobhistory.address</name>
        <value>master:10020</value>
    </property>
    <property>
        <name>mapreduce.jobhistory.webapp.address</name>
        <value>master:19888</value>
    </property>
</configuration>
```

##### 2.5.2.2 检查

启动 yarn

```bash
start-yarn.sh
```

然后打开页面验证 yarn 安装成功: http://localhost:8088/

## 3 Tips

* 在 master/slave 机器上执行 `jps` 命令可以看到后台运行的 java 程序

```bash
[bigdata@master ~]$ jps
43206 NameNode
43398 SecondaryNameNode
43551 ResourceManager
43950 Jps
```

```bash
[bigdata@slave ~]$ jps
32019 DataNode
32658 NodeManager
33267 Jps
```

* hadoop 组件的 web-ui
    * NameNode                    http://master_hostname:50070
    * ResourceManager             http://master_hostname:8088
    * MapReduce JobHistory 服务器 http://master_hostname:19888  (这个的话, 要先开启 `mr-jobhistory-daemon.sh start historyserver`, 关闭 `mr-jobhistory-daemon.sh stop historyserver`)
* 先开 hdfs, 再开 yarn; 先关 yarn, 再关 hdfs
* [hdfs shell 常用命令](hdfs)
* 遇到问题时, 先查看 logs, 很有帮助
* start-balancer.sh, 可以使 DataNode 节点上选择策略重新平衡 DataNode 上的数据块的分布
* 添加节点:
    * 建立 ssh 无密访问
    * 在 master 机器的 $HADOOP_HOME/etc/hadoop/slave 文件中添加新机器的 hostname
    * 将主机的 hadoop 所有文件拷贝到新机器(scp 命令), 根据新机器的环境不同改一下配置文件(如 $JAVA_HOME)
    * 配置环境变量: $HADOOP_HOME 等

## 4 阅读 Hadoop 源码

将 Hadoop 源码转成 eclipse 项目导入 eclipse 中

```bash
sudo apt-get install g++ maven protobuf-compiler=2.5.0 cmake zlib1g-dev findbugs
cd `Hadoop 的源码目录`
cd ./hadoop-maven-plugins
mvn install
cd ../** 你想构建的项目目录
mvn eclipse:eclipse -DskipTests
```

## 附: HBase

### 1 unpackage

```bash
tar xzf hbase-0.98.11-hadoop2-bin.tar.gz -C /usr/local
```

### 2 配置环境变量: 在 /etc/profile (or ~/.bashrc) 添加如下内容, 然后 重新登陆 或 source /etc/profile (or ~/.bashrc)

```bash
export HBASE_HOME=/usr/local/hbase-0.98.11-hadoop2
export PATH=$PATH:$HBASE_HOME/bin
```

### 3 更改所属权

因为是安装到 `/usr/local` 目录下, 所以要对用户账户赋予所属权, 若是安装到用户目录下则不用

```bash
sudo chown -R will:will $HBASE_HOME
```

### 4 修改配置文件

* $HBASE_HOME/conf/hbase-site.xml

```bash
<configuration>
    <property>
        <name>hbase.cluster.distributed</name>
        <value>true</value>
    </property>
    <property>
        <name>hbase.rootdir</name>
        <value>hdfs://localhost:9000/hbase</value>
    </property>
    <property>
        <name>hbase.zookeeper.property.dataDir</name>
        <value>/home/bigdata/work/hbase-zookeeper</value>    -------------自己设!
    </property>
</configuration>
```

hbase.rootdir 要是 hadoop 配置中 fs.default.name 的下级目录

### 5 启动与关闭

* 启动

```bash
start-hbase.sh
```

* 关闭

```bash
stop-hbase.sh
```

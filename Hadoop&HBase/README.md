# Hadoop & HBase

## Hadoop

### 1 伪分布式部署

#### 1.1 安装 JDK

#### 1.2 本机对本机能够 ssh 免密码登陆

配置 Hadoop 伪分布式需要本机对本机能够免密登陆, 直接将 ssh 公钥文件 id_rsa.pub 的内容追加到 authorized_keys 中即可

```bash
sudo apt-get install ssh
cd ~                                             # 最好在要配置的用户的家目录下
ssh-keygen -t rsa                                # 生成 rsa 密钥对, 也可以选 dsa
echo ./.ssh/id_rsa.pub >> ./.ssh/authorized_keys # id_rsa.pub 是公钥, id_rsa 是私钥
ssh localhost                                    # 验证, 第一次要输入 'yes' 确认加入 the list of known hosts
```

#### 1.3 unpackage

```bash
tar xzf hadoop-2.6.0.tar.gz -C /usr/local
```

#### 1.4 把下面的加到 ~/.bashrc 中, 要尽量放到前面(见 1.8 note)

```bash
export JAVA_HOME=/usr/local/java/jdk1.8.0_77

export HADOOP_HOME=/usr/local/hadoop-2.6.0

export CLASSPATH=$CLASSPATH:`$HADOOP_HOME/bin/hadoop classpath --glob`

export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
```

#### 1.5 更改所属权

因为是安装到 `/usr/local` 目录下, 所以要对用户账户赋予所属权, 若是安装到用户目录下则不用

```bash
sudo chown -R will:will $HADOOP_HOME
```

#### 1.6 修改配置文件

* $HADOOP_HOME/etc/hadoop/core-site.xml

```bash
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/home/will/work/hdfs</value>    -------------自己设!
    </property>
</configuration>
```

* $HADOOP_HOME/etc/hadoop/hdfs-site.xml

```bash
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>
```

#### 1.7 init

在 shell 中执行: `hdfs namenode -format`

#### 1.8 启动与关闭

* 启动

```bash
start-dfs.sh
```

然后打开页面验证 hdfs 安装成功: http://localhost:50070/

* 关闭

```bash
stop-dfs.sh
```

note: must define JAVA_HOME at the very beginning of .bashrc
      otherwise won't be executed in ssh localhost , 否则在hadoop-env.sh 中改 JAVA_HOME=....  绝对地址

#### 1.9 配置 yarn

* $HADOOP_HOME/etc/hadoop/mapred-site.xml

```bash
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
    <property>
        <name>mapred.job.tracker</name>
        <value>localhost:9001</value>
    </property>
</configuration>
```

* $HADOOP_HOME/etc/hadoop/yarn-site.xml

```bash
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
</configuration>
```

启动 yarn

```bash
start-yarn.sh
```

然后打开页面验证 yarn 安装成功: http://localhost:8088/cluster

### 2 分布式部署

### 3 阅读 Hadoop 源码

将 Hadoop 源码转成 eclipse 项目导入 eclipse 中

```bash
sudo apt-get install g++ maven protobuf-compiler=2.5.0 cmake zlib1g-dev findbugs
cd `Hadoop 的源码目录`
cd ./hadoop-maven-plugins
mvn install
cd ../** 你想构建的项目目录
mvn eclipse:eclipse -DskipTests
```

## HBase

### 1 unpackage

```bash
tar xzf hbase-0.98.11-hadoop2-bin.tar.gz -C /usr/local
```

### 2 把下面的加到 ~/.bashrc 中, 要尽量放到前面(见 1.8 note)

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
        <value>/home/will/work/hbase-zookeeper</value>    -------------自己设!
    </property>
</configuration>
```

### 5 启动与关闭

* 启动

```bash
start-hbase.sh
```

* 关闭

```bash
stop-hbase.sh
```

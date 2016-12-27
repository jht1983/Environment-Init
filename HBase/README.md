# HBase

在 Hadoop 集群上的分布式配置

## 0 资源分配

| HostName | IP              | Master | RegionServer |
| -------- | --------------- | ------ | ------------ |
| master   | 192.168.125.170 | yes    | no           |
| slave1   | 192.168.125.171 | backup | yes          |
| slave2   | 192.168.125.172 | no     | yes          |
| slave3   | 192.168.125.173 | no     | yes          |

## 1 前置

安装 JDK 与 Hadoop(见[hadoop 分布式部署](../Hadoop/README.md#2_分布式部署))

## 2 下载与解压

下载: http://www.apache.org/dyn/closer.cgi/hbase/

```bash
tar xzf hbase-1.2.4-bin.tar.gz -C /home/bigdata
```

PS: 确保你下载的版本与你现存的 Hadoop 版本兼容([兼容列表](http://hbase.apache.org/book.html#hadoop))

## 3 配置环境变量: 在 /etc/profile (or ~/.bashrc) 添加如下内容, 然后 重新登陆 或 source /etc/profile (or ~/.bashrc)

**四台机器上都要做**

```bash
export HBASE_HOME=/home/bigdata/hbase-1.2.4
export PATH=$PATH:$HBASE_HOME/bin
```

## 4 更改所属权

若是安装到 `/usr/local` 目录下, 要对用户账户赋予所属权

```bash
sudo chown -R will:will $HBASE_HOME
```

## 5 配置文件

**四台机器的配置完全一样, 只需配置完一台, 再复制到其余三台机器上就行**

* `$HBASE_HOME/conf/hbase-env.sh`

```bash
export JAVA_HOME=/usr/lib/jvm/java

# 使用独立的 ZooKeeper 而不使用内置 ZooKeeper
export HBASE_MANAGES_ZK=false
```

* `$HBASE_HOME/conf/hbase-site.xml`

```bash
<configuration>
    <property>
        <name>hbase.rootdir</name>
        <value>hdfs://master:9000/hbase</value>
        <description>是 hadoop 配置中 fs.defaultFS 的下级目录</description>
    </property>
    <property>
        <name>hbase.cluster.distributed</name>
        <value>true</value>
    </property>

    <!-- 因为我们用自己的 zookeeper, 所以不设置下面这几项 -->
    <!-- <property>
        <name>hbase.zookeeper.quorum</name>
        <value>master,slave1,slave2,slave3</value>
        <description>zookeeper 集群列表</description>
    </property>
    <property>
        <name>hbase.zookeeper.property.dataDir</name>
        <value>/home/bigdata/tmp/hbase-data</value>
        <description>对应 zookeeper/config/zoo.cfg 中的 dataDir</description>
    </property> -->
</configuration>
```

* `$HBASE_HOME/conf/regionservers` 去掉 localhost, 添加运行 RegionServer 的机器的 hostname(一行一条)

```bash
slave1
slave2
slave3
```

* 配置 backup Master, 在 `conf/` 目录下建立文件 `backup-masters`, 添加作为 backup Master 的机器的 hostname(一行一条)

```bash
slave1
```

* 以上在一台机器上就配置完了, 传送到所有机器上就行了

```bash
scp -r ~/hbase-1.2.4 username@slave1:~
scp -r ~/hbase-1.2.4 username@slave2:~
scp -r ~/hbase-1.2.4 username@slave3:~
```

## 6 启动与关闭

* **启动: 只需在 master 机上运行下面这条命令就行了**

```bash
start-hbase.sh
```

验证

* web-UI: http://master:16010
* 终端执行 `jps`, 显示如下

master 机

```bash
$ jps
20355 Jps
20137 HMaster
```

slave 机

```bash
$ jps
13901 Jps
13737 HRegionServer
```

* **关闭**

```bash
stop-hbase.sh
```

## 7 hbase shell

* 用 shell 连接 HBase.

```bash
bin/hbase shell
```

* 输入 help 然后 Enter 可以看到 hbase shell 命令的帮助. 要注意的是表名, 行和列需要加引号.

* create: 建表

```bash
hbase(main):001:0> create 'test', 'cf'
0 row(s) in 0.4170 seconds

=> Hbase::Table - test
```

* list: 列出所有表

```bash
hbase(main):002:0> list 'test'
TABLE
test
1 row(s) in 0.0180 seconds

=> ["test"]
```

* put: 插入行

```bash
hbase(main):003:0> put 'test', 'row1', 'cf:a', 'value1'
0 row(s) in 0.0850 seconds

hbase(main):004:0> put 'test', 'row2', 'cf:b', 'value2'
0 row(s) in 0.0110 seconds

hbase(main):005:0> put 'test', 'row3', 'cf:c', 'value3'
0 row(s) in 0.0100 seconds
```

* scan: 全表输出

```bash
hbase(main):006:0> scan 'test'
ROW                                      COLUMN+CELL
 row1                                    column=cf:a, timestamp=1421762485768, value=value1
 row2                                    column=cf:b, timestamp=1421762491785, value=value2
 row3                                    column=cf:c, timestamp=1421762496210, value=value3
3 row(s) in 0.0230 seconds
```

* get: 输出一行

```bash
hbase(main):007:0> get 'test', 'row1'
COLUMN                                   CELL
 cf:a                                    timestamp=1421762485768, value=value1
1 row(s) in 0.0350 seconds
```

* 删除表: 先 disable 表, 再 drop 表. 可以 re-enable 表

* disable: Disable 表

```bash
hbase(main):008:0> disable 'test'
0 row(s) in 1.1820 seconds
```

* enable: Enable 表

```bash
hbase(main):009:0> enable 'test'
0 row(s) in 0.1770 seconds

hbase(main):010:0> disable 'test'
0 row(s) in 1.1820 seconds
```

* drop: Drop 表

```bash
hbase(main):011:0> drop 'test'
0 row(s) in 0.1370 seconds
```

* exit: 退出 hbase shell

```bash
hbase(main):012:0> exit
```

## 附: 修改 ulimit 限制

HBase 会在同一时间打开大量的文件句柄和进程, 超过 Linux 的默认限制, 导致可能会出现如下错误.

```bash
2010-04-06 03:04:37,542 INFO org.apache.hadoop.hdfs.DFSClient: Exception increateBlockOutputStream java.io.EOFException
2010-04-06 03:04:37,542 INFO org.apache.hadoop.hdfs.DFSClient: Abandoning block blk_-6935524980745310745_1391901
```

所以编辑 `/etc/security/limits.conf` 文件, 添加以下两行, 提高能打开的句柄数量和进程数量. 注意将 `bigdata` 改成你运行 HBase 的用户名.

```bash
bigdata  -       nofile  32768
bigdata  -       nproc   32000
```

还需要在 `/etc/pam.d/common-session` 加上这一行:

```bash
session required pam_limits.so
```

否则在 `/etc/security/limits.conf` 上的配置不会生效.

最后还要注销(`logout` 或者 `exit`)后再登录, 这些配置才能生效! 使用 `ulimit -n -u` 命令查看最大文件和进程数量是否改变了. 记得在每台安装 HBase 的机器上运行哦.

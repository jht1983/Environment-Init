# Redis

Redis 是一个开源的可基于内存亦可持久化的日志型、Key-Value 数据库, 它通常被称为数据结构服务器, 因为值(value)可以是字符串(String), 哈希(Map), 列表(list), 集合(sets) 和 有序集合(sorted sets)等类型, 各式各样的问题都可以很自然地映射到这些数据结构上. 用户可以很方便地将 Redis 扩展成一个能够包含数百 GB 数据、每秒钟处理上百万次请求的系统

## 1 Redis 安装

**下载地址:** [http://redis.io/download](http://redis.io/download)

本教程使用的最新文档版本为 3.2.5, 下载并安装:

```bash
wget http://download.redis.io/releases/redis-3.2.5.tar.gz
tar xzf redis-3.2.5.tar.gz
cd redis-3.2.5
make
```

make 完, redis-3.2.5/src 目录下会出现编译后的 redis 服务程序 redis-server, 还有客户端程序 redis-cli

下面启动 redis 服务.

```bash
./src/redis-server
```

注意这种方式启动 redis 使用的是默认配置. 也可以通过启动参数告诉 redis 使用指定配置文件使用下面命令启动.

```bash
./src/redis-server ./redis.conf
```

redis.conf 是一个默认的配置文件. 我们可以根据需要使用自己的配置文件.

启动 redis 服务进程后, 就可以使用客户端程序 redis-cli 和 redis server 交互了. 比如:

```bash
$ ./src/redis-cli    # or ./src/redis-cli -h 127.0.0.1 -p 6379
redis 127.0.0.1:6379> ping
PONG
```

## 2 Redis 配置

Redis 的配置文件位于 Redis 安装目录下, 文件名为 redis.conf.

你可以通过 **CONFIG** 命令查看或设置配置项.

### 2.1 查看方法

**CONFIG GET** 命令基本语法:

```bash
redis 127.0.0.1:6379> CONFIG GET CONFIG_SETTING_NAME
```

例如

```bash
redis 127.0.0.1:6379> CONFIG GET loglevel
1) "loglevel"
2) "notice"
```

使用 `*` 号获取所有配置项:

```bash
redis 127.0.0.1:6379> CONFIG GET *
1) "dbfilename"
2) "dump.rdb"
3) "requirepass"
4) ""
5) "masterauth"
6) ""
...
```

### 2.2 修改方法

你可以通过修改 redis.conf 文件或使用 **CONFIG set** 命令来修改配置.

**CONFIG SET** 命令基本语法:

```bash
redis 127.0.0.1:6379> CONFIG SET CONFIG_SETTING_NAME NEW_CONFIG_VALUE
```

例如

```bash
redis 127.0.0.1:6379> CONFIG SET loglevel "notice"
OK
redis 127.0.0.1:6379> CONFIG GET loglevel
1) "loglevel"
2) "notice"
```

### 2.3 常用配置

```bash
daemonize yes
bind 0.0.0.0
port 6379
requirepass yourpassword
```

### 2.4 附: 参数说明

redis.conf 配置项说明如下:

1. Redis 默认不是以守护进程的方式运行, 可以通过该配置项修改, 使用 yes 启用守护进程
    daemonize no
2. 当 Redis 以守护进程方式运行时, Redis 默认会把 pid 写入 /var/run/redis.pid 文件, 可以通过 pidfile 指定
    pidfile /var/run/redis.pid
3. 绑定用于接受 redis 访问请求的本机 IP 地址, 可绑定多个, 用空格隔开. 即如果你的 redis 服务器有两张网卡, 一张是 ip-1, 另一张是 ip-2, 如果你 bind ip-1, 那么只有对 ip-1 的请求会被受理.
    bind 127.0.0.1 则只能本机访问
    bind 0.0.0.0    则只有本子网内的机器可以访问
    注释掉 `# bind 127.0.0.1` 则接受所有访问
4. 指定 Redis 监听端口, 默认端口为 6379, 作者在自己的一篇博文中解释了为什么选用 6379 作为默认端口, 因为 6379 在手机按键上 MERZ 对应的号码, 而 MERZ 取自意大利歌女 Alessia Merz 的名字
    port 6379
5. 设置 Redis 连接密码, 如果配置了连接密码, 客户端在连接Redis时需要通过 `AUTH <password>` 命令提供密码, 默认关闭
    requirepass yourpassword
6. 当 客户端闲置多长时间后关闭连接, 如果指定为0, 表示关闭该功能
    timeout 300
7. 指定日志记录级别, Redis 总共支持四个级别: debug, verbose, notice, warning, 默认为 verbose
    loglevel verbose
8. 日志记录方式, 默认为标准输出, 如果配置 Redis 为守护进程方式运行, 而这里又配置为日志记录方式为标准输出, 则日志将会发送给 /dev/null
    logfile stdout
9. 设置数据库的数量, 默认数据库为 0, 可以使用 SELECT <dbid> 命令在连接上指定数据库 id
    databases 16
10. 指定在多长时间内, 有多少次更新操作, 就将数据同步到数据文件, 可以多个条件配合
    save <seconds> <changes>
    Redis默认配置文件中提供了三个条件:
    save 900 1
    save 300 10
    save 60 10000
    分别表示 900 秒(15 分钟)内有 1 个更改, 300 秒(5 分钟)内有 10 个更改以及 60 秒内有 10000 个更改.
11. 指定存储至本地数据库时是否压缩数据, 默认为 yes, Redis 采用 LZF 压缩, 如果为了节省 CPU 时间, 可以关闭该选项, 但会导致数据库文件变的巨大
    rdbcompression yes
12. 指定本地数据库文件名, 默认值为 dump.rdb
    dbfilename dump.rdb
13. 指定本地数据库存放目录
    dir ./
14. 设置当本机为 slave 服务时, 设置 master 服务的 IP 地址及端口, 在 Redis 启动时, 它会自动从 master 进行数据同步
    slaveof <masterip> <masterport>
15. 当 master 服务设置了密码保护时, slave 服务连接 master 的密码
    masterauth <master-password>
16. 设置同一时间最大客户端连接数, 默认无限制, Redis 可以同时打开的客户端连接数为 Redis 进程可以打开的最大文件描述符数, 如果设置 maxclients 0, 表示不作限制. 当客户端连接数到达限制时, Redis 会关闭新的连接并向客户端返回 "max number of clients reached" 错误信息
    maxclients 128
17. 指定 Redis 最大内存限制, Redis 在启动时会把数据加载到内存中, 达到最大内存后, Redis 会先尝试清除已到期或即将到期的 Key, 当此方法处理后, 仍然到达最大内存设置, 将无法再进行写入操作, 但仍然可以进行读取操作. Redis 新的 vm 机制, 会把 Key 存放内存, Value 会存放在 swap 区
    maxmemory <bytes>
18. 指定是否在每次更新操作后进行日志记录, Redis 在默认情况下是异步的把数据写入磁盘, 如果不开启, 可能会在断电时导致一段时间内的数据丢失. 因为 redis 本身同步数据文件是按上面 save 条件来同步的, 所以有的数据会在一段时间内只存在于内存中. 默认为 no
    appendonly no
19. 指定更新日志文件名, 默认为 appendonly.aof
    appendfilename appendonly.aof
20. 指定更新日志条件, 共有 3 个可选值:
    no: 表示等操作系统进行数据缓存同步到磁盘(快)
    always: 表示每次更新操作后手动调用 fsync() 将数据写到磁盘(慢, 安全)
    everysec: 表示每秒同步一次(折衷, 默认值)
    appendfsync everysec
21. 指定是否启用虚拟内存机制, 默认值为 no, 简单的介绍一下, VM 机制将数据分页存放, 由 Redis 将访问量较少的页即冷数据 swap 到磁盘上, 访问多的页面由磁盘自动换出到内存中(在后面的文章我会仔细分析 Redis 的 VM 机制)
    vm-enabled no
22. 虚拟内存文件路径, 默认值为 /tmp/redis.swap, 不可多个 Redis 实例共享
    vm-swap-file /tmp/redis.swap
23. 将所有大于 vm-max-memory 的数据存入虚拟内存, 无论 vm-max-memory 设置多小, 所有索引数据都是内存存储的(Redis 的索引数据就是 keys), 也就是说, 当 vm-max-memory 设置为 0 的时候, 其实是所有 value 都存在于磁盘. 默认值为 0
    vm-max-memory 0
24. Redis swap 文件分成了很多的 page, 一个对象可以保存在多个 page 上面, 但一个 page 上不能被多个对象共享, vm-page-size 是要根据存储的数据大小来设定的, 作者建议如果存储很多小对象, page 大小最好设置为 32 或者 64 bytes; 如果存储很大大对象, 则可以使用更大的 page, 如果不确定, 就使用默认值
    vm-page-size 32
25. 设置 swap 文件中的 page 数量, 由于页表(一种表示页面空闲或使用的 bitmap)是在放在内存中的, 在磁盘上每 8 个 pages 将消耗 1 byte 的内存.
    vm-pages 134217728
26. 设置访问 swap 文件的线程数,最好不要超过机器的核数,如果设置为 0,那么所有对 swap 文件的操作都是串行的, 可能会造成比较长时间的延迟. 默认值为 4
    vm-max-threads 4
27. 设置在向客户端应答时, 是否把较小的包合并为一个包发送, 默认为开启
    glueoutputbuf yes
28. 指定在超过一定的数量或者最大的元素超过某一临界值时, 采用一种特殊的哈希算法
    hash-max-zipmap-entries 64
    hash-max-zipmap-value 512
29. 指定是否激活重置哈希, 默认为开启(后面在介绍 Redis 的哈希算法时具体介绍)
    activerehashing yes
30. 指定包含其它的配置文件, 可以在同一主机上多个 Redis 实例之间使用同一份配置文件, 而同时各个实例又拥有自己的特定配置文件
    include /path/to/local.conf

## 3 集群(即分布式)

redis 从 3.0 以后的版本开始支持集群功能, 也就是正真意义上实现了分布式. Redis 集群是一个分布式(distributed), 容错(fault-tolerant)的 Redis 实现, 集群的其中一个主要设计目标是达到线性可扩展性(linear scalability). 目前在数据的一致性和容错性上尚不稳定, 所以暂时没有配置集群.

**PS:** 在单机上运行 Redis 最大的需求是内存.

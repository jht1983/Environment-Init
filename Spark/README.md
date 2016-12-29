# Spark

## 0 资源分配

| IP            | Hostname |
| ------------- | -------- |
| 192.168.1.170 | master   |
| 192.168.1.171 | slave1   |
| 192.168.1.172 | slave2   |
| 192.168.1.173 | slave3   |

**Spark 官方提供了三种集群部署方案: Standalone, Mesos, YARN. 下面分别讲解.**

## 1 Standalone

Standalone

## 2 Mesos

见

## 3 YARN

| IP            | Hostname |
| ------------- | -------- |
| 192.168.1.170 | master   |
| 192.168.1.171 | slave1   |
| 192.168.1.172 | slave2   |
| 192.168.1.173 | slave3   |

* 建议直接在 firewall 中配置这些机器之间的互访不做端口过滤. 使用 rich rule: 对指定的 IP 不做拦截. 例如要设置来自 192.168.1.1 的访问不做端口过滤, 命令如下

```bash
sudo firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='192.168.1.1' accept"
```

* 而对外开放的端口有: (Spark on YARN 没有需要单独配置的对外开放端口)

Spark on YARN 的配置很简单, 只需要配置好 `YARN 集群`, 然后在一台机器上解压 Spark 包, 在提交 spark 程序时, 指定 master 参数为 yarn, deploy-mode 为 cluster 或 client.

### 1 安装配置 Hadoop

详见 [Hadoop 部署](../Hadoop&HBase/README.md)

### 2 下载与解压

下载: http://spark.apache.org/downloads.html, 选择 spark-2.0.2-bin-hadoop2.7.tgz

```bash
tar xzf spark-2.0.2-bin-hadoop2.7.tgz -C /home/bigdata
```

### 3 配置环境变量: 在 /etc/profile (or ~/.bashrc) 添加如下内容, 然后 重新登陆 或 source /etc/profile (or ~/.bashrc)

```bash
export SPARK_HOME=/home/bigdata/spark-2.0.2-bin-hadoop2.7
export PATH=$PATH:$SPARK_HOME/bin
```

### 4 启动 HDFS & YARN

```bash
start-dfs.sh
start-yarn.sh
```

### 5 在 Yarn 上运行 Spark 程序

以 YARN-cluster 形式提交示例程序

```bash
cd $SPARK_HOME
bin/spark-submit --class org.apache.spark.examples.SparkPi \
    --master yarn \
    --deploy-mode cluster \
    examples/jars/spark-examples*.jar \
    10
```

到 Yarn-UI(http://master_hostname:8088), 找到任务

![1](1.png)

点进去, 左上角的 `Kill Application` 用于关闭这个任务

![2](2.png)

中间的 `ApplicationMaster` 可以跳转到 Spark-UI 查看 spark 对这个任务的 UI 界面

![3](3.png)

![4](4.png)

下面的是对这个任务的描述, 如下, 只在一个节点上运行, 点击 `Logs` 可以查看 logs 输出

![5](5.png)

这是示例程序的输出

![6](6.png)

## Spark Streaming 可配置的属性

| Property Name                            | Default | Meaning                                  |
| ---------------------------------------- | ------- | ---------------------------------------- |
| `spark.streaming.backpressure.enabled`   | false   | Enables or disables Spark Streaming's internal backpressure mechanism (since 1.5). This enables the Spark Streaming to control the receiving rate based on the current batch scheduling delays and processing times so that the system receives only as fast as the system can process. Internally, this dynamically sets the maximum receiving rate of receivers. This rate is upper bounded by the values `spark.streaming.receiver.maxRate` and`spark.streaming.kafka.maxRatePerPartition` if they are set (see below). |
| `spark.streaming.backpressure.initialRate` | not set | This is the initial maximum receiving rate at which each receiver will receive data for the first batch when the backpressure mechanism is enabled. |
| `spark.streaming.blockInterval`          | 200ms   | Interval at which data received by Spark Streaming receivers is chunked into blocks of data before storing them in Spark. Minimum recommended - 50 ms. See the [performance tuning](http://spark.apache.org/docs/latest/streaming-programming-guide.html#level-of-parallelism-in-data-receiving)section in the Spark Streaming programing guide for more details. |
| `spark.streaming.receiver.maxRate`       | not set | Maximum rate (number of records per second) at which each receiver will receive data. Effectively, each stream will consume at most this number of records per second. Setting this configuration to 0 or a negative number will put no limit on the rate. See the [deployment guide](http://spark.apache.org/docs/latest/streaming-programming-guide.html#deploying-applications) in the Spark Streaming programing guide for mode details. |
| `spark.streaming.receiver.writeAheadLog.enable` | false   | Enable write ahead logs for receivers. All the input data received through receivers will be saved to write ahead logs that will allow it to be recovered after driver failures. See the [deployment guide](http://spark.apache.org/docs/latest/streaming-programming-guide.html#deploying-applications)in the Spark Streaming programing guide for more details. |
| `spark.streaming.unpersist`              | true    | Force RDDs generated and persisted by Spark Streaming to be automatically unpersisted from Spark's memory. The raw input data received by Spark Streaming is also automatically cleared. Setting this to false will allow the raw data and persisted RDDs to be accessible outside the streaming application as they will not be cleared automatically. But it comes at the cost of higher memory usage in Spark. |
| `spark.streaming.stopGracefullyOnShutdown` | false   | If `true`, Spark shuts down the `StreamingContext` gracefully on JVM shutdown rather than immediately. |
| `spark.streaming.kafka.maxRatePerPartition` | not set | Maximum rate (number of records per second) at which data will be read from each Kafka partition when using the new Kafka direct stream API. See the [Kafka Integration guide](http://spark.apache.org/docs/latest/streaming-kafka-integration.html) for more details. |
| `spark.streaming.kafka.maxRetries`       | 1       | Maximum number of consecutive retries the driver will make in order to find the latest offsets on the leader of each partition (a default value of 1 means that the driver will make a maximum of 2 attempts). Only applies to the new Kafka direct stream API. |
| `spark.streaming.ui.retainedBatches`     | 1000    | How many batches the Spark Streaming UI and status APIs remember before garbage collecting. |
| `spark.streaming.driver.writeAheadLog.closeFileAfterWrite` | false   | Whether to close the file after writing a write ahead log record on the driver. Set this to 'true' when you want to use S3 (or any file system that does not support flushing) for the metadata WAL on the driver. |
| `spark.streaming.receiver.writeAheadLog.closeFileAfterWrite` | false   | Whether to close the file after writing a write ahead log record on the receivers. Set this to 'true' when you want to use S3 (or any file system that does not support flushing) for the data WAL on the receivers. |

#!/bin/bash

echo "Loading properties"
. install.properties

tar zxvf /root/Downloads/presto-server-$PRESTO_VERSION.tar.gz

mv presto-server-$PRESTO_VERSION /usr/local

mv /usr/local/presto-server-$PRESTO_VERSION /usr/local/presto

cp /mnt/tmp/dls/presto-cli-$PRESTO_VERSION-executable.jar /usr/local/presto/bin

mv /usr/local/presto/bin/presto-cli-$PRESTO_VERSION-executable.jar /usr/local/presto/bin/presto

chmod +x /usr/local/presto/bin/presto

mkdir /usr/local/presto/etc
mkdir /usr/local/presto/etc/catalog
mkdir /var/presto
mkdir /var/presto/data

echo "# The following is a minimal etc/node.properties" >> /usr/local/presto/etc/node.properties
echo "node.environment=production" >> /usr/local/presto/etc/node.properties
echo "node.id=ffffffff-ffff-ffff-ffff-ffffffffffff" >> /usr/local/presto/etc/node.properties
echo "node.data-dir=/var/presto/data" >> /usr/local/presto/etc/node.properties

echo "# The following provides a good starting point for creating etc/jvm.config:" >> /usr/local/presto/etc/jvm.config
echo "-server" >> /usr/local/presto/etc/jvm.config
echo "-Xmx16G" >> /usr/local/presto/etc/jvm.config
echo "-XX:+UseConcMarkSweepGC" >> /usr/local/presto/etc/jvm.config
echo "-XX:+ExplicitGCInvokesConcurrent" >> /usr/local/presto/etc/jvm.config
echo "-XX:+AggressiveOpts" >> /usr/local/presto/etc/jvm.config
echo "-XX:+HeapDumpOnOutOfMemoryError" >> /usr/local/presto/etc/jvm.config
echo "-XX:OnOutOfMemoryError=kill -9 %p" >> /usr/local/presto/etc/jvm.config

echo "# if you are setting up a single machine for testing that will function as both a coordinator and worker, use this configuration:" >> /usr/local/presto/etc/config.properties
echo "coordinator=true" >> /usr/local/presto/etc/config.properties
echo "node-scheduler.include-coordinator=true" >> /usr/local/presto/etc/config.properties
echo "http-server.http.port=8084" >> /usr/local/presto/etc/config.properties
echo "task.max-memory=1GB" >> /usr/local/presto/etc/config.properties
echo "discovery-server.enabled=true" >> /usr/local/presto/etc/config.properties
echo "discovery.uri=http://localhost:8084" >> /usr/local/presto/etc/config.properties

echo "com.facebook.presto=INFO" >> /usr/local/presto/etc/log.properties

echo "connector.name=hive-hadoop2" >> /usr/local/presto/etc/catalog/hive.properties
echo "hive.metastore.uri=thrift://localhost:9083" >> /usr/local/presto/etc/catalog/hive.properties

echo "connector.name=kafka" >> /usr/local/presto/etc/catalog/kafka.properties
echo "kafka.nodes=localhost:6667" >> /usr/local/presto/etc/catalog/kafka.properties
echo "kafka.table-names=test,tweets" >> /usr/local/presto/etc/catalog/kafka.properties
echo "kafka.hide-internal-columns=false" >> /usr/local/presto/etc/catalog/kafka.properties

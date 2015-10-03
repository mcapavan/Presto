# Presto
Capture the Presto code and best practices

Java 8 is the mandatory version for Presto

====================
Presto Installation:
====================

wget https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.109/presto-server-0.109.tar.gz

tar -xvf presto-server-0.109.tar.gz

mv presto-server-0.109 /usr/local/presto

cd /usr/local/presto

mkdir /usr/local/presto/etc

####################
#Configuring Presto:
####################

#Node Properties:

vi etc/node.properties

# The following is a minimal etc/node.properties
node.environment=production
node.id=ffffffff-ffff-ffff-ffff-ffffffffffff
node.data-dir=/var/presto/data

mkdir /var/presto

ech

# JVM Config:

vi etc/jvm.config

# The following provides a good starting point for creating etc/jvm.config:

-server
-Xmx16G
-XX:+UseConcMarkSweepGC
-XX:+ExplicitGCInvokesConcurrent
-XX:+AggressiveOpts
-XX:+HeapDumpOnOutOfMemoryError
-XX:OnOutOfMemoryError=kill -9 %p

#Config Properties:

vi etc/config.properties

# if you are setting up a single machine for testing that will function as both a coordinator and worker, use this configuration:

coordinator=true
node-scheduler.include-coordinator=true
http-server.http.port=8084
task.max-memory=1GB
discovery-server.enabled=true
discovery.uri=http://localhost:8084

#Log Levels:

vi etc/log.properties

com.facebook.presto=INFO

#Catalog Properties:

mkdir etc/catalog

#Hive Connector:

vi etc/catalog/hive.properties


#Apache Hadoop 1.x: hive-hadoop1
#Apache Hadoop 2.x: hive-hadoop2
#Cloudera CDH 4: hive-cdh4
# Cloudera CDH 5: hive-cdh5

connector.name=hive-hadoop2
hive.metastore.uri=thrift://localhost:9083



#Running Presto:

#bin/launcher start   # To run as a daemon (at the background)

bin/launcher run # to run in the foreground

# Download Presto CLI:

cd /usr/local/presto/bin

wget https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/0.109/presto-cli-0.109-executable.jar

mv presto-cli-0.109-executable.jar presto

chmod +x presto


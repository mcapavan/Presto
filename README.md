# Presto
Capture the Presto code and best practices

Java 8 is the mandatory version for Presto

### Presto Installation:

You will be installing Presto on Hortonworks Sandbox. Please refer [Hortonworks Sandbox] (http://hortonworks.com/products/hortonworks-sandbox/#install/ "HDP Sandbox") website if required.

Log on to HDP Sandbox via CLI / Putty 

Ensure you have internet access on Sandbox to download Maven, Java and Presto. The total download size is around 600MB.

git clone https://github.com/mcapavan/Presto.git

cd Presto/auto-install

./install.sh

###Start Presto Server: 
/usr/local/presto/bin/tools/start-presto.sh

run jps to confirm the PrestoServer is running

###Access Hive via Presto CLI:

/usr/local/presto/bin/tools/start-presto-cli.sh --server localhost:8084 --catalog hive --schema default

presto:default> show tables;

presto:default> select count(*) from sample_07;


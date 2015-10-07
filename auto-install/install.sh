#!/bin/bash

echo "Usage is: install.sh [-e ENV]"
echo " - for example: ./install.sh -e bob"

echo "Parsing script parameters"
while [[ $# > 0 ]]
do
key="$1"

case $key in
    -e|--environment)
    ENV="$2"
    shift # past argument
    ;;
    -a|--another-option)
    AOTHER_OPTION="$2"
    shift # past argument
    ;;
    *)
    # unknown option
    ;;
esac
shift # past argument or value
done

echo "Loading properties"
. install.properties

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
#echo "Setting environment to '$ENV'"
#echo "$ENV" > $DIR/env/current

#ENVIRONMENT=$(cat "$DIR"/env/current)
#if [ "$ENVIRONMENT" != "" ]; then
#    echo "Overloading properties for environment $ENV"
#    . env/install-$ENVIRONMENT.properties
#fi



echo "The process:"
echo "7. download maven, if not already there"
echo "8. download java 8, if not already there"
echo "9. download presto, if not already there"
echo ""

if [ ! -e "/root/Downloads" ]; then
    mkdir "/root/Downloads"
fi




if [ ! -e "/root/Downloads/apache-maven-$MAVEN_VERSION-bin.tar.gz" ]; then
    echo "Downloading Maven"
    curl -Lo "/root/Downloads/apache-maven-$MAVEN_VERSION-bin.tar.gz" http://mirror.sdunix.com/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz
else
    echo "Skipping Maven download because it already exists"
fi
echo "7. Download Maven: OK"

if [ ! -e "/root/Downloads/$JDK_PACKAGE.tar.gz" ]; then
    echo "Downloading Java 8"
    curl -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u45-b14/$JDK_PACKAGE.tar.gz" > /root/Downloads/$JDK_PACKAGE.tar.gz
else
    echo "Skipping Java 8 download because it already exists"
fi
echo "8. Download Java 8: OK"

if [ ! -e "/root/Downloads/presto-server-$PRESTO_VERSION.tar.gz" ]; then
    echo "Downloading Presto server"
    curl -Lo "/root/Downloads/presto-server-$PRESTO_VERSION.tar.gz" https://repo1.maven.org/maven2/com/facebook/presto/presto-server/$PRESTO_VERSION/presto-server-$PRESTO_VERSION.tar.gz
else
    echo "Skipping Presto server download because it already exists"
fi

if [ ! -e "/root/Downloads/presto-cli-$PRESTO_VERSION-executable.jar" ]; then
    echo "Downloading Presto CLI"
    curl -Lo "/root/Downloads/presto-cli-$PRESTO_VERSION-executable.jar" https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/$PRESTO_VERSION/presto-cli-$PRESTO_VERSION-executable.jar
else
    echo "Skipping Presto CLI download because it already exists"
fi

echo "9. Download Presto: OK"

conf/install-maven.sh

conf/install-java8.sh

conf/install-presto.sh

cp conf/tools/*.* /usr/local/presto/bin/tools

echo "Presto $PRESTO_VERSION installation is SUCCESSFUL!!!"
echo "Run lib/start-presto.sh to start Presto Server and Run lib/start-presto-cli for use Presto CLI"


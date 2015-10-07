#!/bin/bash

echo "Loading properties"
. install.properties

if [ ! -e "/opt/jdk${JAVA_VERSION}" ]; then
tar zxvf /root/Downloads/${JDK_PACKAGE}.tar.gz
mv jdk${JAVA_VERSION} /opt
fi

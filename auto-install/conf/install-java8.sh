#!/bin/bash

echo "Loading properties"
. install.properties

tar zxvf /root/Donwloads/${JDK_PACKAGE}.tar.gz

mv jdk${JAVA_VERSION} /opt

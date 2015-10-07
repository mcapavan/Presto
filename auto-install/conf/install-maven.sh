#!/usr/bin/env bash

echo "Loading properties"
. install.properties


command -v mvn >/dev/null 2>&1 || {
    echo "Maven it's not installed.  Installing maven." >&2;

    tar zxvf /root/Downloads/apache-maven-${MAVEN_VERSION}-bin.tar.gz
    rm -f apache-maven-${MAVEN_VERSION}-bin.tar.gz
    mv apache-maven-${MAVEN_VERSION} /opt

    echo "Adding maven to PATH"
    sudo echo "export M2_HOME=/opt/apache-maven-${MAVEN_VERSION}" >> /root/.bash_profile
    sudo echo "export M2=/opt/apache-maven-${MAVEN_VERSION}/bin" >> /root/.bash_profile
    sudo echo "export PATH=\$PATH:/opt/apache-maven-${MAVEN_VERSION}/bin"  >> /root/.bash_profile
}



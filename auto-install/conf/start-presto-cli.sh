#!/bin/bash

echo "Starting Presto CLI"
echo "Java: ${JAVA_VERSION}"

PATH=/opt/jdk${JAVA_VERSION}/bin:$PATH /usr/local/presto/bin/presto "$@"


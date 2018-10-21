#!/bin/bash

JDK_LOCATION=`ls -1 /opt/jdk`
export JAVA_HOME=/opt/jdk/${JDK_LOCATION}
export PATH=${PATH}:${JAVA_HOME}/bin

export PROFILER_FLAG="-XX:+UseLinuxPosixThreadCPUClocks -agentpath:/opt/profiler/lib/deployed/jdk16/linux-amd64/libprofilerinterface.so=/opt/profiler/lib,5140"

export JAVA_MEMORY_SETTINGS="-Xms4G -Xmx6G"

cd /opt/ProfilerCode

javac Main.java
java ${PROFILER_FLAG} ${JAVA_MEMORY_SETTINGS} -cp . Main


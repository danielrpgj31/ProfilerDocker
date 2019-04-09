[![Price](https://img.shields.io/badge/price-FREE-0098f7.svg)](https://github.com/mkowsiak/ProfilerDocker/blob/master/LICENSE.md)
[![GitHub](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/mkowsiak/ProfilerDocker/blob/master/LICENSE.md)
# NetBeans - Profiler testing Docker image

This Docker based Profiler tester helps you setup remote machine with Java code running and waiting for NetBeans Profiler to attach.

# Project structure

    .
    |-- LICENSE.md                             - MIT license file
    |-- README.md                              - this README.md file
    |-- Dockerfile                             - Docker file for creating image
    |-- run.sh                                 - wrapper script that runs everything
    `-- images                                 - sample images show here

# Creating profiler server

Before you can proceed, you have to create profiler server inside NetBeans. I suggest to store it inside `/tmp/profiler-server-linuxamd64.zip`

Open remote profiler settings by choosing: `Profile -> Attach to External Process`

<p align="center">
  <img src="https://github.com/mkowsiak/ProfilerDocker/blob/master/images/profiler_pack.png?raw=true">
</p>

# Building

    > git clone https://github.com/mkowsiak/ProfilerDocker
    > cd ProfilerDocker
    > cp /tmp/profiler-server-linuxamd64.zip ./profiler-server-linuxamd64.zip
    > docker build -t profiler \
    --build-arg jdk_location=\
    "https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz" \
    .

# Running

    > docker run -i -t -p 5140:5140 profiler

if you can't use your local port `5140` you can always specify different port forwarding

    > docker run -i -t -p $PORT_NO_YOU_WANT:5140 profiler

# Attaching to running, remote, JVM

Make sure to `Attach` from NetBeans and make sure to use `localhost` as an address of the target machine.

<p align="center">
  <img src="https://github.com/mkowsiak/ProfilerDocker/blob/master/images/netbeans_attach.png?raw=true">
</p>

# Known limitations

At the moment, ProfilerDocker is using only one architecture for remote profiling: `Linux (Intel/AMD) 64bit JVM`

# Java code used for profiling

ProfilerDocker is based on very simple Java code that runs infinite loop. The loop spawns 2-4 threads, each thread sleeps 5-10 seconds and allocates memory in range: [512KB, 512MB].

You can find source code here: <a href="https://github.com/mkowsiak/ProfilerCode">ProfilerCode</a>.

# References

- [OpenJDK web page](https://openjdk.java.net)
- [Docker page](https://www.docker.com)
- [ProfilerCode](https://github.com/mkowsiak/ProfilerCode)

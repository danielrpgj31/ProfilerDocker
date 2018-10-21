FROM ubuntu:18.10

LABEL author="michal@owsiak.org"
LABEL description="Profiler tester for NetCAT"

# we need some packages to be installed
RUN apt-get update
RUN apt-get install -y unzip
RUN apt-get install -y curl
RUN apt-get install -y git

# Some variables we need
# You have to pass them via --build-arg while performing build
# of the container
#
# e.g.: 
# --build-arg jdk_location="https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz" \
# --build-arg profiler_pack_location=/tmp/profiler-server-linuxamd64.zip
#

ARG jdk_location=you_have_to_specify_jdk_location_via_argument
ENV jdk_location_bash $jdk_location

# Layout of /opt directories
# /opt
#  |-- ProfilerCode       - Java based code that will be profiled
#  |-- jdk                - JDK will be installed here
#  `-- profiler           - profiler libraries (created by NetBeans)
#
RUN mkdir -p /opt/jdk
RUN mkdir -p /opt/profiler

# We can get JDK from the location specified by user
RUN echo "Getting JDK from: $jdk_location_bash"
WORKDIR /opt
RUN curl -O $jdk_location_bash
RUN find . -name "*gz" -exec tar zxf {} -C /opt/jdk \;

ADD run.sh /opt/run.sh
RUN git clone https://github.com/mkowsiak/ProfilerCode.git

# copy and unzip profiler pack
ADD profiler-server-linuxamd64.zip /opt/profiler
WORKDIR /opt/profiler
RUN find . -name "*zip" -exec unzip {} \;

RUN chmod +x /opt/run.sh

CMD /opt/run.sh


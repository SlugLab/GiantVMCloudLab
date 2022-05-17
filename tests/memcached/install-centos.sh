#!/bin/bash

## download and install memcached. This script is current written for the server and client to be colocated.
## Eventually, we will want the client and server to live on different hosts



#### install memcached
## requirements for memcached
sudo yum -y install libevent-devel
sudo yum install python2
sudo yum install -y maven java-1.8.0-openjdk-devel


wget https://memcached.org/files/memcached-1.6.13.tar.gz --no-check-certificate
tar -xf memcached-1.6.13.tar.gz
pushd memcached-1.6.13
./configure && make -j 9
popd

#### install YCSB
## requirements for YCSB
sudo apt install -y maven openjdk-8-jdk
## Install new version maven in centos from https://linuxize.com/post/how-to-install-apache-maven-on-centos-7/
sudo yum install maven
# mvn -version
sudo yum install java-1.8.0-openjdk
# java -version
# get the latest version from here: https://maven.apache.org/download.cgi
wget https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz -P /tmp --no-check-certificate
sudo tar xf /tmp/apache-maven-3.8.5-bin.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.8.5 /opt/maven


sudo vi /etc/profile.d/maven.sh
# write in this file
export JAVA_HOME=/usr/lib/jvm/jre-openjdk
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
export PATH=${M2_HOME}/bin:${PATH}

sudo chmod +x /etc/profile.d/maven.sh
bash
source /etc/profile.d/maven.sh
# mvn -version 

git clone https://github.com/brianfrankcooper/YCSB.git
pushd YCSB
git apply ../python2.patch
mvn -pl site.ycsb:memcached-binding -am clean package
popd

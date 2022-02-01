#!/bin/bash

## download and install memcached. This script is current written for the server and client to be colocated.
## Eventually, we will want the client and server to live on different hosts



#### install memcached
## requirements for memcached
sudo apt install -y libevent-dev

wget https://memcached.org/files/memcached-1.6.13.tar.gz
tar -xf memcached-1.6.13.tar.gz
pushd memcached-1.6.13
./configure && make -j 9
popd

#### install YCSB
## requirements for YCSB
sudo apt install -y maven openjdk-8-jdk

git clone https://github.com/brianfrankcooper/YCSB.git
pushd YCSB
git apply ../python2.patch
mvn -pl site.ycsb:memcached-binding -am clean package
popd

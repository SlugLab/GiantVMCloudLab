#!/bin/bash
# Install autoconf on CentOS 7 Using yum
sudo yum makecache
sudo yum -y install autoconf

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

pushd ${SCRIPT_DIR}

git clone https://github.com/ydmao/Metis.git

# Comment out irrelevant lines from data_tool/data-gen.sh
cp ./data-gen.sh ./Metis/data_tool/

pushd Metis 
    autoreconf -ivf && ./configure && make

    # Download and extract required dataset for centos
    wget http://pdos.csail.mit.edu/metis/data.tar.gz --no-check-certificate
    tar -xf ./data.tar.gz

    # Increase number of allowed open files
    ulimit -n 1048576

    source ./data_tool/data-gen.sh

popd

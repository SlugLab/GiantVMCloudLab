#!/bin/bash

# install requirements
sudo apt-get update
sudo apt install make
sudo apt-get install build-essential
sudo apt-get install libz-dev


# download Graphchi
git clone https://github.com/GraphChi/graphchi-cpp

# building the PageRank application
cd graphchi-cpp
make example_apps/pagerank_functional

# download twitter dataset
mkdir twitter_dataset
cd twitter_dataset
wget https://github.com/ANLAB-KAIST/traces/releases/download/twitter_rv.net/twitter_rv.net.00.gz
wget https://github.com/ANLAB-KAIST/traces/releases/download/twitter_rv.net/twitter_rv.net.01.gz
wget https://github.com/ANLAB-KAIST/traces/releases/download/twitter_rv.net/twitter_rv.net.02.gz
wget https://github.com/ANLAB-KAIST/traces/releases/download/twitter_rv.net/twitter_rv.net.03.gz
gunzip -c twitter_rv.net.00 twitter_rv.net.01 twitter_rv.net.02 twitter_rv.net.03 > twitter_rv.net



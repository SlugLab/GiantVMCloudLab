nstall requirements
yum check-update
sudo yum install make
sudo yum install gcc gcc-c++ kernel-devel make
sudo yum install zlib-devel


# download Graphchi
git clone https://github.com/GraphChi/graphchi-cpp

# building the PageRank application
cd graphchi-cpp
make example_apps/pagerank_functional

# download twitter dataset
mkdir twitter_dataset
cd twitter_dataset
wget https://github.com/ANLAB-KAIST/traces/releases/download/twitter_rv.net/twitter_rv.net.00.gz --no-check-certificate
wget https://github.com/ANLAB-KAIST/traces/releases/download/twitter_rv.net/twitter_rv.net.01.gz --no-check-certificate
wget https://github.com/ANLAB-KAIST/traces/releases/download/twitter_rv.net/twitter_rv.net.02.gz --no-check-certificate
wget https://github.com/ANLAB-KAIST/traces/releases/download/twitter_rv.net/twitter_rv.net.03.gz --no-check-certificate
gunzip -c twitter_rv.net.00 twitter_rv.net.01 twitter_rv.net.02 twitter_rv.net.03 > twitter_rv.net

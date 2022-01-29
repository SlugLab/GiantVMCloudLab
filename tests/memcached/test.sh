#!/bin/bash


print_usage () {
    echo "./test.sh [server_threads]"
    echo "Memcached saturation throughput test"
    echo "produces header row followed by throughput in operations/second, for all configurations from 1..server_threads"
}

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command pushd "$@" > /dev/null
}

#### start a server with four threads, redirecting standard output and standard error
## Save the pid so you can kill it later

if [ $# != 0 ] && [ $1 = "-h" ]; then
    print_usage
    exit 0
fi;

max_threads=16
if [ $# != 0 ]; then
    max_threads=$1
fi;
   


echo "Threads, Throughput"

threads=1
while [ $threads -le $max_threads ]
do
    ./memcached-1.6.13/memcached -t $threads -m 4096 > memcached.log 2> memcached.err &
    PID=$!

    printf "$threads,"
    pushd YCSB
    ./bin/ycsb load memcached -s -P workloads/workloada -p memcached.hosts=localhost -p recordcount=1000000 -threads 100 2>1 > /dev/null
    ./bin/ycsb run memcached -s -P workloads/workloada -p memcached.hosts=localhost -p recordcount=1000000 -p operationcount=1000000 -threads 100  2>1\
	| grep "\[OVERALL\], T" | awk -F',' '{print $3}'
    popd
    kill $PID
    sleep 2
    threads=$(($threads * 2))
done


#!/bin/bash 
max_threads=16
max_trial=10
trial=1
cd graphchi-cpp/

while [ $trial -le $max_trial ]
do
        echo "##Trial:" $trial
        echo -e "Threads\tTime(second)"
        threads=1
        while [ $threads -le $max_threads ]
        do
                bin/example_apps/pagerank_functional file twitter_dataset/twitter_rv.net filetype edgelist niters 1 execthreads $threads loadthreads $threads > graphchi_$trial_$threads.log 2> graphchi_$trial_$threads.err
                echo -e $threads ' \t ' $(awk '{ if ($1 == "runtime:") print $2; }' graphchi_$trial_$threads.log)
                threads=$(($threads * 2))
        done
        trial=$(($trial + 1))
done

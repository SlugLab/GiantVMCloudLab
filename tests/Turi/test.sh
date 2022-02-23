#!/bin/bash
max_threads=16
max_trial=10
trial=1

while [ $trial -le $max_trial ]
do
        echo "##Trial:" $trial
        echo -e "Threads\tTime(second)"
        threads=1
        while [ $threads -le $max_threads ]
        do
                python3 app_graph_analytics.py -g twitter -a graphcol -t $threads > turi_$trial_$threads.log 2> turi_$trial_$threads.err
                echo -e $threads ' \t ' $(awk '{ if ($1 == "training") print $5; }' turi_$trial_$threads.log)
                threads=$(($threads * 2))
        done
        trial=$(($trial + 1))
done

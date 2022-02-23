#!/bin/bash
max_threads=16
max_trial=10
echo "Threads, Time"
cd Metis/
trial=1
while [ $trial -le $max_trial ]
do
        echo "##Trial:" $trial
        threads=1
        while [ $threads -le $max_threads ]
        do
                echo "#Threads:" $threads
                time ./obj/linear_regression ./data/lr_40GB.txt -p $threads > metis_$threads.log 2> metis_$threads.err
                threads=$(($threads * 2))
        done
        trial=$(($trial + 1))
done

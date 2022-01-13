#!/bin/sh

##maybe make ~/.ssh

for i in `ls /users`; do
    home="/users/$i"
    mkdir -p $home/.ssh
    sudo chmod 700 $home/.ssh
    
    ## get the generated RSA private key for the experiment
    geni-get key | sudo tee $home/.ssh/id_rsa > /dev/null
    sudo chmod 600 $home/.ssh/id_rsa

    ## Calculate the public key portion:
    sudo ssh-keygen -y -f $home/.ssh/id_rsa | sudo tee $home/.ssh/id_rsa.pub > /dev/null

    ## make it so the private key gets you login access:
    sudo grep -q -f $home/.ssh/id_rsa.pub $home/.ssh/authorized_keys ||  sudo cat $home/.ssh/id_rsa.pub | sudo tee -a $home/.ssh/authorized_keys > /dev/null

done




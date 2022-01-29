#!/bin/sh

##maybe make ~/.ssh

for i in `ls /users`; do
    home="/users/$i"
    sudo -u $i mkdir -p $home/.ssh
    sudo -u $i chmod 700 $home/.ssh

    ## get the generated RSA private key for the experiment
    sudo -u $i geni-get key | sudo -u $i tee $home/.ssh/id_rsa > /dev/null
    sudo -u $i chmod 600 $home/.ssh/id_rsa

    ## Calculate the public key portion:
    sudo -u $i ssh-keygen -y -f $home/.ssh/id_rsa | sudo -u $i tee $home/.ssh/id_rsa.pub > /dev/null
    
    ## make it so the private key gets you login access:
    sudo -u $i grep -q -f $home/.ssh/id_rsa.pub $home/.ssh/authorized_keys ||  sudo -u $i cat $home/.ssh/id_rsa.pub | sudo -u $i tee -a $home/.ssh/authorized_keys > /dev/null

done

#done




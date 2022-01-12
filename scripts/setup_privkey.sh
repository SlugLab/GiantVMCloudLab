#!/bin/sh

##maybe make ~/.ssh
mkdir -p $HOME/.ssh && chmod 700 $HOME/.ssh


## get the generated RSA private key for the experiment
geni-get key > $HOME/.ssh/id_rsa
chmod 600 $HOME/.ssh/id_rsa

## Calculate the public key portion:
ssh-keygen -y -f $HOME/.ssh/id_rsa > $HOME/.ssh/id_rsa.pub

## make it so the private key gets you login access:
grep -q -f $HOME/.ssh/id_rsa.pub $HOME/.ssh/authorized_keys || cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys

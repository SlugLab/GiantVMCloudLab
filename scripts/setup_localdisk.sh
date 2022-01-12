#!/bin/sh


## My understanding is that you cannot create disk images that use these things.
## so, like, don't.

sudo mkdir /data
sudo chmod 777 /data
sudo /usr/local/etc/emulab/mkextrafs.pl /data

sudo chown -R $USER /data

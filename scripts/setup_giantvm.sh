#!/bin/bash
LOC=/data/local/

IMG=$LOC/ubuntu.img
DATA=$LOC/user_data.img
USER=$LOC/user.dat
SET=$LOC/.set

## change permitions on kvm
sudo chmod 777 /dev/kvm

if [ ! -f $IMG ]; then
    wget -O $IMG https://cloud-images.ubuntu.com/releases/focal/release-20220104/ubuntu-20.04-server-cloudimg-amd64.img

    qemu-img resize $IMG 10G

    ## this adds the 5.4.0 modules where we need them!
    sudo virt-customize -a /data/local/ubuntu.img --root-password password:gvm --mkdir /lib/modules/5.4.0+ --copy-in /lib/modules/5.4.0+:/lib/modules/
    
    ## maybe change around password stuff? Not sure.
    
fi 

if [ ! -f $DATA ]; then
    rm $USER
    touch $USER
    echo "#cloud-config" >> $USER
#    echo "ssh_pwauth: True" >> user.yaml
    echo "users:" >> $USER
#    printf "  - default\n" >> user.yaml
    printf "  - name: gvm\n" >> $USER
    printf "    sudo: ALL=(ALL) NOPASSWD:ALL\n" >> $USER
    #    printf "  passwd: asdf\n" >> user.yaml
    printf "    groups: sudo\n" >> $USER
    printf "    shell: /bin/bash\n" >> $USER
    printf "    plain_text_passwd: gvm\n" >> $USER
    printf "    ssh_authorized_keys:\n" >> $USER
    printf "      %s" "- " >> $USER
    cat /users/arquinn/.ssh/id_rsa.pub >> $USER


    #printf "runcmd:\n" >> user.yaml
   # printf "  -echo \"AllowUsers jra\"\n" >> user.yaml
   # printf "  -restart ssh\n" >> user.yaml
 #   echo "chpasswd: { expire: False }" >> user.yaml


    cloud-localds $DATA $USER
fi


### setup crap with libvirt:
# I don't know why the image doesn't seem to capture this correctly...
if [ ! -f $SET ]; then
    sudo apt -y --reinstall install libvirt-daemon-system
    sudo systemctl start libvirtd
    sudo virsh net-start default

    sudo apt install -y python2

    touch $SET
fi






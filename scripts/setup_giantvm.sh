#!/bin/bash
LOC=/data/local/

IMG=$LOC/ubuntu.img
DATA=$LOC/user_data.img

if [ ! -f $IMG ]; then
    wget -O $IMG https://cloud-images.ubuntu.com/releases/focal/release-20220104/ubuntu-20.04-server-cloudimg-amd64.img

    qemu-img resize $IMG 10G

    ## this adds the 5.4.0 modules where we need them!
    sudo virt-customize -a /data/local/ubuntu.img --root-password password:gvm --mkdir /lib/modules/5.4.0+ --copy-in /lib/modules/5.4.0+:/lib/modules/
    
    ## maybe change around password stuff? Not sure.
    
fi 

if [ ! -f $DATA ]; then
    echo "#cloud-config" >> user.yaml
#    echo "ssh_pwauth: True" >> user.yaml
    echo "users:" >> user.yaml
#    printf "  - default\n" >> user.yaml
    printf "  - name: gvm\n" >> user.yaml
    printf "    sudo: ALL=(ALL) NOPASSWD:ALL\n" >> user.yaml
    #    printf "  passwd: asdf\n" >> user.yaml
    printf "    groups: sudo\n" >> user.yaml
    printf "    shell: /bin/bash\n" >> user.yaml
    printf "    plain_text_passwd: gvm\n" >> user.yaml
    printf "    ssh_authorized_keys:\n" >> user.yaml
    printf "      %s" "- " >> user.yaml
    cat /users/arquinn/.ssh/id_rsa.pub >> user.yaml


    #printf "runcmd:\n" >> user.yaml
   # printf "  -echo \"AllowUsers jra\"\n" >> user.yaml
   # printf "  -restart ssh\n" >> user.yaml
 #   echo "chpasswd: { expire: False }" >> user.yaml


    cloud-localds $DATA user.yaml
#    rm user.yaml
fi


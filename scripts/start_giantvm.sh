#!/bin/sh


sudo /local/src/QEMU/build/x86_64-softmmu/qemu-system-x86_64\
     -nographic\
     -drive file="/data/local/ubuntu.img,format=qcow2"\
     -drive "file=/data/local/user_data.img,format=raw"\
     -cpu host\
     -machine kernel-irqchip=off\
     -smp 1\
     --enable-kvm\
     -net bridge,br=virbr0,helper=/local/src/QEMU/build/qemu-bridge-helper\
     -net nic,model=virtio\
     -m 4096

#-kernel /boot/vmlinuz-5.4.0+
#    -initrd /boot/initrd.img-5.4.0+
#    -append "root=/dev/sda1 console=ttyS0"

#sudo qemu-system-x86_64\

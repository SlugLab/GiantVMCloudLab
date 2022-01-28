#!/bin/sh

sudo qemu-system-x86_64\
     -nographic\
     -drive file="/data/local/ubuntu.img,format=qcow2"\
     -drive "file=/data/local/user_data.img,format=raw"\
     -cpu host\
     -machine kernel-irqchip=off\
     -smp 1\
     --enable-kvm\
     -net user\
     -net nic,model=virtio\
     -m 4096

#-kernel /boot/vmlinuz-5.4.0+
#    -initrd /boot/initrd.img-5.4.0+
#    -append "root=/dev/sda1 console=ttyS0"

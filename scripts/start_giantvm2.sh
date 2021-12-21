#!/bin/sh

sudo /local/src/QEMU/x86_64-softmmu/qemu-system-x86_64\
     -nographic\
     -kernel /boot/vmlinuz-4.9.76+\
     -hda /data/fs.img\
     -append "root=/dev/dsa1 console=ttypSO"\
     -cpu host\
     -machine kernel-irqchip=off\
     -smp 2\
     -shm-path "/local/src/qemu-shm"\
     -m 20480\
     --enable-kvm\
     -serial mon:stdio\
     -local-cpu 1,start=1\
     -net user\
     -net nic,model=virtio\
     -monitor telnet:127.0.0.1:1234,server,nowait


#     -drive if=none,file=/data/fs.img,format=raw,id=drive-sata0-0-0\
#     -device ide-drive,bus=ahci0.0,drive=drive-sata0-0-0,id=sata0-0-0\

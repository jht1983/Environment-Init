#!/bin/bash
sudo qemu-nbd -f vhdx -c /dev/nbd6 /mnt/hgfs/vm-shared/X.vhdx
sudo partprobe /dev/nbd6
sudo mount -t ntfs /dev/nbd6p2 /home/will/X/
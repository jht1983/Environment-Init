#!/bin/bash
sudo qemu-nbd -f vpc -c /dev/nbd6 /media/will/Data/Configure/vhd/X.vhd
sudo partprobe /dev/nbd6
sudo mount -t ntfs /dev/nbd6p2 /media/will/X/

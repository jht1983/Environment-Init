#!/bin/bash
sudo umount /dev/nbd6p2
sudo qemu-nbd -d /dev/nbd6
#!/bin/bash

# 突破 G(功)F(夫)W(网)
sudo cp /etc/hosts /etc/hosts.back
wget https://raw.githubusercontent.com/racaljk/hosts/master/hosts -O /tmp/hosts
sudo cp /etc/hosts.back /etc/hosts
sudo sh -c "cat /tmp/hosts >> /etc/hosts"
rm /tmp/hosts

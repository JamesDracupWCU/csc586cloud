#!/bin/bash

# generate passwordless SSH
# may not need sudo
sudo runuser -u jd926102 -- ssh-keygen -q -t rsa -f /users/jd926102/.ssh/id_rsa -N ''
sudo runuser -u jd926102 -- cat /users/jd926102/.ssh/id_rsa.pub >> /users/jd926102/.ssh/authorized_keys

# setup NFS for key sharing
apt update
apt install -y nfs-kernel-server
sudo mkdir /var/nfs/keys -p
sudo cp /users/jd926102/.ssh/id_rsa* /var/nfs/keys
sudo chown nobody:nogroup /var/nfs/keys
echo "/var/nfs/keys   192.168.1.2(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports
systemctl restart nfs-kernel-server




# Ignore most of this code is used in order above
# On host node in Experiment
sudo mkdir -p /var/nfs/keys
sudo mount 192.168.1.1:/var/nfs/keys /var/nfs/keys
df -h
sudo cp /var/nfs/keys/id_rsa* /users/jd926102/.ssh/
sudo chown jd926102: .ssh/id_rsa*
cat .ssh/id_rsa.pub >> .ssh/authorized_keys
ssh localhost

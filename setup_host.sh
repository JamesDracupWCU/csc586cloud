#!/bin.bash

apt update
apt install -y nfs-common
mkdir -p /var/nfs/keys

while [ ! -f /var/nfs/keys/id_rsa ]; do
  mount 192.168.1.1:/var/nfs/keys /var/nfs/keys
  sleep 10
 done
 
 cp /var/nfs/keys/id_rsa* /users/jd926102/.ssh/
 chown jd926102: /users/jd926102/.ssh/id_rsa*
 runuser -u jd926102 -- cat /users/jd926102/.ssh/id_rsa.pub >> /users/jd926102/.ssh/authorized_keys


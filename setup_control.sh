#!/bin/bash

# generate passwordless SSH
# may not need sudo
sudo runuser -u jd926102 -- ssh-keygen -q -t rsa -f /users/jd926102/.ssh/id_rsa -N ''
sudo runuser -u jd926102 -- cat /users/jd926102/.ssh/id_rsa.pub >> /users/jd926102/.ssh/authorized_keys

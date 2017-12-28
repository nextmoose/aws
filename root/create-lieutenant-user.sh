#!/bin/sh

adduser user &&
    mkdir /home/user/.ssh &&
    touch /home/user/.ssh/authorized_keys &&
    chmod 0700 /home/user/.ssh &&
    chmod 0600 /home/user/.ssh/authorized_keys &&
    cat /tmp/hacker_2_lieutenant_id_rsa.pub > /home/user/.ssh/authorized_keys &&
    chown -R user:user /home/user/.ssh
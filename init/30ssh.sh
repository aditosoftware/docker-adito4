#!/bin/bash


# persist ssh keys
if [ ! -d /a/data/ssh ]; then
  mkdir -p /a/data/ssh
  cp /etc/ssh/ssh_host_* /a/data/ssh/
fi
ln -s -f /a/data/ssh/ssh_host_* /etc/ssh/

SSH_PASSWORD=${SSH_PASSWORD:-Verpasnargut4855}

# setup passwort for aditouser to connect per ssh
echo "aditouser:${SSH_PASSWORD}" | chpasswd
# start ssh as a service
service ssh start
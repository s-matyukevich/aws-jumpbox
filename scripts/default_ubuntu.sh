#!/bin/bash
set -e

sudo bash -c 'echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config'
sudo service ssh restart

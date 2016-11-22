#!/bin/bash
set -e

sudo bash -c 'echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config'
sudo bash -c 'echo "MaxSessions 1000" >> /etc/ssh/sshd_config'
sudo sed -i 's/AcceptEnv */AcceptEnv \*/g' /etc/ssh/sshd_config
sudo service ssh restart

#!/bin/bash

PUBLIC_IP=$(curl --silent http://169.254.169.254/latest/meta-data/public-ipv4)
CF_DOMAIN=$(curl --silent http://169.254.169.254/latest/meta-data/public-ipv4).xip.io
echo "\n"
echo "CF_DOMAIN=${CF_DOMAIN}" > .ssh/environment
sudo sed -i 's/PermitUserEnvironment no/PermitUserEnvironment yes/g' /etc/ssh/sshd_config
sudo service ssh restart
sudo start-cf "$CF_DOMAIN"

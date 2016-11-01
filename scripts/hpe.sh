#!/bin/bash

cf_domain=$1
uuid=$2
owner_tag=$3

suffix=${uuid:0:4}

echo "CF_DOMAIN=${cf_domain}" > .ssh/environment
echo "CF_ORG=org-${suffix}" >> .ssh/environment
echo "CF_SPACE=space-${suffix}" >> .ssh/environment
echo "CF_USER=${owner_tag}-${suffix}" >> .ssh/environment
echo "CF_PASSWORD=${uuid}" >> .ssh/environment
sudo bash -c 'echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config'
sudo service ssh restart

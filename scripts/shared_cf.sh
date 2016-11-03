#!/bin/bash
set -e

cf_domain="$1"
owner_tag="$2"
uuid="$3"

suffix=${uuid:0:4}

cd "$(dirname "$0")"
echo "CF_DOMAIN=${cf_domain}" > .ssh/environment
echo "CF_ORG=org-${suffix}" >> .ssh/environment
echo "CF_SPACE=space-${suffix}" >> .ssh/environment
echo "CF_USER=${owner_tag}-${suffix}" >> .ssh/environment
echo "CF_PASSWORD=${uuid}" >> .ssh/environment

sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin no/' /etc/ssh/sshd_config
echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config
service ssh restart

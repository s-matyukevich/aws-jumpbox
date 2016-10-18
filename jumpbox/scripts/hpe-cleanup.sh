#!/bin/bash
set -e

cf_domain=$TF_VAR_cf_domain
cf_admin=$TF_VAR_cf_admin
cf_admin_password=$TF_VAR_cf_admin_password
uuid=$TF_VAR_uuid
owner_tag=$TF_VAR_owner_tag

suffix=${uuid:0:4}
org="org-${suffix}"
space="space-${suffix}"
user="${owner_tag}-${suffix}"

export CF_HOME=.
cf api api.${cf_domain} --skip-ssl-validation
cf auth ${cf_admin} ${cf_admin_password}
cf delete-org ${org} -f
cf delete-user ${user} -f

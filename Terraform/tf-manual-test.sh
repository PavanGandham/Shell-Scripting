#!/bin/bash

set -euo pipefail

# Change directory to Main Project Directory
cd /root/terraform/Project-1

# Create the resources
terraform init
terraform validate
terraform fmt
terraform plan --out plan.out
terraform apply -auto-approve

# Wait while the resources and instances boots up 
sleep 1m

# Query the output extract the IP or ALB endpoint and make a request
terraform output -json |\
jq -r '.instance_ip_addr.value' |\
xargs -I {} curl http://{}:8080 -m 10

# If request Succeeds destroy the resources
terraform destroy -auto-approve
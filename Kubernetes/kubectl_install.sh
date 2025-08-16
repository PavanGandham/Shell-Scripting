#!/bin/bash

#1. Download the latest release
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# version based release 
#curl -LO https://dl.k8s.io/release/v1.24.0/bin/linux/amd64/kubectl

#2. Validate the binary (optional)
#Download the kubectl checksum file:
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

#Validate the kubectl binary against the checksum file:
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

#If valid, the output is:

#kubectl: OK
#If the check fails, sha256 exits with nonzero status and prints output similar to:

#kubectl: FAILED
#sha256sum: WARNING: 1 computed checksum did NOT match

#Note: Download the same version of the binary and checksum.

#3. Install kubectl

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

#4. Test to ensure the version you installed is up-to-date:

kubectl version --client

#Or use this for detailed view of version:

kubectl version --client --output=yaml
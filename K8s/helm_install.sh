#!/bin/bash -xe

# From the Binary Releases

# 1. Download your desired version from https://github.com/helm/helm/releases 
wget https://get.helm.sh/helm-v3.10.1-linux-amd64.tar.gz
# 2. Unpack it 
tar -zxvf helm-v3.10.1-linux-amd64.tar.gz
# 3. Find the helm binary in the unpacked directory, and move it to its desired destination
mv linux-amd64/helm /usr/local/bin/helm


# From Script

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# Through Package Managers

# From Apt (Debian/Ubuntu)
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

# From dnf/yum (fedora)
sudo dnf install helm



#!/bin/bash

# Installing kops on Ubuntu or any Linux Distros

# Latest version install
#curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64

# version 1.21.1 install

curl -Lo kops https://github.com/kubernetes/kops/releases/download/v1.21.1/kops-linux-amd64
chmod +x kops
sudo mv kops /usr/local/bin/kops



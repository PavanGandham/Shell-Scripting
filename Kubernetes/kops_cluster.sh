#!/bin/bash
# Setting Env variables and auto completion for kubectl and kops
echo 'export NAME=pavank8s.ml
export KOPS_STATE_STORE=s3://pavank8sb12cluster
export AWS_REGION=us-east-1
export CLUSTER_NAME=pavank8s.ml
export EDITOR='/usr/bin/nano'
#export K8S_VERSION=1.21.0
alias ku=kubectl
complete -F __start_kubectl ku
source <(kubectl completion bash)
source <(kops completion bash)
alias cutils='kubectl run utils --image=sreeharshav/utils:latest'
' >> ~/.bashrc

source ~/.bashrc
# for all sessions in linux 
kops completion bash > /etc/bash_completion.d/kops

# Create an SSH Key pair 
ssh-keygen -t rsa -b 4096

# Creating Cluster using kops
kops create cluster --name=pavank8s.ml \
--state=s3://pavank8sb12cluster --zones=us-east-1a,us-east-1b,us-east-1c \
--node-count=3 --master-count=1 --node-size=t3.medium --master-size=t3.medium \
--master-zones=us-east-1a --master-volume-size 10 --node-volume-size 10 \
--dns-zone=pavank8s.ml --yes

# Getting cluster name
kops get cluster --show-labels

# Validate cluster 
kops validate cluster --wait 10m

# Delete Cluster
#kops delete cluster --name pavank8s.ml --yes


#!/bin/bash
echo 'export NAME=pavank8s.ml
export KOPS_STATE_STORE=s3://pavank8sb12cluster
export AWS_REGION=us-east-1
export CLUSTER_NAME=pavank8s.ml
export EDITOR='/usr/bin/nano'
#export K8S_VERSION=1.21.0
alias ku=kubectl
complete -F __start_kubectl ku' >> ~/.bashrc

source ~/.bashrc


kops create cluster --name=pavank8s.ml \
--state=s3://pavank8sb12cluster --zones=us-east-1a,us-east-1b,us-east-1c \
--node-count=3 --master-count=1 --node-size=t3.medium --master-size=t3.medium \
--master-zones=us-east-1a --master-volume-size 10 --node-volume-size 10 \
--dns-zone=pavank8s.ml --yes
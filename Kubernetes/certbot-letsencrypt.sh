#!/bin/bash

# https://letsencrypt.org/docs/rate-limits/

# CERTBOT on ubuntu 18.04/20.04:
sudo snap install --classic certbot
cd /snap/bin/
cp certbot /usr/local/bin/
./certbot  -h
certbot certonly --manual --preferred-challenges=dns --email pavangandham99@gmail.com \
--server https://acme-v02.api.letsencrypt.org/directory --agree-tos -d *.pavank8s.ml
#Executing above command will give you a a hostname and txt value to create in the DNS/Route53. Create the record and give the TTL value as 1 min.
#Wait for few min and give Yes at the prompt .

# Create a Kubernetes Secret
# kubectl create secret tls my-tls-secret \
# --key < private key filename > \
# --cert < certificate filename >

kubectl create secret tls my-tls-secret \
--key tls.key \
--cert tls.crt
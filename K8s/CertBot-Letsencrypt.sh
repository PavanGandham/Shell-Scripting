#!/bin/bash

# https://letsencrypt.org/docs/rate-limits/

# CERTBOT on ubuntu 18.04/20.04:
sudo snap install --classic certbot
cd /snap/bin/
cp certbot /usr/local/bin/
./certbot  -h
./certbot certonly --manual --preferred-challenges=dns --email mavrick202@gmail.com \
--server https://acme-v02.api.letsencrypt.org/directory --agree-tos -d *.trainingk8s.xyz
#Executing above command will give you a a hostname and txt value to create in the DNS/Route53. Create the record and give the TTL value as 1 min.
#Wait for few min and give Yes at the prompt .

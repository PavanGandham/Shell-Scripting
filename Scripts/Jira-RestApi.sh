#!/bin/bash

for ip in $(cat ip.txt) 10.118,10.119
do
curl -u GITLAB:Token -X PUT --data \
''
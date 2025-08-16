#!/bin/bash

yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd
echo "<h1> Hello World from $(hostname -f) </h1>" > /var/www/html/index.html

for i in {1..10}; do
    echo "test $i"
done
#Installing Nginx in Amazon Linux-2 

#!/bin/bash
yum update -y
amazon-linux-extras install nginx1.12 -y
service nginx start
chkconfig nginx on
echo '<h1> Web-Server-1 </h1>' >> /usr/share/nginx/html/index.html


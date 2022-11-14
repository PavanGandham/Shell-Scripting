#!/bin/bash

# Installing Logrotate in Linux

---------- On Debian and Ubuntu ---------- 
# apt update && apt install logrotate 

---------- On CentOS, RHEL and Fedora ---------- 
# yum update && yum install logrotate

echo 'include /etc/logrotate.d' >> /etc/logrotate.conf 

# Configure Logrotate in Linux
echo '/var/log/apache2/* {
    weekly
    rotate 3
    size 10M
    compress
    delaycompress
}' >> /etc/logrotate.d/apache2.conf

logrotate -d /etc/logrotate.d/apache2.conf

echo '/var/log/squid/access.log {
    monthly
    create 0644 root root
    rotate 5
    size=1M
    dateext
    dateformat -%d%m%Y
    notifempty
    mail gabriel@mydomain.com
}' >> /etc/logrotate.d/squid.conf

# send an email to root when any of the logs inside /var/log/myservice gets rotated
echo '/var/log/myservice/* {
	monthly
	create 0644 root root
	rotate 5
	size=1M
    	postrotate
   		echo "A rotation just took place." | mail root
    	endscript
}' >> /etc/logrotate.d/squid.conf:

# Logrotate and Cron
# By default, the installation of logrotate creates a crontab file inside /etc/cron.daily named logrotate.
# As it is the case with the other crontab files inside this directory,
# it will be executed daily starting at 6:25 am
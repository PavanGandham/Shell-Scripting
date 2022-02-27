#!/bin/bash
#######################################################################################
#Script Name :alertmemory.sh
#Description :send alert mail when server memory is running low
#Args :
#Author :Pavan Gandham
#Email :pavangandham99@gmail.com
#License : GNU GPL-3
#######################################################################################
## declare mail variables
##email subject
subject="Server Memory Status Alert"
##sending mail as
from="root@ec2-54-152-62-230.compute-1.amazonaws.com"
## sending mail to
to="saivenkata7777@gmail.com"
## send carbon copy to
also_to="pavangandham99@gmail.com"

## get total free memory size in megabytes(MB)
free=$(free -mt | awk '/Total/{ print $4 }')

## check if free memory is less or equals to 100MB
if [[ "$free" -le 400 ]]; then
 ## get top processes consuming system memory and save to temporary file
 ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head >/tmp/top_proccesses_consuming_memory.txt

 file=/tmp/top_proccesses_consuming_memory.txt
 ## send email if system memory is running low
 echo -e "Warning, server memory is running low!\n\nFree memory: $free MB" | mail -A $file -s "$subject" "$to" "$also_to" < $file
fi

exit 0

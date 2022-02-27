# Manually Collect Disk I/O Every Certain Minutes Using Shell Script

`Here is an shell script which collect details for debugging the I/O Performance issues 
and store historical data into log files. Manually collect Disk I/O 
Every Certain Minutes using shell script scheduled in crontab. Of course 
you can use different tools but installing 3rd party tools on production systems 
leads to security vulnerabilities.`

# Manually Collect Disk I/O Shell Script

`You can free to use this shell script with our own risk, no warranty. 
What are the processes executed at particular time will captured by script, 
iostat and top command output. Collected information is more than enough to track the issue.`

#!/bin/bash
## Author: Pavan Gandham
## Date: 07/20/2021
#########################
# Monitoring Tools: #
# - Memory Usage #
# - Disk I/O #
# - Top / oracle #
# #
#########################

MAILLIST="YOUREMAIL@DOMAIN.COM"

# Check Memory usage
echo "arkit-serv-64" >> /var/log/iologfile.`date +%h%d%y`
date >> /var/log/iologfile.`date +%h%d%y`
echo " " >> /var/log/iologfile.`date +%h%d%y`
echo "ps -A --sort -rss -o comm,pmem | head -n 11" >> /var/log/iologfile.`date +%h%d%y`
echo " " >> /var/log/iologfile.`date +%h%d%y`
ps -A --sort -rss -o comm,pmem | head -n 11 >> /var/log/iologfile.`date +%h%d%y`
echo " " >> /var/log/iologfile.`date +%h%d%y`

# IOTOP to gather I/O for 5x @ 2 seconds
echo "iostat -x 2 5" >> /var/log/iologfile.`date +%h%d%y`
iostat -x 2 5 >> /var/log/iologfile.`date +%h%d%y`
echo " " >> /var/log/iologfile.`date +%h%d%y`

# Top - Oracle Process
date >> /var/log/toptool.`date +%h%d%y`
echo "top -n 1 -U oracle" >> /var/log/toptool.`date +%h%d%y`
echo " " >> /var/log/toptool.`date +%h%d%y`
top -n 1 -U oracle >> /var/log/toptool.`date +%h%d%y`
echo " " >> /var/log/toptool.`date +%h%d%y`

date >> /var/log/iologfile.`date +%h%d%y`
cat /var/log/iologfile.`date +%h%d%y` | mail -s "arkit-serv-64 Memory, I/O, & Top Output" ${MAILLIST}

# Disk IO Collection using sar Command
# Below Shell script will collect Disk IO Average Usage using sar command.

#!/bin/bash
## Purpose: To Collect Disk IO Report using sar command - Arkit
##Author:Ankam Ravi Kumar
## Date: 14th November 2016

## START ##

sar -p -d 1 3 |grep Average |grep -v nodev |tail -5 >> /var/log/diskio
sed -i "s/Average:/`date +%F_%H:%M:%S`/g" /var/log/diskio

sar -p -d 1 3 |grep -v Average |grep -v nodev |grep -v Linux >> /var/log/rdiskio
## END ##
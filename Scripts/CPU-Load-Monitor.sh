'''Monitor Your CPU Utilization using Shell Script This script will monitor your CPU utilization and send 
an Email alert to mentioned email address. But which is not real time CPU Utilization. 
This script required sar command installed in your Linux machine are else you may get error.'''

# yum install -y sysstat
# sudo apt-get install sysstat

'''There is a situation where we want to keep an eye on our server CPU utilization because if your 
server CPU utilization goes HIGH you can’t process any other jobs since it is busy. Before CPU 
hits HIGH utilization we have to reduce, take an preventing action. Below is the shell script 
which will alert you when CPU hits 70% utilization, you can also change this as per your requirement 
by changing the value of “LOAD=”.'''

#!/bin/bash
# Shell script to monitor or watch the high cpu-load
# It will send an email to $ADMIN, if the (cpu load is in %) percentage
# of cpu-load is >= 70%
# If you have any suggestion or question please email to aravikumar48(yet)gmail.com
HOSTNAME=$(hostname)
LOAD=70.00
CAT=/bin/cat
MAILFILE=/tmp/mailviews
MAILER=/bin/mail
mailto="EMAILADDRESS"
CPU_LOAD=$(sar -P ALL 1 2 |grep 'Average.*all' |awk -F" " '{print 100.0 -$NF}')
if [[ $CPU_LOAD > $LOAD ]];
then
PROC=$(ps -eo pcpu,pid -o comm= | sort -k1 -n -r | head -1)
echo "Please check your processess on ${HOSTNAME} the value of cpu load is $CPU_LOAD % & $PROC" > $MAILFILE
$CAT $MAILFILE | $MAILER -s "CPU Load is $CPU_LOAD % on ${HOSTNAME}" $mailto
fi

#-----------------------------------------CPU-Load-2-------------------------------------------------------------

# Real Time CPU Load Monitoring Shell Script
# Below is the script updated recently to capture real time CPU Utilization and store the historical Data into /var/log/cpuhistory/ directory path

#!/bin/bash
##Author: Pavan Gandham
##Email ID: pavangandham99@gmail.com
##Updated: 07-20-2021

HOSTNAME=$(hostname)
PATHS="/"
WARNING=90
CRIT=98
CAT=/bin/cat
MAILER=/bin/mail
CRITmailto="YOUREMAIL@DOMAIN.COM"
mailto="YOUREMAIL@DOMAIN.COM"
mkdir -p /var/log/cpuhistory
LOGFILE=/var/log/cpuhistory/hist-$(date +%h%d%y).log
touch $LOGFILE

for path in $PATHS
do
CPU_LOAD=$(top -b -n 2 -d1 | grep "Cpu(s)" | tail -n1 | awk '{print $2}' |awk -F. '{print $1}')
if [ -n "$WARNING" -a -n "$CRIT" ]; then
 if [ "$CPU_LOAD" -ge "$WARNING" -a "$CPU_LOAD" -lt "$CRIT" ]; then
 echo " $(date "+%F %H:%M:%S") WARNINGING - $CPU_LOAD on Host $HOSTNAME" >> $LOGFILE
echo "CPU Load is Warning $CPU_LOAD on $HOSTNAME" | $MAILER -s "CPU Load is Warning $CPU_LOAD on $HOSTNAME" $mailto
exit 1
elif [ "$CPU_LOAD" -ge "$CRIT" ]; then
 echo "$(date "+%F %H:%M:%S") CRITICAL - $CPU_LOAD on $HOSTNAME" >> $LOGFILE
echo "CPU Load is Critical $CPU_LOAD on $HOSTNAME" | $MAILER -s "CPU Load is Critical $CPU_LOAD on $HOSTNAME" $CRITmailto
exit 2
else
echo "$(date "+%F %H:%M:%S") OK - $CPU_LOAD on $HOSTNAME" >> $LOGFILE
exit 0
fi
fi
done
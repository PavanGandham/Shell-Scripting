'''Disk Space Monitoring Script And Get Email Alert When CRITICAL
Most of the environments (small environments) they are not effort to buy a monitoring 
tools in this case, scripting will come handy to monitor your environment. 
I hope this disk space monitoring script will help to monitor the disk space. 
Disk Space Monitoring Script And Get Email Alert when CRITICAL, When Disk space is reached more 
than threshold value.'''


 
# Disk Space Monitoring Script

#!/bin/bash

# Shell script to monitor or watch the low-disk space
# It will send an email to $ADMIN, if the (free available) percentage
# of space is >= 90%
# Disk Space Monitoring Script Get Email Alert
#### Script START here ###
## You can change your threshold value whatever you want ##
THRESHOLD=90
PATHS=/
MAILFILE=/tmp/mailviews$$
MAILER=/bin/mail
## Change ADMIN Mail address as per the requirement ##
mailto=pavangandham99@gmail.com

for path in $PATHS
do
## Validate the Percentage of Disk space ##
DISK_AVAIL=`/bin/df -k / | grep -v Filesystem |awk '{print $6}' |sed 's/%//g'`
if [ $DISK_AVAIL -ge $THRESHOLD ]
then
echo "Please clean up your stuff \n\n" > $MAILFILE
$CAT $MAILFILE | $MAILER -s "Clean up stuff" $mailto
fi
done
## END of the Script ##
'''
Explanation of script: Above script is written using one FOR loop and one IF condition.

/bin/df -k / | grep -v Filesystem |awk ‘{print $5}’ |sed ‘s/%//g’ <<– This line will calculate the disk space in percentage number

if [ $DISK_AVAIL -ge $THRESHOLD ] <<– This IF condition will validate the space, which is provided by the above command then number greater then or equal to 90 it will trig an alert using mail command to your given ADMIN address.
'''
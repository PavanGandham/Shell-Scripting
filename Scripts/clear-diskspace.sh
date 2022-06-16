''' Disk space clearing with directories having file more than 30 days old, and get an email 
alert along with the attached report saying disk space percentage beofre prune and after prune'''

# Disk Space restoring Script(deleting old files)

#!/bin/bash

# Shell script to monitor or watch the low-disk space and purne the old files
# It will send an email to $ADMIN, if the (free available) percentage
# of space is >= 80%
# Disk Space Restoring Script Get Email Alert

#### Script START here ###
## You can change your threshold value and file mount path  whatever you want ##

THRESHOLD=90
PATHS=/
MAILFILE=/tmp/mailviews$$
MAILER=/bin/mail
## Change ADMIN Mail address as per the requirement ##
mailto=pavangandham99@gmail.com

for path in $PATHS
do
## Validate the Percentage of Disk space ##
DISK_AVAIL=$(/bin/df -k / | grep -v Filesystem |awk '{print $6}' |sed 's/%//g')
if [ $DISK_AVAIL -ge $THRESHOLD ]
then
echo "Please clean up your stuff \n\n" > $MAILFILE
$CAT $MAILFILE | $MAILER -s "Clean up stuff" $mailto
fi
done
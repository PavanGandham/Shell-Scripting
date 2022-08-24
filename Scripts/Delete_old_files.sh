#!/bin/bash

set -e

prev_count=0
#fpath=/var/log/app/app_log.*
read -p "Enter the file/folder path to be deleted whose age is 30+ days old : " fpath

if [ -d "$fpath" || -f "$fpath" ]; then
    find $fpath -type d -mtime +10 -exec ls -ltrh {} \; >/tmp/folder/out
    find $fpath -type d -mtime +10 -exec rm -rf {} \;
    count=$(cat /tmp/folder.out | wc -l)
    if [ "$prev_count" -lt "$count" ]; then
        MESSAGE="/tmp/file1.out"
        TO="pavangandham99@gmail.com"
        echo "Application log folders are deleted older than 15 days" >>$MESSAGE
        echo "+----------------------------------------------------+" >>$MESSAGE
        echo "" >>$MESSAGE
        cat /tmp/folder.out | awk '{print $6,$7,$9}' >>$MESSAGE
        echo "" >>$MESSAGE
        SUBJECT="WARNING: Apache log files are deleted older than 15 days $(date)"
        mail -s "$SUBJECT" "$TO" <$MESSAGE
        rm $MESSAGE /tmp/folder.out
    fi
else
    echo -e "Folder/file doesn't exists. Please provide the correct folder/file path !!!"
fi

# Setup executable permissions for the script
# chmod +x /opt/script/Delete_old_files.sh

:'Finally add a cronjob to automate this . It runs daily at 7AM
crontab -e 
0 7 * * * /bin/bash /opt/script/Delete_old_files.sh
'

# Sample output
<<COMMENT
Application log folders are deleted older than 20 days
+----------------------------------------------------+
Oct 11 /var/log/app/app_log.11
Oct 12 /var/log/app/app_log.12
Oct 13 /var/log/app/app_log.13
Oct 14 /var/log/app/app_log.14
Oct 15 /var/log/app/app_log.15
COMMENT

#!/bin/bash -xe

cd /apps/logs/backup.txt
find . --type f -mtime +7 -exec mv '{}' /apps/logs/Log_Backup \;
cd /apps/logs/Log_Backup
find /apps/logs/Log_Backup --type f -name '*log*' >include-file
tar -cvf $(hostname)_$(date +%Y%m%d%H%M%S).tar.gz -T include-file

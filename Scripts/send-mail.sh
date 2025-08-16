#!/bin/bash

/usr/sbin/sendmail -i -t <<
Subject: $1 server process status
From: from mailid
To: to mailid
Hi Team,
Please check $1 service in TEST server which has $3
process running with below list of KIT IDs
$2
Regards,
Venkata Sai Pavan Gandham
MESSAGE_END
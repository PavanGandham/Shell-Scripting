#!/bin/bash

CURRENT_DATE_WITH_TIME=$(date) 
CURRENT_DAY=$(date +%A)
SWITCH_TIMES=("00:00","12:00")
#------------------------------Day-Time-Switch-------------------------------------#

nginx_daytime_switchover() {
EC2_LIST=$(aws ec2 describe-instances --region us-east-1)
}

#------------------------------Day-Time-Switch-------------------------------------#

nginx_nighttime_switchover() {

}
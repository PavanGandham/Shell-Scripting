#-----------------------------------For-Loop-Type-1---------------------------------------------------------
#!/bin/bash
I=0
Regions=$(aws ec2 describe-regions | jq ".Regions[].RegionName" | tr -d '"')
for i in ${Regions[@]}; do
 VPC=$(aws ec2 describe-vpcs --region $i | jq ".Vpcs[].VpcId" | tr -d '"')
 I=$(($I + 1))
 echo "The Available Regions are $I: $i"
 echo -e "VPCs Info in $i are \n $VPC \n"
 echo "------------------------------------------------------------------------------"
done
#-------------------------------For-Loop-Type-2---------------------------------------------------------------
#!/bin/bash
REGIONS=$(aws ec2 describe-regions | jq ".Regions[].RegionName" | tr -d '"')
REGION=("$REGIONS")
for i in $REGION; do
 echo "Getting Vpc info From $i"
 aws ec2 describe-vpcs --region $i | jq ".Vpcs[].VpcId"
 echo "------------------------------------------------------------"
done
#-------------------------------For-Loop-Type-3---------------------------------------------------------------
#!/bin/bash
# REGIONS=$(aws ec2 describe-regions | jq ".Regions[].RegionName" | tr -d '"')
REGIONS=('us-east-1' 'us-east-2' 'us-west-1' 'us-west-2' 'ca-central-1')
for ((c = 0; c < ${#REGIONS[@]}; c++)); do
 echo "Getting Vpc info From ${REGIONS[$c]} "
 aws ec2 describe-vpcs --region ${REGIONS[$c]} | jq ".Vpcs[].VpcId"
 echo "------------------------------------------------------------"
done
#---------------------------------------While-Loop-----------------------------------------------------------
#!/bin/bash
i=0
while [ $i -lt 50 ]; do
 echo "I value is : $i"
 i=$(($i + 1))
done
#---------------------------------------While-Loop------------------------------------------------------------
#!/bin/bash
Regions=('us-east-1' 'us-east-2' 'us-west-2' 'us-west-2')
i=0
while (($i < ${#Regions[@]})); do
 aws ec2 describe-vpcs --region ${Regions[$i]} | jq ".Vpcs[].VpcId" | tr -d '"'
 echo "---------------------------------------------------"
 i=$(($i + 1))
 sleep 1
done
#-------------------------------------Create-User-For-Loop------------------------------------------------
#!/bin/bash

# read -p "Please Enter the User Name :" Username
Username=$@
for User in ${Username}; do
 if [ -z $User ]; then
 echo "The Username Cannot be Empty.Please Enter a Vaild Username !!!"
 else
 echo "Checking if User Exists with the Name $User ...."
 ExistUser=$(cat /etc/passwd | grep -w $User | cut -d ":" -f 1)
 if [[ "$ExistUser" == "$User" ]]; then
 echo "User $User is already exists. Please choose another Name for a new User !!!"
 else
 echo "Let's Create a New user with Name $User..."
 Alpha='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
 Spec='!@#$%^&*()_'
 Alphachar=$(echo $Alpha | fold -w5 | shuf | head -1)
 Specchar=$(echo $Spec | fold -w1 | shuf | head -1)
 Password="India${Alphachar}${Specchar}${RANDOM}"
 useradd -m $User
 chown $User:$User /home/$User
 echo "$User:$Password" | sudo chpasswd
 echo "User $User and Password is $Password Successfully Created ...!!!"
 passwd -e $User
 fi
 fi
done
#------------------------------------Create-user-While-Loop--------------------------------------------------
#!/bin/bash
while [ True ]; do
 read -p "Please Enter the User Name :" User
 if [ -z $User ]; then
 echo "The Username Cannot be Empty.Please Enter a Vaild Username !!!"
 else
 echo "Checking if User Exists with the Name $User ...."
 ExistUser=$(cat /etc/passwd | grep -w $User | cut -d ":" -f 1)
 if [[ "$ExistUser" == "$User" ]]; then
 echo "User $User is already exists. Please choose another Name for a new User !!!"
 else
 echo "Let's Create a New user with Name $User..."
 Alpha='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
 Spec='!@#$%^&*()_'
 Alphachar=$(echo $Alpha | fold -w5 | shuf | head -1)
 Specchar=$(echo $Spec | fold -w1 | shuf | head -1)
 Password="India${Alphachar}${Specchar}${RANDOM}"
 useradd -m $User
 chown $User:$User /home/$User
 echo "$User:$Password" | sudo chpasswd
 echo "User $User and Password is $Password Successfully Created ...!!!"
 passwd -e $User
 fi
 fi
done
#---------------------------------------until-Loop-----------------------------------------------------------
# loop executes until the condition is false. if condition is true its skips the loop.
#!/bin/sh
a=0
until [ ! $a -lt 10 ]; do
 echo $a
 a=$(expr $a + 1)
done
#------------------------------------------select-Loop--------------------------------------------------------
#select loop provides an easy way to create a numbered menu from which users can select options
#!/bin/bash
select DRINK in tea cofee water juice appe all none; do
 case $DRINK in
 tea | cofee | water | all)
 echo "Go to canteen"
 ;;
 juice | appe)
 echo "Available at home"
 ;;
 none)
 break
 ;;
 *)
 echo "ERROR: Invalid selection"
 ;;
 esac
done
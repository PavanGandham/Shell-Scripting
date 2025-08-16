#!/bin/bash
Users=$@
if [ $# -gt 0 ]; then
 for Username in $Users; do
 if [[ $Username =~ ^[a-zA-Z]+$ ]]; then
 #if [[ $Username =~ ^[a-zA-Z] ]]; then
 Exist=$(cat /etc/passwd | grep -w $Username | cut -d ":" -f1)
 if [ "$Username" = "$Exist" ]; then
 echo "User Already Exists. Please Use a another username."
 else
 Spec=$(echo '!@#$%^&*()_' | fold -w1 | shuf | head -1)
 Password=India@${RANDOM}${Spec}
 echo "Let's Create a User $Username"
 useradd -m $Username
 echo "${Username}:${Password}" | sudo chpasswd
 passwd -e ${Username}
 echo "Username is ${Username} , Password is ${Password}"
 fi
 else
 echo "Invalid Input.(Note:Username must contain only Alphabets!!)"
 fi
 done
else
 echo "Provide Some Input as You have Given $# Parameters"
fi
#-----------------------------------------Sed------------------------------------------------------------------------------------------------
sed -i "s/.*PasswordAuthentication.*/PasswordAuthentication no/g" /etc/ssh/sshd_config
sed "s/.*enabled="true".*/enabled="false"/g" /opt/IBM/WebSphere/AppServer/profiles/Dmgr01/config/cells/cell01/security.xml
#------------------------------------------Awk-----------------------------------------------------------------------------------------------
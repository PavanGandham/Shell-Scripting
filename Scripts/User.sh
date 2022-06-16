#!/bin/bash
read -p "Enter the Username:" Username
if [ -n "$Username" ]; then # checks if the string not empty and returns true
 ExistUser=$(cat /etc/passwd | grep -w $Username | cut -d ":" -f 1)
 echo "$ExistUser"
 if [ "$Username" == "$ExistUser" ]; then
 echo "$Username Exist"
 else
 echo "Let's Create a Newuser $Username"
 fi
else
 echo "You have Entered Nothing!!!. Please Enter a Valid username as input"
fi

#-------OR-------------------------------------------------OR---------------------------------------------OR

#!/bin/bash
read -p "Enter the Username:" Username
if [ -z "$Username" ]; then #checks the string is empty and returns true
 echo "You have Entered Nothing!!!. Please Enter a Valid username as input"
else
 ExistUser=$(cat /etc/passwd | grep -w $Username | cut -d ":" -f 1)
 echo "$ExistUser"
 if [ "$Username" == "$ExistUser" ]; then
 echo "$Username Exist"
 else
 echo "Let's Create a Newuser $Username"
 fi
fi
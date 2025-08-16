'''How To Use Select Command Create Menu Driven Shell Scripts
We’ll also show you an alternative to the select command to help understand the usefulness of 
implementing select. Creating menu driven scripts is helpful when the intended purpose of 
the script is to perform a wide variety of actions based on user input. 
We can also implement logic to create more complex menus wherein we can 
perform nesting of menus such that selecting one menu option in turns opens another menu.'''

# Why use select command?

# Like many other things in Linux there is more than one method to create a menu within a shell script. 
# Using select offers an easy way to create menus and modify them as needed. Before we use select I 
# would like to show you an alternative method of implementing a menu in a shell script using an 
# infinite while loop, case statement and a bunch of echo and read statements.
 
# HowTo Use Select Command Create Menu
# Here is our menu driven script without using select

cat menu.bash

#!/bin/bash
##create infinite while loop##
while true
do
clear # clear screen for each loop of menu
echo
echo "Menu options"
echo "***************************************"
echo "Enter 1 to view uptime:"
echo "Enter 2 to view file system information:"
echo "Enter 0 to quit q:"
echo -e "Enter your selection here and press enter"
read answer # create variable to retains the answer
case "$answer" in
1) uptime ;;
2) df -h ;;
0) exit ;;
esac
echo -e "Press the enter key to continue!"
read input ##This causes a pause when refreshing the menu##
done

 
# This is a simple script which prompts the user to enter one of three options. 
# If the user inputs the numbers 1 or 2 then the appropriate commands within the case block are executed
# and if the user inputs the number 0 then the script exits. The script continues to prompt the 
# user until he presses 0 to exit. This is achieved by using the infinite while loop.

# Now let’s execute this script and see what happens.

# Menu options
# ***************************************
# Enter 1 to view uptime:
# Enter 2 to view file system information:
# Enter 0 to quit q:
# Enter your selection here and press enter
# 1
# 03:15:45 up 54 min, 1 user, load average: 0.00, 0.01, 0.05
# Press the enter key to continue!
# Menu options
# ***************************************
# Enter 1 to view uptime:
# Enter 2 to view file system information:
# Enter 0 to quit q:
# Enter your selection here and press enter
# 0

# Here we see that when the user press 1 followed by the enter key, the corresponding case statement 
# option is matched and the uptime is executed. The menu gets refreshed once we press enter after s
# eeing the output and the menu exits when we press 0.
# This is a simple implementation but can become complex when number of menu options to be implemented increases.

# Using select to create the menu
# Now we’ll demonstrate how we can create a menu driven script using select. 
# The syntax for select command as follows: select var in list do commands.. done

# The select command runs an infinite loop. var is the variable you’d use in your case statement for the menu. 
# The list would be the menu options. The commands would be part of the case statements being issued during the 
# execution of the menu selection. We can write the commands to be executed for a menu selection within the 
# select loop but for a cleaner code I’ll write the commands within separate functions & just call the functions in the case 
# statements within the select loop.

# HowTo Use Select Command Best Example
# Given below is the script

#!/bin/bash
trap '' 2 # ignore ctrl+c
##set PS3 prompt##
PS3="Enter your selection: "
function diskspace {
df -h
}
function uptime {
uptime
}
select opts in "check disk usage" "check uptime" "exit script"
do
case $opts in
"check disk usage")
echo -e "$(diskspace)"
;;
"check uptime")
echo -e "$(uptime)"
;;
"exit script")
break
;;
*)
echo "invalid option"
;;
esac
done

# I decided to use functions for the commands in this script for cleaner coded else the script could’ve been made significantly shorter.
# The select command runs an infinite loop and we are prompted to select from one of the options we passed to the select command in the 
# opts variable until we type the number 3 and press enter to break out of the case statement and terminate the loop.

# In the above script, we are also setting the value of the PS3 variable. This is what select will print when prompting the user 
# to pass his/selection for further processing by the case statement clauses. It’s default value is #? which is not very informative. 
# Therefore, I modified it to something more user friendly.

# Let’s test this script by executing it and see what happens.

bash select.bash

# 1) check disk usage
# 2) check uptime
# 3) exit script
# Enter your selection: 1
# Filesystem Size Used Avail Use% Mounted on
# /dev/xvda1 20G 5.8G 15G 29% /
# devtmpfs 892M 0 892M 0% /dev
# tmpfs 919M 0 919M 0% /dev/shm
# tmpfs 919M 17M 903M 2% /run
# tmpfs 919M 0 919M 0% /sys/fs/cgroup
# tmpfs 184M 0 184M 0% /run/user/1001
# Enter your selection: 3
# Each value we passed to the opts variable in the script is printed in the menu preceded by a number starting from
# We specify our selection by typing in a selection and pressing enter. 
# After that the case statement evaluates the selected clause.